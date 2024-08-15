/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2023/06/12/criar-ordenacao-em-clique-de-colunas-com-fwbrowse-ti-responde-060/ 
    
*/


//Bibliotecas
#Include "Totvs.ch"
#Include "FWMVCDef.ch"

/*/{Protheus.doc} User Function zVid0060
Tela de Produtos
@author Atilio
@since 30/08/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function zVid0060()
	Local aArea := FWGetArea()
	Local aPergs   := {}
	Local xPar0 := Space(15)
	Local xPar1 := StrTran(xPar0, ' ', 'Z')
	
	//Adicionando os parametros do ParamBox
	aAdd(aPergs, {1, "Produto De", xPar0,  "", ".T.", "SB1", ".T.", 80,  .F.})
	aAdd(aPergs, {1, "Produto Até", xPar1,  "", ".T.", "SB1", ".T.", 80,  .T.})
	
	//Se a pergunta for confirma, chama a tela
	If ParamBox(aPergs, "Informe os parametros", , , , , , , , , .F., .F.)
		fMontaTela()
	EndIf
	
	FWRestArea(aArea)
Return

/*/{Protheus.doc} fMontaTela
Monta a tela com a marcação de dados
@author Atilio
@since 30/08/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fMontaTela()
    Local aArea         := GetArea()
    Local aCampos := {}
    Local oTempTable := Nil
    Local aColunas := {}
    Local cFontPad    := 'Tahoma'
    Local oFontGrid   := TFont():New(cFontPad,,-14)
    Local lOk         := .F.
    Local bBlocoOk    := {|| lOk := .T., oDlgBrowse:End()}
    Local bBlocoCan   := {|| lOk := .F., oDlgBrowse:End()}
    Local aOutrasAc   := { }
    Local bBlocoIni   := {|| EnchoiceBar(oDlgBrowse, bBlocoOk, bBlocoCan, , aOutrasAc)}
    //Janela e componentes
    Private oDlgBrowse
    Private oPanGrid
    Private oBrowseTmp
    Private cAliasTmp := GetNextAlias()
    //Tamanho da janela
    Private aTamanho := MsAdvSize()
    Private nJanLarg := aTamanho[5]
    Private nJanAltu := aTamanho[6]
    //Ordenação da tela
    Private cUltOrdem := ""
    Private lDescend  := .F.
     
    //Adiciona as colunas que serão criadas na temporária
    aAdd(aCampos, { 'B1_COD', 'C', 15, 0}) //Código
    aAdd(aCampos, { 'B1_DESC', 'C', 30, 0}) //Descrição
    aAdd(aCampos, { 'B1_TIPO', 'C', 2, 0}) //Tipo
    aAdd(aCampos, { 'B1_UM', 'C', 2, 0}) //Unidade Medida

    //Cria a tabela temporária
    oTempTable:= FWTemporaryTable():New(cAliasTmp)
    oTempTable:SetFields( aCampos )
    oTempTable:AddIndex("1", {"B1_COD"} )
    oTempTable:AddIndex("2", {"B1_DESC"} )
    oTempTable:Create()  

    //Popula a tabela temporária
    Processa({|| fPopula()}, 'Processando...')

    //Adiciona as colunas que serão exibidas no browse
    aColunas := fCriaCols()
     
    //Criando a janela
    oDlgBrowse := TDialog():New(0, 0, nJanAltu, nJanLarg, 'Tela para Análise de Dados', , , , , , /*nCorFundo*/, , , .T.)
        //Dados
        oPanGrid := tPanel():New(030, 001, '', oDlgBrowse, , , , RGB(000,000,000), RGB(254,254,254), (nJanLarg/2)-1,     (nJanAltu/2 - 10))
        oBrowseTmp := FWBrowse():New()
        oBrowseTmp:SetDataTable()
        oBrowseTmp:SetInsert(.F.)
        oBrowseTmp:SetDelete(.F., { || .F. })
        oBrowseTmp:SetAlias(cAliasTmp)
        oBrowseTmp:DisableReport()
        oBrowseTmp:DisableFilter()
        oBrowseTmp:DisableConfig()
        oBrowseTmp:DisableReport()
        oBrowseTmp:DisableSeek()
        oBrowseTmp:DisableSaveConfig()
        oBrowseTmp:AddLegend(cAliasTmp + "->B1_TIPO == 'PA'",                                          "GREEN",       "Produto Acabado")
        oBrowseTmp:AddLegend(cAliasTmp + "->B1_TIPO == 'PI'",                                          "YELLOW",      "Produto Intermediário")
        oBrowseTmp:AddLegend(cAliasTmp + "->B1_TIPO != 'PA' .And. " + cAliasTmp + "->B1_TIPO != 'PI'", "RED",         "Outros Tipos")
        oBrowseTmp:SetFontBrowse(oFontGrid)
        oBrowseTmp:SetColumns(aColunas)
        oBrowseTmp:SetOwner(oPanGrid)
        oBrowseTmp:lHeaderClick := .T.
        oBrowseTmp:SetItemHeaderClick({"B1_COD", "B1_DESC"})
        oBrowseTmp:Activate()
    oDlgBrowse:Activate(, , , .T., , , bBlocoIni)
    
    //Deleta a temporária e desativa a tela de marcação
    oTempTable:Delete()
    oBrowseTmp:DeActivate()
    
    RestArea(aArea)
Return

/*/{Protheus.doc} fPopula
Executa a query SQL e popula essa informação na tabela temporária usada no browse
@author Atilio
@since 30/08/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fPopula()
    Local cQryDados := ''
    Local nTotal := 0
    Local nAtual := 0

    //Monta a consulta
    cQryDados += "SELECT "		+ CRLF
    cQryDados += " B1_COD, "		+ CRLF
    cQryDados += " B1_DESC, "		+ CRLF
    cQryDados += " B1_TIPO, "		+ CRLF
    cQryDados += " B1_UM "		+ CRLF
    cQryDados += "FROM "		+ CRLF
    cQryDados += " SB1990 SB1 "		+ CRLF
    cQryDados += "WHERE "		+ CRLF
    cQryDados += " B1_FILIAL = '" + FWxfilial('SB1') + "' "		+ CRLF
    cQryDados += " AND B1_COD >= '" + MV_PAR01 + "' "		+ CRLF
    cQryDados += " AND B1_COD <= '" + MV_PAR02 + "' "		+ CRLF
    cQryDados += " AND SB1.D_E_L_E_T_ = ' ' "		+ CRLF
    cQryDados += "ORDER BY "		+ CRLF
    cQryDados += " B1_COD"		+ CRLF
    PLSQuery(cQryDados, 'QRYDADTMP')

    //Definindo o tamanho da régua
    DbSelectArea('QRYDADTMP')
    Count to nTotal
    ProcRegua(nTotal)
    QRYDADTMP->(DbGoTop())

    //Enquanto houver registros, adiciona na temporária
    While ! QRYDADTMP->(EoF())
        nAtual++
        IncProc('Analisando registro ' + cValToChar(nAtual) + ' de ' + cValToChar(nTotal) + '...')

        RecLock(cAliasTmp, .T.)
            (cAliasTmp)->B1_COD := QRYDADTMP->B1_COD
            (cAliasTmp)->B1_DESC := QRYDADTMP->B1_DESC
            (cAliasTmp)->B1_TIPO := QRYDADTMP->B1_TIPO
            (cAliasTmp)->B1_UM := QRYDADTMP->B1_UM
        (cAliasTmp)->(MsUnlock())

        QRYDADTMP->(DbSkip())
    EndDo
    QRYDADTMP->(DbCloseArea())
    (cAliasTmp)->(DbGoTop())
Return

/*/{Protheus.doc} fCriaCols
Função que gera as colunas usadas no browse (similar ao antigo aHeader)
@author Atilio
@since 30/08/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fCriaCols()
    Local nAtual       := 0 
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
    aAdd(aEstrut, { 'B1_COD', 'Código', 'C', 15, 0, ''})
    aAdd(aEstrut, { 'B1_DESC', 'Descrição', 'C', 30, 0, ''})
    aAdd(aEstrut, { 'B1_TIPO', 'Tipo', 'C', 2, 0, ''})
    aAdd(aEstrut, { 'B1_UM', 'Unidade Medida', 'C', 2, 0, ''})

    //Percorrendo todos os campos da estrutura
    For nAtual := 1 To Len(aEstrut)
        //Cria a coluna
        oColumn := FWBrwColumn():New()
        oColumn:SetData(&('{|| ' + cAliasTmp + '->' + aEstrut[nAtual][1] +'}'))
        oColumn:SetTitle(aEstrut[nAtual][2])
        oColumn:SetType(aEstrut[nAtual][3])
        oColumn:SetSize(aEstrut[nAtual][4])
        oColumn:SetDecimal(aEstrut[nAtual][5])
        oColumn:SetPicture(aEstrut[nAtual][6])

        //Se for o código ou descrição, adiciona a opção de clique no cabeçalho
        If Alltrim(aEstrut[nAtual][1]) $ "B1_COD;B1_DESC;"
            oColumn:bHeaderClick := &("{|| fOrdena('" + aEstrut[nAtual][1] + "') }")
        EndIf

        //Adiciona a coluna
        aAdd(aColunas, oColumn)
    Next
Return aColunas

Static Function fOrdena(cCampo)
    Default cCampo := ""

    //Pegando o Índice conforme o campo
    cCampo := Alltrim(cCampo)
    If cCampo == "B1_COD"
        nOrder := 1
    ElseIf cCampo == "B1_DESC"
        nOrder := 2
    EndIf

    //Ordena pelo Índice
    (cAliasTmp)->(DbSetOrder(nOrder))

    //Se o último campo clicado é o mesmo, irá mudar entre crescente / decrescente
    If cUltOrdem == cCampo
        //Se esta como decrescente, ordena crescente
        If lDescend
            OrdDescend(nOrder, cValToChar(nOrder), .F.)
            lDescend := .F.

        //Se esta como crescente, ordena como decrescente
        Else
            OrdDescend(nOrder, cValToChar(nOrder), .T.)
            lDescend := .T.
        EndIf
    Else
        lDescend := .F.
    EndIf
    cUltOrdem := cCampo

    fRefresh()
Return

Static Function fRefresh()
    (cAliasTmp)->(DbGoTop())
    oBrowseTmp:GoBottom(.T.)
    oBrowseTmp:Refresh(.T.)
    oBrowseTmp:GoTop(.T.)
    oBrowseTmp:Refresh(.T.)
Return
