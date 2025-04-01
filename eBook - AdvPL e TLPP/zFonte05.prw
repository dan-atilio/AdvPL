/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFonte05
Exemplo de como utilizar o operador := (Dois Pontos e Igual), para atribuir um valor a uma variável
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.engpro.totvs.com.br/pages/viewpage.action?pageId=6063089
/*/

User Function zFonte05()
    Local aArea   := FWGetArea()
    Local xValor
    Local nValor2 AS Numeric

    //Atribui os valores das duas variáveis
    xValor  := 5
    nValor2 := 10
    FWAlertInfo("Após as primeiras atribuições - " + cValToChar(xValor), "Atenção")

    //Atribui os valores das duas variáveis
    xValor  := "aaa"
    //nValor2 := "bbb"
    FWAlertInfo("Após as segundas atribuições - " + xValor, "Atenção")

    FWRestArea(aArea)
Return
