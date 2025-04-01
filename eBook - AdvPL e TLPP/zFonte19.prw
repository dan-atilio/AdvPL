/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFonte19
Exemplo de como utilizar os operadores Maior e Maior/Igual (> e >=)
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.engpro.totvs.com.br/display/tec/Operadores+Comuns
/*/

User Function zFonte19()
    Local aArea   := FWGetArea()
    Local nVar1   := 2
    Local nVar2   := 2

    //Somente se a variável for menor que a da direita
    If nVar1 > nVar2
        FWAlertInfo("A nVar1 é maior que a nVar2", "Primeiro teste")
    EndIf

    //Somente se a variável for menor ou igual a da direita
    If nVar1 >= nVar2
        FWAlertInfo("A nVar1 é maior ou igual a nVar2", "Segundo teste")
    EndIf

    FWRestArea(aArea)
Return
