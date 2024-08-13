/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/01/executando-queries-com-a-plsquery-maratona-advpl-e-tl-388/
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "POSCSS.ch"

/*/{Protheus.doc} User Function zExe389
Retorna o estilo CSS de objetos instanciados
@type  Function
@author Atilio
@since 28/03/2023
@obs 

    Função PosCSS
    Parâmetros
        Nome da classe do objeto
        Tipo do CSS buscado
        Complementos do CSS para alguns casos
    Retorno
        Retorna o CSS encontrado
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe389()
    Local aArea         := FWGetArea()
    Local nCorFundo     := RGB(238, 238, 238)
    Local nJanAltura    := 281
    Local nJanLargur    := 358 
    Local cJanTitulo    := 'Exemplo PosCSS'
    Local lDimPixels    := .T. 
    Local lCentraliz    := .T. 
    Local nObjLinha     := 0
    Local nObjColun     := 0
    Local nObjLargu     := 0
    Local nObjAltur     := 0
    Local lPosCSS       := FWAlertYesNo("Deseja utilizar o POSCSS?", "Confirma?")
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
        nObjAltur := 12
        oSayInsira  := TSay():New(nObjLinha, nObjColun, {|| cSayInsira}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)
        If lPosCSS
            oSayInsira:SetCSS(PosCss(GetClassName(oSayInsira), CSS_LABEL_FOCAL, {'16',.F.})) 
        EndIf
 
        //objeto2 - usando a classe TGet
        nObjLinha := 3
        nObjColun := 64
        nObjLargu := 110
        nObjAltur := 15
        oGetTexto  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , cGetTexto := u, cGetTexto)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
        If lPosCSS
            oGetTexto:SetCSS(PosCss(GetClassName(oGetTexto), CSS_GET_FOCAL)) 
        EndIf

        //objeto4 - usando a classe TButton
        nObjLinha := 116
        nObjColun := 2
        nObjLargu := (nJanLargur/2) - 2
        nObjAltur := 15
        oBtnConf  := TButton():New(nObjLinha, nObjColun, cBtnObj8, oDialogPvt, bBtnObj8, nObjLargu, nObjAltur, , oFontPadrao, , lDimPixels)
        If lPosCSS
            oBtnConf:SetCSS(PosCss(GetClassName(oBtnConf), CSS_BTN_ATIVO)) 
        EndIf
     
    //Ativa e exibe a janela
    oDialogPvt:Activate(, , , lCentraliz, , , bBlocoIni)
     
    FWRestArea(aArea)
Return

Static Function fConfirma()
    Local cMensagem := "teste"
    FWAlertInfo(cMensagem, "Teste PosCSS")
Return
