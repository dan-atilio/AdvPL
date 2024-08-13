/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/30/criando-um-editor-atraves-da-tsimpleeditor-maratona-advpl-e-tl-509/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe509
Cria uma caixa de texto grande para digitação / visualização (com algumas opções como exibir em html)
@type Function
@author Atilio
@since 04/04/2023
@see https://tdn.totvs.com/display/tec/TSimpleEditor
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe509()
    Local aArea         := FWGetArea()
    Local nCorFundo     := RGB(238, 238, 238)
    Local nJanAltura    := 154
    Local nJanLargur    := 318 
    Local cJanTitulo    := 'Exemplo TSimpleEditor'
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
    Private oSimpEdit 
    Private cSimpEdit    := ''  
    //objeto1 
    Private oBtnObj1 
    Private cBtnObj1    := 'Confirmar'  
    Private bBtnObj1    := {|| MsgInfo('O texto digitado foi:' + CRLF + CRLF + oSimpEdit:RetText(), 'Atenção')}  
    
    //Cria a dialog
    oDialogPvt := TDialog():New(0, 0, nJanAltura, nJanLargur, cJanTitulo, , , , , , nCorFundo, , , lDimPixels)
    
        //Monta o texto que será exibido
        cSimpEdit := '<p>Olá.</p>' + CRLF
        cSimpEdit += '<p>Esse é um exemplo de <strong>mensagem em HTML</strong>.</p>' + CRLF
        cSimpEdit += '<p>Note que as <font color="red">tags foram interpretadas</font>.</p>' + CRLF

        //objeto0 - usando a classe TSimpleEditor
        nObjLinha := 7
        nObjColun := 6
        nObjLargu := 145
        nObjAltur := 40
        oPanelEdit := tPanel():New(nObjLinha, nObjColun, "", oDialogPvt, , , , RGB(000,000,000), RGB(254,254,254), nObjLargu, nObjAltur)
            oSimpEdit := TSimpleEditor():Create(oPanelEdit)
            oSimpEdit:lAutoIndent := .T.
            oSimpEdit:nWidth := oPanelEdit:nWidth
            oSimpEdit:nHeight := oPanelEdit:nHeight
            oSimpEdit:TextFormat(1) //1=Html; 2=Plain Text
            oSimpEdit:TextSize(11)
            oSimpEdit:Load(cSimpEdit)
            oSimpEdit:Refresh()

        //objeto1 - usando a classe TButton
        nObjLinha := 54
        nObjColun := 6
        nObjLargu := 75
        nObjAltur := 15
        oBtnObj1  := TButton():New(nObjLinha, nObjColun, cBtnObj1, oDialogPvt, bBtnObj1, nObjLargu, nObjAltur, , oFontPadrao, , lDimPixels)

    
    //Ativa e exibe a janela
    oDialogPvt:Activate(, , , lCentraliz, , , bBlocoIni)
    
    FWRestArea(aArea)
Return
