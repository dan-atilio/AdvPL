/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/07/convertendo-um-valor-numerico-adicionando-zeros-a-esquerda-com-strzero-maratona-advpl-e-tl-462/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe462
Converte um valor numérico para caractere adicionando zeros a esqueda
@type Function
@author Atilio
@since 02/04/2023
@see https://tdn.totvs.com/display/tec/StrZero
@obs 
    Função StrZero
    Parâmetros
        + nValor        , Numérico     , Valor a ser analisado
        + nTamanho      , Numérico     , Define o tamanho que ficará a String
        + nDecimal      , Numérico     , Define o número de casas decimais após a vírgula
    Retorno
        + cRet          , Caractere    , Retorna a string conforme o valor informado

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe462()
    Local aArea     := FWGetArea()
    Local nValor    := 13.8
    Local cMensagem := ""

    //Monta a mensagem de teste
    cMensagem := "Valor (original):                 '" + cValToChar(nValor)     + "'" + CRLF
    cMensagem += "Valor com tamanho 8:              '" + StrZero(nValor, 8)     + "'" + CRLF
    cMensagem += "Valor com tamanho 8 e 2 decimais: '" + StrZero(nValor, 8, 2)  + "'" + CRLF

    //Exibe a mensagem
    ShowLog(cMensagem)

    FWRestArea(aArea)
Return
