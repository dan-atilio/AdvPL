//Bibliotecas
#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'
 
//Variáveis Estáticas
Static cTitulo := "Grp. Produtos (Abas)"
 
/*/{Protheus.doc} zAba2
Exemplo de rotina com multiplas abas em MVC
@author Atilio
@since 25/07/2017
@version 1.0
	@return Nil, Função não tem retorno
	@example
	u_zAba2()
/*/
 
User Function zAba2()
	Local aArea   := GetArea()
	Local oBrowse
	Local cFunBkp := FunName()
	
	SetFunName("zAba2")
	
	//Instânciando FWMBrowse
	oBrowse := FWMBrowse():New()
	oBrowse:SetAlias("SBM")
	oBrowse:SetDescription(cTitulo)
	oBrowse:Activate()
	
	SetFunName(cFunBkp)
	RestArea(aArea)
Return Nil

/*---------------------------------------------------------------------*
 | Func:  MenuDef                                                      |
 | Desc:  Criação do menu MVC                                          |
 *---------------------------------------------------------------------*/
 
Static Function MenuDef()
	Local aRot := {}
	
	//Adicionando opções
	ADD OPTION aRot TITLE 'Visualizar' ACTION 'VIEWDEF.zAba2' OPERATION MODEL_OPERATION_VIEW ACCESS 0
Return aRot
 
/*---------------------------------------------------------------------*
 | Func:  ModelDef                                                     |
 | Desc:  Criação do modelo de dados MVC                               |
 *---------------------------------------------------------------------*/
 
Static Function ModelDef()
	Local oModel     := Nil
	Local oStPai     := FWFormStruct(1, 'SBM')
	Local oStFilho1  := FWFormStruct(1, 'SB1')
	Local oStFilho2  := FWFormStruct(1, 'SB1')
	Local oStNeto1a  := FWFormStruct(1, 'SD1')
	Local oStNeto1b  := FWFormStruct(1, 'SC7')
	Local oStNeto2a  := FWFormStruct(1, 'SD1')
	Local oStNeto2b  := FWFormStruct(1, 'SC7')
	Local aRelFilho1 := {}
	Local aRelFilho2 := {}
	Local aRelNeto1a := {}
	Local aRelNeto1b := {}
	Local aRelNeto2a := {}
	Local aRelNeto2b := {}
	
	//Criando o modelo
	oModel := MPFormModel():New('zAba2M')
	oModel:AddFields('SBM_MASTER', /*cOwner*/, oStPai)
	
	//Criando as grids dos filhos
	oModel:AddGrid('SB1_FILHO1', 'SBM_MASTER', oStFilho1)
	oModel:AddGrid('SB1_FILHO2', 'SBM_MASTER', oStFilho2)
	
	//Criando as grids dos netos
	oModel:AddGrid('SD1_NETO1A', 'SB1_FILHO1', oStNeto1a)
	oModel:AddGrid('SC7_NETO1B', 'SB1_FILHO1', oStNeto1b)
	oModel:AddGrid('SD1_NETO2A', 'SB1_FILHO2', oStNeto2a)
	oModel:AddGrid('SC7_NETO2B', 'SB1_FILHO2', oStNeto2b)
	
	//Criando os relacionamentos dos pais e filhos
	aAdd(aRelFilho1, {'B1_GRUPO',  'BM_GRUPO'})
	aAdd(aRelFilho1, {'B1_LOCPAD', '00'})
	aAdd(aRelFilho2, {'B1_GRUPO',  'BM_GRUPO'})
	aAdd(aRelFilho2, {'B1_LOCPAD', '01'})
	
	//Criando os relacionamentos dos netos com os filhos
	aAdd(aRelNeto1a, {'D1_COD',     "oModel:GetModel('SB1_FILHO1'):GetValue('B1_COD')"})
	aAdd(aRelNeto1a, {'D1_LOCAL',   "oModel:GetModel('SB1_FILHO1'):GetValue('B1_LOCPAD')"})
	aAdd(aRelNeto1b, {'C7_PRODUTO', "oModel:GetModel('SB1_FILHO1'):GetValue('B1_COD')"})
	aAdd(aRelNeto1b, {'C7_LOCAL',   "oModel:GetModel('SB1_FILHO1'):GetValue('B1_LOCPAD')"})
	aAdd(aRelNeto2a, {'D1_COD',     "oModel:GetModel('SB1_FILHO2'):GetValue('B1_COD')"})
	aAdd(aRelNeto2a, {'D1_LOCAL',   "oModel:GetModel('SB1_FILHO2'):GetValue('B1_LOCPAD')"})
	aAdd(aRelNeto2b, {'C7_PRODUTO', "oModel:GetModel('SB1_FILHO2'):GetValue('B1_COD')"})
	aAdd(aRelNeto2b, {'C7_LOCAL',   "oModel:GetModel('SB1_FILHO2'):GetValue('B1_LOCPAD')"})
	
	//Criando o relacionamento do Filho 1 - Produtos do Armazém 00
	oModel:SetRelation('SB1_FILHO1', aRelFilho1, SB1->(IndexKey(1)))
	oModel:GetModel('SB1_FILHO1'):SetUniqueLine({"B1_FILIAL", "B1_COD"})
	
	//Criando o relacionamento dos netos do Filho 1
	oModel:SetRelation('SD1_NETO1A', aRelNeto1a, SD1->(IndexKey(1)))
	oModel:GetModel('SD1_NETO1A'):SetUniqueLine({"D1_FILIAL", "D1_DOC", "D1_SERIE", "D1_ITEM", "D1_COD"})
	oModel:SetRelation('SC7_NETO1B', aRelNeto1b, SC7->(IndexKey(1)))
	oModel:GetModel('SC7_NETO1B'):SetUniqueLine({"C7_FILIAL", "C7_ITEM", "C7_PRODUTO"})
	
	//Criando o relacionamento do Filho 2 - Produtos do Armazém 01
	oModel:SetRelation('SB1_FILHO2', aRelFilho2, SB1->(IndexKey(1)))
	oModel:GetModel('SB1_FILHO2'):SetUniqueLine({"B1_FILIAL", "B1_COD"})
	
	//Criando o relacionamento dos netos do Filho 2
	oModel:SetRelation('SD1_NETO2A', aRelNeto2a, SD1->(IndexKey(1)))
	oModel:GetModel('SD1_NETO2A'):SetUniqueLine({"D1_FILIAL", "D1_DOC", "D1_SERIE", "D1_ITEM", "D1_COD"})
	oModel:SetRelation('SC7_NETO2B', aRelNeto2b, SC7->(IndexKey(1)))
	oModel:GetModel('SC7_NETO2B'):SetUniqueLine({"C7_FILIAL", "C7_ITEM", "C7_PRODUTO"})
	
	//Finalizando a criação do Model
	oModel:SetPrimaryKey({})
	oModel:SetDescription("Grupo de Produtos - com Abas")
	oModel:GetModel('SBM_MASTER'):SetDescription('Modelo Grupo')
	oModel:GetModel('SB1_FILHO1'):SetDescription('Modelo Prod. Arm. 00')
	oModel:GetModel('SB1_FILHO2'):SetDescription('Modelo Prod. Arm. 01')
Return oModel
 
/*---------------------------------------------------------------------*
 | Func:  ViewDef                                                      |
 | Desc:  Criação da visão MVC                                         |
 *---------------------------------------------------------------------*/
 
Static Function ViewDef()
	Local oView     := Nil
	Local oModel    := FWLoadModel('zAba2')
	Local oStPai    := FWFormStruct(2, 'SBM')
	Local oStFilho1 := FWFormStruct(2, 'SB1')
	Local oStFilho2 := FWFormStruct(2, 'SB1')
	Local oStNeto1a := FWFormStruct(2, 'SD1')
	Local oStNeto1b := FWFormStruct(2, 'SC7')
	Local oStNeto2a := FWFormStruct(2, 'SD1')
	Local oStNeto2b := FWFormStruct(2, 'SC7')
	Local nAtual    := 0
	Local aStrutSB1 := SB1->(DbStruct())
	Local aStrutSD1 := SD1->(DbStruct())
	Local aStrutSC7 := SC7->(DbStruct())
	
	//Criando a View
	oView := FWFormView():New()
	oView:SetModel(oModel)
	
	//Adicionando os campos do cabeçalho
	oView:AddField('VIEW_SBM', oStPai, 'SBM_MASTER')
	
	//Grids dos filhos
	oView:AddGrid('VIEW_FILHO1', oStFilho1, 'SB1_FILHO1')
	oView:AddGrid('VIEW_FILHO2', oStFilho2, 'SB1_FILHO2')
	
	//Grid dos netos
	oView:AddGrid('VIEW_NETO1A', oStNeto1a, 'SD1_NETO1A')
	oView:AddGrid('VIEW_NETO1B', oStNeto1b, 'SC7_NETO1B')
	oView:AddGrid('VIEW_NETO2A', oStNeto2a, 'SD1_NETO2A')
	oView:AddGrid('VIEW_NETO2B', oStNeto2b, 'SC7_NETO2B')
	
	//Setando o dimensionamento de tamanho
	oView:CreateHorizontalBox('SUPERIOR', 30)
	oView:CreateHorizontalBox('INFERIOR', 70)
	
	//Criando a folder dos produtos (filhos)
	oView:CreateFolder('PASTA_FILHOS', 'INFERIOR')
	oView:AddSheet('PASTA_FILHOS', 'ABA_FILHO01', "Armazém 00")
	oView:AddSheet('PASTA_FILHOS', 'ABA_FILHO02', "Armazém 01")
	
	//Cria as caixas onde serão mostrados os dados dos filhos
	oView:CreateHorizontalBox('ITENS_FILHO01', 050,,, 'PASTA_FILHOS', 'ABA_FILHO01' )
	oView:CreateHorizontalBox('ITENS_FILHO02', 050,,, 'PASTA_FILHOS', 'ABA_FILHO02' )
	
	//Criando a folder dos pedidos (netos do Filho 1)
	oView:CreateHorizontalBox('NETOS_FILHO01', 050,,, 'PASTA_FILHOS', 'ABA_FILHO01' )
	oView:CreateFolder('PASTA_NETO1', 'NETOS_FILHO01')
	oView:AddSheet('PASTA_NETO1', 'ABA_NETO1A', "Entradas")
	oView:AddSheet('PASTA_NETO1', 'ABA_NETO1B', "Compras")
	
	//Cria as caixas onde serão mostrados os dados dos netos do Filho 1
	oView:CreateHorizontalBox('ITENS_NETO1A', 100,,, 'PASTA_NETO1', 'ABA_NETO1A' )
	oView:CreateHorizontalBox('ITENS_NETO1B', 100,,, 'PASTA_NETO1', 'ABA_NETO1B' )
	
	//Criando a folder dos pedidos (netos do Filho 2)
	oView:CreateHorizontalBox('NETOS_FILHO02', 050,,, 'PASTA_FILHOS', 'ABA_FILHO02' )
	oView:CreateFolder('PASTA_NETO2', 'NETOS_FILHO02')
	oView:AddSheet('PASTA_NETO2', 'ABA_NETO2A', "Entradas")
	oView:AddSheet('PASTA_NETO2', 'ABA_NETO2B', "Compras")
	
	//Cria as caixas onde serão mostrados os dados dos netos do Filho 2
	oView:CreateHorizontalBox('ITENS_NETO2A', 100,,, 'PASTA_NETO2', 'ABA_NETO2A' )
	oView:CreateHorizontalBox('ITENS_NETO2B', 100,,, 'PASTA_NETO2', 'ABA_NETO2B' )
	
	//Amarrando a view com as box
	oView:SetOwnerView('VIEW_SBM',    'SUPERIOR')
	oView:SetOwnerView('VIEW_FILHO1', 'ITENS_FILHO01')
	oView:SetOwnerView('VIEW_FILHO2', 'ITENS_FILHO02')
	oView:SetOwnerView('VIEW_NETO1A', 'ITENS_NETO1A')
	oView:SetOwnerView('VIEW_NETO1B', 'ITENS_NETO1B')
	oView:SetOwnerView('VIEW_NETO2A', 'ITENS_NETO2A')
	oView:SetOwnerView('VIEW_NETO2B', 'ITENS_NETO2B')
	
	//Retira campos da SB1
	For nAtual := 1 To Len(aStrutSB1)
		If ! Alltrim(aStrutSB1[nAtual][01]) $ "B1_COD;B1_DESC;"
			oStFilho1:RemoveField(aStrutSB1[nAtual][01])
			
			oStFilho2:RemoveField(aStrutSB1[nAtual][01])
		EndIf
	Next
	
	//Retira campos da SD1
	For nAtual := 1 To Len(aStrutSD1)
		If ! Alltrim(aStrutSD1[nAtual][01]) $ "D1_FILIAL;D1_DOC;D1_ITEM;D1_QUANT;D1_VUNIT;D1_TOTAL;D1_TES;D1_FORNECE;"
			oStNeto1a:RemoveField(aStrutSD1[nAtual][01])
			
			oStNeto2a:RemoveField(aStrutSD1[nAtual][01])
		EndIf
	Next
	
	//Retira campos da SC7
	For nAtual := 1 To Len(aStrutSC7)
		If ! Alltrim(aStrutSC7[nAtual][01]) $ "C7_FILIAL;C7_NUM;C7_ITEM;C7_QUANT;C7_PRECO;C7_TOTAL;C7_TES;C7_FORNECE;"
			oStNeto1b:RemoveField(aStrutSC7[nAtual][01])
			
			oStNeto2b:RemoveField(aStrutSC7[nAtual][01])
		EndIf
	Next
	
Return oView