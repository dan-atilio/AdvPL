/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFonte11
Exemplo de como utilizar os operadores de comparação (==) e o por que de evitarmos o de atribuição (=)
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.engpro.totvs.com.br/display/tec/Operadores+Comuns
/*/

User Function zFonte11()
    Local aArea   := FWGetArea()
    Local cVar    := "Atilio"
    
    //Demonstrando que o = é para atribuição
    cVar = "Daniel"
    FWAlertInfo("cVar é: " + cVar, "= é Atribuição!")

    //Logo ao usar em comparação, erros estranhos podem ocasionar, como:
    If "ZZZZ" = "ZZZ"
        FWAlertInfo("Caiu dentro desse IF por causa de utilizar um único igual!", "'ZZZZ' é igual 'ZZZ' ???")
    EndIf

    //Portanto, o correto é como boa prática usar := para atribuições e o == para comparações
    cVar := "Dan"
    If Upper(cVar) == "DAN"
        FWAlertInfo("Caiu no If do Exatamente Igual", "Agora sim")
    EndIf

    FWRestArea(aArea)
Return
