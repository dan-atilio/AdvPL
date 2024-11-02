/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2024/10/15/criando-um-browse-que-e-atualizado-conforme-alteracoes-em-um-tget-ti-responde-0090/ 
    
*/


//Bibliotecas
#Include "Totvs.ch"
#Include "FWMVCDef.ch"

/*/{Protheus.doc} User Function zVid0090
Lista de Produtos
@author Atilio
@since 26/02/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function zVid0090()
	Local aArea := FWGetArea()
	
	//Chama a tela
	fMontaTela()
	
	FWRestArea(aArea)
Return

/*/{Protheus.doc} fMontaTela
Monta a tela com a marcação de dados
@author Atilio
@since 26/02/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fMontaTela()
    Local aArea         := GetArea()
    Local aCampos := {}
    Local aColunas := {}
    Local cFontPad    := 'Tahoma'
    Local oFontGrid   := TFont():New(cFontPad, /*uPar2*/, -14)
    //Barra de Botões
    Local bBlocoOk     := {|| lOk := .T., oDlgBrow:End()}
    Local bBlocoCan    := {|| lOk := .F., oDlgBrow:End()}
    Local aOutrasAc    := {}
    Local bBlocoIni    := {|| EnchoiceBar(oDlgBrow, bBlocoOk, bBlocoCan, , aOutrasAc)}
    Private lOk        := .F.
    //Janela e componentes
    Private oDlgBrow
    Private oPanGrid
    Private oFWBrowse
    Private oTempTable := Nil
    Private cAliasTmp := GetNextAlias()
    Private aRotina   := MenuDef()
    //Tamanho da janela
    Private aTamanho := MsAdvSize()
    Private nJanLarg := aTamanho[5]
    Private nJanAltu := aTamanho[6]
    //Get da pesquisa
    Private oGetPesq, cGetPesq := Space(100)
    
    //Adiciona as colunas que serão criadas na temporária
    aAdd(aCampos, { 'B1_COD',  'C', TamSX3('B1_COD')[1],  0}) //Produto
    aAdd(aCampos, { 'B1_TIPO', 'C', TamSX3('B1_TIPO')[1], 0}) //Tipo
    aAdd(aCampos, { 'B1_UM',   'C', TamSX3('B1_UM')[1],   0}) //U.M.
    aAdd(aCampos, { 'B1_DESC', 'C', TamSX3('B1_DESC')[1], 0}) //Descrição

    //Cria a tabela temporária
    oTempTable:= FWTemporaryTable():New(cAliasTmp)
    oTempTable:SetFields( aCampos )
    oTempTable:Create()  

    //Popula a tabela temporária
    Processa({|| fPopula()}, 'Processando...')

    //Adiciona as colunas que serão exibidas no FWBrowse
    aColunas := fCriaCols()
     
    //Criando a janela
    oDlgBrow := TDialog():New(0, 0, nJanAltu, nJanLarg, 'Tela para Consulta de Dados - Autumn Code Maker', , , , , , /*nCorFundo*/, , , .T.)
        //Get de pesquisa
        oGetPesq  := TGet():New(035, 003, {|u| Iif(PCount() > 0 , cGetPesq := u, cGetPesq)}, oDlgBrow, 150, 10, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontGrid, , , .T.)
        oGetPesq:cPlaceHold := "Digite aqui código ou descrição do produto..."
        oGetPesq:bGetKey      := {|self, cText, nKey| fKeyPress(self, cText, nKey)}

        //Dados
        oPanGrid := tPanel():New(050, 001, '', oDlgBrow, /*oFont*/, /*lCentered*/, /*uParam7*/, RGB(000,000,000), RGB(254,254,254), (nJanLarg/2) - 1, (nJanAltu/2) - 1)
        oFWBrowse := FWBrowse():New()
        oFWBrowse:DisableFilter()
        oFWBrowse:DisableConfig()
        oFWBrowse:DisableReport()
        oFWBrowse:DisableSeek()
        oFWBrowse:DisableSaveConfig()
        oFWBrowse:SetFontBrowse(oFontGrid)
        oFWBrowse:SetAlias(cAliasTmp)
        oFWBrowse:SetDataTable()
        oFWBrowse:SetEditCell(.T., {|| .T.}) 
        oFWBrowse:lHeaderClick := .F.
        
        //Define as colunas, vincula ao painel e exibe
        oFWBrowse:SetColumns(aColunas)
        oFWBrowse:SetOwner(oPanGrid)
        oFWBrowse:Activate()
        
    oDlgBrow:Activate(, , , .T., , , bBlocoIni)

    If lOk
        //Aqui dentro desse if, será executado o usuário clicou no confirmar
    EndIf
    
    //Deleta a temporária e desativa a tela de marcação
    oTempTable:Delete()
    oFWBrowse:DeActivate()
    
    RestArea(aArea)
Return

/*/{Protheus.doc} fPopula
Executa a query SQL e popula essa informação na tabela temporária usada no browse
@author Atilio
@since 26/02/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fPopula()
    Local cQryDados := ''

    //Popula a temporária com a query
    //   Baixar a zExecQry nesse link - https://terminaldeinformacao.com/2021/04/21/como-fazer-um-update-via-advpl/
    cQryDados := " INSERT INTO " + oTempTable:GetRealName() + " (B1_COD, B1_TIPO, B1_UM, B1_DESC) " + CRLF
    cQryDados += " SELECT B1_COD, B1_TIPO, B1_UM, B1_DESC FROM " + RetSQLName("SB1") + " SB1 WHERE B1_FILIAL = '" + FWxFilial("SB1") + "' AND SB1.D_E_L_E_T_ = ' ' " + CRLF
	u_zExecQry(cQryDados, .T.)

Return

/*/{Protheus.doc} fCriaCols
Função que gera as colunas usadas no browse (similar ao antigo aHeader)
@author Atilio
@since 26/02/2024
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
    //[7] - Editável? .T. = sim, .F. = não
    //[8] - Código da Consulta Padrão
    //[9] - Bloco de Código usado na Validação (ex.: {|| fSuaValid()} )
    aAdd(aEstrut, { 'B1_COD',  'Produto',   'C', TamSX3('B1_COD')[1],  0, '', .F., Nil, Nil})
    aAdd(aEstrut, { 'B1_TIPO', 'Tipo',      'C', TamSX3('B1_TIPO')[1], 0, '', .F., Nil, Nil})
    aAdd(aEstrut, { 'B1_UM',   'U.M.',      'C', TamSX3('B1_UM')[1],   0, '', .F., Nil, Nil})
    aAdd(aEstrut, { 'B1_DESC', 'Descrição', 'C', TamSX3('B1_DESC')[1], 0, '', .F., Nil, Nil})

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

        //Se for ser possível ter o duplo clique para editar
        If aEstrut[nAtual][7]
        	oColumn:SetEdit(.T.)
        	oColumn:SetReadVar(aEstrut[nAtual][1])
        	
        	//Se tiver Consulta Padrão
        	If ! Empty(aEstrut[nAtual][8])
        		oColumn:xF3 := aEstrut[nAtual][8]
        	EndIf
        	
        	//Se tiver Validação
        	If ! Empty(aEstrut[nAtual][9])
        		oColumn:SetValid(aEstrut[nAtual][9])
        	EndIf
        EndIf
        
        //Adiciona a coluna
        aAdd(aColunas, oColumn)
    Next
Return aColunas

Static Function fKeyPress(oObjeto, cTextoComp, nKey)
    Local cProdFiltr := Upper(Alltrim(cTextoComp))
    Local cFiltro    := ""

    //Se tiver vazio o campo, marca o filtro para trazer tudo (CleanFilter às vezes não estava funcionando)
    If Empty(cProdFiltr)
        cFiltro := ".T."
        oFWBrowse:SetFilterDefault(cFiltro)
    Else
  
        //Se for algum caractere válido da tabela ASCII (até 255)
        //  Ou for o Backspace (16777219)
        //  Ou for o Delete (16777223)
        If nKey < 255 .Or. nKey == 16777219 .Or. nKey == 16777223
            
            //Se o tamanho da string, passar de 3 caracteres
            If Len(cProdFiltr) > 3
                //Monta o filtro por código ou descrição
                cFiltro := "'" + cProdFiltr + "' $ Upper((cAliasTmp)->B1_COD) .Or. "
                cFiltro += "'" + cProdFiltr + "' $ Upper((cAliasTmp)->B1_DESC) "
                oFWBrowse:SetFilterDefault(cFiltro)
            EndIf
        EndIf
    EndIf
  
    //Aciona o refresh, indo ao topo
    oFWBrowse:Refresh(.T.)

Return
