/*
    Esse exemplo faz parte da s�rie do YouTube, Maratona de Exemplos, do canal Terminal de Informa��o, 
    caso queira ver esse exemplo rodando em v�deo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/17/executando-instrucoes-no-banco-com-tcsqlexec-e-tcsqlerror-maratona-advpl-e-tl-482/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe483
Retorna o plano de execu��o de uma query via AdvPL
@type Function
@author Atilio
@since 03/04/2023
@see https://tdn.totvs.com/display/tec/TCSqlPlan
@obs 

    TCSqlPlan
    Par�metros
        + cQuery      , Caractere      , Query que ser� analisada
        + aResult     , Array          , Array com o resultado do plano
        + nLevel      , Num�rico       , Define o n�vel de detalhamento
    Retorno
        + nRet        , Num�rico       , Retorna um n�mero com o resultado de execu��o da query (se menor que 0 aconteceu algum erro)

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe483()
    Local aArea     := FWGetArea()
    Local cQuery    := ""
    Local aResult   := {}
    Local aPlano    := {}
    Local nAtual    := 0
    Local cMensagem := ""

    cQuery := " SELECT " + CRLF
    cQuery += "     C5_NUM, " + CRLF
    cQuery += "     A1_NOME, " + CRLF
    cQuery += "     C6_ITEM, " + CRLF
    cQuery += "     C6_PRODUTO, " + CRLF
    cQuery += "     B1_DESC " + CRLF
    cQuery += " FROM " + CRLF
    cQuery += "     " + RetSQLName("SC5") + " SC5 " + CRLF
    cQuery += "     INNER JOIN " + RetSQLName("SA1") + " SA1 ON ( " + CRLF
    cQuery += "         A1_FILIAL = '" + FWxFilial("SA1") + "' " + CRLF
    cQuery += "         AND A1_COD = C5_CLIENTE " + CRLF
    cQuery += "         AND A1_LOJA = C5_LOJACLI " + CRLF
    cQuery += "         AND SA1.D_E_L_E_T_ = ' ' " + CRLF
    cQuery += "     ) " + CRLF
    cQuery += "     INNER JOIN " + RetSQLName("SC6") + " SC6 ON ( " + CRLF
    cQuery += "         C6_FILIAL = C5_FILIAL " + CRLF
    cQuery += "         AND C6_NUM = C5_NUM " + CRLF
    cQuery += "         AND C6_CLI = C5_CLIENTE " + CRLF
    cQuery += "         AND C6_LOJA = C5_LOJACLI " + CRLF
    cQuery += "         AND SC6.D_E_L_E_T_ = ' ' " + CRLF
    cQuery += "     ) " + CRLF
    cQuery += "     INNER JOIN " + RetSQLName("SB1") + " SB1 ON ( " + CRLF
    cQuery += "         B1_FILIAL = '" + FWxFilial("SB1") + "' " + CRLF
    cQuery += "         AND B1_COD = C6_PRODUTO " + CRLF
    cQuery += "         AND SB1.D_E_L_E_T_ = ' ' " + CRLF
    cQuery += "     ) " + CRLF
    cQuery += " WHERE " + CRLF
    cQuery += "     C5_FILIAL = '" + FWxFilial("SC5") + "' " + CRLF
    cQuery += "     AND C5_TIPO NOT IN ('B', 'D') " + CRLF
    cQuery += "     AND SC5.D_E_L_E_T_ = ' ' " + CRLF
    cQuery += " ORDER BY " + CRLF
    cQuery += "     C5_NUM, " + CRLF
    cQuery += "     C6_ITEM " + CRLF
    
    //Busca o plano de execu��o, se veio menor que zero, houve falha
    If TCSqlPlan(cQuery, @aResult) < 0
        FWAlertInfo("Falha: " + TCSQLError(), "Teste TCSqlPlan")
    Else
        aPlano := aResult[2]

        For nAtual := 1 To Len(aPlano)
            cMensagem += "[" + StrZero(nAtual, 4) + "] " + aPlano[nAtual][1] + CRLF
        Next
        ShowLog(cMensagem)
    EndIf

    FWRestArea(aArea)
Return
