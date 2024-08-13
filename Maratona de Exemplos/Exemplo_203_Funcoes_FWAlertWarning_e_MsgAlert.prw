/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/29/mostrando-mensagens-com-icone-verde-atraves-da-fwalertsuccess-maratona-advpl-e-tl-202/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe203
Função que exibe uma mensagem em tela com um símbolo de cuidado / atenção
@type Function
@author Atilio
@since 12/02/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=24346992
@obs 
    Função MsgAlert
    Parâmetros
        + cTexto      , Caractere        , Texto da mensagem
        + cTitulo     , Caractere        , Título da janela da mensagem
    Retorno
        Função não tem retorno

    Função FWAlertWarning
    Parâmetros
        + Texto da mensagem
        + Título da janela da mensagem
    Retorno
        Função não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe203()
    Local aArea     := FWGetArea()
    Local cMensagem := ""

    //Monta uma mensagem normal e exibe
    cMensagem := "Hoje é " + dToC(Date())
    FWAlertWarning(cMensagem, "Teste FWAlertWarning")
    MsgAlert(cMensagem, "Teste MsgAlert")

    //Monta uma mensagem com quebra de linhas
    cMensagem := "Hoje é " + dToC(Date()) + CRLF + "Terminal de Informação"
    FWAlertWarning(cMensagem, "Teste 2 FWAlertWarning")
    MsgAlert(cMensagem, "Teste 2 MsgAlert")

    //Monta uma mensagem com tags html
    cMensagem := "Hoje é <strong>" + dToC(Date()) +"</strong><br><font color='red'>Terminal de Informação</font>"
    FWAlertWarning(cMensagem, "Teste 3 FWAlertWarning")
    MsgAlert(cMensagem, "Teste 3 MsgAlert")

    FWRestArea(aArea)
Return
