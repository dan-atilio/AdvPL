/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/04/validando-se-uma-expressao-esta-vazia-com-a-funcao-empty-maratona-advpl-e-tl-152/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe153
Cria uma barra na tela com botões como Confirmar, Cancelar e Outras Ações
@type Function
@author Atilio
@since 18/12/2022
@obs 
    Função EnchoiceBar
    Parâmetros
        + Nome da Dialog que a EnchoiceBar será vinculada
        + Ação ao clicar no botão Confirmar
        + Ação ao clicar no botão Cancelar
        + Se for .T. mostra uma mensagem de deseja realmente excluir
        + Botões do Outras Ações
        + Número do Recno que será posicionado da tabela
        + Tabela de onde esta sendo feito as operações
        + Ativa a função Mashups no Outras Ações
    Retorno
        Função não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe153()
    Local aArea       := FWGetArea()
    Local nJanAltu   := 200
    Local nJanLarg   := 600
    Local lDimPixels := .T.
    Local lCentraliz := .T.
    Local bBlocoOk   := {|| lOk := .T., oDlgAux:End()}
    Local bBlocoCan  := {|| lOk := .F., oDlgAux:End()}
    Local aOutrasAc  := { {"BMP", {|| Alert("Cliquei no 1")}, "Botão 1"}, {"BMP", {|| Alert("Cliquei no 2")}, "Botão 2"} }
    Local bBlocoIni  := {|| EnchoiceBar(oDlgAux, bBlocoOk, bBlocoCan, , aOutrasAc)}
    Local cJanTitulo := "Tela usando TDialog com EnchoiceBar"
    Private oDlgAux
    Private lOk      := .F.

    //Cria a dialog
    oDlgAux := TDialog():New(0, 0, nJanAltu, nJanLarg, cJanTitulo, , , , , , /*nCorFundo*/, , , lDimPixels)

    //Ativa e exibe a janela
    oDlgAux:Activate(, , , lCentraliz, , , bBlocoIni)

    //Se o retorno for positivo, foi clicado no botão Confirmar ao invés do Cancelar
    If lOk
        FWAlertSuccess("Foi clicado no botão Confirmar!", "OK")
    EndIf

    FWRestArea(aArea)
Return
