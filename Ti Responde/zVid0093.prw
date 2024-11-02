/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2024/10/24/posicionar-em-uma-determinada-linha-e-coluna-usando-fwbrowse-ti-responde-0093/ 
    
*/


#Include "Totvs.ch"
    
/*/{Protheus.doc} User Function zVid0093
Função que demonstra como posicionar numa linha e coluna em um browse
@type  Function
@author Atilio
@since  01/09/2021
@version version
/*/
    
User Function zVid0093()
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
    Private cAliasTab := "TMPSBM"
    //Tamanho da janela
    Private    aTamanho := MsAdvSize()
    Private    nJanLarg := aTamanho[5]
    Private    nJanAltu := aTamanho[6]
    
    //Cria a temporária
    oTempTable := FWTemporaryTable():New(cAliasTab)
        
    //Adiciona no array das colunas as que serão incluidas (Nome do Campo, Tipo do Campo, Tamanho, Decimais)
    aFields := {}
    aAdd(aFields, {"XXCODIGO", "C",   6, 0})
    aAdd(aFields, {"XXDESCRI", "C",  30, 0})
    aAdd(aFields, {"XXQUANTI", "N",   9, 2})
    aAdd(aFields, {"XXEMISSA", "D",   8, 0})
    aAdd(aFields, {"XXOBSERV", "C", 100, 0})
        
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
        @ 004, 050 SAY "Listagem Genérica de"    SIZE 200, 030 FONT oFontSub  OF oDlgGrp COLORS RGB(031,073,125) PIXEL
        @ 014, 050 SAY "Dados Temporários"       SIZE 200, 030 FONT oFontSubN OF oDlgGrp COLORS RGB(031,073,125) PIXEL
    
        //Botões
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
    //[06] - Máscara
    //[07] - Editável? .T. = sim, .F. = não
    //[08] - Código da Consulta Padrão
    //[09] - Bloco de Código usado na Validação (ex.: {|| fSuaValid()} )
    //[10] - Alinhamento sendo 0=Centralizado (textos);1=Esquerda; 2=Direita
    aAdd(aHeadAux, {"XXCODIGO", "Código",     "C",   6,  0, "",              .F., '', Nil,            Nil})
    aAdd(aHeadAux, {"XXDESCRI", "Descricao",  "C",  30,  0, "",              .F., '', Nil,            Nil})
    aAdd(aHeadAux, {"XXQUANTI", "Quantidade", "N",   9,  2, "@E 999,999.99", .T., '', {|| fVldQtd()}, Nil})
    aAdd(aHeadAux, {"XXEMISSA", "Emissão",    "D",   8,  0, "",              .T., '', Nil,            Nil})
    aAdd(aHeadAux, {"XXOBSERV", "Observação", "C", 100,  0, "",              .T., '', Nil,            Nil})
    
    //Percorrendo e criando as colunas
    For nAtual := 1 To Len(aHeadAux)
        oColumn := FWBrwColumn():New()
        oColumn:SetData(&("{|| " + cAliasTab + "->" + aHeadAux[nAtual][1] +"}"))
        oColumn:SetTitle(aHeadAux[nAtual][2])
        oColumn:SetType(aHeadAux[nAtual][3])
        oColumn:SetSize(aHeadAux[nAtual][4])
        oColumn:SetDecimal(aHeadAux[nAtual][5])
        oColumn:SetPicture(aHeadAux[nAtual][6])
  
        //Se for ser possível ter o duplo clique
        If aHeadAux[nAtual][7]
            oColumn:SetEdit(.T.)
            oColumn:SetReadVar(aHeadAux[nAtual][1])

            //Se tiver Consulta Padrão
        	If ! Empty(aHeadAux[nAtual][8])
        		oColumn:xF3 := aHeadAux[nAtual][8]
        	EndIf
        	
        	//Se tiver Validação
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
    
    //Faz um laço de repetição
    For nAtual := 1 To nTotal
        //Muda a mensagem na regua
        nAtual++
        oSay:SetText("Adicionando registro " + cValToChar(nAtual) + " de " + cValToChar(nTotal) + "...")
  
        //Pega as variáveis que vão ser gravadas
        cCodAtu := Soma1(cCodAtu)
        cDescri := "[" + Time() + "] Teste - " + cCodAtu
        nQuanti := Randomize(-5, 5)
        dEmissa := DaySub(dDtRef, nAtual)
  
        //Insere os dados na temporária
        RecLock(cAliasTab, .T.)
            (cAliasTab)->XXCODIGO := cCodAtu
            (cAliasTab)->XXDESCRI := cDescri
            (cAliasTab)->XXQUANTI := nQuanti
            (cAliasTab)->XXEMISSA := dEmissa
            (cAliasTab)->XXOBSERV := ""
        (cAliasTab)->(MsUnlock())
    
    Next
    
    RestArea(aArea)
Return

/*/{Protheus.doc} fVldQtd
Função para validar a quantidade digitada
@type  Static Function
@author Atilio
@since 01/03/2024
/*/

Static Function fVldQtd()
    Local lContinua := .T.
    Local aPosAtual := oGetGrid:oBrowse:GetCursorPos() //1 = Linha; 2= Coluna
    Local nLinha    := aPosAtual[1]
    Local nColuna   := 3 //Campo da quantidade

    //Atualiza a linha, antes de ir para a próxima
    oGetGrid:LineRefresh(nLinha)

    //Define para qual coluna quer ir
    oGetGrid:oBrowse:GoColumn(nColuna)

    //Pula para uma linha para baixo
    oGetGrid:GoDown(1)

    //Define para qual linha quer ir (outra forma)
    //oGetGrid:oBrowse:SetSelectedRow(nLinha + 1)

Return lContinua
