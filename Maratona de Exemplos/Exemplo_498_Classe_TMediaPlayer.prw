/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/25/abrindo-videos-e-musicas-atraves-da-tmediaplayer-maratona-advpl-e-tl-498/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe498
Abre o Windows Media Player em uma Dialog
@type Function
@author Atilio
@since 04/04/2023
@see https://tdn.totvs.com/display/tec/TMediaPlayer
@obs 

    O exemplo dessa dialog foi baseado no link acima disponível no TDN

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe498()
    Local aArea         := FWGetArea()
    Local nCorFundo     := RGB(238, 238, 238)
    Local nJanAltura    := 500
    Local nJanLargur    := 800
    Local cJanTitulo    := 'Exemplo TMediaPlayer'
    Local lDimPixels    := .T. 
    Local lCentraliz    := .T. 
    Local nObjLinha     := 0
    Local nObjColun     := 0
    Local nObjLargu     := 0
    Local nObjAltur     := 0
    Local lShowBar      := .F.
    Local lIsMute       := .F.
    Local nVolume       := 70
    Private cFontNome   := 'Tahoma'
    Private oFontPadrao := TFont():New(cFontNome, , -12)
    Private oMedia
    Private oBtnOpen  , bBtnOpen   := {|| oMedia:OpenFile(FWInputBox("Escolha o arquivo", "C:\OBS\"))}
    Private oBtnPlay  , bBtnPlay   := {|| oMedia:Play()}
    Private oBtnPause , bBtnPause  := {|| oMedia:Pause()}
    Private oBtnStop  , bBtnStop   := {|| oMedia:Stop()}
    Private oBtnSetVol, bBtnSetVol := {|| oMedia:SetVolume(Val(FWInputBox("Insira o volume (0 a 100)", cValToChar(oMedia:nVolume))))}
    Private oBtnGetVol, bBtnGetVol := {|| FWAlertInfo("O volume está em " + cValToChar(oMedia:nVolume), "Teste TMediaPlayer")}
    Private oBtnShoBar, bBtnShoBar := {|| lShowBar := !lShowBar, oMedia:SetShowBar(lShowBar)}
    Private oBtnRepeat, bBtnRepeat := {|| oMedia:nPlayCount := (Val(FWInputBox("Defina o número de repetições", cValToChar(oMedia:nPlayCount))))}
    Private oBtnMute  , bBtnMute   := {|| lIsMute := !lIsMute, oMedia:SetMute(lIsMute)}
    
    //Cria a dialog
    oDialogPvt := TDialog():New(0, 0, nJanAltura, nJanLargur, cJanTitulo, , , , , , nCorFundo, , , lDimPixels)

        //Cria o Media Player
        nObjLinha := 3
        nObjColun := 3
        nObjLargu := (nJanLargur/2) - 56
        nObjAltur := (nJanAltura/2) - 3
        oMedia := TMediaPlayer():New(nObjLinha, nObjColun, nObjLargu, nObjAltur, oDialogPvt,"C:\OBS\Vídeos Prontos\intro_free.mp4", nVolume, lShowBar)

        //Cria os botões na direita
        nObjLinha := 3
        nObjColun := (nJanLargur/2) - 50
        nObjLargu := 47
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
        
    
    //Ativa e exibe a janela
    oDialogPvt:Activate(, , , lCentraliz)
    
    FWRestArea(aArea)
Return
