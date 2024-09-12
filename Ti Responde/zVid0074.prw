/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2024/08/20/itens-diferentes-em-um-combobox-dependendo-se-e-inclusao-ou-alteracao-ti-responde-0074/ 
    
*/


//Bibliotecas
#Include "Totvs.ch"
#Include "FWMVCDef.ch"

//Variveis Estaticas
Static cTitulo := "Artistas"
Static cAliasMVC := "ZD1"

/*/{Protheus.doc} User Function zVid0074
Cadastro de Artistas
@author Daniel Atilio
@since 21/01/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function zVid0074()
	Local aArea   := GetArea()
	Local oBrowse
	Private aRotina := {}

	//Definicao do menu
	aRotina := MenuDef()

	//Instanciando o browse
	oBrowse := FWMBrowse():New()
	oBrowse:SetAlias(cAliasMVC)
	oBrowse:SetDescription(cTitulo)
	oBrowse:DisableDetails()

	//Ativa a Browse
	oBrowse:Activate()

	RestArea(aArea)
Return Nil

/*/{Protheus.doc} MenuDef
Menu de opcoes na funcao zVid0074
@author Daniel Atilio
@since 21/01/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function MenuDef()
	Local aRotina := {}

	//Adicionando opcoes do menu
	ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.zVid0074" OPERATION 1 ACCESS 0
	ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.zVid0074" OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.zVid0074" OPERATION 4 ACCESS 0

Return aRotina

/*/{Protheus.doc} ModelDef
Modelo de dados na funcao zVid0074
@author Daniel Atilio
@since 21/01/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function ModelDef()
	Local oStruct := FWFormStruct(1, cAliasMVC)
	Local oModel
	Local bPre := Nil
	Local bPos := Nil
	Local bCommit := Nil
	Local bCancel := Nil

	//oStruct:SetProperty('ZD1_DTFORM', MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, 'Date()'))
	oStruct:SetProperty('ZD1_DTFORM', MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, 'dDataBase'))
	//oStruct:SetProperty('ZD1_DTFORM', MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, 'sToD("20221101")'))


	//Cria o modelo de dados para cadastro
	oModel := MPFormModel():New("zVid74M", bPre, bPos, bCommit, bCancel)
	oModel:AddFields("ZD1MASTER", /*cOwner*/, oStruct)
	oModel:SetDescription("Modelo de dados - " + cTitulo)
	oModel:GetModel("ZD1MASTER"):SetDescription( "Dados de - " + cTitulo)
	oModel:SetPrimaryKey({})
Return oModel

/*/{Protheus.doc} ViewDef
Visualizacao de dados na funcao zVid0074
@author Daniel Atilio
@since 21/01/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function ViewDef()
	Local oModel := FWLoadModel("zVid0074")
	Local oStruct := FWFormStruct(2, cAliasMVC)
	Local oView

	//Cria a visualizacao do cadastro
	oView := FWFormView():New()
	oView:SetModel(oModel)
	oView:AddField("VIEW_ZD1", oStruct, "ZD1MASTER")
	oView:CreateHorizontalBox("TELA" , 100 )
	oView:SetOwnerView("VIEW_ZD1", "TELA")

    //Define uma ação logo após abrir a tela
    oView:SetAfterViewActivate({|| fAtuCombo()})

Return oView

/*/{Protheus.doc} fAtuCombo
Função que define as opções do combo na tela
@author Atilio
@since 21/11/2023
@version 1.0
@type function
@obs O X3_CBOX do campo esta como "1=Novo Registro;2=Inclusão Teste;3=Registro Revisado;4=Alteração Teste;5=Sem Classificação;6=Sempre Mostrar;7=Último Teste;"
/*/

Static Function fAtuCombo()
    Local lContinua   := .T.
    Local oModel      := FWModelActive()
    Local nOper       := oModel:GetOperation()
    Local oView       := FWViewActive()
    Local oModelZD1   := oModel:GetModel("ZD1MASTER")
    Local aOpcoes     := {}
 
    //Somente se for inclusão ou alteração
    If nOper == 3 .Or. nOper == 4
    
        //Somente inclusão
        If nOper == 3
            aAdd(aOpcoes, "1=Novo Registro")
            aAdd(aOpcoes, "2=Inclusão Teste")

        //Se for alteração
        ElseIf nOper == 4 .Or. nOper == 1
            aAdd(aOpcoes, "3=Registro Revisado")
            aAdd(aOpcoes, "4=Alteração Teste")
        EndIf

        //Os outros sempre adicionam
        aAdd(aOpcoes, "5=Sem Classificação")
        aAdd(aOpcoes, "6=Sempre Mostrar")
        aAdd(aOpcoes, "7=Último Teste")
        
        //Define  direto no Model
        oModelZD1:GetStruct():SetProperty("ZD1_TIPO", MODEL_FIELD_VALUES, aOpcoes)
    
        //E agora define na View
        oView:SetFieldProperty("ZD1MASTER", "ZD1_TIPO", "COMBOVALUES", { aOpcoes })

        //Atualiza a tela
        oView:Refresh()
    EndIf
Return lContinua
