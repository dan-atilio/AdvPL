/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/08/18/operador-ou-para-realizar-exponenciacao-maratona-advpl-e-tl-010/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe010
Exemplo de como utilizar os operadores de exponenciação ** e ^ (eles também funcionam com atribuição **= e ^=)
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.engpro.totvs.com.br/display/tec/Operadores+Comuns
@obs
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe010()
    Local aArea   := FWGetArea()
    Local nVar1   := 2
    Local nVar2   := 5
    Local nResult := 0

    //Faz a exponenciação de um pelo outro (2 * 2 * 2 * 2 * 2)
    nResult := nVar1 ** nVar2
    FWAlertInfo("O resultado é " + cValToChar(nResult), "Resultado da Exponenciação / Potenciação")

    //Faz a multiplicação direto pela atribuição (5 * 5)
    nResult := nVar2 ^ nVar1
    FWAlertInfo("O resultado é " + cValToChar(nResult), "Resultado da Exponenciação / Potenciação")

    FWRestArea(aArea)
Return
