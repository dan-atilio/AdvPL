/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/15/buscando-a-quantidade-de-dias-em-um-ano-com-a-getyeardaysnumber-maratona-advpl-e-tl-294/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe294
Retorna a quantidade de dias em um ano normal ou bissexto
@type  Function
@author Atilio
@since 21/02/2023
@obs 
    
    Função GetYearDaysNumber
    Parâmetros
        Recebe o ano em caractere
    Retorno
        Retorna o número de dias

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe294()
    Local aArea      := FWGetArea()
    Local nAnoAtual  := 0
    Local nAnoNormal := 0
    Local nAnoBissex := 0
    Local cMensagem  := ""
     
    //Busca os dias do ano atual, de um ano normal e de um ano bissexsto
    nAnoAtual  := GetYearDaysNumber(cValToChar(Year(Date()))) + 1
    nAnoNormal := GetYearDaysNumber("2021") + 1
    nAnoBissex := GetYearDaysNumber("2024") + 1
     
    //Monta a mensagem e exibe
    cMensagem += "Ano Atual: " + cValToChar(nAnoAtual) + CRLF
    cMensagem += "Ano Normal: " + cValToChar(nAnoNormal) + CRLF
    cMensagem += "Ano Bissexto: " + cValToChar(nAnoBissex) + CRLF
    FWAlertInfo(cMensagem, "Teste GetYearDaysNumber")

    FWRestArea(aArea)
Return
