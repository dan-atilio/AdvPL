/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} zFonte29
Exemplo de estrutura de condicao com Do Case
@author Atilio
@since 29/02/2020
@version 1.0
@type function
@see https://tdn.totvs.com/display/public/framework/DO+CASE
/*/

User Function zFonte29()
	Local aArea  := GetArea()
    Local cNome  := ""
    Local nTipo  := 0
    
    //Definindo 1 nome
    cNome := Upper("Maria")

    Do Case
        Case cNome == "JOAO"
            nTipo := 1
        
        Case cNome == "MARIA"
            nTipo := 2
        
        Otherwise
            nTipo := 3
    EndCase

    Alert("Tipo = " + cValToChar(nTipo))

    RestArea(aArea)
Return
