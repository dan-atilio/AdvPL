/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/29/realizando-tratativas-com-try-catch-maratona-advpl-e-tl-506/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe507
Cria labels de texto dentro de uma dialog
@type Function
@author Atilio
@since 04/04/2023
@see https://tdn.totvs.com/display/tec/TSay
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe507()
    Local aArea         := FWGetArea()
    Local nCorFundo     := RGB(238, 238, 238)
    Local nJanAltura    := 222
    Local nJanLargur    := 404 
    Local cJanTitulo    := 'Exemplo TSay'
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
    Private oSayObj0 
    Private cSayObj0    := 'Label comum'  
    //objeto1 
    Private oSayObj1 
    Private cSayObj1    := '<h3>Label html - <font color="blue">teste</font></h3>'  
    //objeto2 
    Private oSayObj2 
    Private cSayObj2    := 'Label com cores'  
    //objeto3 
    Private oSayObj3 
    Private cSayObj3    := 'Label com CSS'  
    //objeto4 
    Private oSayObj4 
    Private cSayObj4    := 'Label com clique'  
    
    //Cria a dialog
    oDialogPvt := TDialog():New(0, 0, nJanAltura, nJanLargur, cJanTitulo, , , , , , nCorFundo, , , lDimPixels)
    
        //objeto0 - usando a classe TSay
        nObjLinha := 9
        nObjColun := 7
        nObjLargu := 180
        nObjAltur := 15
        oSayObj0  := TSay():New(nObjLinha, nObjColun, {|| cSayObj0}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

        //objeto1 - usando a classe TSay
        nObjLinha := 29
        nObjColun := 7
        nObjLargu := 180
        nObjAltur := 15
        oSayObj1  := TSay():New(nObjLinha, nObjColun, {|| cSayObj1}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , .T.)

        //objeto2 - usando a classe TSay
        nObjLinha := 49
        nObjColun := 7
        nObjLargu := 180
        nObjAltur := 15
        oSayObj2  := TSay():New(nObjLinha, nObjColun, {|| cSayObj2}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, RGB(255, 0, 0), /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

        //objeto3 - usando a classe TSay
        nObjLinha := 69
        nObjColun := 7
        nObjLargu := 180
        nObjAltur := 15
        oSayObj3  := TSay():New(nObjLinha, nObjColun, {|| cSayObj3}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)
        oSayObj3:SetCSS("background-color: #FF0000; color: #0D0D0D}")

        //objeto4 - usando a classe TSay
        nObjLinha := 89
        nObjColun := 7
        nObjLargu := 180
        nObjAltur := 15
        oSayObj4  := TSay():New(nObjLinha, nObjColun, {|| cSayObj4}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)
        oSayObj4:bLClicked  := {|| FWAlertInfo("Clique com o botão esquerdo do Mouse", "bLClicked")}
        oSayObj4:bRClicked  := {|| FWAlertInfo("Clique com o botão direito do Mouse", "bRClicked")}
        //oSayObj4:bLDblClick := {|| FWAlertInfo("Duplo clique com o botão esquerdo do Mouse", "bLDblClick")}

    
    //Ativa e exibe a janela
    oDialogPvt:Activate(, , , lCentraliz, , , bBlocoIni)
    
    FWRestArea(aArea)
Return
