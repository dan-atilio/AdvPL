/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2023/08/07/f3-customizado-em-mvc-ti-responde-068/ 
    
*/


//Bibliotecas
#Include "Totvs.ch"
#Include "FWMVCDef.ch"

//Variveis Estaticas
Static cTitulo := "Artistas"
Static cAliasMVC := "ZD1"

/*/{Protheus.doc} User Function zVid0068
Cadastro de Artistas
@author Daniel Atilio
@since 10/09/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function zVid0068()
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
Menu de opcoes na funcao zVid0068
@author Daniel Atilio
@since 10/09/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function MenuDef()
	Local aRotina := {}

	//Adicionando opcoes do menu
	ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.zVid0068" OPERATION 1 ACCESS 0
	ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.zVid0068" OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.zVid0068" OPERATION 4 ACCESS 0
	ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.zVid0068" OPERATION 5 ACCESS 0

Return aRotina

/*/{Protheus.doc} ModelDef
Modelo de dados na funcao zVid0068
@author Daniel Atilio
@since 10/09/2022
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


	//Cria o modelo de dados para cadastro
	oModel := MPFormModel():New("zVid68M", bPre, bPos, bCommit, bCancel)
	oModel:AddFields("ZD1MASTER", /*cOwner*/, oStruct)
	oModel:SetDescription("Modelo de dados - " + cTitulo)
	oModel:GetModel("ZD1MASTER"):SetDescription( "Dados de - " + cTitulo)
	oModel:SetPrimaryKey({})
Return oModel

/*/{Protheus.doc} ViewDef
Visualizacao de dados na funcao zVid0068
@author Daniel Atilio
@since 10/09/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function ViewDef()
	Local oModel := FWLoadModel("zVid0068")
	Local oStruct := FWFormStruct(2, cAliasMVC)
	Local oView

    //Define a consulta padrão do campo de observação
    oStruct:SetProperty("ZD1_OBSERV", MVC_VIEW_LOOKUP, {|| fObsF3()})

	//Cria a visualizacao do cadastro
	oView := FWFormView():New()
	oView:SetModel(oModel)
	oView:AddField("VIEW_ZD1", oStruct, "ZD1MASTER")
	oView:CreateHorizontalBox("TELA" , 100 )
	oView:SetOwnerView("VIEW_ZD1", "TELA")

Return oView

Static Function fObsF3()
    Local oModel    := FwModelActive()
    Local oModZD1   := oModel:GetModel("ZD1MASTER")
    Local cNome     := Upper(oModZD1:GetValue("ZD1_NOME"))
    Local cConsulta := ""

    //Se a primeira letra do nome do artista for C, irá usar a consulta de Clientes
    If Left(cNome, 1) == "C"
        cConsulta := "SA1"

    //Senão se a primeira letra do nome do artista for F, irá usar a consulta de Fornecedores
    ElseIf Left(cNome, 1) == "F"
        cConsulta := "SA2"

    //Senão por default usará a de Produtos
    Else
        cConsulta := "SB1"
    EndIf

Return cConsulta
