/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/11/20/convertendo-variaveis-para-caractere-com-a-funcao-cvaltochar-maratona-advpl-e-tl-104/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe104
Converte valores para o tipo caractere
@type Function
@author Atilio
@since 12/12/2022
@see https://tdn.totvs.com/display/tec/cValToChar
@obs 
    Função cValToChar
    Parâmetros
        + xParametro    , Indefinido   , Valor a ser convertido (data, lógico, numérico)
    Retorno
        + cRet          , Caractere    , Retorna a string conforme o valor informado

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe104()
    Local aArea     := FWGetArea()
    Local dData     := Date()
    Local nValor    := 13.8
    Local lLogico   := .T.
    Local cMensagem := ""

    //Monta a mensagem de teste
    cMensagem += "Data: "     + cValToChar(dData)    + CRLF
    cMensagem += "Numérico: " + cValToChar(nValor)   + CRLF
    cMensagem += "Lógico: "   + cValToChar(lLogico)

    //Exibe a mensagem
    FWAlertInfo(cMensagem, "Teste de cValToChar")

    FWRestArea(aArea)
Return
