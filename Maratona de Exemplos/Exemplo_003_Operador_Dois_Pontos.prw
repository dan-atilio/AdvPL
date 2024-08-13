/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/08/11/operador-para-acessar-atributos-e-metodos-de-um-objeto-classe-maratona-advpl-e-tl-003/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe003
Exemplo de como utilizar o operador : (Dois Pontos), para acessar um atributo ou método de uma classe
@type Function
@author Atilio
@since 26/11/2022
@obs
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe003()
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
