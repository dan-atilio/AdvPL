/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2021/01/13/funcao-para-visualizar-a-estrutura-de-produtos-dentro-de-uma-dialog/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "TOTVS.ch"
#Include 'FWMVCDef.ch'
 
/*/{Protheus.doc} zTelEstr
Monta a tela da estrutura customizada
@type  Function
@author Atilio
@since 31/01/2020
@version 1.0
@param cProduto, character, Codigo do Produto
@param cDescric, character, Descricao do Produto
/*/
 
User Function zTelEstr(cProduto, cDescric)
    Local aArea := GetArea()
    Local cFontUti    := "Tahoma"
    Local oFontAno    := TFont():New(cFontUti,,-38)
    Local oFontSub    := TFont():New(cFontUti,,-20)
    Local oFontSubN   := TFont():New(cFontUti,,-20,,.T.)
    Local oFontBtn    := TFont():New(cFontUti,,-14)
    Default cProduto := SB1->B1_COD
    Default cDescric := SB1->B1_DESC
    Private    aTamanho := MsAdvSize()
    Private    nJanLarg := aTamanho[5]
    Private    nJanAltu := aTamanho[6]
    Private cProdPai := cProduto
    Private oDlgEstr
    Private oTreePad
    //Variaveis para usar o Ma200Monta
    Private ldbTree := .T.
    Private nIndex  := 1
 
    //Criando a janela
    DEFINE MSDIALOG oDlgEstr TITLE "Estrutura do Produto" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
        //Labels gerais
        @ 004, 003 SAY "EST"                             SIZE 200, 030 FONT oFontAno  OF oDlgEstr COLORS RGB(149,179,215) PIXEL
        @ 004, 050 SAY "Produto " + Alltrim(cProduto)    SIZE 200, 030 FONT oFontSub  OF oDlgEstr COLORS RGB(031,073,125) PIXEL
        @ 014, 050 SAY Alltrim(cDescric)                 SIZE 400, 030 FONT oFontSubN OF oDlgEstr COLORS RGB(031,073,125) PIXEL
         
        //Criando o DbTree
        oTreePad := dbTree():New(029, 003, (nJanAltu/2)-26, (nJanLarg/2)-1, oDlgEstr, {|| /* Se quiser colocar alguma função aqui, será chamada ao mudar de cargo */ }, , .T., , oFontBtn)
         
        //Monta os dados da Tree
        Pergunte('MTA200', .F.)
        Ma200Monta(oTreePad, oDlgEstr, cProduto)
 
        //Legenda
        @ (nJanAltu/2)-23, 003 GROUP oGrpLeg TO (nJanAltu/2)-3, (nJanLarg/2-003)-96 PROMPT "Legenda: " OF oDlgEstr COLOR 0, 16777215 PIXEL
            @ (nJanAltu/2)-17, 006 BITMAP oBmpPend SIZE 012, 011 OF oDlgEstr FILENAME "FOLDER5"  NOBORDER ADJUST PIXEL
            @ (nJanAltu/2)-17, 067 BITMAP oBmpFina SIZE 012, 011 OF oDlgEstr FILENAME "FOLDER7" NOBORDER ADJUST PIXEL
            @ (nJanAltu/2)-14, 024 SAY oSayPend PROMPT "Componente Ok"        SIZE 040, 007 OF oDlgEstr PIXEL
            @ (nJanAltu/2)-14, 085 SAY oSayFina PROMPT "Componente Expirado"  SIZE 060, 007 OF oDlgEstr PIXEL
 
        @ (nJanAltu/2)-23, (nJanLarg/2-003)-93 GROUP oGrpAco TO (nJanAltu/2)-3, (nJanLarg/2)-1 PROMPT "Acoes: " OF oDlgEstr COLOR 0, 16777215 PIXEL
            @ (nJanAltu/2)-17,(nJanLarg/2-003)-(0042*02) BUTTON "&Ver Prod."  Size 040, 012 Font oFontBtn Action (Processa({|| fVisProd()}, "Processando...")) PIXEL
            @ (nJanAltu/2)-17,(nJanLarg/2-003)-(0042*01) BUTTON "&Sair"       Size 040, 012 Font oFontBtn Action (oDlgEstr:End()) PIXEL
         
    ACTIVATE MSDIALOG oDlgEstr CENTERED
 
    RestArea(aArea)
Return
 
Static Function fVisProd()
    Local aArea  := GetArea()
    Local cCargo := oTreePad:GetCargo()
    Local nRecno := Val(SubStr(cCargo, Len(SG1->G1_COD + SG1->G1_TRT + SG1->G1_COMP) + 1, 9))
    Local cTipo  := Right(cCargo,4)
    Local cCodig := ""
     
    //Se houver registro
    If nRecno > 0
 
        //Posicionando no Recno
        DbSelectArea('SG1')
        SG1->(dbSetOrder(1))
        SG1->(DbGoTo(nRecno))
 
        DbSelectArea('SB1')
        SB1->(DbSetOrder(1))
 
        //Pegando o produto
        If cTipo == 'CODI'
            cCodig := cProdPai //SG1->G1_COD
        Else
            cCodig := SG1->G1_COMP
        EndIf
 
        SB1->(DbSeek(FWxFilial('SB1') + cCodig))
        FWExecView("Visualizar produto", "MATA010",  MODEL_OPERATION_VIEW,,{||.T.},,,,,,,)
    EndIf    
 
    RestArea(aArea)
Return