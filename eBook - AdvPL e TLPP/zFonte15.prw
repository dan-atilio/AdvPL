/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFonte15
Exemplo de como utilizar os operadores de soma e incremento + (eles também funcionam com atribuição +=)
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.engpro.totvs.com.br/display/tec/Operadores+Comuns
/*/

User Function zFonte15()
    Local aArea   := FWGetArea()
    Local nVar1   := 12
    Local nVar2   := 15
    Local nResult := 0
    Local cVar1   := "Daniel"
    Local cVar2   := "Atilio"
    Local cResult := ""

    //Faz a soma de uma variável com outra
    nResult := nVar1 + nVar2
    nResult += 5
    FWAlertInfo("O resultado é " + cValToChar(nResult), "Resultado da Soma")

    //Faz a multiplicação direto pela atribuição (5 * 5)
    cResult := cVar1 + " " + cVar2
    cResult += " aaaa"
    FWAlertInfo("O resultado é " + cResult, "Resultado do Incremento")

    FWRestArea(aArea)
Return
