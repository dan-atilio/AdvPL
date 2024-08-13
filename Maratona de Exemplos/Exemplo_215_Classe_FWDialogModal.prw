/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/04/criando-dialogs-com-a-fwdialogmodal-maratona-advpl-e-tl-215/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe215
Exemplo de função que cria uma dialog
@type Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/display/public/framework/FwDialogModal
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe215()
    Local aArea := FWGetArea()
    Local oDlgAux
    Local nJanAltu   := 100
    Local nJanLarg   := 200
    Local bBlocoTst  := {|| FWAlertInfo("Clicou no botão escrito 'Teste'", "Botão Teste")}
    Local cJanTitulo := "Tela usando FWDialogModal"

    //Instancia a classe, criando uma janela
    oDlgAux := FWDialogModal():New()
    oDlgAux:SetTitle(cJanTitulo)
    oDlgAux:SetSize(nJanAltu, nJanLarg)
    oDlgAux:EnableFormBar(.T.)
    oDlgAux:CreateDialog()
    oDlgAux:CreateFormBar()
    oDlgAux:AddButton("Teste", bBlocoTst, "Teste", , .T., .F., .T., )

    //Aqui antes de abrir a tela, caso você queira usar essa classe, pode usar o método oDlgAux:GetPanelMain()
    //   e instanciar os objetos apontando para esse painel
    
    oDlgAux:Activate()

    FWRestArea(aArea)
Return
