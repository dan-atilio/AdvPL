/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/17/gerando-um-qrcode-atraves-da-classe-fwqrcode-maratona-advpl-e-tl-241/
*/


//Bibliotecas
#Include 'TOTVS.ch'
 
/*/{Protheus.doc} User Function zExe241
Função que gera um QRCode em tela
@type Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/display/public/framework/FwQrCode
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe241()
	Local aArea         := FWGetArea()
    Local nCorFundo     := RGB(238, 238, 238)
    Local nJanAltura    := 281
    Local nJanLargur    := 358 
    Local cJanTitulo    := 'Exemplo FWQrCode'
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
    //objeto1 
    Private oSayInsira 
    Private cSayInsira    := 'Insira o Texto:' 
    //objeto2 
    Private oGetTexto 
    Private cGetTexto    := "https://terminaldeinformacao.com" + Space(200)
    //objeto 3
    Private oQrCode
    //objeto4 
    Private oBtnObj8 
    Private cBtnObj8    := 'Confirmar' 
    Private bBtnObj8    := {|| fAtualiza()}  
     
    //Cria a dialog
    oDialogPvt := TDialog():New(0, 0, nJanAltura, nJanLargur, cJanTitulo, , , , , , nCorFundo, , , lDimPixels)
     
        //objeto1 - usando a classe TSay
        nObjLinha := 4
        nObjColun := 4
        nObjLargu := 70
        nObjAltur := 6
        oSayInsira  := TSay():New(nObjLinha, nObjColun, {|| cSayInsira}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)
 
        //objeto2 - usando a classe TGet
        nObjLinha := 3
        nObjColun := 64
        nObjLargu := 110
        nObjAltur := 10
        oGetTexto  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , cGetTexto := u, cGetTexto)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
 
        //objeto3 - usando a classe FWQRCode
        nObjLinha := 19
        nObjColun := 44
        nObjLargu := 180
        nObjAltur := 180
        oQrCode := FwQrCode():New({nObjLinha, nObjColun, nObjLargu, nObjAltur}, oDialogPvt, cGetTexto)

        //objeto4 - usando a classe TButton
        nObjLinha := 116
        nObjColun := 2
        nObjLargu := (nJanLargur/2) - 2
        nObjAltur := 15
        oBtnObj8  := TButton():New(nObjLinha, nObjColun, cBtnObj8, oDialogPvt, bBtnObj8, nObjLargu, nObjAltur, , oFontPadrao, , lDimPixels)
     
    //Ativa e exibe a janela
    oDialogPvt:Activate(, , , lCentraliz, , , bBlocoIni)
     
    FWRestArea(aArea)
Return

Static Function fAtualiza()
    //Somente se houver texto, irá atualizar na tela
    If ! Empty(cGetTexto)
        oQrCode:SetCodeBar(cGetTexto)
        oQrCode:Refresh()
    EndIf
Return
