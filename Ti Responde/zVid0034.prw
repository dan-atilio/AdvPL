//Bibliotecas
#Include 'TOTVS.ch'

/*/{Protheus.doc} User Function zVid0034
Funcao com tela customizada usando a classe TDialog que foi gerado pelo PDialogMaker
@type  Function
@author Atilio
@since 07/05/2022 
@see https://atiliosistemas.com/portfolio/pdialogmaker/
@obs Obrigado por usar um aplicativo da Atilio Sistemas
/*/

User Function zVid0034()
    Local aArea         := FWGetArea()
    Local nCorFundo     := RGB(238, 238, 238)
    Local nJanAltura    := 146
    Local nJanLargur    := 246 
    Local cJanTitulo    := 'Teste Colar / Ctrl+V'
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
    Private cSayObj0    := 'Insira o Texto:'  
    //objeto1 
    Private oGetInput 
    Private cGetInput    := Space(20) //Se o get for data para inicilizar use dToS(''), se for numerico inicie com 0  
    //objeto2 
    Private oBtnObj2 
    Private cBtnObj2    := 'Confirmar'  
    Private bBtnObj2    := {|| MsgInfo('Foi inserido: "' + cGetInput + '"', 'Atenção')}  
    
    //Cria a dialog
    oDialogPvt := TDialog():New(0, 0, nJanAltura, nJanLargur, cJanTitulo, , , , , , nCorFundo, , , lDimPixels)
    
        //objeto0 - usando a classe TSay
        nObjLinha := 10
        nObjColun := 9
        nObjLargu := 200
        nObjAltur := 6
        oSayObj0  := TSay():New(nObjLinha, nObjColun, {|| cSayObj0}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

        //objeto1 - usando a classe TGet
        nObjLinha := 28
        nObjColun := 9
        nObjLargu := 100
        nObjAltur := 10
        oGetInput  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , cGetInput := u, cGetInput)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
        //oGetInput:cPlaceHold := 'Digite aqui um texto...'   //Texto que sera exibido no campo antes de ter conteudo
        //oGetInput:cF3        := 'Codigo da consulta padrao' //Codigo da consulta padrao / F3 que sera habilitada
        //oGetInput:lReadOnly  := .T.                         //Para permitir o usuario clicar mas nao editar o campo
        //oGetInput:lActive    := .F.                         //Para deixar o campo inativo e o usuario nao conseguir nem clicar
        //oGetInput:cPict      := '@!'                        //Mascara / Picture do campo
        oGetInput:bValid     := {|| fFuncaoVld()}           //Funcao para validar o que foi digitado

        //objeto2 - usando a classe TButton
        nObjLinha := 49
        nObjColun := 9
        nObjLargu := 50
        nObjAltur := 15
        oBtnObj2  := TButton():New(nObjLinha, nObjColun, cBtnObj2, oDialogPvt, bBtnObj2, nObjLargu, nObjAltur, , oFontPadrao, , lDimPixels)

    
    //Ativa e exibe a janela
    oDialogPvt:Activate(, , , lCentraliz, , , bBlocoIni)
    
    FWRestArea(aArea)
Return

Static Function fFuncaoVld()
    Local aArea      := FWGetArea()
	Local lRet       := .T.
	Local cEmMemoria := PasteFromClipboard()
    Local cConteudo  := Iif( Empty(ReadVar()), cGetInput, &(ReadVar()) )

	//Compara o get com o que existe na memória, se for, irá abortar a operação
	If Alltrim(cConteudo) == Alltrim(cEmMemoria)
		lRet := .F.
		cSayObj0 := "A opção Colar não pode ser usada!"
        oSayObj0:nClrText := RGB(255, 0, 0)
    Else
        cSayObj0 := "Insira o Texto:"
        oSayObj0:nClrText := RGB(0, 0, 0)
	EndIf
    oSayObj0:Refresh()
	
	FWRestArea(aArea)
Return lRet
