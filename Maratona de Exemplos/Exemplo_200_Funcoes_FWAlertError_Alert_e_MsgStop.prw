/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/28/mostrando-mensagens-com-icone-azul-atraves-das-fwalertinfo-e-msginfo-maratona-advpl-e-tl-201/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe200
Função que exibe uma mensagem em tela com um símbolo de erro
@type Function
@author Atilio
@since 11/02/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=23889111 e https://tdn.totvs.com/pages/releaseview.action?pageId=24346998
@obs 
    Função Alert
    Parâmetros
        + cTexto      , Caractere        , Texto da mensagem
    Retorno
        Função não tem retorno

    Função MsgStop
    Parâmetros
        + cTexto      , Caractere        , Texto da mensagem
        + cTitulo     , Caractere        , Título da janela da mensagem
    Retorno
        Função não tem retorno

    Função FWAlertError
    Parâmetros
        + Texto da mensagem
        + Título da janela da mensagem
    Retorno
        Função não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe200()
    Local aArea     := FWGetArea()
    Local cMensagem := ""

    //Monta uma mensagem normal e exibe
    cMensagem := "Hoje é " + dToC(Date())
    FWAlertError(cMensagem, "Teste FWAlertError")
    MsgStop(cMensagem, "Teste MsgStop")
    Alert(cMensagem)

    //Monta uma mensagem com quebra de linhas
    cMensagem := "Hoje é " + dToC(Date()) + CRLF + "Terminal de Informação"
    FWAlertError(cMensagem, "Teste 2 FWAlertError")
    MsgStop(cMensagem, "Teste 2 MsgStop")
    Alert(cMensagem)

    //Monta uma mensagem com tags html
    cMensagem := "Hoje é <strong>" + dToC(Date()) +"</strong><br><font color='red'>Terminal de Informação</font>"
    FWAlertError(cMensagem, "Teste 3 FWAlertError")
    MsgStop(cMensagem, "Teste 3 MsgStop")
    Alert(cMensagem)

    FWRestArea(aArea)
Return
