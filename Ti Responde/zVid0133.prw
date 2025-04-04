/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/03/13/como-fazer-uma-modelo-2-em-mvc-com-abas-ti-responde-0133/ 
    
*/


//Bibliotecas
#Include "Totvs.ch"
#Include "FWMVCDef.ch"

//Variveis Estaticas
Static cTitulo    := "Grupos de Produtos"
Static cCamposChv := "BM_PICPAD ;BM_PROORI ;BM_STATUS ;BM_GRUREL ;BM_MARGPRE;BM_LENREL ;BM_CLASGRU;BM_FORMUL ;"
Static cTabPai    := "SBM"

/*/{Protheus.doc} User Function zVid0133
Cadastro de Grupos de Produtos
@author Atilio
@since 20/02/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function zVid0133()
	Local aArea   := FWGetArea()
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

	FWRestArea(aArea)
Return Nil

/*/{Protheus.doc} MenuDef
Menu de opcoes na funcao zVid0133
@author Atilio
@since 20/02/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function MenuDef()
	Local aRotina := {}

	//Adicionando opcoes do menu
	ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.zVid0133" OPERATION 1 ACCESS 0
	ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.zVid0133" OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.zVid0133" OPERATION 4 ACCESS 0

Return aRotina

/*/{Protheus.doc} ModelDef
Modelo de dados na funcao zVid0133
@author Atilio
@since 20/02/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function ModelDef()
	Local oStruPai   := FWFormStruct(1, cTabPai, {|cCampo| Alltrim(cCampo) $ cCamposChv})
	Local oStruFilho := FWFormStruct(1, cTabPai)
	Local aRelation := {}
	Local oModel
	Local bPre := Nil
	Local bPos := Nil
	Local bCancel := Nil


	//Cria o modelo de dados para cadastro
	oModel := MPFormModel():New("zVid133M", bPre, bPos, /*bCommit*/, bCancel)
	oModel:AddFields("SBMMASTER", /*cOwner*/, oStruPai)
	oModel:AddGrid("SBMDETAIL","SBMMASTER",oStruFilho,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)
	oModel:SetDescription("Modelo de dados - " + cTitulo)
	oModel:GetModel("SBMMASTER"):SetDescription( "Dados de - " + cTitulo)
	oModel:GetModel("SBMDETAIL"):SetDescription( "Grid de - " + cTitulo)
	oModel:SetPrimaryKey({})

	//Fazendo o relacionamento
	aAdd(aRelation, {"BM_FILIAL", "FWxFilial('SBM')"} )
	aAdd(aRelation, {"BM_PICPAD", "BM_PICPAD"})
	aAdd(aRelation, {"BM_PROORI", "BM_PROORI"})
	aAdd(aRelation, {"BM_STATUS", "BM_STATUS"})
	aAdd(aRelation, {"BM_GRUREL", "BM_GRUREL"})
	aAdd(aRelation, {"BM_MARGPRE", "BM_MARGPRE"})
	aAdd(aRelation, {"BM_LENREL", "BM_LENREL"})
	aAdd(aRelation, {"BM_CLASGRU", "BM_CLASGRU"})
	aAdd(aRelation, {"BM_FORMUL", "BM_FORMUL"})
	oModel:SetRelation("SBMDETAIL", aRelation, SBM->(IndexKey(1)))
	
	//Definindo campos unicos da linha
	oModel:GetModel("SBMDETAIL"):SetUniqueLine({'BM_GRUPO'})

Return oModel

/*/{Protheus.doc} ViewDef
Visualizacao de dados na funcao zVid0133
@author Atilio
@since 20/02/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function ViewDef()
	Local oModel     := FWLoadModel("zVid0133")
	Local oStruAba1  := FWFormStruct(2, cTabPai, {|cCampo| Alltrim(cCampo) $ "BM_PROORI ;BM_STATUS ;BM_CLASGRU;"})
    Local oStruAba2  := FWFormStruct(2, cTabPai, {|cCampo| Alltrim(cCampo) $ "BM_PICPAD ;BM_MARGPRE;BM_FORMUL ;"})
    Local oStruAba3  := FWFormStruct(2, cTabPai, {|cCampo| Alltrim(cCampo) $ "BM_GRUREL ;BM_LENREL ;"})
	Local oStruFilho := FWFormStruct(2, cTabPai, {|cCampo| ! Alltrim(cCampo) $ cCamposChv})
	Local oView

    //Caso tenha abas no padrão, tira
    oStruAba1:SetNoFolder()
    oStruAba2:SetNoFolder()
    oStruAba3:SetNoFolder()

	//Cria a visualizacao do cadastro
	oView := FWFormView():New()
	oView:SetModel(oModel)
	oView:AddField("VIEW_SBM1", oStruAba1, "SBMMASTER")
    oView:AddField("VIEW_SBM2", oStruAba2, "SBMMASTER")
    oView:AddField("VIEW_SBM3", oStruAba3, "SBMMASTER")
	oView:AddGrid("GRID_SBM",  oStruFilho,  "SBMDETAIL")

    //Partes da tela
	oView:CreateHorizontalBox("CABEC", 40)
	oView:CreateHorizontalBox("GRID", 60)

    //Cria o controle de Abas
    oView:CreateFolder('ABAS', 'CABEC')
    oView:AddSheet('ABAS', 'ABA_CAD', 'Cadastro')
    oView:AddSheet('ABAS', 'ABA_INF', 'Informações')
    oView:AddSheet('ABAS', 'ABA_OUT', 'Outros Campos')

    //Cria os Box que serão vinculados as abas
    oView:CreateHorizontalBox('BOX_CAD' ,100, /*owner*/, /*lUsePixel*/, 'ABAS', 'ABA_CAD')
    oView:CreateHorizontalBox('BOX_INF' ,100, /*owner*/, /*lUsePixel*/, 'ABAS', 'ABA_INF')
    oView:CreateHorizontalBox('BOX_OUT' ,100, /*owner*/, /*lUsePixel*/, 'ABAS', 'ABA_OUT')

    //Amarra as structs com as views
    oView:SetOwnerView('VIEW_SBM1', 'BOX_CAD')
    oView:SetOwnerView('VIEW_SBM2', 'BOX_INF')
    oView:SetOwnerView('VIEW_SBM3', 'BOX_OUT')
    oView:SetOwnerView("GRID_SBM", "GRID")

Return oView
