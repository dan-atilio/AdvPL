//Bibliotecas
#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'

//Variáveis Estáticas
Static cTitulo := "Grp.Produtos (Mod.X)"

/*/{Protheus.doc} zMVCMdX
Função para cadastro de Grupo de Produtos (SBM), Produtos (SB1) e Saldos dos Produtos (SB2), exemplo de Modelo X em MVC
@author Atilio
@since 17/08/2015
@version 1.0
	@return Nil, Função não tem retorno
	@example
	u_zMVCMdX()
	@obs Não se pode executar função MVC dentro do fórmulas
/*/

User Function zMVCMdX()
	Local aArea   := GetArea()
	Local oBrowse
	
	//Instânciando FWMBrowse - Somente com dicionário de dados
	oBrowse := FWMBrowse():New()
	
	//Setando a tabela de cadastro de Autor/Interprete
	oBrowse:SetAlias("SBM")

	//Setando a descrição da rotina
	oBrowse:SetDescription(cTitulo)
	
	//Legendas
	oBrowse:AddLegend( "SBM->BM_PROORI == '1'", "GREEN",	"Original" )
	oBrowse:AddLegend( "SBM->BM_PROORI == '0'", "RED",	"Não Original" )
	
	//Ativa a Browse
	oBrowse:Activate()
	
	RestArea(aArea)
Return Nil

/*---------------------------------------------------------------------*
 | Func:  MenuDef                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  17/08/2015                                                   |
 | Desc:  Criação do menu MVC                                          |
 | Obs.:  /                                                            |
 *---------------------------------------------------------------------*/

Static Function MenuDef()
	Local aRot := {}
	
	//Adicionando opções
	ADD OPTION aRot TITLE 'Visualizar' ACTION 'VIEWDEF.zMVCMdX' OPERATION MODEL_OPERATION_VIEW   ACCESS 0 //OPERATION 1
	ADD OPTION aRot TITLE 'Legenda'    ACTION 'u_zMVC01Leg'     OPERATION 6                      ACCESS 0 //OPERATION X
	//ADD OPTION aRot TITLE 'Incluir'    ACTION 'VIEWDEF.zMVCMdX' OPERATION MODEL_OPERATION_INSERT ACCESS 0 //OPERATION 3
	//ADD OPTION aRot TITLE 'Alterar'    ACTION 'VIEWDEF.zMVCMdX' OPERATION MODEL_OPERATION_UPDATE ACCESS 0 //OPERATION 4
	//ADD OPTION aRot TITLE 'Excluir'    ACTION 'VIEWDEF.zMVCMdX' OPERATION MODEL_OPERATION_DELETE ACCESS 0 //OPERATION 5

Return aRot

/*---------------------------------------------------------------------*
 | Func:  ModelDef                                                     |
 | Autor: Daniel Atilio                                                |
 | Data:  17/08/2015                                                   |
 | Desc:  Criação do modelo de dados MVC                               |
 | Obs.:  /                                                            |
 *---------------------------------------------------------------------*/

Static Function ModelDef()
	Local oModel 		:= Nil
	Local oStPai 		:= FWFormStruct(1, 'SBM')
	Local oStFilho 	:= FWFormStruct(1, 'SB1')
	Local oStNeto 	:= FWFormStruct(1, 'SB2')
	Local aSB1Rel		:= {}
	Local aSB2Rel		:= {}
	
	//Criando o modelo e os relacionamentos
	oModel := MPFormModel():New('zMVCMdXM')
	oModel:AddFields('SBMMASTER',/*cOwner*/,oStPai)
	oModel:AddGrid('SB1DETAIL','SBMMASTER',oStFilho,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)  //cOwner é para quem pertence
	oModel:AddGrid('SB2DETAIL','SB1DETAIL',oStNeto,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)  //cOwner é para quem pertence
	
	//Fazendo o relacionamento entre o Pai e Filho
	aAdd(aSB1Rel, {'B1_FILIAL',	'BM_FILIAL'} )
	aAdd(aSB1Rel, {'B1_GRUPO',	'BM_GRUPO'})
	
	//Fazendo o relacionamento entre o Filho e Neto
	aAdd(aSB2Rel, {'B2_FILIAL',	'B1_FILIAL'} )
	aAdd(aSB2Rel, {'B2_COD',		'B1_COD'}) 
	
	oModel:SetRelation('SB1DETAIL', aSB1Rel, SB1->(IndexKey(1))) //IndexKey -> quero a ordenação e depois filtrado
	oModel:GetModel('SB1DETAIL'):SetUniqueLine({"B1_FILIAL","B1_COD"})	//Não repetir informações ou combinações {"CAMPO1","CAMPO2","CAMPOX"}
	oModel:SetPrimaryKey({})
	
	oModel:SetRelation('SB2DETAIL', aSB2Rel, SB2->(IndexKey(1))) //IndexKey -> quero a ordenação e depois filtrado
	oModel:GetModel('SB2DETAIL'):SetUniqueLine({"B2_COD","B2_LOCAL","B2_QATU"})	//Não repetir informações ou combinações {"CAMPO1","CAMPO2","CAMPOX"}
	oModel:SetPrimaryKey({})
	
	//Setando as descrições
	oModel:SetDescription("Grupo de Produtos - Mod. X")
	oModel:GetModel('SBMMASTER'):SetDescription('Modelo Grupo')
	oModel:GetModel('SB1DETAIL'):SetDescription('Modelo Produtos')
	oModel:GetModel('SB2DETAIL'):SetDescription('Modelo Saldos')
	
	//Adicionando totalizadores
	oModel:AddCalc('TOT_SALDO', 'SB1DETAIL', 'SB2DETAIL', 'B2_QATU', 'XX_TOTAL', 'SUM', , , "Saldo Total:" )
Return oModel

/*---------------------------------------------------------------------*
 | Func:  ViewDef                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  17/08/2015                                                   |
 | Desc:  Criação da visão MVC                                         |
 | Obs.:  /                                                            |
 *---------------------------------------------------------------------*/

Static Function ViewDef()
	Local oView		:= Nil
	Local oModel		:= FWLoadModel('zMVCMdX')
	Local oStPai		:= FWFormStruct(2, 'SBM')
	Local oStFilho	:= FWFormStruct(2, 'SB1')
	Local oStNeto		:= FWFormStruct(2, 'SB2')
	Local oStTot		:= FWCalcStruct(oModel:GetModel('TOT_SALDO'))
	//Estruturas das tabelas e campos a serem considerados
	Local aStruSBM	:= SBM->(DbStruct())
	Local aStruSB1	:= SB1->(DbStruct())
	Local aStruSB2	:= SB2->(DbStruct())
	Local cConsSBM	:= "BM_GRUPO;BM_DESC;BM_PROORI"
	Local cConsSB1	:= "B1_COD;B1_DESC;B1_TIPO;B1_UM;B1_LOCPAD"
	Local cConsSB2	:= "B2_LOCAL;B2_QATU"
	Local nAtual		:= 0
	
	//Criando a View
	oView := FWFormView():New()
	oView:SetModel(oModel)
	
	//Adicionando os campos do cabeçalho e o grid dos filhos
	oView:AddField('VIEW_SBM',oStPai,'SBMMASTER')
	oView:AddGrid('VIEW_SB1',oStFilho,'SB1DETAIL')
	oView:AddGrid('VIEW_SB2',oStNeto,'SB2DETAIL')
	oView:AddField('VIEW_TOT', oStTot,'TOT_SALDO')
	
	//Setando o dimensionamento de tamanho
	oView:CreateHorizontalBox('CABEC',20)
	oView:CreateHorizontalBox('GRID',40)
	oView:CreateHorizontalBox('GRID2',27)
	oView:CreateHorizontalBox('TOTAL',13)
	
	//Amarrando a view com as box
	oView:SetOwnerView('VIEW_SBM','CABEC')
	oView:SetOwnerView('VIEW_SB1','GRID')
	oView:SetOwnerView('VIEW_SB2','GRID2')
	oView:SetOwnerView('VIEW_TOT','TOTAL')
	
	//Habilitando título
	oView:EnableTitleView('VIEW_SBM','Grupo')
	oView:EnableTitleView('VIEW_SB1','Produtos')
	oView:EnableTitleView('VIEW_SB2','Saldos')
	
	//Percorrendo a estrutura da SBM
	For nAtual := 1 To Len(aStruSBM)
		//Se o campo atual não estiver nos que forem considerados
		If ! Alltrim(aStruSBM[nAtual][01]) $ cConsSBM
			oStPai:RemoveField(aStruSBM[nAtual][01])
		EndIf
	Next
	
	//Percorrendo a estrutura da SB1
	For nAtual := 1 To Len(aStruSB1)
		//Se o campo atual não estiver nos que forem considerados
		If ! Alltrim(aStruSB1[nAtual][01]) $ cConsSB1
			oStFilho:RemoveField(aStruSB1[nAtual][01])
		EndIf
	Next
	
	//Percorrendo a estrutura da SB2
	For nAtual := 1 To Len(aStruSB2)
		//Se o campo atual não estiver nos que forem considerados
		If ! Alltrim(aStruSB2[nAtual][01]) $ cConsSB2
			oStNeto:RemoveField(aStruSB2[nAtual][01])
		EndIf
	Next
Return oView