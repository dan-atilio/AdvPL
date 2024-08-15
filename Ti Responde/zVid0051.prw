/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2023/04/10/qual-a-diferenca-entre-count-to-e-reccount-ti-responde-051/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} User Function zVid0051
Função para comparar o Count To e RecCount
@type  Function
@author Atilio
@since 24/08/2022
/*/

User Function zVid0051()
    Local aArea     := FWGetArea()
    Local cQryAux   := ""
    Local nTotalCou := 0
    Local nTotalRec := 0
    Local nSB1Count := 0
    Local nSB1Recno := 0
    Local cMensagem := ""

    //Busca todos os produtos que não estejam bloqueados
    cQryAux := " SELECT " + CRLF
    cQryAux += "     B1_COD, " + CRLF
    cQryAux += "     B1_DESC, " + CRLF
    cQryAux += "     SB1.R_E_C_N_O_ AS SB1REC " + CRLF
    cQryAux += " FROM " + CRLF
    cQryAux += "     " + RetSQLName("SB1") + " SB1 " + CRLF
    cQryAux += " WHERE " + CRLF
    cQryAux += "     B1_FILIAL = '" + FWxFilial("SB1") + "' " + CRLF
    cQryAux += "     AND B1_MSBLQL != '1' " + CRLF
    cQryAux += "     AND SB1.D_E_L_E_T_ = ' ' " + CRLF
    TCQuery cQryAux New Alias "QRY_AUX"
    DbSelectArea("QRY_AUX")

    //Pega o total via RecCount da Query
    nTotalRec := QRY_AUX->(RecCount())
    QRY_AUX->(DbGoTop())

    //Pega o total via Count To da Query
    Count To nTotalCou
    QRY_AUX->(DbGoTop())
    QRY_AUX->(DbCloseArea())

    //Pega o total via RecCount da SB1
    DbSelectArea("SB1")
    nSB1Recno := SB1->(RecCount())
    SB1->(DbGoTop())

    //Pega o total via Count To da SB1
    Count To nSB1Count
    SB1->(DbGoTop())

    //Monta a mensagem e exibe
    cMensagem += "Query da SB1:" + CRLF
    cMensagem += "Total do <strong>RecCount</strong>: " + cValToChar(nTotalRec) + CRLF
    cMensagem += "Total do <strong>Count To</strong>: " + cValToChar(nTotalCou) + CRLF
    cMensagem += CRLF
    cMensagem += "SB1 padrão:" + CRLF
    cMensagem += "Total do <strong>RecCount</strong>: " + cValToChar(nSB1Recno) + CRLF
    cMensagem += "Total do <strong>Count To</strong>: " + cValToChar(nSB1Count) + CRLF
    MsgInfo(cMensagem, "Atenção")

    FWRestArea(aArea)
Return
