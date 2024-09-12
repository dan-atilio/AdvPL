/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2024/08/27/como-testar-uma-query-antes-de-executar-em-advpl-ti-responde-0076/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} User Function zVid0076
Função que testa a query antes de executar
@type  Function
@author Atilio
@since 27/11/2023
/*/

User Function zVid0076()
    Local aArea    := FWGetArea()
    Local aPergs   := {}
    Local cNome    := Space(30)

    //Adiciona nos parâmetros que serão exibidos em tela
    aAdd(aPergs, {1, "Parte do nome",     cNome, "@!", ".T.", "",    ".T.", 80, .T.})

    //Se a pergunta for confirmada
    If ParamBox(aPergs, "Informe os parâmetros para filtrar o cliente", , , , , , , , , .F., .F.)
        Processa({|| fProcessa()})
    EndIf

    FWRestArea(aArea)
Return

Static Function fProcessa()
    Local aArea     := FWGetArea()
    Local cQuery    := ""
    Local nStatus   := 0
    Local cMensagem := ""
    Local nAtual    := 0
    Local nTotal    := 0

    //Monta a query pesquisando pelo nome dos clientes
    cQuery := " SELECT " + CRLF
    cQuery += "     A1_COD, " + CRLF
    cQuery += "     A1_NOME " + CRLF
    cQuery += " FROM " + CRLF
    cQuery += "     " + RetSQLName("SA1") + " SA1 " + CRLF
    cQuery += " WHERE " + CRLF
    cQuery += "     A1_FILIAL = '" + FWxFilial("SA1") + "' " + CRLF
    cQuery += "     AND A1_MSBLQL != '1' " + CRLF
    cQuery += "     AND UPPER(A1_NOME) LIKE '%" + Alltrim(MV_PAR01) + "%' " + CRLF
    cQuery += "     AND SA1.D_E_L_E_T_ = ' ' " + CRLF
    cQuery += " ORDER BY " + CRLF
    cQuery += "     A1_COD " + CRLF

    //Tenta executar a query primeiro (mesmo sendo select)
    nStatus  := TCSQLExec(cQuery)

    //Se houve erro
    If (nStatus < 0)
        cMensagem += "Erro na execução da query: " + CRLF + CRLF
        cMensagem += TCSQLError()
    Else
        
        //Incrementa a mensagem e executa a query
        cMensagem += "Query executada com sucesso!" + CRLF + CRLF
        TCQuery cQuery New Alias "QRY_SA1"

        //Define o tamanho da régua
        Count To nTotal
        ProcRegua(nTotal)
        QRY_SA1->(DbGoTop())
        While ! QRY_SA1->(EoF())
            //Incrementa a régua
            nAtual++
            IncProc("Processando registro " + cValToChar(nAtual)  + " de " + cValToChar(nTotal) + "...")

            //Incrementa a mensagem
            cMensagem += "[" + QRY_SA1->A1_COD + "] " + Alltrim(QRY_SA1->A1_NOME) + CRLF

            QRY_SA1->(DbSkip())
        EndDo
        QRY_SA1->(DbCloseArea())

    EndIf

    //Mostra a mensagem com o resultado
    ShowLog(cMensagem)

    FWRestArea(aArea)
Return
