/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2024/12/10/como-colocar-uma-imagem-em-um-tbutton-ti-responde-0106/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zVid0106
Exemplo de botões com imagens
@type  Function
@author Atilio
@since 04/03/2024
/*/

User Function zVid0106()
    Local aArea         := FWGetArea()
    Local nCorFundo     := RGB(238, 238, 238)
    Local nJanAltura    := 340
    Local nJanLargur    := 160
    Local cJanTitulo    := 'Exemplo botões'
    Local lDimPixels    := .T. 
    Local lCentraliz    := .T. 
    Local nObjLinha     := 0
    Local nObjColun     := 0
    Local nObjLargu     := 0
    Local nObjAltur     := 0
    Private cFontNome   := 'Tahoma'
    Private oFontPadrao := TFont():New(cFontNome, , -12)
    Private oMedia
    Private oBtnOpen  , bBtnOpen   := {|| Alert("...")}
    Private oBtnPlay  , bBtnPlay   := {|| Alert("...")}
    Private oBtnPause , bBtnPause  := {|| Alert("...")}
    Private oBtnStop  , bBtnStop   := {|| Alert("...")}
    Private oBtnSetVol, bBtnSetVol := {|| Alert("...")}
    Private oBtnGetVol, bBtnGetVol := {|| Alert("...")}
    Private oBtnShoBar, bBtnShoBar := {|| Alert("...")}
    Private oBtnRepeat, bBtnRepeat := {|| Alert("...")}
    Private oBtnMute  , bBtnMute   := {|| Alert("...")}
    
    //Cria a dialog
    oDialogPvt := TDialog():New(0, 0, nJanAltura, nJanLargur, cJanTitulo, , , , , , nCorFundo, , , lDimPixels)

        //Cria os botões na direita
        nObjLinha := 3
        nObjColun := (nJanLargur/2) - 70
        nObjLargu := 67
        nObjAltur := 15
        oBtnOpen   := TButton():New(nObjLinha + ((nObjAltur + 3) * 0), nObjColun, "Abrir Arq.",  oDialogPvt, bBtnOpen  , nObjLargu, nObjAltur, , oFontPadrao, , lDimPixels)
        oBtnPlay   := TButton():New(nObjLinha + ((nObjAltur + 3) * 1), nObjColun, "Play",        oDialogPvt, bBtnPlay  , nObjLargu, nObjAltur, , oFontPadrao, , lDimPixels)
        oBtnPause  := TButton():New(nObjLinha + ((nObjAltur + 3) * 2), nObjColun, "Pausar",      oDialogPvt, bBtnPause , nObjLargu, nObjAltur, , oFontPadrao, , lDimPixels)
        oBtnStop   := TButton():New(nObjLinha + ((nObjAltur + 3) * 3), nObjColun, "Parar",       oDialogPvt, bBtnStop  , nObjLargu, nObjAltur, , oFontPadrao, , lDimPixels)
        oBtnSetVol := TButton():New(nObjLinha + ((nObjAltur + 3) * 4), nObjColun, "Def. Volume", oDialogPvt, bBtnSetVol, nObjLargu, nObjAltur, , oFontPadrao, , lDimPixels)
        oBtnGetVol := TButton():New(nObjLinha + ((nObjAltur + 3) * 5), nObjColun, "Ver Volume",  oDialogPvt, bBtnGetVol, nObjLargu, nObjAltur, , oFontPadrao, , lDimPixels)
        oBtnShoBar := TButton():New(nObjLinha + ((nObjAltur + 3) * 6), nObjColun, "Mostr.Barra", oDialogPvt, bBtnShoBar, nObjLargu, nObjAltur, , oFontPadrao, , lDimPixels)
        oBtnRepeat := TButton():New(nObjLinha + ((nObjAltur + 3) * 7), nObjColun, "Repetir",     oDialogPvt, bBtnRepeat, nObjLargu, nObjAltur, , oFontPadrao, , lDimPixels)
        oBtnMute   := TButton():New(nObjLinha + ((nObjAltur + 3) * 8), nObjColun, "Mudo",        oDialogPvt, bBtnMute  , nObjLargu, nObjAltur, , oFontPadrao, , lDimPixels)
        
        //Definindo imagens a serem exibidas nos botões
        oBtnOpen:SetCSS(  "TButton { " + fBackImg("rpo:open.png")       + " font: bold;     background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #3DAFCC, stop: 1 #0D9CBF);    color: #FFFFFF;     border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:focus {    padding:0px; outline-width:1px; outline-style:solid; outline-color: #51DAFC; outline-radius:3px; border-color:#369CB5;}TButton:hover {    color: #FFFFFF;     background-color : qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #3DAFCC, stop: 1 #1188A6);    border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:pressed {    color: #FFF;     background-color : qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #1188A6, stop: 1 #3DAFCC);    border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:disabled {    color: #FFFFFF;     background-color: #4CA0B5; }")
        oBtnPlay:SetCSS(  "TButton { " + fBackImg("rpo:play.png")       + " font: bold;     background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #3DAFCC, stop: 1 #0D9CBF);    color: #FFFFFF;     border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:focus {    padding:0px; outline-width:1px; outline-style:solid; outline-color: #51DAFC; outline-radius:3px; border-color:#369CB5;}TButton:hover {    color: #FFFFFF;     background-color : qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #3DAFCC, stop: 1 #1188A6);    border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:pressed {    color: #FFF;     background-color : qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #1188A6, stop: 1 #3DAFCC);    border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:disabled {    color: #FFFFFF;     background-color: #4CA0B5; }")
        oBtnPause:SetCSS( "TButton { " + fBackImg("rpo:coltot.png")     + " font: bold;     background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #3DAFCC, stop: 1 #0D9CBF);    color: #FFFFFF;     border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:focus {    padding:0px; outline-width:1px; outline-style:solid; outline-color: #51DAFC; outline-radius:3px; border-color:#369CB5;}TButton:hover {    color: #FFFFFF;     background-color : qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #3DAFCC, stop: 1 #1188A6);    border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:pressed {    color: #FFF;     background-color : qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #1188A6, stop: 1 #3DAFCC);    border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:disabled {    color: #FFFFFF;     background-color: #4CA0B5; }")
        oBtnStop:SetCSS(  "TButton { " + fBackImg("rpo:stop.png")       + " font: bold;     background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #3DAFCC, stop: 1 #0D9CBF);    color: #FFFFFF;     border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:focus {    padding:0px; outline-width:1px; outline-style:solid; outline-color: #51DAFC; outline-radius:3px; border-color:#369CB5;}TButton:hover {    color: #FFFFFF;     background-color : qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #3DAFCC, stop: 1 #1188A6);    border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:pressed {    color: #FFF;     background-color : qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #1188A6, stop: 1 #3DAFCC);    border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:disabled {    color: #FFFFFF;     background-color: #4CA0B5; }")
        oBtnSetVol:SetCSS("TButton { " + fBackImg("rpo:pmssetatop.png") + " font: bold;     background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #3DAFCC, stop: 1 #0D9CBF);    color: #FFFFFF;     border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:focus {    padding:0px; outline-width:1px; outline-style:solid; outline-color: #51DAFC; outline-radius:3px; border-color:#369CB5;}TButton:hover {    color: #FFFFFF;     background-color : qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #3DAFCC, stop: 1 #1188A6);    border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:pressed {    color: #FFF;     background-color : qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #1188A6, stop: 1 #3DAFCC);    border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:disabled {    color: #FFFFFF;     background-color: #4CA0B5; }")
        oBtnGetVol:SetCSS("TButton { " + fBackImg("rpo:chat.png")       + " font: bold;     background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #3DAFCC, stop: 1 #0D9CBF);    color: #FFFFFF;     border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:focus {    padding:0px; outline-width:1px; outline-style:solid; outline-color: #51DAFC; outline-radius:3px; border-color:#369CB5;}TButton:hover {    color: #FFFFFF;     background-color : qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #3DAFCC, stop: 1 #1188A6);    border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:pressed {    color: #FFF;     background-color : qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #1188A6, stop: 1 #3DAFCC);    border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:disabled {    color: #FFFFFF;     background-color: #4CA0B5; }")
        oBtnShoBar:SetCSS("TButton { " + fBackImg("rpo:dbg09.png")      + " font: bold;     background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #3DAFCC, stop: 1 #0D9CBF);    color: #FFFFFF;     border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:focus {    padding:0px; outline-width:1px; outline-style:solid; outline-color: #51DAFC; outline-radius:3px; border-color:#369CB5;}TButton:hover {    color: #FFFFFF;     background-color : qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #3DAFCC, stop: 1 #1188A6);    border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:pressed {    color: #FFF;     background-color : qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #1188A6, stop: 1 #3DAFCC);    border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:disabled {    color: #FFFFFF;     background-color: #4CA0B5; }")
        oBtnRepeat:SetCSS("TButton { " + fBackImg("rpo:pmsrrfsh.png")   + " font: bold;     background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #3DAFCC, stop: 1 #0D9CBF);    color: #FFFFFF;     border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:focus {    padding:0px; outline-width:1px; outline-style:solid; outline-color: #51DAFC; outline-radius:3px; border-color:#369CB5;}TButton:hover {    color: #FFFFFF;     background-color : qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #3DAFCC, stop: 1 #1188A6);    border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:pressed {    color: #FFF;     background-color : qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #1188A6, stop: 1 #3DAFCC);    border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:disabled {    color: #FFFFFF;     background-color: #4CA0B5; }")
        oBtnMute:SetCSS(  "TButton { " + fBackImg("rpo:qmt_no.png")     + " font: bold;     background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #3DAFCC, stop: 1 #0D9CBF);    color: #FFFFFF;     border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:focus {    padding:0px; outline-width:1px; outline-style:solid; outline-color: #51DAFC; outline-radius:3px; border-color:#369CB5;}TButton:hover {    color: #FFFFFF;     background-color : qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #3DAFCC, stop: 1 #1188A6);    border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:pressed {    color: #FFF;     background-color : qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #1188A6, stop: 1 #3DAFCC);    border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:disabled {    color: #FFFFFF;     background-color: #4CA0B5; }")
        

    //Ativa e exibe a janela
    oDialogPvt:Activate(, , , lCentraliz)
    
    FWRestArea(aArea)
Return

Static Function fBackImg(cImagem)
    Local cTextoCSS := 'padding-left: 25px; background-image: url(' + cImagem + '); background-repeat: none; background-position: left center;'
Return cTextoCSS
