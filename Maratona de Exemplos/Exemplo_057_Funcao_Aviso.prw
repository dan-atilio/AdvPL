/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/10/04/exibindo-mensagens-com-a-funcao-aviso-maratona-advpl-e-tl-057/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe057
Exemplo de função que mostra uma mensagem de aviso na tela
@type Function
@author Atilio
@since 05/12/2022
@see https://tdn.totvs.com/display/public/framework/Aviso
@obs 
    Função Aviso
    Parâmetros
        + cTitulo         , Caracter   , Mensagem no Título
        + cMsg            , Caracter   , Mensagem que será exibida na tela
        + aBotoes         , Array      , Array com as opções dos botões
        + nSize           , Numérico   , Tamanho da janela (podendo ser 1, 2 ou 3)
        + cText           , Caracter   , Título da Descrição (dentro da janela)
        + nRotAutDefault  , Numérico   , Opção padrão em caso de rotina automática
        + cBitmap         , Caracter   , Nome da imagem BITMAP dentro do Repositório (descontinuado a partir do Protheus 12)
        + lEdit           , Lógico     , Se .T. permitir editar a mensagem senão se for .F. não permite
        + nTimer          , Numérico   , Tempo para exibir a mensagem em milissegundos
        + nOpcPadrao      , Numérico   , Número da opção padrão do array
    Retorno
        + nOpcAviso       , Numérico   , Retorna a opção clicada pelo usuário

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe057()
    Local aArea   := FWGetArea()
    Local cMsg    := "Terminal de Informação"
    Local nOpc    := 0
    Local cMsgRet := cMsg

    //Mensagem pequena normal
    Aviso("Título Exemplo 1", cMsg, {"OK"}, 1, "Sub Título")

    //Mensagem média com botões
    nOpc := Aviso("Título Exemplo 2 (Botões)", cMsg, {"Sim", "Não", "Talvez"}, 2, "Sub Título")
    If nOpc == 1
        FWAlertInfo("Clicou no Sim", "Atenção")
    EndIf

    //Mensagem grande sendo possível editar
    Aviso("Título Exemplo 3 (Editável)", @cMsgRet, {"OK"}, 3, "Sub Título", , , .T.)
    FWAlertInfo(cMsgRet, "Conteúdo digitado")

    //Mensagem que fecha sozinha depois de 5 segundos
    cMsg += " (tela será fechada em 5 segundos)"
    Aviso("Título Exemplo 4 (Timer)", cMsg, {"OK"}, 2, "Sub Título", , , , 5000)

    FWRestArea(aArea)
Return
