/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/12/separando-horas-minutos-e-segundos-com-a-funcao-extracttime-maratona-advpl-e-tl-168/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe168
Função para extrair informações de uma string com "hh:mm:ss"
@type Function
@author Atilio
@since 19/12/2022
@obs 
    Função ExtractPath
    Parâmetros
        + Hora no formato "hh:mm:ss"
        + Quantidade de horas
        + Quantidade de minutos
        + Quantidade de segundos
        + Define o tipo de retorno ("h" ou "m" ou "s")
    Retorno
        + Retorno conforme cRet

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe168()
    Local aArea     := FWGetArea()
    Local cHoraAtu  := Time()
    Local nHoras    := 0
    Local nMinutos  := 0
    Local nSegundos := 0
    Local cMensagem := ""

    //Faz a extração do tempo e atualiza as variáveis
    ExtractTime(cHoraAtu, @nHoras, @nMinutos, @nSegundos)

    //Exibindo uma mensagem
    cMensagem := "Hora atual: " + cHoraAtu + CRLF + CRLF
    cMensagem += "Horas: "      + cValToChar(nHoras) + CRLF
    cMensagem += "Minutos: "    + cValToChar(nMinutos) + CRLF
    cMensagem += "Segundos: "   + cValToChar(nSegundos)
    FWAlertInfo(cMensagem, "Teste com ExtractTime")

    FWRestArea(aArea)
Return
