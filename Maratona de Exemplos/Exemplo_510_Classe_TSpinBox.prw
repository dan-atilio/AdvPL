/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/01/criando-um-icone-na-bandeja-do-s-o-com-tsystemtray-maratona-advpl-e-tl-511/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe510
Cria uma caixa de texto com botões ao lado de manipulação
@type Function
@author Atilio
@since 04/04/2023
@see https://tdn.totvs.com/display/tec/TSpinBox
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe510()
    Local aArea         := FWGetArea()
    Local nCorFundo     := RGB(238, 238, 238)
    Local nJanAltura    := 154
    Local nJanLargur    := 318 
    Local cJanTitulo    := 'Exemplo TSpinBox'
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
    Private oSpinBox 
    Private nSpinBox    := 10
    //objeto1 
    Private oBtnObj1 
    Private cBtnObj1    := 'Confirmar'  
    Private bBtnObj1    := {|| MsgInfo('O valor é:' + CRLF + CRLF + cValToChar(nSpinBox), 'Atenção')}  
    
    //Cria a dialog
    oDialogPvt := TDialog():New(0, 0, nJanAltura, nJanLargur, cJanTitulo, , , , , , nCorFundo, , , lDimPixels)
    
        //objeto0 - usando a classe TSpinBox
        nObjLinha := 7
        nObjColun := 6
        nObjLargu := 145
        nObjAltur := 15
        oSpinBox := TSpinBox():New(nObjLinha, nObjColun, oDialogPvt, {|x| nSpinBox := x }, nObjLargu, nObjAltur)
        oSpinBox:setRange(-30, 30)
        oSpinBox:setStep(5)
        oSpinBox:setValue(nSpinBox)

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
