/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/16/formatando-uma-string-de-horas-com-a-gtformathour-maratona-advpl-e-tl-296/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe296
Formata uma string de horas colocando uma máscara
@type  Function
@author Atilio
@since 22/02/2023
@obs 
    
    Função GTFormatHour
    Parâmetros
        Recebe a hora
        Recebe a máscara
    Retorno
        Retorna a hora formatada conforme a máscara

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe296()
    Local aArea      := FWGetArea()
    Local cHoraAtual := Time()
    Local cMensagem  := ""
    
    //Monta a mensagem e exibe
    cMensagem += "Exemplo 1: " + GTFormatHour(cHoraAtual, "99")        + CRLF
    cMensagem += "Exemplo 2: " + GTFormatHour(cHoraAtual, "9999")      + CRLF
	cMensagem += "Exemplo 3: " + GTFormatHour(cHoraAtual, "99:99")     + CRLF
	cMensagem += "Exemplo 4: " + GTFormatHour(cHoraAtual, "99.99")     + CRLF
	cMensagem += "Exemplo 5: " + GTFormatHour(cHoraAtual, "99h")       + CRLF
	cMensagem += "Exemplo 6: " + GTFormatHour(cHoraAtual, "99h99")     + CRLF
    FWAlertInfo(cMensagem, "Teste GTFormatHour")

    FWRestArea(aArea)
Return
