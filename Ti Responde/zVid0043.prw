/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2023/02/13/como-fazer-um-tget-que-posiciona-nele-mesmo-ti-responde-043/ 
    
*/


//Bibliotecas
#Include 'TOTVS.ch'

/*/{Protheus.doc} User Function zVid0043
Funcao com tela customizada usando a classe TDialog que foi gerado pelo PDialogMaker
@type  Function
@author Atilio
@since 28/07/2022 
@see https://atiliosistemas.com/portfolio/pdialogmaker/
@obs Obrigado por usar um aplicativo da Atilio Sistemas
/*/

User Function zVid0043()
    Local aArea         := FWGetArea()
    Local nCorFundo     := RGB(204, 255, 204)
    Local nJanAltura    := 118
    Local nJanLargur    := 221 
    Local cJanTitulo    := 'Teste TGet'
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
    Private oGetObj0 
    Private xGetObj0    := Space(10) //Se o get for data para inicilizar use dToS(''), se for numerico inicie com 0  
    //objeto1 
    Private oSayObj1 
    Private cSayObj1    := ''  
    //objeto2 
    Private oGetObj2 
    Private xGetObj2    := Space(10) //Se o get for data para inicilizar use dToS(''), se for numerico inicie com 0  
    //objeto3 
    Private oBtnObj3 
    Private cBtnObj3    := 'Fechar'  
    Private bBtnObj3    := {|| oDialogPvt:End()}  
    
    //Cria a dialog
    oDialogPvt := TDialog():New(0, 0, nJanAltura, nJanLargur, cJanTitulo, , , , , , nCorFundo, , , lDimPixels)
    
        //objeto0 - usando a classe TGet
        nObjLinha := 5
        nObjColun := 5
        nObjLargu := 100
        nObjAltur := 10
        oGetObj0  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , xGetObj0 := u, xGetObj0)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
        oGetObj0:bValid := {|| fVldGet()}

        //objeto1 - usando a classe TSay
        nObjLinha := 18
        nObjColun := 5
        nObjLargu := 100
        nObjAltur := 6
        oSayObj1  := TSay():New(nObjLinha, nObjColun, {|| cSayObj1}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

        //objeto2 - usando a classe TGet
        nObjLinha := 84
        nObjColun := 70
        nObjLargu := 1
        nObjAltur := 1
        oGetObj2  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , xGetObj2 := u, xGetObj2)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
        oGetObj2:bGotFocus:={|| oGetObj0:SetFocus()}

        //objeto3 - usando a classe TButton
        nObjLinha := 40
        nObjColun := 5
        nObjLargu := 50
        nObjAltur := 15
        oBtnObj3  := TButton():New(nObjLinha, nObjColun, cBtnObj3, oDialogPvt, bBtnObj3, nObjLargu, nObjAltur, , oFontPadrao, , lDimPixels)

    
    //Ativa e exibe a janela
    oDialogPvt:Activate(, , , lCentraliz, , , bBlocoIni)
    
    FWRestArea(aArea)
Return

Static Function fVldGet()
    Local lRet := .T.

    cSayObj1 := "Texto lido: '" + xGetObj0 + "'"
Return lRet
