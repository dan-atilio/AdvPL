/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2024/09/26/execauto-do-retornar-do-pedido-de-vendas-ti-responde-0085/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} User Function zVid0085
Teste de ExecAuto de Retornar
@type  Function
@author Atilio
@since 27/06/2023
/*/

User Function zVid0085()
    Local aArea     := FWGetArea()
    Local cQueryDoc := ""
    //Variáveis passadas dentro do ExecAuto
    Local cAliasDoc := "SF1"
    Local nPrimRec  := 0
    Local nOpcExec  := 4
    Local lUsaForn  := .T.
    Local cCodForn  := "F00003"
    Local cLojaForn := "01"
    Local cFiltrDoc := ""
    //Variáveis private do execauto
    Private lMsErroAuto := .F.
    Private lForn       := lUsaForn
    Private l410Auto
    Private INCLUI      := .T.
    Private aRotina     := FWLoadMenuDef("MATA410")
    
    //Busca os documentos que serão retornados
    cQueryDoc := " SELECT " + CRLF
    cQueryDoc += "     SF1.R_E_C_N_O_ AS SF1REC, " + CRLF
    cQueryDoc += "     SD1.R_E_C_N_O_ AS SD1REC, " + CRLF
    cQueryDoc += "     D1_DOC, " + CRLF
    cQueryDoc += "     D1_SERIE, " + CRLF
    cQueryDoc += "     D1_ITEM " + CRLF
    cQueryDoc += " FROM " + CRLF
    cQueryDoc += "     " + RetSQLName("SD1") + " SD1 " + CRLF
    cQueryDoc += "     INNER JOIN " + RetSQLName("SF1") + " SF1 ON ( " + CRLF
    cQueryDoc += "         F1_FILIAL = D1_FILIAL " + CRLF
    cQueryDoc += "         AND F1_DOC = D1_DOC " + CRLF
    cQueryDoc += "         AND F1_SERIE = D1_SERIE " + CRLF
    cQueryDoc += "         AND F1_FORNECE = D1_FORNECE " + CRLF
    cQueryDoc += "         AND F1_LOJA = D1_LOJA " + CRLF
    cQueryDoc += "         AND SF1.D_E_L_E_T_ = ' ' " + CRLF
    cQueryDoc += "     ) " + CRLF
    cQueryDoc += " WHERE " + CRLF
    cQueryDoc += "     D1_FILIAL = '" + FWxFilial("SD1") + "' " + CRLF
    cQueryDoc += "     AND D1_FORNECE = '" + cCodForn + "' " + CRLF
    cQueryDoc += "     AND D1_LOJA = '" + cLojaForn + "' " + CRLF
    cQueryDoc += "     AND D1_TIPO NOT IN ('B', 'D') " + CRLF
    cQueryDoc += "     AND D1_QUANT > D1_QTDEDEV " + CRLF
    cQueryDoc += "     AND D1_EMISSAO >= '20230601' " + CRLF
    cQueryDoc += "     AND SD1.D_E_L_E_T_ = ' ' " + CRLF
    TCQuery cQueryDoc New Alias "QRY_DOC"

    //Se tem dados
    If ! QRY_DOC->(EoF())
        //Percorre os dados e vai montando o filtro
        While ! QRY_DOC->(EoF())
            cFiltrDoc += Iif(! Empty(cFiltrDoc), ", ", "") + cValToChar(QRY_DOC->SD1REC)

            //Se o primeiro recno da SF1, ainda estiver vazio
            If Empty(nPrimRec)
                nPrimRec := QRY_DOC->SF1REC
            EndIf

            QRY_DOC->(DbSkip())
        EndDo

        //Adiciona dizendo que será um filtro do campo recno
        cFiltrDoc := "SD1.R_E_C_N_O_ IN (" + cFiltrDoc + ")" + CRLF

        //Adiciona um ultimo parenteses para não dar erro no execauto (ele abre o parenteses mas não fecha)
        cFiltrDoc += ")"
    EndIf
    QRY_DOC->(DbCloseArea())

    //Se houver documentos
    If ! Empty(cFiltrDoc)
        //Define se irá ser uma execução automática ou não
        If FWAlertYesNo("Você deseja executar automaticamente (SIM) ou exibir a tela antes de confirmar (NÃO)?", "Atenção - Retornar")
            l410Auto := .T. 
        Else
            l410Auto := .F.
        EndIf

        //Posiciona no primeiro documento da SF1
        DbSelectArea("SF1")
        SF1->(DbGoTo(nPrimRec))

        //Parâmetros da A410ProcDV: 
        // a = cAlias
        // b = nReg
        // c = nOpc
        // d = lFornece
        // e = cFornece
        // f = cLoja
        // g = cDocSF1
        MSExecAuto({|a, b, c, d, e, f, g| A410ProcDv(a, b, c, d, e, f, g)}, cAliasDoc, nPrimRec, nOpcExec, lUsaForn, cCodForn, cLojaForn, cFiltrDoc)

        //Se houve erro, mostra a mensagem
        If lMsErroAuto
            MostraErro()
        EndIf
    EndIf

    FWRestArea(aArea)
Return

/*/{Protheus.doc} User Function M410PCDV
Ponto de entrada, na inserção da linha do retornar (caso queira tratar algum documento no momento que ta sendo inserido no aCols)
@type  Function
@author Atilio
@since 27/06/2023
/*/

User Function M410PCDV()
    Local aArea   := FWGetArea()
    Local nPosDoc := GDFieldPos("C6_NFORI")
    Local nLinha  := Len(aCols)

    //Se veio da rotina de retornar
    If FWIsInCallStack("u_zVid0085")
        //Valida o campo de documento
        Alert("Documento de número: " + aCols[nLinha][nPosDoc])
    EndIf

    FWRestArea(aArea)
Return
