/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFonte16
Exemplo de como utilizar os operadores de divisão e divisão com atribuição / e /=
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.engpro.totvs.com.br/display/tec/Operadores+Comuns
/*/

User Function zFonte16()
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
