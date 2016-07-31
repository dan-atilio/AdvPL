//Bibliotecas
#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'

//Variáveis Estáticas
Static cTitulo := "Artista"

/*/{Protheus.doc} zModel1
Exemplo de Modelo 1 para cadastro de Artistas
@author Atilio
@since 31/07/2016
@version 1.0
	@return Nil, Função não tem retorno
	@example
	u_zModel1()
/*/

User Function zModel1()
	Local aArea   := GetArea()
	Local oBrowse
	Local cFunBkp := FunName()
	
	SetFunName("zModel1")
	
	//Instânciando FWMBrowse - Somente com dicionário de dados
	oBrowse := FWMBrowse():New()
	
	//Setando a tabela de cadastro de Autor/Interprete
	oBrowse:SetAlias("ZZ1")

	//Setando a descrição da rotina
	oBrowse:SetDescription(cTitulo)
	
	//Legendas
	oBrowse:AddLegend( "ZZ1->ZZ1_COD <= '000005'", "GREEN",	"Menor ou igual a 5" )
	oBrowse:AddLegend( "ZZ1->ZZ1_COD >  '000005'", "RED",	"Maior que 5" )
	
	//Filtrando
	//oBrowse:SetFilterDefault("ZZ1->ZZ1_COD >= '000000' .And. ZZ1->ZZ1_COD <= 'ZZZZZZ'")
	
	//Ativa a Browse
	oBrowse:Activate()
	
	SetFunName(cFunBkp)
	RestArea(aArea)
Return Nil

/*---------------------------------------------------------------------*
 | Func:  MenuDef                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  31/07/2016                                                   |
 | Desc:  Criação do menu MVC                                          |
 *---------------------------------------------------------------------*/

Static Function MenuDef()
	Local aRot := {}
	
	//Adicionando opções
	ADD OPTION aRot TITLE 'Visualizar' ACTION 'VIEWDEF.zModel1' OPERATION MODEL_OPERATION_VIEW   ACCESS 0 //OPERATION 1
	ADD OPTION aRot TITLE 'Legenda'    ACTION 'u_zMod1Leg'      OPERATION 6                      ACCESS 0 //OPERATION X
	ADD OPTION aRot TITLE 'Incluir'    ACTION 'VIEWDEF.zModel1' OPERATION MODEL_OPERATION_INSERT ACCESS 0 //OPERATION 3
	ADD OPTION aRot TITLE 'Alterar'    ACTION 'VIEWDEF.zModel1' OPERATION MODEL_OPERATION_UPDATE ACCESS 0 //OPERATION 4
	ADD OPTION aRot TITLE 'Excluir'    ACTION 'VIEWDEF.zModel1' OPERATION MODEL_OPERATION_DELETE ACCESS 0 //OPERATION 5

Return aRot

/*---------------------------------------------------------------------*
 | Func:  ModelDef                                                     |
 | Autor: Daniel Atilio                                                |
 | Data:  31/07/2016                                                   |
 | Desc:  Criação do modelo de dados MVC                               |
 *---------------------------------------------------------------------*/

Static Function ModelDef()
	//Criação do objeto do modelo de dados
	Local oModel := Nil
	
	//Criação da estrutura de dados utilizada na interface
	Local oStZZ1 := FWFormStruct(1, "ZZ1")
	
	//Editando características do dicionário
	oStZZ1:SetProperty('ZZ1_COD',   MODEL_FIELD_WHEN,    FwBuildFeature(STRUCT_FEATURE_WHEN,    '.F.'))                                 //Modo de Edição
	oStZZ1:SetProperty('ZZ1_COD',   MODEL_FIELD_INIT,    FwBuildFeature(STRUCT_FEATURE_INIPAD,  'GetSXENum("ZZ1", "ZZ1_COD")'))         //Ini Padrão
	oStZZ1:SetProperty('ZZ1_DESC',  MODEL_FIELD_VALID,   FwBuildFeature(STRUCT_FEATURE_VALID,   'Iif(Empty(M->ZZ1_DESC), .F., .T.)'))   //Validação de Campo
	oStZZ1:SetProperty('ZZ1_DESC',  MODEL_FIELD_OBRIGAT, Iif(RetCodUsr()!='000000', .T., .F.) )                                         //Campo Obrigatório
	
	//Instanciando o modelo, não é recomendado colocar nome da user function (por causa do u_), respeitando 10 caracteres
	oModel := MPFormModel():New("zModel1M",/*bPre*/, /*bPos*/,/*bCommit*/,/*bCancel*/) 
	
	//Atribuindo formulários para o modelo
	oModel:AddFields("FORMZZ1",/*cOwner*/,oStZZ1)
	
	//Setando a chave primária da rotina
	oModel:SetPrimaryKey({'ZZ1_FILIAL','ZZ1_COD'})
	
	//Adicionando descrição ao modelo
	oModel:SetDescription("Modelo de Dados do Cadastro "+cTitulo)
	
	//Setando a descrição do formulário
	oModel:GetModel("FORMZZ1"):SetDescription("Formulário do Cadastro "+cTitulo)
Return oModel

/*---------------------------------------------------------------------*
 | Func:  ViewDef                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  31/07/2016                                                   |
 | Desc:  Criação da visão MVC                                         |
 *---------------------------------------------------------------------*/

Static Function ViewDef()
	Local aStruZZ1	:= ZZ1->(DbStruct())
	
	//Criação do objeto do modelo de dados da Interface do Cadastro de Autor/Interprete
	Local oModel := FWLoadModel("zModel1")
	
	//Criação da estrutura de dados utilizada na interface do cadastro de Autor
	Local oStZZ1 := FWFormStruct(2, "ZZ1")  //pode se usar um terceiro parâmetro para filtrar os campos exibidos { |cCampo| cCampo $ 'SZZ1_NOME|SZZ1_DTAFAL|'}
	
	//Criando oView como nulo
	Local oView := Nil

	//Criando a view que será o retorno da função e setando o modelo da rotina
	oView := FWFormView():New()
	oView:SetModel(oModel)
	
	//Atribuindo formulários para interface
	oView:AddField("VIEW_ZZ1", oStZZ1, "FORMZZ1")
	
	//Criando um container com nome tela com 100%
	oView:CreateHorizontalBox("TELA",100)
	
	//Colocando título do formulário
	oView:EnableTitleView('VIEW_ZZ1', 'Dados - '+cTitulo )  
	
	//Força o fechamento da janela na confirmação
	oView:SetCloseOnOk({||.T.})
	
	//O formulário da interface será colocado dentro do container
	oView:SetOwnerView("VIEW_ZZ1","TELA")
	
	/*
	//Tratativa para remover campos da visualização
	For nAtual := 1 To Len(aStruZZ1)
		cCampoAux := Alltrim(aStruZZ1[nAtual][01])
		
		//Se o campo atual não estiver nos que forem considerados
		If Alltrim(cCampoAux) $ "ZZ1_COD;"
			oStZZ1:RemoveField(cCampoAux)
		EndIf
	Next
	*/
Return oView

/*/{Protheus.doc} zMod1Leg
Função para mostrar a legenda
@author Atilio
@since 31/07/2016
@version 1.0
	@example
	u_zMod1Leg()
/*/

User Function zMod1Leg()
	Local aLegenda := {}
	
	//Monta as cores
	AADD(aLegenda,{"BR_VERDE",		"Menor ou igual a 5"  })
	AADD(aLegenda,{"BR_VERMELHO",	"Maior que 5"})
	
	BrwLegenda(cTitulo, "Status", aLegenda)
Return