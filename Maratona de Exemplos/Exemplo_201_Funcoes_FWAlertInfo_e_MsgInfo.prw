/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/28/mostrando-mensagens-com-icone-vermelho-fwalerterror-alert-e-msgstop-maratona-advpl-e-tl-200/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe201
Função que exibe uma mensagem em tela com um símbolo de informação
@type Function
@author Atilio
@since 12/02/2023
@see https://tdn.totvs.com/display/tec/MsgInfo
@obs 
    Função MsgInfo
    Parâmetros
        + cTexto      , Caractere        , Texto da mensagem
        + cTitulo     , Caractere        , Título da janela da mensagem
    Retorno
        Função não tem retorno

    Função FWAlertInfo
    Parâmetros
        + Texto da mensagem
        + Título da janela da mensagem
    Retorno
        Função não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe201()
    Local aArea     := FWGetArea()
    Local cMensagem := ""

    //Monta uma mensagem normal e exibe
    cMensagem := "Hoje é " + dToC(Date())
    FWAlertInfo(cMensagem, "Teste FWAlertInfo")
    MsgInfo(cMensagem, "Teste MsgInfo")

    //Monta uma mensagem com quebra de linhas
    cMensagem := "Hoje é " + dToC(Date()) + CRLF + "Terminal de Informação"
    FWAlertInfo(cMensagem, "Teste 2 FWAlertInfo")
    MsgInfo(cMensagem, "Teste 2 MsgInfo")

    //Monta uma mensagem com tags html
    cMensagem := "Hoje é <strong>" + dToC(Date()) +"</strong><br><font color='red'>Terminal de Informação</font>"
    FWAlertInfo(cMensagem, "Teste 3 FWAlertInfo")
    MsgInfo(cMensagem, "Teste 3 MsgInfo")

    FWRestArea(aArea)
Return
