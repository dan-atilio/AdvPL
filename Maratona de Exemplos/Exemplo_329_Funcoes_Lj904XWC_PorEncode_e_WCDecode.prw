/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/01/tratando-caracteres-especiais-pra-web-com-lj904xwc-porencode-e-wcdecode-maratona-advpl-e-tl-329/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe329
Converte uma string para o padrão usado em HTML
@type Function
@author Atilio
@since 12/03/2023
@obs 

    Função Lj904XWC
    Parâmetros
        Recebe uma string com os caracteres a serem tratados
    Retorno
        Retorna uma string formatada

    Função PorEncode
    Parâmetros
        Recebe uma string com os caracteres a serem tratados
        Recebe um parâmetro lógico se irá formatar em HTML (.T.) ou se irá formatar barras e -enters- (.F.)
    Retorno
        Retorna uma string formatada

    Função WCDecode
    Parâmetros
        Recebe uma string com os caracteres a serem tratados
    Retorno
        Retorna uma string formatada

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe329()
    Local aArea     := FWGetArea()
    Local cFrase    := "A aranha arranha a rã. A rã arranha a aranha. Nem a aranha arranha a rã. Nem a rã arranha a aranha."
    Local cMensagem := ""
     
    //Aciona aqui as conversões
    cMensagem += "Lj904XWC:  '" + Lj904XWC(cFrase)  + "'" + CRLF + CRLF
    cMensagem += "PorEncode: '" + PorEncode(cFrase) + "'" + CRLF + CRLF
    cMensagem += "WCDecode:  '" + WCDecode(cFrase)  + "'" + CRLF + CRLF
    ShowLog(cMensagem)
     
    FWRestArea(aArea)
Return
