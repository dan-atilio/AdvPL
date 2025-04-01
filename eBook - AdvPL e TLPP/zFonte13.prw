/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFonte13
Exemplo de como utilizar os operadores de multiplicação e multiplicação com atribuição * e *=
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.engpro.totvs.com.br/display/tec/Operadores+Comuns
/*/

User Function zFonte13()
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
