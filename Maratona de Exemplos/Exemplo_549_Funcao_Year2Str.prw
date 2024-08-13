/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/20/pegando-o-numero-do-ano-com-year-maratona-advpl-e-tl-548/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe549
Pega uma expressão e retorna o ano dela (se for data) ou converte para caractere (se for numérica) ou adiciona zeros a esquerda (se for caractere)
@type Function
@author Atilio
@since 07/04/2023
@obs 

    Função Year2Str
    Parâmetros
        Recebe a expressão no formato Data ou Numérico ou Caractere
    Retorno
        Retorna o ano no formato caractere com 4 digitos "YYYY"

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe549()
	Local aArea     := FWGetArea()
    Local cMensagem := ""

    //Monta a mensagem que será exibida
    cMensagem := "Via Data: "      + Year2Str(Date()) + CRLF
    cMensagem += "Via Número: "    + Year2Str(1993)   + CRLF
    cMensagem += "Via Caractere: " + Year2Str("123")  + CRLF
    FWAlertInfo(cMensagem, "Teste Year2Str")

    FWRestArea(aArea)
Return
