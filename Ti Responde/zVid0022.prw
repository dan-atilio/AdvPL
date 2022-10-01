/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2022/09/19/temporaria-em-mvc-com-fwtemporarytable-ti-responde-022/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Totvs.ch"
#Include "FWMVCDef.ch"

//Variveis Estaticas
Static cTitulo := "Tabela Temporária - "

/*/{Protheus.doc} User Function zVid0022
Cadastro de temporária
@author Atilio
@since 10/03/2022
@version 1.0
/*/

User Function zVid0022()
	Local aArea   := FWGetArea()
	Local oBrowse
    Local aCampos := {}
    Local aColunas := {}
    Local aPesquisa := {}
	Private aRotina := {}
    Private cAliasTmp := GetNextAlias()

	//Definicao do menu
	aRotina := MenuDef()

    //Campos da temporária
    aAdd(aCampos, {"TMP_COD", "C", 06, 0})
    aAdd(aCampos, {"TMP_DES", "C", 50, 0})
    aAdd(aCampos, {"TMP_VAL", "N", 10, 0})
    aAdd(aCampos, {"TMP_DAT", "D", 08, 0})

    //Cria a temporária
    oTempTable := FWTemporaryTable():New(cAliasTmp)
    oTempTable:SetFields(aCampos)
    oTempTable:AddIndex("1", {"TMP_COD"} )
    oTempTable:Create()
    cTitulo += oTempTable:GetRealName()

    //Definindo as colunas que serão usadas no browse
    aAdd(aColunas, {"Codigo",    "TMP_COD", "C", 06, 0, "@!"})
    aAdd(aColunas, {"Descricao", "TMP_DES", "C", 50, 0, "@!"})
    aAdd(aColunas, {"Valor",     "TMP_VAL", "N", 10, 0, "@E 9,999,999.99"})
    aAdd(aColunas, {"Data",      "TMP_DAT", "D", 08, 0, "@D"})

    //Adiciona os indices para pesquisar
    /*
        [n,1] Título da pesquisa
        [n,2,n,1] LookUp
        [n,2,n,2] Tipo de dados
        [n,2,n,3] Tamanho
        [n,2,n,4] Decimal
        [n,2,n,5] Título do campo
        [n,2,n,6] Máscara
        [n,2,n,7] Nome Físico do campo - Opcional - é ajustado no programa
        [n,3] Ordem da pesquisa
        [n,4] Exibe na pesquisa
    */
    aAdd(aPesquisa, {"Codigo", {{"", "C", 6, 0, "Codigo", "@!", "TMP_COD"}} } )

    //Criando o browse da temporária
    oBrowse := FWMBrowse():New()
    oBrowse:SetAlias(cAliasTmp)
    oBrowse:SetTemporary(.T.)
    oBrowse:SetFields(aColunas)
    oBrowse:DisableDetails()
    oBrowse:SetDescription(cTitulo)
    oBrowse:SetSeek(.T., aPesquisa)
    oBrowse:Activate()

    oTempTable:Delete()
	FWRestArea(aArea)
Return Nil

/*/{Protheus.doc} MenuDef
Menu de opcoes na funcao zVid0022
@author Atilio
@since 10/03/2022
@version 1.0
/*/

Static Function MenuDef()
	Local aRotina := {}

	//Adicionando opcoes do menu
	ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.zVid0022" OPERATION 1 ACCESS 0
	ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.zVid0022" OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.zVid0022" OPERATION 4 ACCESS 0
	ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.zVid0022" OPERATION 5 ACCESS 0

Return aRotina

/*/{Protheus.doc} ModelDef
Modelo de dados na funcao zVid0022
@author Atilio
@since 10/03/2022
@version 1.0
/*/

Static Function ModelDef()
    Local oModel := Nil
    Local oStTMP := FWFormModelStruct():New()
     
    //Na estrutura, define os campos e a temporária
    oStTMP:AddTable(cAliasTmp, {'TMP_COD', 'TMP_DES', 'TMP_VAL', 'TMP_DAT'}, "Temporaria")
     
    //Adiciona os campos da estrutura
    oStTmp:AddField(;
        "Codigo",;                                                                                  // [01]  C   Titulo do campo
        "Codigo",;                                                                                  // [02]  C   ToolTip do campo
        "TMP_COD",;                                                                                 // [03]  C   Id do Field
        "C",;                                                                                       // [04]  C   Tipo do campo
        06,;                                                                                        // [05]  N   Tamanho do campo
        0,;                                                                                         // [06]  N   Decimal do campo
        Nil,;                                                                                       // [07]  B   Code-block de validação do campo
        Nil,;                                                                                       // [08]  B   Code-block de validação When do campo
        {},;                                                                                        // [09]  A   Lista de valores permitido do campo
        .T.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
        FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,"+cAliasTmp+"->TMP_COD,'')" ),;         // [11]  B   Code-block de inicializacao do campo
        .T.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
        .F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
        .F.)                                                                                        // [14]  L   Indica se o campo é virtual
    oStTmp:AddField(;
        "Descricao",;                                                                               // [01]  C   Titulo do campo
        "Descricao",;                                                                               // [02]  C   ToolTip do campo
        "TMP_DES",;                                                                                 // [03]  C   Id do Field
        "C",;                                                                                       // [04]  C   Tipo do campo
        50,;                                                                                        // [05]  N   Tamanho do campo
        0,;                                                                                         // [06]  N   Decimal do campo
        Nil,;                                                                                       // [07]  B   Code-block de validação do campo
        Nil,;                                                                                       // [08]  B   Code-block de validação When do campo
        {},;                                                                                        // [09]  A   Lista de valores permitido do campo
        .T.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
        FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,"+cAliasTmp+"->TMP_DES,'')" ),;         // [11]  B   Code-block de inicializacao do campo
        .F.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
        .F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
        .F.)                                                                                        // [14]  L   Indica se o campo é virtual
    oStTmp:AddField(;
        "Valor",;                                                                                   // [01]  C   Titulo do campo
        "Valor",;                                                                                   // [02]  C   ToolTip do campo
        "TMP_VAL",;                                                                                 // [03]  C   Id do Field
        "N",;                                                                                       // [04]  C   Tipo do campo
        10,;                                                                                        // [05]  N   Tamanho do campo
        02,;                                                                                        // [06]  N   Decimal do campo
        Nil,;                                                                                       // [07]  B   Code-block de validação do campo
        Nil,;                                                                                       // [08]  B   Code-block de validação When do campo
        {},;                                                                                        // [09]  A   Lista de valores permitido do campo
        .F.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
        FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,"+cAliasTmp+"->TMP_VAL,'')" ),;         // [11]  B   Code-block de inicializacao do campo
        .F.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
        .F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
        .F.)                                                                                        // [14]  L   Indica se o campo é virtual
    oStTmp:AddField(;
        "Data",;                                                                                    // [01]  C   Titulo do campo
        "Data",;                                                                                    // [02]  C   ToolTip do campo
        "TMP_DAT",;                                                                                 // [03]  C   Id do Field
        "D",;                                                                                       // [04]  C   Tipo do campo
        08,;                                                                                        // [05]  N   Tamanho do campo
        0,;                                                                                         // [06]  N   Decimal do campo
        Nil,;                                                                                       // [07]  B   Code-block de validação do campo
        Nil,;                                                                                       // [08]  B   Code-block de validação When do campo
        {},;                                                                                        // [09]  A   Lista de valores permitido do campo
        .F.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
        FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,"+cAliasTmp+"->TMP_DAT,'')" ),;         // [11]  B   Code-block de inicializacao do campo
        .F.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
        .F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
        .F.)                                                                                        // [14]  L   Indica se o campo é virtual
     
    //Instanciando o modelo
    oModel := MPFormModel():New("zVid0022M",/*bPre*/, /*bPos*/,/*bCommit*/,/*bCancel*/) 
    oModel:AddFields("FORMTMP",/*cOwner*/,oStTMP)
    oModel:SetPrimaryKey({'TMP_COD'})
    oModel:SetDescription("Modelo de Dados do Cadastro "+cTitulo)
    oModel:GetModel("FORMTMP"):SetDescription("Formulário do Cadastro "+cTitulo)
Return oModel

/*/{Protheus.doc} ViewDef
Visualizacao de dados na funcao zVid0022
@author Atilio
@since 10/03/2022
@version 1.0
/*/

Static Function ViewDef()
    Local oModel := FWLoadModel("zVid0022")
    Local oStTMP := FWFormViewStruct():New()
    Local oView := Nil
 
    //Adicionando campos da estrutura
    oStTmp:AddField(;
        "TMP_COD",;                 // [01]  C   Nome do Campo
        "01",;                      // [02]  C   Ordem
        "Codigo",;                  // [03]  C   Titulo do campo
        "Codigo",;                  // [04]  C   Descricao do campo
        Nil,;                       // [05]  A   Array com Help
        "C",;                       // [06]  C   Tipo do campo
        "@!",;                      // [07]  C   Picture
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
        "TMP_DES",;                 // [01]  C   Nome do Campo
        "02",;                      // [02]  C   Ordem
        "Descricao",;               // [03]  C   Titulo do campo
        "Descricao",;               // [04]  C   Descricao do campo
        Nil,;                       // [05]  A   Array com Help
        "C",;                       // [06]  C   Tipo do campo
        "@!",;                      // [07]  C   Picture
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
    oStTmp:AddField(;
        "TMP_VAL",;                 // [01]  C   Nome do Campo
        "03",;                      // [02]  C   Ordem
        "Valor",;                   // [03]  C   Titulo do campo
        "Valor",;                   // [04]  C   Descricao do campo
        Nil,;                       // [05]  A   Array com Help
        "N",;                       // [06]  C   Tipo do campo
        "@E 9,999,999.99",;         // [07]  C   Picture
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
    oStTmp:AddField(;
        "TMP_DAT",;                 // [01]  C   Nome do Campo
        "04",;                      // [02]  C   Ordem
        "Data",;                    // [03]  C   Titulo do campo
        "Data",;                    // [04]  C   Descricao do campo
        Nil,;                       // [05]  A   Array com Help
        "D",;                       // [06]  C   Tipo do campo
        "@D",;                      // [07]  C   Picture
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
    oView:AddField("VIEW_TMP", oStTMP, "FORMTMP")
    oView:CreateHorizontalBox("TELA",100)
    oView:EnableTitleView('VIEW_TMP', 'Dados - '+cTitulo )  
    oView:SetCloseOnOk({||.T.})
    oView:SetOwnerView("VIEW_TMP","TELA")
Return oView
