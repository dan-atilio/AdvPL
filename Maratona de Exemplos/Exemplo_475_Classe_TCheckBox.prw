/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/13/preparando-a-execucao-de-uma-query-atraves-das-tcgenqry-e-tcgenqry2-maratona-advpl-e-tl-474/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe475
Classe para criar checkbox em uma Dialog
@type Function
@author Atilio
@since 03/04/2023
@see https://tdn.totvs.com/display/tec/TCheckBox
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe475()
    Local aArea         := FWGetArea()
    Local nCorFundo     := RGB(238, 238, 238)
    Local nJanAltura    := 187
    Local nJanLargur    := 253 
    Local cJanTitulo    := 'Exemplo TCheckBox'
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
    Private oChkObj0 
    Private lChkObj0    := .F.  
    Private cChkObj0    := 'CheckBox vindo desmarcado'  
    //objeto1 
    Private oChkObj1 
    Private lChkObj1    := .T.  
    Private cChkObj1    := 'CheckBox vindo marcado'  
    //objeto2 
    Private oChkObj2 
    Private lChkObj2    := .T.  
    Private cChkObj2    := 'CheckBox desativado'  
    //objeto3 
    Private oBtnObj3 
    Private cBtnObj3    := 'Confirmar'  
    Private bBtnObj3    := {|| MsgInfo('Primeiro [' + cValToChar(lChkObj0) + '], Segundo [' + cValToChar(lChkObj1) + '], Terceiro [' + cValToChar(lChkObj2) + ']', 'Atencao')}  
    
    //Cria a dialog
    oDialogPvt := TDialog():New(0, 0, nJanAltura, nJanLargur, cJanTitulo, , , , , , nCorFundo, , , lDimPixels)
    
        //objeto0 - usando a classe TCheckBox
        nObjLinha := 5
        nObjColun := 7
        nObjLargu := 110
        nObjAltur := 15
        oChkObj0  := TCheckBox():New(nObjLinha, nObjColun, cChkObj0, {|u| Iif(PCount() > 0 , lChkObj0 := u, lChkObj0)}, oDialogPvt, nObjLargu, nObjAltur, , /*bLClicked*/, oFontPadrao, /*bValid*/, /*nClrText*/, /*nClrPane*/, , lDimPixels)

        //objeto1 - usando a classe TCheckBox
        nObjLinha := 25
        nObjColun := 7
        nObjLargu := 110
        nObjAltur := 15
        oChkObj1  := TCheckBox():New(nObjLinha, nObjColun, cChkObj1, {|u| Iif(PCount() > 0 , lChkObj1 := u, lChkObj1)}, oDialogPvt, nObjLargu, nObjAltur, , /*bLClicked*/, oFontPadrao, /*bValid*/, /*nClrText*/, /*nClrPane*/, , lDimPixels)

        //objeto2 - usando a classe TCheckBox
        nObjLinha := 45
        nObjColun := 7
        nObjLargu := 110
        nObjAltur := 15
        oChkObj2  := TCheckBox():New(nObjLinha, nObjColun, cChkObj2, {|u| Iif(PCount() > 0 , lChkObj2 := u, lChkObj2)}, oDialogPvt, nObjLargu, nObjAltur, , /*bLClicked*/, oFontPadrao, /*bValid*/, /*nClrText*/, /*nClrPane*/, , lDimPixels)
        oChkObj2:lActive := .F.

        //objeto3 - usando a classe TButton
        nObjLinha := 70
        nObjColun := 7
        nObjLargu := 110
        nObjAltur := 15
        oBtnObj3  := TButton():New(nObjLinha, nObjColun, cBtnObj3, oDialogPvt, bBtnObj3, nObjLargu, nObjAltur, , oFontPadrao, , lDimPixels)

    
    //Ativa e exibe a janela
    oDialogPvt:Activate(, , , lCentraliz, , , bBlocoIni)
    
    FWRestArea(aArea)
Return
