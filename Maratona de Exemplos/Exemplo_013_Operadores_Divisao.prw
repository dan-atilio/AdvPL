/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/08/21/operador-de-divisao-maratona-advpl-e-tl-013/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe013
Exemplo de como utilizar os operadores de divisão e divisão com atribuição / e /=
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.engpro.totvs.com.br/display/tec/Operadores+Comuns
@obs
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe013()
    Local aArea   := FWGetArea()
    Local nResult := 0

    //Faz a divisão de um pelo outro
    nResult := 100 / 2
    FWAlertInfo("O resultado é " + cValToChar(nResult), "Resultado da Divisão")

    //Faz a divisão direto pela atribuição
    nResult /= 5
    FWAlertInfo("O resultado é " + cValToChar(nResult), "Resultado da Divisão")

    FWRestArea(aArea)
Return
