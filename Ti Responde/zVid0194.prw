/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/10/14/campo-memo-um-do-lado-do-outro-em-mvc-ti-responde-0194/ 
    
*/


//Bibliotecas
#Include "Totvs.ch"
#Include "FWMVCDef.ch"
#Include "FWEditPanel.ch"

//Variveis Estaticas
Static cTitulo := "Artistas"
Static cAliasMVC := "ZA1"

/*/{Protheus.doc} User Function zVid0194
Cadastro de Artistas
@author Daniel Atilio
@since 21/01/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
    Criar 2 campos MEMO na tabela: ZA1_OBS01 e ZA1_OBS02
@see http://autumncodemaker.com
/*/

User Function zVid0194()
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
Menu de opcoes na funcao zVid0194
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
	ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.zVid0194" OPERATION 1 ACCESS 0
	ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.zVid0194" OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.zVid0194" OPERATION 4 ACCESS 0

Return aRotina

/*/{Protheus.doc} ModelDef
Modelo de dados na funcao zVid0194
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

	//Cria o modelo de dados para cadastro
	oModel := MPFormModel():New("zVid74M", bPre, bPos, bCommit, bCancel)
	oModel:AddFields("ZA1MASTER", /*cOwner*/, oStruct)
	oModel:SetDescription("Modelo de dados - " + cTitulo)
	oModel:GetModel("ZA1MASTER"):SetDescription( "Dados de - " + cTitulo)
	oModel:SetPrimaryKey({})
Return oModel

/*/{Protheus.doc} ViewDef
Visualizacao de dados na funcao zVid0194
@author Daniel Atilio
@since 21/01/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function ViewDef()
	Local oModel    := FWLoadModel("zVid0194")
	Local oStruct   := FWFormStruct(2, cAliasMVC, { |x| ! 'ZA1_OBS' $ Alltrim(x) })
	Local oStructM1 := FWFormStruct(2, cAliasMVC, { |x| 'ZA1_OBS01' == Alltrim(x) })
	Local oStructM2 := FWFormStruct(2, cAliasMVC, { |x| 'ZA1_OBS02' == Alltrim(x) })
	Local oView

	//Cria a visualizacao do cadastro
	oView := FWFormView():New()
	oView:SetModel(oModel)
	oView:AddField("VIEW_ZA1", oStruct,   "ZA1MASTER")
	oView:AddField("OBS1_ZA1", oStructM1, "ZA1MASTER")
	oView:AddField("OBS2_ZA1", oStructM2, "ZA1MASTER")
	oView:CreateHorizontalBox("TELACABEC" , 40 )
	oView:CreateHorizontalBox("TELARESTO" , 60 )
		oView:CreateVerticalBox("RESTO_ESQUERDA", 50 , "TELARESTO")
        oView:CreateVerticalBox("RESTO_DIREITA",  50 , "TELARESTO")
	oView:SetOwnerView("VIEW_ZA1", "TELACABEC")
	oView:SetOwnerView("OBS1_ZA1", "RESTO_ESQUERDA")
	oView:SetOwnerView("OBS2_ZA1", "RESTO_DIREITA")

	//Altera o numero de colunas de 5 para 1
	oView:aViews[2][3]:nColumns := 1 //OBS1_ZA1
	oView:aViews[3][3]:nColumns := 1 //OBS2_ZA1

Return oView
