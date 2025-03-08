/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/02/18/como-abrir-um-site-pelo-navegador-via-codigo-fonte-ti-responde-0126/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zVid0126
Demonstração em como abrir um site pelo navegador
@type  Function
@author Atilio
@since 22/02/2024
/*/

User Function zVid0126()
    Local aArea := FWGetArea()
    Local cURL  := "https://atiliosistemas.com"

    //Mostra uma pergunta
    If FWAlertYesNo("Deseja abrir o site <strong>" + cURL + "</strong>?", "Continua?")
    
        //Abre o link pelo navegador
        ShellExecute("Open", cURL, "", "", 1)
    EndIf

    FWRestArea(aArea)
Return
