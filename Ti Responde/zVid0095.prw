/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2024/10/31/como-deixar-uma-grid-opcional-em-mvc-ti-responde-0095/ 
    
*/


//Bibliotecas
#Include "Totvs.ch"
#Include "FWMVCDef.ch"

//Variveis Estaticas
Static cTitulo := "Cadastro de CDs"
Static cTabPai := "ZD2"
Static cTabFilho := "ZD3"

/*/{Protheus.doc} User Function zVid0095
CDs
@author Daniel Atilio
@since 21/01/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function zVid0095()
	Local aArea   := GetArea()
	Local oBrowse
	Private aRotina := {}

	//Definicao do menu
	aRotina := MenuDef()

	//Instanciando o browse
	oBrowse := FWMBrowse():New()
	oBrowse:SetAlias(cTabPai)
	oBrowse:SetDescription(cTitulo)
	oBrowse:DisableDetails()

	//Ativa a Browse
	oBrowse:Activate()

	RestArea(aArea)
Return Nil

/*/{Protheus.doc} MenuDef
Menu de opcoes na funcao zVid0095
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
	ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.zVid0095" OPERATION 1 ACCESS 0
	ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.zVid0095" OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.zVid0095" OPERATION 4 ACCESS 0
	ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.zVid0095" OPERATION 5 ACCESS 0

Return aRotina

User Function z02Menu()
Return MenuDef()

/*/{Protheus.doc} ModelDef
Modelo de dados na funcao zVid0095
@author Daniel Atilio
@since 21/01/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function ModelDef()
	Local oStruPai := FWFormStruct(1, cTabPai)
	Local oStruFilho := FWFormStruct(1, cTabFilho)
	Local aRelation := {}
	Local oModel
	Local bPre := Nil
	Local bPos := Nil
	Local bCommit := Nil
	Local bCancel := Nil


	//Cria o modelo de dados para cadastro
	oModel := MPFormModel():New("zVid95M", bPre, bPos, bCommit, bCancel)
	oModel:AddFields("ZD2MASTER", /*cOwner*/, oStruPai)
	oModel:AddGrid("ZD3DETAIL","ZD2MASTER",oStruFilho,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)
	oModel:SetDescription("Modelo de dados - " + cTitulo)
	oModel:GetModel("ZD2MASTER"):SetDescription( "Dados de - " + cTitulo)
	oModel:GetModel("ZD3DETAIL"):SetDescription( "Grid de - " + cTitulo)
	oModel:SetPrimaryKey({})

	//Fazendo o relacionamento
	aAdd(aRelation, {"ZD3_FILIAL", "FWxFilial('ZD3')"} )
	aAdd(aRelation, {"ZD3_CD", "ZD2_CD"})
	oModel:SetRelation("ZD3DETAIL", aRelation, ZD3->(IndexKey(1)))
	
	//Definindo campos unicos da linha
	oModel:GetModel("ZD3DETAIL"):SetUniqueLine({'ZD3_MUSICA'})

    //Deixando a grid como opcional
    oModel:GetModel("ZD3DETAIL"):SetOptional(.T.)

Return oModel

/*/{Protheus.doc} ViewDef
Visualizacao de dados na funcao zVid0095
@author Daniel Atilio
@since 21/01/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function ViewDef()
	Local oModel := FWLoadModel("zVid0095")
	Local oStruPai := FWFormStruct(2, cTabPai)
	Local oStruFilho := FWFormStruct(2, cTabFilho)
	Local oView

	//Cria a visualizacao do cadastro
	oView := FWFormView():New()
	oView:SetModel(oModel)
	oView:AddField("VIEW_ZD2", oStruPai, "ZD2MASTER")
	oView:AddGrid("VIEW_ZD3",  oStruFilho,  "ZD3DETAIL")

	//Partes da tela
	oView:CreateHorizontalBox("CABEC", 30)
	oView:CreateHorizontalBox("GRID", 70)
	oView:SetOwnerView("VIEW_ZD2", "CABEC")
	oView:SetOwnerView("VIEW_ZD3", "GRID")

	//Titulos
	oView:EnableTitleView("VIEW_ZD2", "Cabecalho - ZD2 (CDs)")
	oView:EnableTitleView("VIEW_ZD3", "Grid - ZD3 (Musicas dos CDs)")

	//Removendo campos
	oStruFilho:RemoveField("ZD3_CD")

	//Adicionando campo incremental na grid
	oView:AddIncrementField("VIEW_ZD3", "ZD3_ITEM")

Return oView
