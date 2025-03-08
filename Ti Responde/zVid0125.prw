/*
    
    Esse � um exemplo disponibilizado no Terminal de Informa��o 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/02/13/como-gatilhar-uma-informacao-em-uma-grid-com-fwbrowse-ti-responde-0125/ 
    
*/


//Bibliotecas
#Include "Totvs.ch"
    
/*/{Protheus.doc} User Function zVid0125
Fun��o que demonstra como gatilhar uma informa��o de uma coluna para outra usando FWBrowse
@type  Function
@author Atilio
@since  11/03/2024
@version version
/*/
    
User Function zVid0125()
    Local aArea := GetArea()
    //Fontes
    Local cFontUti    := "Tahoma"
    Local oFontAno    := TFont():New(cFontUti,,-38)
    Local oFontSub    := TFont():New(cFontUti,,-20)
    Local oFontSubN   := TFont():New(cFontUti,,-20,,.T.)
    Local oFontBtn    := TFont():New(cFontUti,,-14)
    //Janela e componentes
    Private oDlgGrp
    Private oPanGrid
    Private oGetGrid
    Private aColunas := {}
    Private cAliasTab := GetNextAlias()
    //Tamanho da janela
    Private    aTamanho := MsAdvSize()
    Private    nJanLarg := aTamanho[5]
    Private    nJanAltu := aTamanho[6]
    
    //Cria a tempor�ria
    oTempTable := FWTemporaryTable():New(cAliasTab)
        
    //Adiciona no array das colunas as que ser�o incluidas (Nome do Campo, Tipo do Campo, Tamanho, Decimais)
    aFields := {}
    aAdd(aFields, {"XXCODIGO",  "C",   6,                    0})
    aAdd(aFields, {"XXDESCRI",  "C",  30,                    0})
    aAdd(aFields, {"XXQUANTI",  "N",   9,                    2})
    aAdd(aFields, {"XXEMISSA",  "D",   8,                    0})
    aAdd(aFields, {"XXOBSERV",  "C", 100,                    0})
    aAdd(aFields, {"XXPRODCOD", "C", TamSX3("B1_COD")[1],    0})
    aAdd(aFields, {"XXPRODDES", "C", TamSX3("B1_DESC")[1],   0})
        
    //Define as colunas usadas, adiciona indice e cria a temporaria no banco
    oTempTable:SetFields( aFields )
    oTempTable:AddIndex("1", {"XXCODIGO"} )
    oTempTable:Create()
    
    //Monta o cabecalho
    fMontaHead()
    
    //Montando os dados, eles devem ser montados antes de ser criado o FWBrowse
    FWMsgRun(, {|oSay| fMontDados(oSay) }, "Processando", "Buscando grupos")
    
    //Criando a janela
    DEFINE MSDIALOG oDlgGrp TITLE "Dados" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
        //Labels gerais
        @ 004, 003 SAY "FAT"                     SIZE 200, 030 FONT oFontAno  OF oDlgGrp COLORS RGB(149,179,215) PIXEL
        @ 004, 050 SAY "Listagem Gen�rica de"    SIZE 200, 030 FONT oFontSub  OF oDlgGrp COLORS RGB(031,073,125) PIXEL
        @ 014, 050 SAY "Dados Tempor�rios"       SIZE 200, 030 FONT oFontSubN OF oDlgGrp COLORS RGB(031,073,125) PIXEL
    
        //Bot�es
        @ 006, (nJanLarg/2-001)-(0052*01) BUTTON oBtnFech  PROMPT "Fechar"        SIZE 050, 018 OF oDlgGrp ACTION (oDlgGrp:End())   FONT oFontBtn PIXEL
    
        //Dados
        @ 024, 003 GROUP oGrpDad TO (nJanAltu/2-003), (nJanLarg/2-003) PROMPT "Browse" OF oDlgGrp COLOR 0, 16777215 PIXEL
        oGrpDad:oFont := oFontBtn
            oPanGrid := tPanel():New(033, 006, "", oDlgGrp, , , , RGB(000,000,000), RGB(254,254,254), (nJanLarg/2 - 13),     (nJanAltu/2 - 45))
            oGetGrid := FWBrowse():New()
            oGetGrid:DisableFilter()
            oGetGrid:DisableConfig()
            oGetGrid:DisableReport()
            oGetGrid:DisableSeek()
            oGetGrid:DisableSaveConfig()
            oGetGrid:SetFontBrowse(oFontBtn)
            oGetGrid:SetAlias(cAliasTab)
            oGetGrid:SetDataTable()
            oGetGrid:SetEditCell(.T., {|| .T.}) 
            oGetGrid:lHeaderClick := .F.
            oGetGrid:AddLegend(cAliasTab + "->XXQUANTI == 0", "YELLOW", "Quantidade zerada")
            oGetGrid:AddLegend(cAliasTab + "->XXQUANTI <  0", "RED",    "Quantidade menor que zero")
            oGetGrid:AddLegend(cAliasTab + "->XXQUANTI >  0", "GREEN",  "Quantidade maior que zero")
            oGetGrid:SetColumns(aColunas)
            oGetGrid:SetOwner(oPanGrid)
            oGetGrid:Activate()
    ACTIVATE MsDialog oDlgGrp CENTERED
    
    //Deleta a temporaria
    oTempTable:Delete()
    
    RestArea(aArea)
Return
    
Static Function fMontaHead()
    Local nAtual
    Local aHeadAux := {}
    
    //Adicionando colunas
    //[01] - Campo da Temporaria
    //[02] - Titulo
    //[03] - Tipo
    //[04] - Tamanho
    //[05] - Decimais
    //[06] - M�scara
    //[07] - Edit�vel? .T. = sim, .F. = n�o
    //[08] - C�digo da Consulta Padr�o
    //[09] - Bloco de C�digo usado na Valida��o (ex.: {|| fSuaValid()} )
    //[10] - Alinhamento sendo 0=Centralizado (textos);1=Esquerda; 2=Direita
    aAdd(aHeadAux, {"XXCODIGO",  "C�digo",        "C",   6,                  0, "",              .F., '',    Nil,                               Nil})
    aAdd(aHeadAux, {"XXDESCRI",  "Descricao",     "C",  30,                  0, "",              .F., '',    Nil,                               Nil})
    aAdd(aHeadAux, {"XXQUANTI",  "Quantidade",    "N",   9,                  2, "@E 999,999.99", .T., '',    Nil,                               Nil})
    aAdd(aHeadAux, {"XXEMISSA",  "Emiss�o",       "D",   8,                  0, "",              .T., '',    Nil,                               Nil})
    aAdd(aHeadAux, {"XXOBSERV",  "Observa��o",    "C", 100,                  0, "",              .T., '',    Nil,                               Nil})
    aAdd(aHeadAux, {"XXPRODCOD", "Produto C�d.",  "C", TamSX3("B1_COD")[1],  0, "",              .T., 'SB1', {|| ExistCPO('SB1'), fAtuDesc()},  Nil})
    aAdd(aHeadAux, {"XXPRODDES", "Produto Desc.", "C", TamSX3("B1_DESC")[1], 0, "",              .F., '',    Nil,                               Nil})
    
    //Percorrendo e criando as colunas
    For nAtual := 1 To Len(aHeadAux)
        oColumn := FWBrwColumn():New()
        oColumn:SetData(&("{|| " + cAliasTab + "->" + aHeadAux[nAtual][1] +"}"))
        oColumn:SetTitle(aHeadAux[nAtual][2])
        oColumn:SetType(aHeadAux[nAtual][3])
        oColumn:SetSize(aHeadAux[nAtual][4])
        oColumn:SetDecimal(aHeadAux[nAtual][5])
        oColumn:SetPicture(aHeadAux[nAtual][6])
  
        //Se for ser poss�vel ter o duplo clique
        If aHeadAux[nAtual][7]
            oColumn:SetEdit(.T.)
            oColumn:SetReadVar(cAliasTab + "->" + aHeadAux[nAtual][1]) //Tem que ter o alias na esquerda para poder usar o F3

            //Se tiver Consulta Padr�o
        	If ! Empty(aHeadAux[nAtual][8])
        		oColumn:xF3 := aHeadAux[nAtual][8]
        	EndIf
        	
        	//Se tiver Valida��o
        	If ! Empty(aHeadAux[nAtual][9])
        		oColumn:SetValid(aHeadAux[nAtual][9])
        	EndIf
        EndIf

        //Define o alinhamento
        If ! Empty(aHeadAux[nAtual][10])
            oColumn:nAlign := aHeadAux[nAtual][10]
        EndIf
  
        aAdd(aColunas, oColumn)
    Next
Return
    
Static Function fMontDados(oSay)
    Local aArea   := GetArea()
    Local nAtual  := 0
    Local nTotal  := 50
    Local dDtRef  := Date()
    Local cCodAtu := "000000"
    Local cDescri := ""
    Local nQuanti := 0
    Local dEmissa := sToD("")
    
    //Faz um la�o de repeti��o
    For nAtual := 1 To nTotal
        //Muda a mensagem na regua
        nAtual++
        oSay:SetText("Adicionando registro " + cValToChar(nAtual) + " de " + cValToChar(nTotal) + "...")
  
        //Pega as vari�veis que v�o ser gravadas
        cCodAtu := Soma1(cCodAtu)
        cDescri := "[" + Time() + "] Teste - " + cCodAtu
        nQuanti := Randomize(-5, 5)
        dEmissa := DaySub(dDtRef, nAtual)
  
        //Insere os dados na tempor�ria
        RecLock(cAliasTab, .T.)
            (cAliasTab)->XXCODIGO  := cCodAtu
            (cAliasTab)->XXDESCRI  := cDescri
            (cAliasTab)->XXQUANTI  := nQuanti
            (cAliasTab)->XXEMISSA  := dEmissa
            (cAliasTab)->XXOBSERV  := ""
            (cAliasTab)->XXPRODCOD := ""
            (cAliasTab)->XXPRODDES := ""
        (cAliasTab)->(MsUnlock())
    
    Next
    
    RestArea(aArea)
Return

Static Function fAtuDesc()
    Local aArea     := FWGetArea()
    Local cCodProd  := (cAliasTab)->XXPRODCOD
    Local lContinua := .T.
    Local cDescric  := ""

    DbSelectArea("SB1")
    SB1->(DbSetOrder(1)) //B1_FILIAL + B1_COD

    //Se o produto n�o estiver posicionado, posiciona a tabela
    If cCodProd != SB1->B1_COD
        lContinua := SB1->(MsSeek(FWxFilial('SB1') + cCodProd))
    EndIf

    //Se deu tudo certo, pega a descri��o do produto
    If lContinua
        cDescric := SB1->B1_DESC
    EndIf

    //Atualiza a tempor�ria
    RecLock(cAliasTab, .F.)
        (cAliasTab)->XXPRODDES := cDescric
    (cAliasTab)->(MsUnlock())

    FWRestArea(aArea)
Return lContinua
