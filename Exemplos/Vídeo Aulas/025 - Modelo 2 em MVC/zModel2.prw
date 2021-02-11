/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2017/01/30/vd-advpl-025/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'

//Variáveis Estáticas
Static cTitulo := "Tabelas Genéricas"

/*/{Protheus.doc} zModel2
Exemplo de Modelo 2 para cadastro de SX5
@author Atilio
@since 14/01/2017
@version 1.0
	@return Nil, Função não tem retorno
	@example
	u_zModel2()
	@obs Para o erro na exclusão - FORMCANDEL da CC2, abra a SX9, e onde tiver '12'+CC2_COD, substitua por '12'+CC2_CODMUN
/*/

User Function zModel2()
	Local aArea   := GetArea()
	Local oBrowse
	Local cFunBkp := FunName()
	
	SetFunName("zModel2")
	
	//Cria um browse para a SX5, filtrando somente a tabela 00 (cabeçalho das tabelas
	oBrowse := FWMBrowse():New()
	oBrowse:SetAlias("SX5")
	oBrowse:SetDescription(cTitulo)
	oBrowse:SetFilterDefault("SX5->X5_TABELA == '00'")
	oBrowse:Activate()
	
	SetFunName(cFunBkp)
	RestArea(aArea)
Return Nil

/*---------------------------------------------------------------------*
 | Func:  MenuDef                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  14/01/2017                                                   |
 | Desc:  Criação do menu MVC                                          |
 *---------------------------------------------------------------------*/

Static Function MenuDef()
	Local aRot := {}
	
	//Adicionando opções
	ADD OPTION aRot TITLE 'Visualizar' ACTION 'VIEWDEF.zModel2' OPERATION MODEL_OPERATION_VIEW   ACCESS 0 //OPERATION 1
	ADD OPTION aRot TITLE 'Incluir'    ACTION 'VIEWDEF.zModel2' OPERATION MODEL_OPERATION_INSERT ACCESS 0 //OPERATION 3
	ADD OPTION aRot TITLE 'Alterar'    ACTION 'VIEWDEF.zModel2' OPERATION MODEL_OPERATION_UPDATE ACCESS 0 //OPERATION 4
	ADD OPTION aRot TITLE 'Excluir'    ACTION 'VIEWDEF.zModel2' OPERATION MODEL_OPERATION_DELETE ACCESS 0 //OPERATION 5
Return aRot

/*---------------------------------------------------------------------*
 | Func:  ModelDef                                                     |
 | Autor: Daniel Atilio                                                |
 | Data:  14/01/2017                                                   |
 | Desc:  Criação do modelo de dados MVC                               |
 *---------------------------------------------------------------------*/

Static Function ModelDef()
	Local oModel   := Nil
	Local oStTmp   := FWFormModelStruct():New()
	Local oStFilho := FWFormStruct(1, 'SX5')
	Local bVldPos  := {|| u_zVldX5Tab()}
	Local bVldCom  := {|| u_zSaveMd2()}
	Local aSX5Rel  := {}
	
	//Adiciona a tabela na estrutura temporária
	oStTmp:AddTable('SX5', {'X5_FILIAL', 'X5_CHAVE', 'X5_DESCRI'}, "Cabecalho SX5")
	
	//Adiciona o campo de Filial
	oStTmp:AddField(;
		"Filial",;                                                                                  // [01]  C   Titulo do campo
		"Filial",;                                                                                  // [02]  C   ToolTip do campo
		"X5_FILIAL",;                                                                               // [03]  C   Id do Field
		"C",;                                                                                       // [04]  C   Tipo do campo
		TamSX3("X5_FILIAL")[1],;                                                                    // [05]  N   Tamanho do campo
		0,;                                                                                         // [06]  N   Decimal do campo
		Nil,;                                                                                       // [07]  B   Code-block de validação do campo
		Nil,;                                                                                       // [08]  B   Code-block de validação When do campo
		{},;                                                                                        // [09]  A   Lista de valores permitido do campo
		.F.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
		FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,SX5->X5_FILIAL,FWxFilial('SX5'))" ),;   // [11]  B   Code-block de inicializacao do campo
		.T.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
		.F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
		.F.)                                                                                        // [14]  L   Indica se o campo é virtual
	
	//Adiciona o campo de Código da Tabela
	oStTmp:AddField(;
		"Tabela",;                                                                    // [01]  C   Titulo do campo
		"Tabela",;                                                                    // [02]  C   ToolTip do campo
		"X5_CHAVE",;                                                                  // [03]  C   Id do Field
		"C",;                                                                         // [04]  C   Tipo do campo
		TamSX3("X5_TABELA")[1],;                                                      // [05]  N   Tamanho do campo
		0,;                                                                           // [06]  N   Decimal do campo
		Nil,;                                                                         // [07]  B   Code-block de validação do campo
		Nil,;                                                                         // [08]  B   Code-block de validação When do campo
		{},;                                                                          // [09]  A   Lista de valores permitido do campo
		.T.,;                                                                         // [10]  L   Indica se o campo tem preenchimento obrigatório
		FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,SX5->X5_CHAVE,'')" ),;    // [11]  B   Code-block de inicializacao do campo
		.T.,;                                                                         // [12]  L   Indica se trata-se de um campo chave
		.F.,;                                                                         // [13]  L   Indica se o campo pode receber valor em uma operação de update.
		.F.)                                                                          // [14]  L   Indica se o campo é virtual
	
	//Adiciona o campo de Descrição
	oStTmp:AddField(;
		"Descricao",;                                                                 // [01]  C   Titulo do campo
		"Descricao",;                                                                 // [02]  C   ToolTip do campo
		"X5_DESCRI",;                                                                 // [03]  C   Id do Field
		"C",;                                                                         // [04]  C   Tipo do campo
		TamSX3("X5_DESCRI")[1],;                                                      // [05]  N   Tamanho do campo
		0,;                                                                           // [06]  N   Decimal do campo
		Nil,;                                                                         // [07]  B   Code-block de validação do campo
		Nil,;                                                                         // [08]  B   Code-block de validação When do campo
		{},;                                                                          // [09]  A   Lista de valores permitido do campo
		.T.,;                                                                         // [10]  L   Indica se o campo tem preenchimento obrigatório
		FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,SX5->X5_DESCRI,'')" ),;   // [11]  B   Code-block de inicializacao do campo
		.F.,;                                                                         // [12]  L   Indica se trata-se de um campo chave
		.F.,;                                                                         // [13]  L   Indica se o campo pode receber valor em uma operação de update.
		.F.)                                                                          // [14]  L   Indica se o campo é virtual
	
	
	//Setando as propriedades na grid, o inicializador da Filial e Tabela, para não dar mensagem de coluna vazia
	oStFilho:SetProperty('X5_FILIAL', MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, '"*"'))
	oStFilho:SetProperty('X5_TABELA', MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, '"*"'))
	
	//Criando o FormModel, adicionando o Cabeçalho e Grid
	oModel := MPFormModel():New("zModel2M", , bVldPos, bVldCom) 
	oModel:AddFields("FORMCAB",/*cOwner*/,oStTmp)
	oModel:AddGrid('SX5DETAIL','FORMCAB',oStFilho)
	
	//Adiciona o relacionamento de Filho, Pai
	aAdd(aSX5Rel, {'X5_FILIAL', 'Iif(!INCLUI, SX5->X5_FILIAL, FWxFilial("SX5"))'} )
	aAdd(aSX5Rel, {'X5_TABELA', 'Iif(!INCLUI, SX5->X5_CHAVE,  "")'} ) 
	
	//Criando o relacionamento
	oModel:SetRelation('SX5DETAIL', aSX5Rel, SX5->(IndexKey(1)))
	
	//Setando o campo único da grid para não ter repetição
	oModel:GetModel('SX5DETAIL'):SetUniqueLine({"X5_CHAVE"})
	
	//Setando outras informações do Modelo de Dados
	oModel:SetDescription("Modelo de Dados do Cadastro "+cTitulo)
	oModel:SetPrimaryKey({})
	oModel:GetModel("FORMCAB"):SetDescription("Formulário do Cadastro "+cTitulo)
Return oModel

/*---------------------------------------------------------------------*
 | Func:  ViewDef                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  14/01/2017                                                   |
 | Desc:  Criação da visão MVC                                         |
 *---------------------------------------------------------------------*/

Static Function ViewDef()
	Local oModel     := FWLoadModel("zModel2")
	Local oStTmp     := FWFormViewStruct():New()
	Local oStFilho   := FWFormStruct(2, 'SX5')
	Local oView      := Nil
	
	//Adicionando o campo Chave para ser exibido
	oStTmp:AddField(;
		"X5_CHAVE",;                // [01]  C   Nome do Campo
		"01",;                      // [02]  C   Ordem
		"Tabela",;                  // [03]  C   Titulo do campo
		X3Descric('X5_TABELA'),;    // [04]  C   Descricao do campo
		Nil,;                       // [05]  A   Array com Help
		"C",;                       // [06]  C   Tipo do campo
		X3Picture("X5_TABELA"),;    // [07]  C   Picture
		Nil,;                       // [08]  B   Bloco de PictTre Var
		Nil,;                       // [09]  C   Consulta F3
		Iif(INCLUI, .T., .F.),;     // [10]  L   Indica se o campo é alteravel
		Nil,;                       // [11]  C   Pasta do campo
		Nil,;                       // [12]  C   Agrupamento do campo
		Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
		Nil,;                       // [14]  N   Tamanho maximo da maior opção do combo
		Nil,;                       // [15]  C   Inicializador de Browse
		Nil,;                       // [16]  L   Indica se o campo é virtual
		Nil,;                       // [17]  C   Picture Variavel
		Nil)                        // [18]  L   Indica pulo de linha após o campo
	
	oStTmp:AddField(;
		"X5_DESCRI",;               // [01]  C   Nome do Campo
		"02",;                      // [02]  C   Ordem
		"Descricao",;               // [03]  C   Titulo do campo
		X3Descric('X5_DESCRI'),;    // [04]  C   Descricao do campo
		Nil,;                       // [05]  A   Array com Help
		"C",;                       // [06]  C   Tipo do campo
		X3Picture("X5_DESCRI"),;    // [07]  C   Picture
		Nil,;                       // [08]  B   Bloco de PictTre Var
		Nil,;                       // [09]  C   Consulta F3
		.T.,;                       // [10]  L   Indica se o campo é alteravel
		Nil,;                       // [11]  C   Pasta do campo
		Nil,;                       // [12]  C   Agrupamento do campo
		Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
		Nil,;                       // [14]  N   Tamanho maximo da maior opção do combo
		Nil,;                       // [15]  C   Inicializador de Browse
		Nil,;                       // [16]  L   Indica se o campo é virtual
		Nil,;                       // [17]  C   Picture Variavel
		Nil)                        // [18]  L   Indica pulo de linha após o campo
	
	//Criando a view que será o retorno da função e setando o modelo da rotina
	oView := FWFormView():New()
	oView:SetModel(oModel)
	oView:AddField("VIEW_CAB", oStTmp, "FORMCAB")
	oView:AddGrid('VIEW_SX5',oStFilho,'SX5DETAIL')
	
	//Setando o dimensionamento de tamanho
	oView:CreateHorizontalBox('CABEC',30)
	oView:CreateHorizontalBox('GRID',70)
	
	//Amarrando a view com as box
	oView:SetOwnerView('VIEW_CAB','CABEC')
	oView:SetOwnerView('VIEW_SX5','GRID')
	
	//Habilitando título
	oView:EnableTitleView('VIEW_CAB','Cabeçalho - Tabela Genérica')
	oView:EnableTitleView('VIEW_SX5','Itens - Tabela Genérica')
	
	//Tratativa padrão para fechar a tela
	oView:SetCloseOnOk({||.T.})
	
	//Remove os campos de Filial e Tabela da Grid
	oStFilho:RemoveField('X5_FILIAL')
	oStFilho:RemoveField('X5_TABELA')
Return oView

/*/{Protheus.doc} zVldX5Tab
Função chamada na validação do botão Confirmar, para verificar se já existe a tabela digitada
@type function
@author Atilio
@since 14/01/2017
@version 1.0
	@return lRet, .T. se pode prosseguir e .F. se deve barrar
/*/

User Function zVldX5Tab()
	Local aArea      := GetArea()
	Local lRet       := .T.
	Local oModelDad  := FWModelActive()
	Local cFilSX5    := oModelDad:GetValue('FORMCAB', 'X5_FILIAL')
	Local cCodigo    := SubStr(oModelDad:GetValue('FORMCAB', 'X5_CHAVE'), 1, TamSX3('X5_TABELA')[01])
	Local nOpc       := oModelDad:GetOperation()
	
	//Se for Inclusão
	If nOpc == MODEL_OPERATION_INSERT
		DbSelectArea('SX5')
		SX5->(DbSetOrder(1)) //X5_FILIAL + X5_TABELA + X5_CHAVE
		
		//Se conseguir posicionar, tabela já existe
		If SX5->(DbSeek(cFilSX5 + '00' + cCodigo))
			Aviso('Atenção', 'Esse código de tabela já existe!', {'OK'}, 02)
			lRet := .F.
		EndIf
	EndIf
	
	RestArea(aArea)
Return lRet

/*/{Protheus.doc} zSaveMd2
Função desenvolvida para salvar os dados do Modelo 2
@type function
@author Atilio
@since 14/01/2017
@version 1.0
/*/

User Function zSaveMd2()
	Local aArea      := GetArea()
	Local lRet       := .T.
	Local oModelDad  := FWModelActive()
	Local cFilSX5    := oModelDad:GetValue('FORMCAB', 'X5_FILIAL')
	Local cCodigo    := SubStr(oModelDad:GetValue('FORMCAB', 'X5_CHAVE'), 1, TamSX3('X5_TABELA')[01])
	Local cDescri    := oModelDad:GetValue('FORMCAB', 'X5_DESCRI')
	Local nOpc       := oModelDad:GetOperation()
	Local oModelGrid := oModelDad:GetModel('SX5DETAIL')
	Local aHeadAux   := oModelGrid:aHeader
	Local aColsAux   := oModelGrid:aCols
	Local nPosChave  := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("X5_CHAVE")})
	Local nPosDescPt := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("X5_DESCRI")})
	Local nPosDescSp := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("X5_DESCSPA")})
	Local nPosDescEn := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("X5_DESCENG")})
	Local nAtual     := 0
	
	DbSelectArea('SX5')
	SX5->(DbSetOrder(1)) //X5_FILIAL + X5_TABELA + X5_CHAVE
	
	//Se for Inclusão
	If nOpc == MODEL_OPERATION_INSERT
		//Cria o registro na tabela 00 (Cabeçalho de tabelas)
		RecLock('SX5', .T.)
			X5_FILIAL   := cFilSX5
			X5_TABELA   := '00'
			X5_CHAVE    := cCodigo
			X5_DESCRI   := cDescri
			X5_DESCSPA  := cDescri
			X5_DESCENG  := cDescri
		SX5->(MsUnlock())
		
		//Percorre as linhas da grid
		For nAtual := 1 To Len(aColsAux)
			//Se a linha não estiver excluída, inclui o registro
			If ! aColsAux[nAtual][Len(aHeadAux)+1]
				RecLock('SX5', .T.)
					X5_FILIAL   := cFilSX5
					X5_TABELA   := cCodigo
					X5_CHAVE    := aColsAux[nAtual][nPosChave]
					X5_DESCRI   := aColsAux[nAtual][nPosDescPt]
					X5_DESCSPA  := aColsAux[nAtual][nPosDescSp]
					X5_DESCENG  := aColsAux[nAtual][nPosDescEn]
				SX5->(MsUnlock())
			EndIf
		Next
		
	//Se for Alteração
	ElseIf nOpc == MODEL_OPERATION_UPDATE
		//Se conseguir posicionar, altera a descrição digitada
		If SX5->(DbSeek(cFilSX5 + '00' + cCodigo))
			RecLock('SX5', .F.)
				X5_DESCRI   := cDescri
				X5_DESCSPA  := cDescri
				X5_DESCENG  := cDescri
			SX5->(MsUnlock())
		EndIf
		
		//Percorre o acols
		For nAtual := 1 To Len(aColsAux)
			//Se a linha estiver excluída
			If aColsAux[nAtual][Len(aHeadAux)+1]
				//Se conseguir posicionar, exclui o registro 
				If SX5->(DbSeek(cFilSX5 + cCodigo + aColsAux[nAtual][nPosChave]))
					RecLock('SX5', .F.)
						DbDelete()
					SX5->(MsUnlock())
				EndIf
				
			Else
				//Se conseguir posicionar no registro, será alteração
				If SX5->(DbSeek(cFilSX5 + cCodigo + aColsAux[nAtual][nPosChave]))
					RecLock('SX5', .F.)
				
				//Senão, será inclusão
				Else
					RecLock('SX5', .T.)
					X5_FILIAL := cFilSX5
					X5_TABELA := cCodigo
					X5_CHAVE    := aColsAux[nAtual][nPosChave]
				EndIf
				
				X5_DESCRI   := aColsAux[nAtual][nPosDescPt]
				X5_DESCSPA  := aColsAux[nAtual][nPosDescSp]
				X5_DESCENG  := aColsAux[nAtual][nPosDescEn]
				SX5->(MsUnlock())
			EndIf
		Next
		
	//Se for Exclusão
	ElseIf nOpc == MODEL_OPERATION_DELETE
		//Se conseguir posicionar, exclui o registro
		If SX5->(DbSeek(cFilSX5 + '00' + cCodigo))
			RecLock('SX5', .F.)
				DbDelete()
			SX5->(MsUnlock())
		EndIf
		
		//Percorre a grid
		For nAtual := 1 To Len(aColsAux)
			//Se conseguir posicionar, exclui o registro
			If SX5->(DbSeek(cFilSX5 + cCodigo + aColsAux[nAtual][nPosChave]))
				RecLock('SX5', .F.)
					DbDelete()
				SX5->(MsUnlock())
			EndIf
		Next
	EndIf
	
	//Se não for inclusão, volta o INCLUI para .T. (bug ao utilizar a Exclusão, antes da Inclusão)
	If nOpc != MODEL_OPERATION_INSERT
		INCLUI := .T.
	EndIf
	
	RestArea(aArea)
Return lRet