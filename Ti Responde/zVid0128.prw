/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/02/25/tela-modelo-3-mvc-com-tabelas-temporarias-ti-responde-0128/ 
    
*/


//Bibliotecas
#Include "Totvs.ch"
#Include "FWMVCDef.ch"
  
//Variveis Estaticas
Static cTitulo := ""
  
/*/{Protheus.doc} User Function zVid0128
Cadastro de temporária modelo 3 (com duas tabelas)
@author Atilio
@since 15/03/2024
@version 1.0
@obs Baseado no exemplo - https://terminaldeinformacao.com/2022/09/19/temporaria-em-mvc-com-fwtemporarytable-ti-responde-022/
/*/
  
User Function zVid0128()
    Local aArea   := FWGetArea()
    Local oBrowse
    Local aCampos1 := {}
    Local aCampos2 := {}
    Local aColunas := {}
    Local aPesquisa := {}
    Private aRotina := {}
    Private oTmpTable1
    Private cAliasTmp1 := GetNextAlias()
    Private oTmpTable2
    Private cAliasTmp2 := GetNextAlias()
  
    //Definicao do menu
    aRotina := MenuDef()
    
    cTitulo := "Temporárias Mod3 - "
  
    //Campos da temporária pai
    aAdd(aCampos1, {"TMPAI_COD", "C", 06, 0})
    aAdd(aCampos1, {"TMPAI_DES", "C", 50, 0})
    aAdd(aCampos1, {"TMPAI_VAL", "N", 10, 0})
    aAdd(aCampos1, {"TMPAI_DAT", "D", 08, 0})

    //Campos da temporária filho
    aAdd(aCampos2, {"TMFIL_COD",  "C", 006, 0})
    aAdd(aCampos2, {"TMFIL_ITEM", "C", 002, 0})
    aAdd(aCampos2, {"TMFIL_DESC", "C", 100, 0})
  
    //Cria a temporária pai
    oTmpTable1 := FWTemporaryTable():New(cAliasTmp1)
    oTmpTable1:SetFields(aCampos1)
    oTmpTable1:AddIndex("1", {"TMPAI_COD"} )
    oTmpTable1:Create()
    cTitulo += "Pai - " + oTmpTable1:GetRealName()

    //Cria a temporária filho
    oTmpTable2 := FWTemporaryTable():New(cAliasTmp2)
    oTmpTable2:SetFields(aCampos2)
    oTmpTable2:AddIndex("1", {"TMFIL_COD", "TMFIL_ITEM"} )
    oTmpTable2:Create()
    cTitulo += "; Filho - " + oTmpTable2:GetRealName()
  
    //Definindo as colunas que serão usadas no browse
    aAdd(aColunas, {"Codigo",    "TMPAI_COD", "C", 06, 0, "@!"})
    aAdd(aColunas, {"Descricao", "TMPAI_DES", "C", 50, 0, "@!"})
    aAdd(aColunas, {"Valor",     "TMPAI_VAL", "N", 10, 0, "@E 9,999,999.99"})
    aAdd(aColunas, {"Data",      "TMPAI_DAT", "D", 08, 0, "@D"})
  
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
    aAdd(aPesquisa, {"Codigo", {{"", "C", 6, 0, "Codigo", "@!", "TMPAI_COD"}} } )
  
    //Criando o browse da temporária
    oBrowse := FWMBrowse():New()
    oBrowse:SetAlias(cAliasTmp1)
    oBrowse:SetTemporary(.T.)
    oBrowse:SetFields(aColunas)
    oBrowse:DisableDetails()
    oBrowse:SetDescription(cTitulo)
    oBrowse:SetSeek(.T., aPesquisa)
    oBrowse:Activate()
  
    oTmpTable1:Delete()
    FWRestArea(aArea)
Return Nil
  
/*/{Protheus.doc} MenuDef
Menu de opcoes na funcao zVid0128
@author Atilio
@since 15/03/2024
@version 1.0
/*/
  
Static Function MenuDef()
    Local aRotina := {}
  
    //Adicionando opcoes do menu
    ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.zVid0128" OPERATION 1 ACCESS 0
    ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.zVid0128" OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.zVid0128" OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.zVid0128" OPERATION 5 ACCESS 0
    ADD OPTION aRotina TITLE "Copiar" ACTION "VIEWDEF.zVid0128" OPERATION 9 ACCESS 0
  
Return aRotina
  
/*/{Protheus.doc} ModelDef
Modelo de dados na funcao zVid0128
@author Atilio
@since 15/03/2024
@version 1.0
/*/
  
Static Function ModelDef()
    Local oModel := Nil
    Local oStTMPPai := FWFormModelStruct():New()
    Local oStTMPFil := FWFormModelStruct():New()
    Local aRelation := {}
	Local bPre := Nil
	Local bPos := Nil
	Local bCancel := Nil
       
    //Na estrutura, define os campos e a temporária
    oStTMPPai:AddTable(cAliasTmp1, {'TMPAI_COD', 'TMPAI_DES', 'TMPAI_VAL', 'TMPAI_DAT'}, "Temporaria Pai")
    oStTMPFil:AddTable(cAliasTmp2, {'TMFIL_COD', 'TMFIL_ITEM', 'TMFIL_DESC'}, "Temporaria Filho")
       
    //Adiciona os campos da estrutura
    oStTMPPai:AddField(;
        "Codigo",;                                                                                  // [01]  C   Titulo do campo
        "Codigo",;                                                                                  // [02]  C   ToolTip do campo
        "TMPAI_COD",;                                                                               // [03]  C   Id do Field
        "C",;                                                                                       // [04]  C   Tipo do campo
        06,;                                                                                        // [05]  N   Tamanho do campo
        0,;                                                                                         // [06]  N   Decimal do campo
        Nil,;                                                                                       // [07]  B   Code-block de validação do campo
        Nil,;                                                                                       // [08]  B   Code-block de validação When do campo
        {},;                                                                                        // [09]  A   Lista de valores permitido do campo
        .T.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
        FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,"+cAliasTmp1+"->TMPAI_COD,'')" ),;      // [11]  B   Code-block de inicializacao do campo
        .T.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
        .F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
        .F.)                                                                                        // [14]  L   Indica se o campo é virtual
    oStTMPPai:AddField(;
        "Descricao",;                                                                               // [01]  C   Titulo do campo
        "Descricao",;                                                                               // [02]  C   ToolTip do campo
        "TMPAI_DES",;                                                                               // [03]  C   Id do Field
        "C",;                                                                                       // [04]  C   Tipo do campo
        50,;                                                                                        // [05]  N   Tamanho do campo
        0,;                                                                                         // [06]  N   Decimal do campo
        Nil,;                                                                                       // [07]  B   Code-block de validação do campo
        Nil,;                                                                                       // [08]  B   Code-block de validação When do campo
        {},;                                                                                        // [09]  A   Lista de valores permitido do campo
        .T.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
        FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,"+cAliasTmp1+"->TMPAI_DES,'')" ),;      // [11]  B   Code-block de inicializacao do campo
        .F.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
        .F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
        .F.)                                                                                        // [14]  L   Indica se o campo é virtual
    oStTMPPai:AddField(;
        "Valor",;                                                                                   // [01]  C   Titulo do campo
        "Valor",;                                                                                   // [02]  C   ToolTip do campo
        "TMPAI_VAL",;                                                                               // [03]  C   Id do Field
        "N",;                                                                                       // [04]  C   Tipo do campo
        10,;                                                                                        // [05]  N   Tamanho do campo
        02,;                                                                                        // [06]  N   Decimal do campo
        Nil,;                                                                                       // [07]  B   Code-block de validação do campo
        Nil,;                                                                                       // [08]  B   Code-block de validação When do campo
        {},;                                                                                        // [09]  A   Lista de valores permitido do campo
        .F.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
        FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,"+cAliasTmp1+"->TMPAI_VAL,'')" ),;      // [11]  B   Code-block de inicializacao do campo
        .F.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
        .F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
        .F.)                                                                                        // [14]  L   Indica se o campo é virtual
    oStTMPPai:AddField(;
        "Data",;                                                                                    // [01]  C   Titulo do campo
        "Data",;                                                                                    // [02]  C   ToolTip do campo
        "TMPAI_DAT",;                                                                               // [03]  C   Id do Field
        "D",;                                                                                       // [04]  C   Tipo do campo
        08,;                                                                                        // [05]  N   Tamanho do campo
        0,;                                                                                         // [06]  N   Decimal do campo
        Nil,;                                                                                       // [07]  B   Code-block de validação do campo
        Nil,;                                                                                       // [08]  B   Code-block de validação When do campo
        {},;                                                                                        // [09]  A   Lista de valores permitido do campo
        .F.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
        FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,"+cAliasTmp1+"->TMPAI_DAT,'')" ),;      // [11]  B   Code-block de inicializacao do campo
        .F.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
        .F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
        .F.)                                                                                        // [14]  L   Indica se o campo é virtual
       
    // --

    oStTMPFil:AddField(;
        "Codigo",;                                                                                  // [01]  C   Titulo do campo
        "Codigo",;                                                                                  // [02]  C   ToolTip do campo
        "TMFIL_COD",;                                                                               // [03]  C   Id do Field
        "C",;                                                                                       // [04]  C   Tipo do campo
        06,;                                                                                        // [05]  N   Tamanho do campo
        0,;                                                                                         // [06]  N   Decimal do campo
        Nil,;                                                                                       // [07]  B   Code-block de validação do campo
        Nil,;                                                                                       // [08]  B   Code-block de validação When do campo
        {},;                                                                                        // [09]  A   Lista de valores permitido do campo
        .F.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
        FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,"+cAliasTmp2+"->TMFIL_COD,'')" ),;      // [11]  B   Code-block de inicializacao do campo
        .T.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
        .F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
        .F.)                                                                                        // [14]  L   Indica se o campo é virtual
    oStTMPFil:AddField(;
        "Item",;                                                                                    // [01]  C   Titulo do campo
        "Item",;                                                                                    // [02]  C   ToolTip do campo
        "TMFIL_ITEM",;                                                                              // [03]  C   Id do Field
        "C",;                                                                                       // [04]  C   Tipo do campo
        2,;                                                                                         // [05]  N   Tamanho do campo
        0,;                                                                                         // [06]  N   Decimal do campo
        Nil,;                                                                                       // [07]  B   Code-block de validação do campo
        Nil,;                                                                                       // [08]  B   Code-block de validação When do campo
        {},;                                                                                        // [09]  A   Lista de valores permitido do campo
        .T.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
        FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,"+cAliasTmp2+"->TMFIL_ITEM,'')" ),;     // [11]  B   Code-block de inicializacao do campo
        .F.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
        .F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
        .F.)                                                                                        // [14]  L   Indica se o campo é virtual
    oStTMPFil:AddField(;
        "Descricao",;                                                                               // [01]  C   Titulo do campo
        "Descricao",;                                                                               // [02]  C   ToolTip do campo
        "TMFIL_DESC",;                                                                              // [03]  C   Id do Field
        "C",;                                                                                       // [04]  C   Tipo do campo
        100,;                                                                                       // [05]  N   Tamanho do campo
        0,;                                                                                         // [06]  N   Decimal do campo
        Nil,;                                                                                       // [07]  B   Code-block de validação do campo
        Nil,;                                                                                       // [08]  B   Code-block de validação When do campo
        {},;                                                                                        // [09]  A   Lista de valores permitido do campo
        .T.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
        FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,"+cAliasTmp2+"->TMFIL_DESC,'')" ),;     // [11]  B   Code-block de inicializacao do campo
        .F.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
        .F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
        .F.)                                                                                        // [14]  L   Indica se o campo é virtual


    //Cria o modelo de dados para cadastro
	oModel := MPFormModel():New("zVid128M", bPre, bPos, /*bCommit*/, bCancel)
	oModel:AddFields("PAIMASTER", /*cOwner*/, oStTMPPai)
	oModel:AddGrid("FILDETAIL","PAIMASTER",oStTMPFil,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/, {|oGridFilho| fLoadGrid(oGridFilho)})
	oModel:SetDescription("Modelo de dados - " + cTitulo)
	oModel:GetModel("PAIMASTER"):SetDescription( "Dados de - " + cTitulo)
	oModel:GetModel("FILDETAIL"):SetDescription( "Grid de - " + cTitulo)
	oModel:SetPrimaryKey({})

	//Fazendo o relacionamento
	aAdd(aRelation, {"FIL_FILIAL", "FWxFilial('FIL')"} )
	aAdd(aRelation, {"TMFIL_COD", "TMPAI_COD"})
	oModel:SetRelation("FILDETAIL", aRelation, FIL->(IndexKey(1)))
	
	//Definindo campos unicos da linha
	oModel:GetModel("FILDETAIL"):SetUniqueLine({'TMFIL_DESC'})
Return oModel
  
/*/{Protheus.doc} ViewDef
Visualizacao de dados na funcao zVid0128
@author Atilio
@since 15/03/2024
@version 1.0
/*/
  
Static Function ViewDef()
    Local oModel := FWLoadModel("zVid0128")
    Local oStTMPPai := FWFormViewStruct():New()
    Local oStTMPFil := FWFormViewStruct():New()
    Local oView := Nil
   
    //Adicionando campos da estrutura
    oStTMPPai:AddField(;
        "TMPAI_COD",;               // [01]  C   Nome do Campo
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
    oStTMPPai:AddField(;
        "TMPAI_DES",;               // [01]  C   Nome do Campo
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
    oStTMPPai:AddField(;
        "TMPAI_VAL",;               // [01]  C   Nome do Campo
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
    oStTMPPai:AddField(;
        "TMPAI_DAT",;               // [01]  C   Nome do Campo
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

    // -

    oStTMPFil:AddField(;
        "TMFIL_COD",;               // [01]  C   Nome do Campo
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
    oStTMPFil:AddField(;
        "TMFIL_ITEM",;              // [01]  C   Nome do Campo
        "02",;                      // [02]  C   Ordem
        "Item",;                    // [03]  C   Titulo do campo
        "Item",;                    // [04]  C   Descricao do campo
        Nil,;                       // [05]  A   Array com Help
        "C",;                       // [06]  C   Tipo do campo
        "@!",;                      // [07]  C   Picture
        Nil,;                       // [08]  B   Bloco de PictTre Var
        Nil,;                       // [09]  C   Consulta F3
        .F.,;                       // [10]  L   Indica se o campo é alteravel
        Nil,;                       // [11]  C   Pasta do campo
        Nil,;                       // [12]  C   Agrupamento do campo
        Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
        Nil,;                       // [14]  N   Tamanho maximo da maior opção do combo
        Nil,;                       // [15]  C   Inicializador de Browse
        Nil,;                       // [16]  L   Indica se o campo é virtual
        Nil,;                       // [17]  C   Picture Variavel
        Nil)                        // [18]  L   Indica pulo de linha após o campo
    oStTMPFil:AddField(;
        "TMFIL_DESC",;              // [01]  C   Nome do Campo
        "03",;                      // [02]  C   Ordem
        "Descrição",;               // [03]  C   Titulo do campo
        "Descrição",;               // [04]  C   Descricao do campo
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
       
    //Cria a visualizacao do cadastro
	oView := FWFormView():New()
	oView:SetModel(oModel)
	oView:AddField("VIEW_PAI", oStTMPPai, "PAIMASTER")
	oView:AddGrid("VIEW_FIL",  oStTMPFil, "FILDETAIL")

	//Partes da tela
	oView:CreateHorizontalBox("CABEC", 30)
	oView:CreateHorizontalBox("GRID", 70)
	oView:SetOwnerView("VIEW_PAI", "CABEC")
	oView:SetOwnerView("VIEW_FIL", "GRID")

	//Titulos
	oView:EnableTitleView("VIEW_PAI", "Cabecalho - PAI")
	oView:EnableTitleView("VIEW_FIL", "Grid - FILHO")

	//Removendo campos
	oStTMPFil:RemoveField("TMFIL_COD")

	//Adicionando campo incremental na grid
	oView:AddIncrementField("VIEW_FIL", "TMFIL_ITEM")
Return oView

Static Function fLoadGrid(oGridFilho)
    Local aArea		:= FWGetArea()
    Local aRetorno  := {}
    Local cCampos	:= '%R_E_C_N_O_, TMFIL_COD, TMFIL_ITEM, TMFIL_DESC%'
    Local cTmpQry   := GetNextAlias()
    Local cTabela   := '%' + oTmpTable2:GetRealName() + '%'
    Local cCodPai   := (cAliasTmp1)->TMPAI_COD

    //Executa a query SQL, filtrando o código do pai na tabela de filhos
    BeginSQL Alias cTmpQry
        SELECT %Exp:cCampos%
        FROM %Exp:cTabela%
        WHERE 
            TMFIL_COD = %Exp:cCodPai%
            AND %NotDel%
        ORDER BY TMFIL_ITEM
    EndSQL

    //Executa a função FWLoadByAlias populando a grid e fecha a query
    aRetorno := FWLoadByAlias(oGridFilho, cTmpQry)
    (cTmpQry)->(DBCloseArea())

    FWRestArea(aArea)
Return aRetorno
