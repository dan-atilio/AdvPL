/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFonte07
Exemplo de como utilizar o operador @ (Arroba), passando uma variável por referência (similar a um ponteiro)
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.engpro.totvs.com.br/display/tec/Operadores+Especiais
/*/

User Function zFonte07()
    Local aArea   := FWGetArea()
    Local cTexto1 := "Daniel"
    Local cTexto2 := "Atilio"

    //Aciona a função estática
    fTrocaTxt(cTexto1, @cTexto2)

    //Mostrando como ficaram as variáveis
    FWAlertInfo("Variáveis - cTexto1: " + cTexto1 + ", cTexto2: " + cTexto2, "Exemplo de passagem por referência")

    FWRestArea(aArea)
Return

Static Function fTrocaTxt(cVar01, cVar02)
    cVar01 := "aaa"
    cVar02 := "bbb"
Return
