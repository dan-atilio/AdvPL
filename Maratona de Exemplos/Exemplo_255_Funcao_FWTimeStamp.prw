/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/24/formatando-data-e-hora-com-a-fwtimestamp-maratona-advpl-e-tl-255/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe255
Retorna a data e hora pré formatadas
@type  Function
@author Atilio
@since 21/02/2023
@see https://tdn.totvs.com/display/public/framework/FWTimeStamp
@obs 

    Função FWTimeStamp
    Parâmetros
		+ nType          , Numérico        , Tipo da formatação (ver mais no link do TDN disponível acima)
		+ dDate          , Data            , Data a ser formatada (se não enviar nada pega da Date() atual)
		+ cTime          , Caractere       , Hora a ser formatada (se não enviar nada pega da Time() atual)
    Retorno
        Retorna um texto a data pré formatada
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe255()
    Local aArea      := FWGetArea()
    Local cMensagem  := ""
    Local dData      := Date()
    Local cHora      := Time()

    //Monta uma mensagem com todos os tipos disponíveis do FWTimeStamp
    cMensagem += "1: " + FWTimeStamp(1, dData, cHora) + CRLF //aaaammddhhmmss
    cMensagem += "2: " + FWTimeStamp(2, dData, cHora) + CRLF //dd/mm/aaaa-hh:mm:ss
    cMensagem += "3: " + FWTimeStamp(3, dData, cHora) + CRLF //aaaa-mm-ddThh:mm:ss
    cMensagem += "4: " + FWTimeStamp(4, dData, cHora) + CRLF //Total em milissegundos desde 01/01/1970
    cMensagem += "5: " + FWTimeStamp(5, dData, cHora) + CRLF //aaaa-mm-ddThh:mm:ss-+Time Zone
    cMensagem += "6: " + FWTimeStamp(6, dData, cHora)        //aaaa-mm-ddThh:mm:ssZ

    //Exibe a mensagem
    FWAlertInfo(cMensagem, "Teste FWTimeStamp")

    FWRestArea(aArea)
Return
