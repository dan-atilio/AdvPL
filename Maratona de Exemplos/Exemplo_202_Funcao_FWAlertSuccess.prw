/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/29/mostrando-mensagens-com-icone-amarelo-usando-fwalertwarning-e-msgalert-maratona-advpl-e-tl-203/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe202
Função que exibe uma mensagem em tela com um símbolo de êxito
@type Function
@author Atilio
@since 12/02/2023
@obs 

    Função FWAlertSuccess
    Parâmetros
        + Texto da mensagem
        + Título da janela da mensagem
    Retorno
        Função não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe202()
    Local aArea     := FWGetArea()
    Local cMensagem := ""

    //Monta uma mensagem normal e exibe
    cMensagem := "Hoje é " + dToC(Date())
    FWAlertSuccess(cMensagem, "Teste FWAlertSuccess")

    //Monta uma mensagem com quebra de linhas
    cMensagem := "Hoje é " + dToC(Date()) + CRLF + "Terminal de Informação"
    FWAlertSuccess(cMensagem, "Teste 2 FWAlertSuccess")

    //Monta uma mensagem com tags html
    cMensagem := "Hoje é <strong>" + dToC(Date()) +"</strong><br><font color='red'>Terminal de Informação</font>"
    FWAlertSuccess(cMensagem, "Teste 3 FWAlertSuccess")

    FWRestArea(aArea)
Return
