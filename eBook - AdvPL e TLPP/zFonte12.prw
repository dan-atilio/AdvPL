/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFonte12
Exemplo de como utilizar os operadores de exponenciação ** e ^ (eles também funcionam com atribuição **= e ^=)
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.engpro.totvs.com.br/display/tec/Operadores+Comuns
/*/

User Function zFonte12()
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
