/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/20/estilizando-textos-atraves-da-tfont-maratona-advpl-e-tl-488/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe489
Cria campos em uma Dialog
@type Function
@author Atilio
@since 04/04/2023
@see https://tdn.totvs.com/display/tec/TGet
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe489()
    Local aArea         := FWGetArea()
    Local nCorFundo     := RGB(238, 238, 238)
    Local nJanAltura    := 281
    Local nJanLargur    := 318 
    Local cJanTitulo    := 'Exemplo TGet'
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
    Private cSayObj0    := 'Normal'  
    //objeto1 
    Private oGetObj1 
    Private xGetObj1    := sToD("") //Se o get for data para inicilizar use dToS(''), se for numerico inicie com 0  
    //objeto2 
    Private oSayObj2 
    Private cSayObj2    := 'Com ReadOnly'  
    //objeto3 
    Private oGetObj3 
    Private xGetObj3    := Space(10) //Se o get for data para inicilizar use dToS(''), se for numerico inicie com 0  
    //objeto4 
    Private oSayObj4 
    Private cSayObj4    := 'Inativo'  
    //objeto5 
    Private oGetObj5 
    Private xGetObj5    := Space(10) //Se o get for data para inicilizar use dToS(''), se for numerico inicie com 0  
    //objeto6 
    Private oSayObj6 
    Private cSayObj6    := 'PlaceHolder'  
    //objeto7 
    Private oGetObj7 
    Private xGetObj7    := Space(10) //Se o get for data para inicilizar use dToS(''), se for numerico inicie com 0  
    //objeto8 
    Private oSayObj8 
    Private cSayObj8    := 'Com F3'  
    //objeto9 
    Private oGetObj9 
    Private xGetObj9    := Space(10) //Se o get for data para inicilizar use dToS(''), se for numerico inicie com 0  
    //objeto10 
    Private oSayObj10 
    Private cSayObj10    := 'Com Picture'  
    //objeto11 
    Private oGetObj11 
    Private xGetObj11    := 0 //Se o get for data para inicilizar use dToS(''), se for numerico inicie com 0  
    //objeto12 
    Private oSayObj12 
    Private cSayObj12    := 'Com Valid'  
    //objeto13 
    Private oGetObj13 
    Private xGetObj13    := 0 //Se o get for data para inicilizar use dToS(''), se for numerico inicie com 0  
    //objeto14 
    Private oBtnObj14 
    Private cBtnObj14    := 'Button'  
    Private bBtnObj14    := {|| MsgInfo('Clicou no OK', 'Atenção')}  
    
    //Cria a dialog
    oDialogPvt := TDialog():New(0, 0, nJanAltura, nJanLargur, cJanTitulo, , , , , , nCorFundo, , , lDimPixels)
    
        //objeto0 - usando a classe TSay
        nObjLinha := 4
        nObjColun := 4
        nObjLargu := 40
        nObjAltur := 6
        oSayObj0  := TSay():New(nObjLinha, nObjColun, {|| cSayObj0}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

        //objeto1 - usando a classe TGet
        nObjLinha := 3
        nObjColun := 49
        nObjLargu := 100
        nObjAltur := 10
        oGetObj1  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , xGetObj1 := u, xGetObj1)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
        //oGetObj1:cPlaceHold := 'Digite aqui um texto...'   //Texto que sera exibido no campo antes de ter conteudo
        //oGetObj1:cF3        := 'Codigo da consulta padrao' //Codigo da consulta padrao / F3 que sera habilitada
        //oGetObj1:bValid     := {|| fFuncaoVld()}           //Funcao para validar o que foi digitado
        //oGetObj1:lReadOnly  := .T.                         //Para permitir o usuario clicar mas nao editar o campo
        //oGetObj1:lActive    := .F.                         //Para deixar o campo inativo e o usuario nao conseguir nem clicar
        //oGetObj1:Picture      := '@!'                        //Mascara / Picture do campo

        //objeto2 - usando a classe TSay
        nObjLinha := 19
        nObjColun := 4
        nObjLargu := 45
        nObjAltur := 6
        oSayObj2  := TSay():New(nObjLinha, nObjColun, {|| cSayObj2}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

        //objeto3 - usando a classe TGet
        nObjLinha := 18
        nObjColun := 49
        nObjLargu := 100
        nObjAltur := 10
        oGetObj3  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , xGetObj3 := u, xGetObj3)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
        //oGetObj3:cPlaceHold := 'Digite aqui um texto...'   //Texto que sera exibido no campo antes de ter conteudo
        //oGetObj3:cF3        := 'Codigo da consulta padrao' //Codigo da consulta padrao / F3 que sera habilitada
        //oGetObj3:bValid     := {|| fFuncaoVld()}           //Funcao para validar o que foi digitado
        oGetObj3:lReadOnly  := .T.                         //Para permitir o usuario clicar mas nao editar o campo
        //oGetObj3:lActive    := .F.                         //Para deixar o campo inativo e o usuario nao conseguir nem clicar
        //oGetObj3:Picture      := '@!'                        //Mascara / Picture do campo

        //objeto4 - usando a classe TSay
        nObjLinha := 34
        nObjColun := 4
        nObjLargu := 45
        nObjAltur := 6
        oSayObj4  := TSay():New(nObjLinha, nObjColun, {|| cSayObj4}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

        //objeto5 - usando a classe TGet
        nObjLinha := 33
        nObjColun := 49
        nObjLargu := 100
        nObjAltur := 10
        oGetObj5  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , xGetObj5 := u, xGetObj5)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
        //oGetObj5:cPlaceHold := 'Digite aqui um texto...'   //Texto que sera exibido no campo antes de ter conteudo
        //oGetObj5:cF3        := 'Codigo da consulta padrao' //Codigo da consulta padrao / F3 que sera habilitada
        //oGetObj5:bValid     := {|| fFuncaoVld()}           //Funcao para validar o que foi digitado
        //oGetObj5:lReadOnly  := .T.                         //Para permitir o usuario clicar mas nao editar o campo
        oGetObj5:lActive    := .F.                         //Para deixar o campo inativo e o usuario nao conseguir nem clicar
        //oGetObj5:Picture      := '@!'                        //Mascara / Picture do campo

        //objeto6 - usando a classe TSay
        nObjLinha := 49
        nObjColun := 4
        nObjLargu := 45
        nObjAltur := 6
        oSayObj6  := TSay():New(nObjLinha, nObjColun, {|| cSayObj6}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

        //objeto7 - usando a classe TGet
        nObjLinha := 48
        nObjColun := 49
        nObjLargu := 100
        nObjAltur := 10
        oGetObj7  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , xGetObj7 := u, xGetObj7)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
        oGetObj7:cPlaceHold := 'Digite aqui um texto...'   //Texto que sera exibido no campo antes de ter conteudo
        //oGetObj7:cF3        := 'Codigo da consulta padrao' //Codigo da consulta padrao / F3 que sera habilitada
        //oGetObj7:bValid     := {|| fFuncaoVld()}           //Funcao para validar o que foi digitado
        //oGetObj7:lReadOnly  := .T.                         //Para permitir o usuario clicar mas nao editar o campo
        //oGetObj7:lActive    := .F.                         //Para deixar o campo inativo e o usuario nao conseguir nem clicar
        //oGetObj7:Picture      := '@!'                        //Mascara / Picture do campo

        //objeto8 - usando a classe TSay
        nObjLinha := 64
        nObjColun := 4
        nObjLargu := 45
        nObjAltur := 6
        oSayObj8  := TSay():New(nObjLinha, nObjColun, {|| cSayObj8}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

        //objeto9 - usando a classe TGet
        nObjLinha := 63
        nObjColun := 49
        nObjLargu := 100
        nObjAltur := 10
        oGetObj9  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , xGetObj9 := u, xGetObj9)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels, /*uParam15*/, /*uParam16*/, /*bWhen*/, /*uParam18*/, /*uParam19*/, /*bChange*/, /*lReadOnly*/, /*lPassword*/, /*uParam23*/, /*cReadVar*/, /*uParam25*/, /*uParam26*/, /*uParam27*/, .T.)
        //oGetObj9:cPlaceHold := 'Digite aqui um texto...'   //Texto que sera exibido no campo antes de ter conteudo
        oGetObj9:cF3        := 'SB1' //Codigo da consulta padrao / F3 que sera habilitada
        //oGetObj9:bValid     := {|| fFuncaoVld()}           //Funcao para validar o que foi digitado
        //oGetObj9:lReadOnly  := .T.                         //Para permitir o usuario clicar mas nao editar o campo
        //oGetObj9:lActive    := .F.                         //Para deixar o campo inativo e o usuario nao conseguir nem clicar
        //oGetObj9:Picture      := '@!'                        //Mascara / Picture do campo

        //objeto10 - usando a classe TSay
        nObjLinha := 79
        nObjColun := 4
        nObjLargu := 45
        nObjAltur := 6
        oSayObj10  := TSay():New(nObjLinha, nObjColun, {|| cSayObj10}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

        //objeto11 - usando a classe TGet
        nObjLinha := 78
        nObjColun := 49
        nObjLargu := 100
        nObjAltur := 10
        oGetObj11  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , xGetObj11 := u, xGetObj11)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
        //oGetObj11:cPlaceHold := 'Digite aqui um texto...'   //Texto que sera exibido no campo antes de ter conteudo
        //oGetObj11:cF3        := 'Codigo da consulta padrao' //Codigo da consulta padrao / F3 que sera habilitada
        //oGetObj11:bValid     := {|| fFuncaoVld()}           //Funcao para validar o que foi digitado
        //oGetObj11:lReadOnly  := .T.                         //Para permitir o usuario clicar mas nao editar o campo
        //oGetObj11:lActive    := .F.                         //Para deixar o campo inativo e o usuario nao conseguir nem clicar
        oGetObj11:Picture      := '@E 999.99'                        //Mascara / Picture do campo

        //objeto12 - usando a classe TSay
        nObjLinha := 94
        nObjColun := 4
        nObjLargu := 45
        nObjAltur := 6
        oSayObj12  := TSay():New(nObjLinha, nObjColun, {|| cSayObj12}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

        //objeto13 - usando a classe TGet
        nObjLinha := 93
        nObjColun := 49
        nObjLargu := 100
        nObjAltur := 10
        oGetObj13  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , xGetObj13 := u, xGetObj13)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
        //oGetObj13:cPlaceHold := 'Digite aqui um texto...'   //Texto que sera exibido no campo antes de ter conteudo
        //oGetObj13:cF3        := 'Codigo da consulta padrao' //Codigo da consulta padrao / F3 que sera habilitada
        oGetObj13:bValid     := {|| fValidVlr()}           //Funcao para validar o que foi digitado
        //oGetObj13:lReadOnly  := .T.                         //Para permitir o usuario clicar mas nao editar o campo
        //oGetObj13:lActive    := .F.                         //Para deixar o campo inativo e o usuario nao conseguir nem clicar
        oGetObj13:Picture      := '@E 999'                        //Mascara / Picture do campo

        //objeto14 - usando a classe TButton
        nObjLinha := 116
        nObjColun := 2
        nObjLargu := (nJanLargur/2) - 4
        nObjAltur := 15
        oBtnObj14  := TButton():New(nObjLinha, nObjColun, cBtnObj14, oDialogPvt, bBtnObj14, nObjLargu, nObjAltur, , oFontPadrao, , lDimPixels)

    
    //Ativa e exibe a janela
    oDialogPvt:Activate(, , , lCentraliz, , , bBlocoIni)
    
    FWRestArea(aArea)
Return

Static Function fValidVlr()
    Local aArea := FWGetArea()
    Local lRet := .T.

    If xGetObj13 > 0
        lRet := .T.
    Else
        lRet := .F.
        Alert("Falha na validação")
    EndIf

    FWRestArea(aArea)
Return lRet
