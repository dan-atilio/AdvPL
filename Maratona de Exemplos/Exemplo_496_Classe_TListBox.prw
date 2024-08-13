/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/24/criando-uma-listagem-de-informacoes-com-tlistbox-maratona-advpl-e-tl-496/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe496
Cria uma pequena grid em uma Dialog
@type Function
@author Atilio
@since 04/04/2023
@see https://tdn.totvs.com/display/tec/TListBox
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe496()
    Local aArea         := FWGetArea()
    Local nCorFundo     := RGB(238, 238, 238)
    Local nJanAltura    := 228
    Local nJanLargur    := 318 
    Local cJanTitulo    := 'Exemplo TListBox'
    Local lDimPixels    := .T. 
    Local lCentraliz    := .T. 
    Local nObjLinha     := 0
    Local nObjColun     := 0
    Local nObjLargu     := 0
    Local nObjAltur     := 0
    Private cFontNome   := 'Tahoma'
    Private oFontPadrao := TFont():New(cFontNome, , -12)
    Private oDialogPvt 
    Private bBlocoIni   := {|| /*fSuaFuncao()*/ } //Aqui voce pode acionar funcoes customizadas que irao ser acionadas ao abrir a dialog 
    //objeto0 
    Private oLisObj0 
    Private nLisObj0    := 0  
    Private aLisObj0    := {'YouTube', 'Instagram', 'Twitter', 'Facebook', 'e-Mail'}  
    //objeto1 
    Private oBtnObj1 
    Private cBtnObj1    := 'Confirmar'  
    Private bBtnObj1    := {|| MsgYesNo('Você nos segue via "' + aLisObj0[oLisObj0:nAt] + '"?', 'Dúvida')}  
    
    //Cria a dialog
    oDialogPvt := TDialog():New(0, 0, nJanAltura, nJanLargur, cJanTitulo, , , , , , nCorFundo, , , lDimPixels)
    
        //objeto0 - usando a classe TListBox
        nObjLinha := 6
        nObjColun := 8
        nObjLargu := 142
        nObjAltur := 80
        oLisObj0  := TListBox():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , nLisObj0 := u, nLisObj0)}, aLisObj0, nObjLargu, nObjAltur, /*bChange*/, oDialogPvt, /*bValid*/, , , lDimPixels, , /*bLDBLClick*/, oFontPadrao)

        //objeto1 - usando a classe TButton
        nObjLinha := 95
        nObjColun := 8
        nObjLargu := 65
        nObjAltur := 15
        oBtnObj1  := TButton():New(nObjLinha, nObjColun, cBtnObj1, oDialogPvt, bBtnObj1, nObjLargu, nObjAltur, , oFontPadrao, , lDimPixels)

    
    //Ativa e exibe a janela
    oDialogPvt:Activate(, , , lCentraliz, , , bBlocoIni)
    
    FWRestArea(aArea)
Return
