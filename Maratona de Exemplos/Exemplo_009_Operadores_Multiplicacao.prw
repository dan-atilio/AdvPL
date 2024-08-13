/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/08/17/operador-para-multiplicacoes-maratona-advpl-e-tl-009/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe009
Exemplo de como utilizar os operadores de multiplicação e multiplicação com atribuição * e *=
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.engpro.totvs.com.br/display/tec/Operadores+Comuns
@obs
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe009()
    Local aArea   := FWGetArea()
    Local nVar1   := 2
    Local nVar2   := 5
    Local nResult := 0

    //Faz a multiplicação de um pelo outro
    nResult := nVar1 * nVar2
    FWAlertInfo("O resultado é " + cValToChar(nResult), "Resultado da Multiplicação")

    //Faz a multiplicação direto pela atribuição
    nResult *= 3
    FWAlertInfo("O resultado é " + cValToChar(nResult), "Resultado da Multiplicação")

    FWRestArea(aArea)
Return
