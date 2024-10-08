/*
    Esse exemplo faz parte da s�rie do YouTube, Maratona de Exemplos, do canal Terminal de Informa��o, 
    caso queira ver esse exemplo rodando em v�deo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/01/buscando-a-classe-de-um-objeto-com-a-getclassname-maratona-advpl-e-tl-266/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe266
Retorna o nome da classe de um objeto
@type  Function
@author Atilio
@since 21/02/2023
@see https://tdn.totvs.com/display/tec/GetClassName
@obs 

    Fun��o GetClassName
    Par�metros
        + oObjeto        , Objeto           , Vari�vel com o objeto instanciado de uma classe
    Retorno
        + cClassName     , Caractere        , Nome da classe usada no Objeto
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe266()
    Local aArea         := FWGetArea()
    Local nCorFundo     := RGB(238, 238, 238)
    Local nJanAltura    := 281
    Local nJanLargur    := 358 
    Local cJanTitulo    := 'Exemplo GetClassName'
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
    //objeto4 
    Private oBtnConf 
    Private cBtnObj8    := 'Confirmar' 
    Private bBtnObj8    := {|| fConfirma()}  
     
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

        //objeto4 - usando a classe TButton
        nObjLinha := 116
        nObjColun := 2
        nObjLargu := (nJanLargur/2) - 2
        nObjAltur := 15
        oBtnConf  := TButton():New(nObjLinha, nObjColun, cBtnObj8, oDialogPvt, bBtnObj8, nObjLargu, nObjAltur, , oFontPadrao, , lDimPixels)
     
    //Ativa e exibe a janela
    oDialogPvt:Activate(, , , lCentraliz, , , bBlocoIni)
     
    FWRestArea(aArea)
Return

Static Function fConfirma()
    Local cMensagem := ""

    //Busca a classe dos objetos em tela
    cMensagem += "oDialogPvt: " + GetClassName(oDialogPvt) + CRLF
    cMensagem += "oSayInsira: " + GetClassName(oSayInsira) + CRLF
    cMensagem += "oGetTexto: "  + GetClassName(oGetTexto) + CRLF
    cMensagem += "oBtnConf: "   + GetClassName(oBtnConf)
    FWAlertInfo(cMensagem, "Teste GetClassName")
Return
