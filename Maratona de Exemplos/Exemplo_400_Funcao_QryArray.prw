/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/07/executando-uma-query-e-pegando-o-resultado-em-um-array-com-a-qryarray-maratona-advpl-e-tl-400/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe400
Executa uma query e joga o resultado em um array
@type Function
@author Atilio
@since 28/03/2023
@obs 
    Função QryArray
    Parâmetros
        Query SQL
    Retorno
        Array com todas as linhas e colunas do resultado da query

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe400()
    Local aArea     := FWGetArea()
    Local cQryAux   := ""
    Local aDados    := {}

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
    aDados := QryArray(cQryAux)
    
    //Mostra uma mensagem
    FWAlertInfo("Foi encontrado " + cValToChar(Len(aDados)) + " registro(s), a posição 1 é: " + aDados[1][1], "Teste QryArray")

    FWRestArea(aArea)
Return
