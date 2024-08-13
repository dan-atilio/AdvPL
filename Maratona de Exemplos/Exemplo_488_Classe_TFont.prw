/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/20/criando-campos-em-tela-com-tget-maratona-advpl-e-tl-489/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe488
Classe para modificar as fontes de um objeto instanciado
@type Function
@author Atilio
@since 04/04/2023
@see https://tdn.totvs.com/display/tec/TFont
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe488()
    Local aArea         := FWGetArea()
    Local nCorFundo     := RGB(238, 238, 238)
    Local nJanAltura    := 222
    Local nJanLargur    := 404 
    Local cJanTitulo    := 'Exemplo TFont'
    Local lDimPixels    := .T. 
    Local lCentraliz    := .T. 
    Local nObjLinha     := 0
    Local nObjColun     := 0
    Local nObjLargu     := 0
    Local nObjAltur     := 0
    Private oDialogPvt 
    Private bBlocoIni   := {|| /*fSuaFuncao()*/ } //Aqui voce pode acionar funcoes customizadas que irao ser acionadas ao abrir a dialog 
    //objeto0 
    Private oSayObj0 
    Private cSayObj0    := 'Tahoma, -12, Normal'  
    Private oFontPad    := TFont():New("Tahoma", /*uPar2*/, -12)
    //objeto1 
    Private oSayObj1 
    Private cSayObj1    := 'Tahoma, -12, Negrito'  
    Private oFontNeg    := TFont():New("Tahoma", /*uPar2*/, -12, /*uPar4*/, .T.)
    //objeto2 
    Private oSayObj2 
    Private cSayObj2    := 'Tahoma, -14, Sublinhado'  
    Private oFontSub    := TFont():New("Tahoma", /*uPar2*/, -14, /*uPar4*/, .F., /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .T.)
    //objeto3 
    Private oSayObj3 
    Private cSayObj3    := 'Tahoma, -16, Itálico'  
    Private oFontIta    := TFont():New("Tahoma", /*uPar2*/, -16, /*uPar4*/, .F., /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .F., .T.)
    //objeto4 
    Private oSayObj4 
    Private cSayObj4    := 'Arial, -10, Tudo'  
    Private oFontTudo    := TFont():New("Arial", /*uPar2*/, -10, /*uPar4*/, .T., /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .T., .T.)
    
    //Cria a dialog
    oDialogPvt := TDialog():New(0, 0, nJanAltura, nJanLargur, cJanTitulo, , , , , , nCorFundo, , , lDimPixels)
    
        //objeto0 - usando a classe TSay
        nObjLinha := 9
        nObjColun := 7
        nObjLargu := 200
        nObjAltur := 20
        oSayObj0  := TSay():New(nObjLinha, nObjColun, {|| cSayObj0}, oDialogPvt, /*cPicture*/, oFontPad, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

        //objeto1 - usando a classe TSay
        nObjLinha := 29
        nObjColun := 7
        nObjLargu := 200
        nObjAltur := 20
        oSayObj1  := TSay():New(nObjLinha, nObjColun, {|| cSayObj1}, oDialogPvt, /*cPicture*/, oFontNeg, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

        //objeto2 - usando a classe TSay
        nObjLinha := 49
        nObjColun := 7
        nObjLargu := 200
        nObjAltur := 20
        oSayObj2  := TSay():New(nObjLinha, nObjColun, {|| cSayObj2}, oDialogPvt, /*cPicture*/, oFontSub, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

        //objeto3 - usando a classe TSay
        nObjLinha := 69
        nObjColun := 7
        nObjLargu := 200
        nObjAltur := 20
        oSayObj3  := TSay():New(nObjLinha, nObjColun, {|| cSayObj3}, oDialogPvt, /*cPicture*/, oFontIta, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

        //objeto4 - usando a classe TSay
        nObjLinha := 89
        nObjColun := 7
        nObjLargu := 200
        nObjAltur := 20
        oSayObj4  := TSay():New(nObjLinha, nObjColun, {|| cSayObj4}, oDialogPvt, /*cPicture*/, oFontTudo, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

    
    //Ativa e exibe a janela
    oDialogPvt:Activate(, , , lCentraliz, , , bBlocoIni)
    
    FWRestArea(aArea)
Return
