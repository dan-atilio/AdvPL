//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zVid0035
Função de exemplo para validar se tem strings que possuam apenas números
@type  Function
@author Atilio
@since 10/05/2022
/*/

User Function zVid0035()
    Local aArea := FWGetArea()
    Local cString01 := "Daniel"
    Local cString02 := "Dan123"
    Local cString03 := "123"
    Local cString04 := "123.45"

    FWAlertInfo("Abaixo os resultados:" + CRLF + ;
        "cString01: " + cValToChar(IsNumeric(cString01)) + CRLF + ;
        "cString02: " + cValToChar(IsNumeric(cString02)) + CRLF + ;
        "cString03: " + cValToChar(IsNumeric(cString03)) + CRLF + ;
        "cString04: " + cValToChar(IsNumeric(cString04));
    , "Resultado")

    FWRestArea(aArea)
Return
