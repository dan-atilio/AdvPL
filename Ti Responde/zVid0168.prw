/*
    
    Esse � um exemplo disponibilizado no Terminal de Informa��o 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/07/15/copiar-filtros-no-profile-de-usuarios-ti-responde-0168/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} User Function ChkExec
Ponto de Entrada acionado ao clicar em alguma op��o no menu
@type  Function
@author Atilio
@since 04/11/2023
@see https://tdn.totvs.com/display/public/framework/CHKEXEC+-+Dispara+ponto+de+entrada
/*/

User Function ChkExec()
    Local lContinua := .T.
    Local cFuncao	:= Upper(ParamIXB)

    //Se for a fun��o de manuten��o do profile
    If ("PROFMGR" $ cFuncao)
        FWAlertInfo("Shift + F8: Filtra Profile" + CRLF + "Shift + F9: Copia Profile", "Atalhos manuten��o Profile")
        SetKey(K_SH_F8, {|| u_zFiltProf() })
        SetKey(K_SH_F9, {|| u_zCopyProf() })
    EndIf

Return lContinua

/*/{Protheus.doc} User Function zFiltProf
Fun��o para abrir uma tela de filtros na manuten��o do Profile dos Usu�rios
@type  Function
@author Atilio
@since 04/11/2023
@see https://terminaldeinformacao.com/2023/12/18/como-filtrar-mais-facil-os-registros-dentro-da-tela-de-manutencao-de-profile-do-protheus/
/*/

User Function zFiltProf()
    Local cTabProfile := "PROFALIAS"
    Local cFiltro     := ""
    Local aCamposTab  := {}
    Local aCampos     := {}
    Local nAtual      := 0

    //Se a tabela de Profile tiver aberta
    If Select(cTabProfile) > 0

        //Monta o Array de Campos que ser� passado na BuildExpr
        aCamposTab := (cTabProfile)->(DbStruct())
        For nAtual := 1 To Len(aCamposTab)
            aAdd(aCampos, {;
                aCamposTab[nAtual][1],; // Nome do Campo
                aCamposTab[nAtual][1],; // T�tulo
                "",;                    // Usado
                nAtual,;                // Ordem
                aCamposTab[nAtual][3],; // Tamanho
                "",;                    // M�scara
                aCamposTab[nAtual][2],; // Tipo
                aCamposTab[nAtual][4];  // Tamanho de Decimais
            })
        Next

        //Abre a tela de montagem de filtro
        cFiltro := BuildExpr(cTabProfile, /*oWnd*/, /*cFilter*/, /*lTopFilter*/, /*bOk*/, /*oDlg*/, /*aUsado*/, /*cDesc*/, /*nRow*/, /*nCol*/, aCampos)
    
        //Se tiver filtro, usa o DbSetFilter para filtrar a tabela
        If ! Empty(cFiltro)
            (cTabProfile)->(DbSetFilter({|| &(cFiltro)}, cFiltro))
            
        //Sen�o, limpa qualquer filtragem
        Else
            (cTabProfile)->(DbClearFilter())
        EndIf
        (cTabProfile)->(DbGoTop())
    EndIf
Return

/*/{Protheus.doc} User Function zCopyProf
Copia a regra atual para outros usu�rios
@type  Function
@author Atilio
@since 22/08/2024
/*/

User Function zCopyProf()
    Local aArea   := FWGetArea()
    Local aPergs  := {}
    Local cUsrDe  := Space(6)
    Local cUsrAt  := StrTran(cUsrDe, " ", "Z")

    //Adiciona os par�metros a serem confirmados pelo usu�rio
    aAdd(aPergs, {1, "Usu�rio De",  cUsrDe,  "", ".T.", "USR", ".T.", 80,  .T.})
    aAdd(aPergs, {1, "Usu�rio At�", cUsrAt,  "", ".T.", "USR", ".T.", 80,  .T.})

    //Se a tela de par�metros for confirmada
    If ParamBox(aPergs, "Informe os par�metros", /*aRet*/, /*bOk*/, /*aButtons*/, /*lCentered*/, /*nPosx*/, /*nPosy*/, /*oDlgWizard*/, /*cLoad*/, .F., .F.)
        Processa({|| fCopia()}, "Aguarde...")
    EndIf

    FWRestArea(aArea)
Return

Static Function fCopia()
    Local aArea       := FWGetArea()
    Local cTabProfile := "PROFALIAS"
    Local cQryUsers   := ""
    Local cProg       := ""
    Local cTask       := ""
    Local cType       := ""
    Local cDefs       := ""
    Local cEmpr       := ""
    Local cFili       := ""
    Local nAtual      := 0
    Local nTotal      := 0
    Local cMensagem   := ""

    //Busca os usu�rios conforme os filtros colocados
    cQryUsers := " SELECT " + CRLF
    cQryUsers += "     USR_ID AS CODIGO, " + CRLF
    cQryUsers += "     USR_NOME AS NOME " + CRLF
    cQryUsers += " FROM " + CRLF
    cQryUsers += "     SYS_USR " + CRLF
    cQryUsers += " WHERE " + CRLF
    cQryUsers += "     D_E_L_E_T_ = ' ' " + CRLF
    cQryUsers += "     AND USR_ID >= '" + MV_PAR01 + "' " + CRLF
    cQryUsers += "     AND USR_ID <= '" + MV_PAR02 + "' " + CRLF
    cQryUsers += "     AND USR_ID != '" + Alltrim((cTabProfile)->P_NAME) + "' " + CRLF
    cQryUsers += " ORDER BY " + CRLF
    cQryUsers += "     1 " + CRLF
    TCQuery cQryUsers New Alias "QRY_USR"

    //Se houver dados
    If ! QRY_USR->(EoF())
        //Busca as informa��es o registro atual
        cProg := (cTabProfile)->P_PROG
        cTask := (cTabProfile)->P_TASK
        cType := (cTabProfile)->P_TYPE
        cDefs := (cTabProfile)->P_DEFS
        cEmpr := (cTabProfile)->P_EMPANT
        cFili := (cTabProfile)->P_FILANT

        //Define o tamanho da r�gua
        DbSelectArea("QRY_USR")
        Count To nTotal
        ProcRegua(nTotal)
        QRY_USR->(DbGoTop())

        //Enquanto houver dados no resultado da query, percorre todos os usu�rios
        While ! QRY_USR->(EoF())
            //Incrementa a r�gua
            nAtual++
            IncProc("Copiando informa��es, registro " + cValToChar(nAtual) + " de " + cValToChar(nTotal) + "...")

            //Cria o novo registro
            RecLock(cTabProfile, .T.)
                (cTabProfile)->P_NAME   := QRY_USR->CODIGO
                (cTabProfile)->P_PROG   := cProg
                (cTabProfile)->P_TASK   := cTask
                (cTabProfile)->P_TYPE   := cType
                (cTabProfile)->P_DEFS   := cDefs
                (cTabProfile)->P_EMPANT := cEmpr
                (cTabProfile)->P_FILANT := cFili
            (cTabProfile)->(MsUnlock())

            //Incrementa a mensagem
            cMensagem += QRY_USR->CODIGO + " - " + QRY_USR->NOME + CRLF

            QRY_USR->(DbSkip())
        EndDo

        //Exibe mensagem
        ShowLog("Registro foi copiado para os seguintes usu�rios: " + CRLF + CRLF + cMensagem)
    Else
        FWAlertError("N�o foi encontrado usu�rios com os filtros informados!", "Falha")
    EndIf
    QRY_USR->(DbCloseArea())

    FWRestArea(aArea)
Return
