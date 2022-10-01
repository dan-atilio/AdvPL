/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2022/09/05/criar-tela-com-varios-componentes-usando-fwlayer-ti-responde-020/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "TOTVS.ch"
 
/*/{Protheus.doc} User Function zVid0020
Tela com vários componentes gráficos, usando FWLayer
@type Function
@author Atilio
@since 09/03/2022
@version 1.0
/*/
 
User Function zVid0020()
    Local aArea := GetArea()
 
    fMontaTela()
 
    RestArea(aArea)
Return
 
Static Function fMontaTela()
    Local nLargBtn      := 50
    Local nLinhaObj     := 0
    Local nLargPanel    := 0
    //Objetos e componentes gerais
    Private oDlgExemp
    Private oFwLayer
    Private oPanTitulo
    Private oPanGrid
    Private oPanCheck
    Private oPanTotal
    Private cMascara := "@E 999,999,999,999,999.99"
    //Cabeçalho
    Private oSayModulo, cSayModulo := 'TST'
    Private oSayTitulo, cSayTitulo := 'Exemplo de Tela com
    Private oSaySubTit, cSaySubTit := 'Objetos gráficos usando FWLayer'
    //Tamanho da janela
    Private aSize := MsAdvSize(.F.)
    Private nJanLarg := aSize[5]
    Private nJanAltu := aSize[6]
    //Fontes
    Private cFontUti    := "Tahoma"
    Private oFontMod    := TFont():New(cFontUti, , -38)
    Private oFontSub    := TFont():New(cFontUti, , -20)
    Private oFontSubN   := TFont():New(cFontUti, , -20, , .T.)
    Private oFontBtn    := TFont():New(cFontUti, , -14)
    Private oFontSay    := TFont():New(cFontUti, , -12)
    //Grid
    Private aCampos := {}
    Private cAliasTmp := "TST_" + RetCodUsr()
    Private aColunas := {}
    Private oMarkBrowse
    //Componentes da segunda coluna
    Private oSayChkDes
    Private oSayChkPer
    Private oSayChkVlr
    Private oCheck01, lCheck01 := .F., oGetPerc01, nGetPerc01 := 0, oGetTot01, nGetTot01 := 0
    Private oCheck02, lCheck02 := .F., oGetPerc02, nGetPerc02 := 0, oGetTot02, nGetTot02 := 0
    Private oCheck03, lCheck03 := .F., oGetPerc03, nGetPerc03 := 0, oGetTot03, nGetTot03 := 0
    Private oCheck04, lCheck04 := .F., oGetPerc04, nGetPerc04 := 0, oGetTot04, nGetTot04 := 0
    Private oCheck05, lCheck05 := .F., oGetPerc05, nGetPerc05 := 0, oGetTot05, nGetTot05 := 0
    //Componentes da terceira coluna
    Private oSayTot, cSayTot := "Total marcado:",             oGetTot, nGetTot := 0
    Private oSayApu, cSayApu := "% Apurado:",                 oGetApu, nGetApu := 0
    Private oSayPro, cSayPro := "Total que será processado:", oGetPro, nGetPro := 0
    Private oBtnProc, oBtnPrev
 
    //Adiciona as colunas que serão criadas na temporária
    aAdd(aCampos, { "OK"        , "C", 2    , 0 })
    aAdd(aCampos, { "CONTA"     , "C", 10   , 0 })
    aAdd(aCampos, { "VALOR"     , "N", 18   , 2 })

    //Cria a tabela temporária
    oTempTable:= FWTemporaryTable():New(cAliasTmp)
    oTempTable:SetFields( aCampos )
    oTempTable:Create()  
 
    //Busca as colunas do browse
    aColunas := fCriaCols()
 
    //Popula a tabela temporária
    Processa({|| fPopula()}, "Processando...")
 
    //Cria a janela
    DEFINE MSDIALOG oDlgExemp TITLE "Exemplo de Tela com Objetos gráficos usando FWLayer"  FROM 0, 0 TO nJanAltu, nJanLarg PIXEL
 
        //Criando a camada
        oFwLayer := FwLayer():New()
        oFwLayer:init(oDlgExemp,.F.)
 
        //Adicionando 3 linhas, a de título, a superior e a do calendário
        oFWLayer:addLine("TITULO", 010, .F.)
        oFWLayer:addLine("CORPO",  088, .F.)
        oFWLayer:addLine("RODAPE", 002, .F.)
 
        //Adicionando as colunas das linhas
        oFWLayer:addCollumn("HEADERTEXT",   050, .T., "TITULO")
        oFWLayer:addCollumn("BLANKBTN",     040, .T., "TITULO")
        oFWLayer:addCollumn("BTNSAIR",      010, .T., "TITULO")

        oFWLayer:addCollumn("BLANKANTES",   001, .T., "CORPO")
        oFWLayer:addCollumn("COLGRID",      039, .T., "CORPO")
        oFWLayer:addCollumn("COLCHECK",     040, .T., "CORPO")
        oFWLayer:addCollumn("COLTOTAL",     019, .T., "CORPO")
        oFWLayer:addCollumn("BLANKDEPOIS",  001, .T., "CORPO")
 
        //Criando os paineis
        oPanHeader := oFWLayer:GetColPanel("HEADERTEXT", "TITULO")
        oPanSair   := oFWLayer:GetColPanel("BTNSAIR",    "TITULO")
        oPanGrid   := oFWLayer:GetColPanel("COLGRID",    "CORPO")
        oPanCheck  := oFWLayer:GetColPanel("COLCHECK",   "CORPO")
        oPanTotal  := oFWLayer:GetColPanel("COLTOTAL",   "CORPO")
 
        //Títulos e SubTítulos
        oSayModulo := TSay():New(004, 003, {|| cSayModulo}, oPanHeader, "", oFontMod,  , , , .T., RGB(149, 179, 215), , 200, 30, , , , , , .F., , )
        oSayTitulo := TSay():New(004, 045, {|| cSayTitulo}, oPanHeader, "", oFontSub,  , , , .T., RGB(031, 073, 125), , 200, 30, , , , , , .F., , )
        oSaySubTit := TSay():New(014, 045, {|| cSaySubTit}, oPanHeader, "", oFontSubN, , , , .T., RGB(031, 073, 125), , 300, 30, , , , , , .F., , )
 
        //Criando os botões
        oBtnSair := TButton():New(006, 001, "Fechar",             oPanSair, {|| oDlgExemp:End()}, nLargBtn, 018, , oFontBtn, , .T., , , , , , )
 
        //Cria a grid
        oMarkBrowse := FWMarkBrowse():New()
        oMarkBrowse:SetAlias(cAliasTmp)
        oMarkBrowse:DisableFilter()
        oMarkBrowse:DisableConfig()
        oMarkBrowse:DisableReport()
        oMarkBrowse:DisableSeek()
        oMarkBrowse:DisableSaveConfig()
        oMarkBrowse:SetFontBrowse(oFontSay)
        oMarkBrowse:SetFieldMark('OK')
        oMarkBrowse:SetTemporary(.T.)
        oMarkBrowse:SetColumns(aColunas)
        oMarkBrowse:SetOwner(oPanGrid)
        oMarkBrowse:Activate()

        //Cria os componentes da segunda coluna
        @ 001, 001 SCROLLBOX oScroll VERTICAL HORIZONTAL SIZE oPanCheck:nHeight / 2, oPanCheck:nWidth / 2 OF oPanCheck
        
        nLinhaObj := 1
        nLargPanel := (oPanCheck:nWidth) / 2
        nTotEspCol := (nLargPanel/3)
        nTotCol01  := 003 + nTotEspCol * 0
        nTotCol02  := 003 + nTotEspCol * 1
        nTotCol03  := 003 + nTotEspCol * 2
        oSayChkDes := TSay():New(nLinhaObj, 001 + nTotCol01, {|| "Descrição"}, oScroll, "", oFontSay,  , , , .T., RGB(031, 073, 125), , nTotEspCol, 10, , , , , , .F., , )
        oSayChkPer := TSay():New(nLinhaObj, 001 + nTotCol02, {|| "%"},         oScroll, "", oFontSay,  , , , .T., RGB(031, 073, 125), , nTotEspCol, 10, , , , , , .F., , )
        oSayChkVlr := TSay():New(nLinhaObj, 001 + nTotCol03, {|| "Valor"},     oScroll, "", oFontSay,  , , , .T., RGB(031, 073, 125), , nTotEspCol, 10, , , , , , .F., , )

        nLinhaObj += 25
        oCheck01    := TCheckBox():New(nLinhaObj, 003 + nTotCol01, "Check 01", {|u| Iif(PCount() > 0 , lCheck01 := u, lCheck01)}, oScroll, nTotEspCol - 3, 10, , /*bLClicked*/, oFontSay, /*bValid*/, /*nClrText*/, /*nClrPane*/, , .T.)
        oGetPerc01  := TGet():New(nLinhaObj, 003 + nTotCol02, {|u| Iif(PCount() > 0 , nGetPerc01 := u, nGetPerc01)}, oScroll, nTotEspCol - 9, 10, cMascara, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontSay, , , .T.)
        oGetTot01   := TGet():New(nLinhaObj, 003 + nTotCol03, {|u| Iif(PCount() > 0 , nGetTot01 := u, nGetTot01)}, oScroll, nTotEspCol - 9, 10, cMascara, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontSay, , , .T.)
        oGetTot01:lActive := .F.

        nLinhaObj += 15
        oCheck02    := TCheckBox():New(nLinhaObj, 003 + nTotCol01, "Check 02", {|u| Iif(PCount() > 0 , lCheck02 := u, lCheck02)}, oScroll, nTotEspCol - 3, 10, , /*bLClicked*/, oFontSay, /*bValid*/, /*nClrText*/, /*nClrPane*/, , .T.)
        oGetPerc02  := TGet():New(nLinhaObj, 003 + nTotCol02, {|u| Iif(PCount() > 0 , nGetPerc02 := u, nGetPerc02)}, oScroll, nTotEspCol - 9, 10, cMascara, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontSay, , , .T.)
        oGetTot02   := TGet():New(nLinhaObj, 003 + nTotCol03, {|u| Iif(PCount() > 0 , nGetTot02 := u, nGetTot02)}, oScroll, nTotEspCol - 9, 10, cMascara, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontSay, , , .T.)
        oGetTot02:lActive := .F.

        nLinhaObj += 15
        oCheck03    := TCheckBox():New(nLinhaObj, 003 + nTotCol01, "Check 03", {|u| Iif(PCount() > 0 , lCheck03 := u, lCheck03)}, oScroll, nTotEspCol - 3, 10, , /*bLClicked*/, oFontSay, /*bValid*/, /*nClrText*/, /*nClrPane*/, , .T.)
        oGetPerc03  := TGet():New(nLinhaObj, 003 + nTotCol02, {|u| Iif(PCount() > 0 , nGetPerc03 := u, nGetPerc03)}, oScroll, nTotEspCol - 9, 10, cMascara, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontSay, , , .T.)
        oGetTot03   := TGet():New(nLinhaObj, 003 + nTotCol03, {|u| Iif(PCount() > 0 , nGetTot03 := u, nGetTot03)}, oScroll, nTotEspCol - 9, 10, cMascara, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontSay, , , .T.)
        oGetTot03:lActive := .F.

        nLinhaObj += 15
        oCheck04    := TCheckBox():New(nLinhaObj, 003 + nTotCol01, "Check 04", {|u| Iif(PCount() > 0 , lCheck04 := u, lCheck04)}, oScroll, nTotEspCol - 3, 10, , /*bLClicked*/, oFontSay, /*bValid*/, /*nClrText*/, /*nClrPane*/, , .T.)
        oGetPerc04  := TGet():New(nLinhaObj, 003 + nTotCol02, {|u| Iif(PCount() > 0 , nGetPerc04 := u, nGetPerc04)}, oScroll, nTotEspCol - 9, 10, cMascara, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontSay, , , .T.)
        oGetTot04   := TGet():New(nLinhaObj, 003 + nTotCol03, {|u| Iif(PCount() > 0 , nGetTot04 := u, nGetTot04)}, oScroll, nTotEspCol - 9, 10, cMascara, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontSay, , , .T.)
        oGetTot04:lActive := .F.

        nLinhaObj += 15
        oCheck05    := TCheckBox():New(nLinhaObj, 003 + nTotCol01, "Check 05", {|u| Iif(PCount() > 0 , lCheck05 := u, lCheck05)}, oScroll, nTotEspCol - 3, 10, , /*bLClicked*/, oFontSay, /*bValid*/, /*nClrText*/, /*nClrPane*/, , .T.)
        oGetPerc05  := TGet():New(nLinhaObj, 003 + nTotCol02, {|u| Iif(PCount() > 0 , nGetPerc05 := u, nGetPerc05)}, oScroll, nTotEspCol - 9, 10, cMascara, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontSay, , , .T.)
        oGetTot05   := TGet():New(nLinhaObj, 003 + nTotCol03, {|u| Iif(PCount() > 0 , nGetTot05 := u, nGetTot05)}, oScroll, nTotEspCol - 9, 10, cMascara, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontSay, , , .T.)
        oGetTot05:lActive := .F.


        //Cria os componentes da terceira coluna
        nLargPanel := (oPanTotal:nWidth) / 2
        nLinhaObj  := 30
        oSayTot := TSay():New(nLinhaObj, 003, {|| cSayTot}, oPanTotal, "", oFontSay,  , , , .T., RGB(031, 073, 125), , 200, 10, , , , , , .F., , )
        nLinhaObj += 10
        oGetTot  := TGet():New(nLinhaObj, 013, {|u| Iif(PCount() > 0 , nGetTot := u, nGetTot)}, oPanTotal, nLargPanel - 25, 15, cMascara, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontSay, , , .T.)
        oGetTot:lReadOnly := .T.
        nLinhaObj += 25

        oSayApu := TSay():New(nLinhaObj, 003, {|| cSayApu}, oPanTotal, "", oFontSay,  , , , .T., RGB(031, 073, 125), , 200, 10, , , , , , .F., , )
        nLinhaObj += 10
        oGetApu  := TGet():New(nLinhaObj, 013, {|u| Iif(PCount() > 0 , nGetApu := u, nGetApu)}, oPanTotal, nLargPanel - 25, 15, cMascara, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontSay, , , .T.)
        oGetApu:lReadOnly := .T.
        nLinhaObj += 25

        oSayPro := TSay():New(nLinhaObj, 003, {|| cSayPro}, oPanTotal, "", oFontSay,  , , , .T., RGB(031, 073, 125), , 200, 10, , , , , , .F., , )
        nLinhaObj += 10
        oGetPro  := TGet():New(nLinhaObj, 013, {|u| Iif(PCount() > 0 , nGetPro := u, nGetPro)}, oPanTotal, nLargPanel - 25, 15, cMascara, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontSay, , , .T.)
        oGetApu:lReadOnly := .T.
        nLinhaObj += 25

        nLinhaObj += 20
        oBtnProc := TButton():New(nLinhaObj, 003, "Processar informações",      oPanTotal, {|| Alert("botão 1")}, nLargPanel - 3, 018, , oFontBtn, , .T., , , , , , )
        nLinhaObj += 25
        oBtnPrev := TButton():New(nLinhaObj, 003, "Previsão dos dados",         oPanTotal, {|| Alert("botão 2")}, nLargPanel - 3, 018, , oFontBtn, , .T., , , , , , )

    Activate MsDialog oDlgExemp Centered
    oTempTable:Delete()
Return
 
Static Function fCriaCols()
    Local nAtual   := 0 
    Local aColunas := {}
    Local aEstrut  := {}
    Local oColumn
     
    //Adicionando campos que serão mostrados na tela
    //[1] - Campo da Temporaria
    //[2] - Titulo
    //[3] - Tipo
    //[4] - Tamanho
    //[5] - Decimais
    //[6] - Máscara
    aAdd(aEstrut, {"CONTA", "Conta",             "C", 10,   0, ""})
    aAdd(aEstrut, {"VALOR", "Valor",             "N", 18,   2, cMascara})
 
    //Percorrendo todos os campos da estrutura
    For nAtual := 1 To Len(aEstrut)
        //Cria a coluna
        oColumn := FWBrwColumn():New()
        oColumn:SetData(&("{|| (cAliasTmp)->" + aEstrut[nAtual][1] +"}"))
        oColumn:SetTitle(aEstrut[nAtual][2])
        oColumn:SetType(aEstrut[nAtual][3])
        oColumn:SetSize(aEstrut[nAtual][4])
        oColumn:SetDecimal(aEstrut[nAtual][5])
        oColumn:SetPicture(aEstrut[nAtual][6])
 
        //Adiciona a coluna
        aAdd(aColunas, oColumn)
    Next
Return aColunas
 
Static Function fPopula()
    Local nAtual := 0
    
    For nAtual := 1 To 30
        //Grava na temporária
        RecLock(cAliasTmp, .T.)
            (cAliasTmp)->OK     := ""
            (cAliasTmp)->CONTA  := StrZero(nAtual, 4)
            (cAliasTmp)->VALOR  := Randomize(100, 1000)
        (cAliasTmp)->(MsUnlock())
    Next
Return
