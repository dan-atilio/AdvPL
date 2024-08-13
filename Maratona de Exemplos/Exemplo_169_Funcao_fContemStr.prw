/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/12/validando-se-uma-string-esta-contida-na-outra-com-fcontemstr-maratona-advpl-e-tl-169/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe169
Verifica se uma string esta contida em outra
@type Function
@author Atilio
@since 19/12/2022
@obs 
    Função fContemStr
    Parâmetros
        + Primeira string
        + Segunda string
        + Define se o teste é das duas strings serem iguais (.T.) ou uma estiver contida na outra (.F.)
    Retorno
        + Retorna .T. se uma string estiver contida na outra / ou for igual senão retorna .F.

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe169()
    Local aArea     := FWGetArea()
    Local cTexto1   := "daniel"
    Local cTexto2   := "DAN"

    //Se uma string estiver contida na outra
    If fContemStr(cTexto1, cTexto2)
        FWAlertSuccess("A string '" + cTexto1 + "' esta contida ou contém a string '" + cTexto2 + "'", "Teste com fContemStr")
    Else
        FWAlertError("Falha na validação, uma string não esta contida na outra", "Teste com fContemStr")
    EndIf

    FWRestArea(aArea)
Return
