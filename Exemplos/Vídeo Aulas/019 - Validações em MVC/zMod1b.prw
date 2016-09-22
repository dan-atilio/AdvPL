//Bibliotecas
#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'

//Variáveis Estáticas
Static cTitulo  := "Artista"
Static cDefault := "NOME DO ARTISTA"

/*/{Protheus.doc} zMod1b
Exemplo de Modelo 1 para cadastro de Artistas com validações
@author Atilio
@since 03/09/2016
@version 1.0
	@return Nil, Função não tem retorno
	@example
	u_zMod1b()
/*/

User Function zMod1b()
	Local aArea   := GetArea()
	Local oBrowse
	Local cFunBkp := FunName()
	
	SetFunName("zMod1b")
	
	//Instânciando FWMBrowse - Somente com dicionário de dados
	oBrowse := FWMBrowse():New()
	
	//Setando a tabela de cadastro de Autor/Interprete
	oBrowse:SetAlias("ZZ1")

	//Setando a descrição da rotina
	oBrowse:SetDescription(cTitulo)
	
	//Ativa a Browse
	oBrowse:Activate()
	
	SetFunName(cFunBkp)
	RestArea(aArea)
Return Nil

/*---------------------------------------------------------------------*
 | Func:  MenuDef                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  03/09/2016                                                   |
 | Desc:  Criação do menu MVC                                          |
 *---------------------------------------------------------------------*/

Static Function MenuDef()
	Local aRot := {}
	
	//Adicionando opções
	ADD OPTION aRot TITLE 'Visualizar' ACTION 'VIEWDEF.zMod1b' OPERATION MODEL_OPERATION_VIEW   ACCESS 0 //OPERATION 1s
	ADD OPTION aRot TITLE 'Incluir'    ACTION 'VIEWDEF.zMod1b' OPERATION MODEL_OPERATION_INSERT ACCESS 0 //OPERATION 3
	ADD OPTION aRot TITLE 'Alterar'    ACTION 'VIEWDEF.zMod1b' OPERATION MODEL_OPERATION_UPDATE ACCESS 0 //OPERATION 4
	ADD OPTION aRot TITLE 'Excluir'    ACTION 'VIEWDEF.zMod1b' OPERATION MODEL_OPERATION_DELETE ACCESS 0 //OPERATION 5

Return aRot

/*---------------------------------------------------------------------*
 | Func:  ModelDef                                                     |
 | Autor: Daniel Atilio                                                |
 | Data:  03/09/2016                                                   |
 | Desc:  Criação do modelo de dados MVC                               |
 *---------------------------------------------------------------------*/

Static Function ModelDef()
	//Blocos de código nas validações
	Local bVldPre := {|| u_zM1bPre()} //Antes de abrir a Tela
	Local bVldPos := {|| u_zM1bPos()} //Validação ao clicar no Confirmar
	Local bVldCom := {|| u_zM1bCom()} //Função chamadao ao cancelar
	Local bVldCan := {|| u_zM1bCan()} //Função chamadao ao cancelar
	
	//Criação do objeto do modelo de dados
	Local oModel := Nil
	
	//Criação da estrutura de dados utilizada na interface
	Local oStZZ1 := FWFormStruct(1, "ZZ1")
	
	//Editando características do dicionário
	oStZZ1:SetProperty('ZZ1_COD',   MODEL_FIELD_WHEN,    FwBuildFeature(STRUCT_FEATURE_WHEN,    '.F.'))                                 //Modo de Edição
	oStZZ1:SetProperty('ZZ1_COD',   MODEL_FIELD_INIT,    FwBuildFeature(STRUCT_FEATURE_INIPAD,  'GetSXENum("ZZ1", "ZZ1_COD")'))         //Ini Padrão
	oStZZ1:SetProperty('ZZ1_DESC',  MODEL_FIELD_OBRIGAT, Iif(RetCodUsr()!='000000', .T., .F.) )                                         //Campo Obrigatório
	oStZZ1:SetProperty('ZZ1_DESC',  MODEL_FIELD_INIT,    FwBuildFeature(STRUCT_FEATURE_INIPAD,  "'"+cDefault+"'"))                              //Ini Padrão
	
	//Instanciando o modelo, não é recomendado colocar nome da user function (por causa do u_), respeitando 10 caracteres
	oModel := MPFormModel():New("zMod1bM", bVldPre, bVldPos, bVldCom, bVldCan) 
	
	//Atribuindo formulários para o modelo
	oModel:AddFields("FORMZZ1",/*cOwner*/,oStZZ1)
	
	//Setando a chave primária da rotina
	oModel:SetPrimaryKey({'ZZ1_FILIAL','ZZ1_COD'})
	
	//Adicionando descrição ao modelo
	oModel:SetDescription("Modelo de Dados do Cadastro "+cTitulo)
	
	//Setando a descrição do formulário
	oModel:GetModel("FORMZZ1"):SetDescription("Formulário do Cadastro "+cTitulo)
	
	//Pode ativar?
	oModel:SetVldActive( { | oModel | fAlterar( oModel ) } )
Return oModel

/*---------------------------------------------------------------------*
 | Func:  ViewDef                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  03/09/2016                                                   |
 | Desc:  Criação da visão MVC                                         |
 *---------------------------------------------------------------------*/

Static Function ViewDef()
	Local aStruZZ1	:= ZZ1->(DbStruct())
	
	//Criação do objeto do modelo de dados da Interface do Cadastro de Autor/Interprete
	Local oModel := FWLoadModel("zMod1b")
	
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
Return oView

/*/{Protheus.doc} zM1bPre
Função chamada na criação do Modelo de Dados (pré-validação)
@type function
@author Atilio
@since 03/09/2016
@version 1.0
/*/

User Function zM1bPre()
	Local oModelPad  := FWModelActive()
	Local nOpc       := oModelPad:GetOperation()
	Local lRet       := .T.
	
	//Se for inclusão ou exclusão
	If nOpc == MODEL_OPERATION_INSERT
		If RetCodUsr() == '000000'
			oModelPad:GetModel('FORMZZ1'):GetStruct():SetProperty('ZZ1_COD',   MODEL_FIELD_WHEN,    FwBuildFeature(STRUCT_FEATURE_WHEN,    '.T.'))
		EndIf
	EndIf
Return lRet

/*/{Protheus.doc} zM1bPos
Função chamada no clique do botão Ok do Modelo de Dados (pós-validação)
@type function
@author Atilio
@since 03/09/2016
@version 1.0
/*/

User Function zM1bPos()
	Local oModelPad  := FWModelActive()
	Local cDescri    := oModelPad:GetValue('FORMZZ1', 'ZZ1_DESC')
	Local lRet       := .T.
	
	//Se a descrição estiver em branco
	If Empty(cDescri) .Or. Alltrim(Upper(cDescri)) == cDefault
		lRet := .F.
		Aviso('Atenção', 'Campo Descrição esta em branco!', {'OK'}, 03)
	EndIf
	
Return lRet

/*/{Protheus.doc} zM1bCom
Função chamada após validar o ok da rotina para os dados serem salvos
@type function
@author Atilio
@since 03/09/2016
@version 1.0
/*/

User Function zM1bCom()
	Local oModelPad  := FWModelActive()
	Local cCodigo    := oModelPad:GetValue('FORMZZ1', 'ZZ1_COD')
	Local cDescri    := oModelPad:GetValue('FORMZZ1', 'ZZ1_DESC')
	Local nOpc       := oModelPad:GetOperation()
	Local lRet       := .T.
	
	//Se for Inclusão
	If nOpc == MODEL_OPERATION_INSERT
		RecLock('ZZ1', .T.)
			ZZ1_FILIAL := FWxFilial('ZZ1')
			ZZ1_COD    := cCodigo
			ZZ1_DESC   := cDescri
		ZZ1->(MsUnlock())
		ConfirmSX8()
		
		Aviso('Atenção', 'Inclusão realizada!', {'OK'}, 03)
		
	//Se for Alteração
	ElseIf nOpc == MODEL_OPERATION_UPDATE
		RecLock('ZZ1', .F.)
			ZZ1_DESC := cDescri
		ZZ1->(MsUnlock())
		
		Aviso('Atenção', 'Alteração realizada!', {'OK'}, 03)
		
	//Se for Exclusão
	ElseIf nOpc == MODEL_OPERATION_DELETE
		RecLock('ZZ1', .F.)
			DbDelete()
		ZZ1->(MsUnlock())
		
		Aviso('Atenção', 'Exclusão realizada!', {'OK'}, 03)
	EndIf
Return lRet

/*/{Protheus.doc} zM1bCan
Função chamada ao cancelar as informações do Modelo de Dados (botão Cancelar)
@type function
@author Atilio
@since 03/09/2016
@version 1.0
/*/

User Function zM1bCan()
	Local oModelPad  := FWModelActive()
	Local lRet       := .T.
	
	//Somente permite cancelar se o usuário confirmar
	lRet := MsgYesNo("Deseja cancelar a operação?", "Atenção")
Return lRet

/*---------------------------------------------------------------------*
 | Func:  fAlterar                                                     |
 | Autor: Daniel Atilio                                                |
 | Data:  03/09/2016                                                   |
 | Desc:  Define se pode abrir o Modelo de Dados                       |
 *---------------------------------------------------------------------*/

Static Function fAlterar( oModel )
	Local lRet       := .T.
	Local nOperation := oModel:GetOperation()

	//Se for exclusão
	If nOperation == MODEL_OPERATION_DELETE
		//Se não for o Administrador
		If RetCodUsr() != '000000'
			lRet := .F.
			Aviso('Atenção', 'Somente o Administrador pode excluir registros!', {'OK'}, 03)
		EndIf
	EndIf

Return lRet