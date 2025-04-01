/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFonte14
Exemplo de como utilizar os operadores de subtração - (ele também funciona com atribuição -=)
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.engpro.totvs.com.br/display/tec/Operadores+Comuns
/*/

User Function zFonte14()
    Local aArea   := FWGetArea()
    Local nVar1   := 12
    Local nVar2   := 15
    Local nResult := 0

    //Faz a subtração de uma variável com outra
    nResult := nVar1 - nVar2
    nResult -= 5
    FWAlertInfo("O resultado é " + cValToChar(nResult), "Resultado da Subtração")

    FWRestArea(aArea)
Return
