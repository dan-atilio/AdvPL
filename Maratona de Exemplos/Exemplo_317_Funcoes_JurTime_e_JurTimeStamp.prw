/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/26/manipulando-jsons-com-a-jsonobject-maratona-advpl-e-tl-316/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe317
Retorna data e hora com milissegundos e pré formatada
@type Function
@author Atilio
@since 25/02/2023
@obs 
    JurTime
    Parâmetros
        Recebe se deve enviar a data (.T.) ou não (.F.)
        Recebe se a string de retorno deve ser formatada (.T.) ou não (.F.)
    Retorno
        Retorna a string com o resultado

    JurTimeStamp
    Parâmetros
        Recebe o tipo da operação (1 = data com hora e milissegundos; 2 = função com data e hora e milissegundos; 3 = data abreviada e hora abreviada)
    Retorno
        Retorna a string com o resultado

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe317()
    Local aArea      := FWGetArea()
    Local cMensagem  := ""

    //Monta a mensagem e exibe
    cMensagem := ".T. e .T.: " + JurTime(.T., .T.) + CRLF
    cMensagem += ".T. e .F.: " + JurTime(.T., .F.) + CRLF
    cMensagem += ".F. e .T.: " + JurTime(.F., .T.) + CRLF
    cMensagem += ".F. e .F.: " + JurTime(.F., .F.)
    FWAlertInfo(cMensagem, "Teste JurTime")

    //Monta a mensagem e exibe
    cMensagem := "Tipo 1: " + JurTimeStamp(1) + CRLF
    cMensagem += "Tipo 2: " + JurTimeStamp(2) + CRLF
    cMensagem += "Tipo 3: " + JurTimeStamp(3)
    FWAlertInfo(cMensagem, "Teste JurTimeStamp")

    FWRestArea(aArea)
Return
