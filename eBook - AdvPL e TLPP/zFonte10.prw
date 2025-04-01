/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFonte10
Exemplo de como utilizar o operador : (Dois Pontos), para acessar um atributo ou método de uma classe
@type Function
@author Atilio
@since 26/11/2022
/*/

User Function zFonte10()
    Local aArea  := FWGetArea()
    Local oFont
    
    //Instancia uma classe na variável oFont através do método New
    oFont := TFont():New('Arial', , -16)

    //Acessando e modificando um atributo
    FWAlertInfo("Conteúdo do atributo Negrito: " + cValToChar(oFont:Bold), "Antes")
    oFont:Bold := .T.
    FWAlertInfo("Conteúdo do atributo Negrito: " + cValToChar(oFont:Bold), "Depois")

    FWRestArea(aArea)
Return
