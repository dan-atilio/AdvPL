/*
    
    Esse � um exemplo disponibilizado no Terminal de Informa��o 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2022/11/28/fazer-um-combo-filtrar-outro-combo-ti-responde-032/ 
    
*/


//Bibliotecas
#Include 'TOTVS.ch'

/*/{Protheus.doc} User Function zVid0032
Funcao com tela customizada usando a classe TDialog que foi gerado pelo PDialogMaker
@type  Function
@author Atilio
@since 28/04/2022 
@see https://atiliosistemas.com/portfolio/pdialogmaker/
@obs Obrigado por usar um aplicativo da Atilio Sistemas
/*/

User Function zVid0032()
    Local aArea         := FWGetArea()
    Local nCorFundo     := RGB(204, 255, 204)
    Local nJanAltura    := 190
    Local nJanLargur    := 245 
    Local cJanTitulo    := 'Exemplo Combo'
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
    Private cSayObj0    := 'Regi�o:'  
    //objeto1 
    Private oCmbObj1 
    Private cCmbObj1    := 'XX'  
    Private aCmbObj1    := {'XX=Nenhuma Regi�o', 'NT=Norte', 'ND=Nordeste', 'CO=Centro Oeste', 'SD=Sudeste', 'SU=Sul'}  
    //objeto2 
    Private oSayObj2 
    Private cSayObj2    := 'Estado:'  
    //objeto3 
    Private oCmbObj3 
    Private cCmbObj3    := ''  
    Private aCmbObj3    := {}  
    //objeto4 
    Private oBtnObj4 
    Private cBtnObj4    := 'Confirmar'  
    Private bBtnObj4    := {|| MsgInfo('Regi�o [' + cCmbObj1 + '] e Estado [' + cCmbObj3 + ']', 'Combos escolhidos')}  
    
    //Cria a dialog
    oDialogPvt := TDialog():New(0, 0, nJanAltura, nJanLargur, cJanTitulo, , , , , , nCorFundo, , , lDimPixels)
    
        //objeto0 - usando a classe TSay
        nObjLinha := 8
        nObjColun := 7
        nObjLargu := 28
        nObjAltur := 6
        oSayObj0  := TSay():New(nObjLinha, nObjColun, {|| cSayObj0}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

        //objeto1 - usando a classe TComboBox
        nObjLinha := 17
        nObjColun := 18
        nObjLargu := 100
        nObjAltur := 12
        oCmbObj1  := TComboBox():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , cCmbObj1 := u, cCmbObj1)}, aCmbObj1, nObjLargu, nObjAltur, oDialogPvt, , {|| fAtuCmb()}, /*bValid*/, /*nClrText*/, /*nClrBack*/, lDimPixels, oFontPadrao)

        //objeto2 - usando a classe TSay
        nObjLinha := 35
        nObjColun := 7
        nObjLargu := 28
        nObjAltur := 6
        oSayObj2  := TSay():New(nObjLinha, nObjColun, {|| cSayObj2}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

        //objeto3 - usando a classe TComboBox
        nObjLinha := 44
        nObjColun := 18
        nObjLargu := 100
        nObjAltur := 12
        oCmbObj3  := TComboBox():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , cCmbObj3 := u, cCmbObj3)}, aCmbObj3, nObjLargu, nObjAltur, oDialogPvt, , /*bChange*/, /*bValid*/, /*nClrText*/, /*nClrBack*/, lDimPixels, oFontPadrao)

        //objeto4 - usando a classe TButton
        nObjLinha := 72
        nObjColun := 70
        nObjLargu := 50
        nObjAltur := 15
        oBtnObj4  := TButton():New(nObjLinha, nObjColun, cBtnObj4, oDialogPvt, bBtnObj4, nObjLargu, nObjAltur, , oFontPadrao, , lDimPixels)

    
    //Ativa e exibe a janela
    oDialogPvt:Activate(, , , lCentraliz, , , bBlocoIni)
    
    FWRestArea(aArea)
Return

Static Function fAtuCmb()
    Local aEstados := {}

    //Se for a regi�o Norte
    If cCmbObj1 == "NT"
        aAdd(aEstados, "RR=Roraima")
        aAdd(aEstados, "AP=Amap�")
        aAdd(aEstados, "AM=Amazonas")
        aAdd(aEstados, "PA=Par�")
        aAdd(aEstados, "AC=Acre")
        aAdd(aEstados, "RO=Rond�nia")
        aAdd(aEstados, "TO=Tocantins")

    //Sen�o se for a regi�o Nordeste
    ElseIf cCmbObj1 == "ND"
        aAdd(aEstados, "MA=Maranh�o")
        aAdd(aEstados, "PI=Piau�")
        aAdd(aEstados, "CE=Cear�")
        aAdd(aEstados, "RN=Rio Grande do Norte")
        aAdd(aEstados, "PB=Para�ba")
        aAdd(aEstados, "PE=Pernambuco")
        aAdd(aEstados, "AL=Alagoas")
        aAdd(aEstados, "SE=Sergipe")
        aAdd(aEstados, "BA=Bahia")


    //Sen�o se for a regi�o Centro Oeste
    ElseIf cCmbObj1 == "CO"
        aAdd(aEstados, "MT=Mato Grosso")
        aAdd(aEstados, "DF=Distrito Federal")
        aAdd(aEstados, "GO=Goi�s")
        aAdd(aEstados, "MS=Mato Grosso do Sul")

    //Sen�o se for a regi�o Sudeste
    ElseIf cCmbObj1 == "SD"
        aAdd(aEstados, "MG=Minas Gerais")
        aAdd(aEstados, "ES=Esp�rito Santo")
        aAdd(aEstados, "RJ=Rio de Janeiro")
        aAdd(aEstados, "SP=S�o Paulo")

    //Sen�o se for a regi�o Sul
    ElseIf cCmbObj1 == "SU"
        aAdd(aEstados, "PR=Paran�")
        aAdd(aEstados, "SC=Santa Catarina")
        aAdd(aEstados, "RS=Rio Grande do Sul")
    
    //Nenhuma regi�o
    Else
        aAdd(aEstados, "")
    EndIf

    //Define no segundo combo o array com os estados
    oCmbObj3:SetItems(aEstados)
    oCmbObj3:Refresh()
Return
