/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2023/05/29/procurando-linhas-em-mvc-com-seekline-ti-responde-058/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "FWMVCDef.ch"

//Variveis Estaticas
Static cTitulo := "Artistas x CDs x Músicas (com Cálculos)"
Static cTabPai := "ZD1"
Static cTabFilho := "ZD2"
Static cTabNeto := "ZD3"

/*/{Protheus.doc} User Function zVid0058
Exemplo de Modelo X
@author Daniel Atilio
@since 04/02/2022
@version 1.0
@type function
/*/

User Function zVid0058()
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
Menu de opcoes na funcao zVid0058
@author Daniel Atilio
@since 04/02/2022
@version 1.0
@type function
/*/

Static Function MenuDef()
	Local aRotina := {}

	//Adicionando opcoes do menu
	ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.zVid0058" OPERATION 1 ACCESS 0
	ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.zVid0058" OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.zVid0058" OPERATION 4 ACCESS 0
	ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.zVid0058" OPERATION 5 ACCESS 0

Return aRotina

/*/{Protheus.doc} ModelDef
Modelo de dados na funcao zVid0058
@author Daniel Atilio
@since 04/02/2022
@version 1.0
@type function
/*/

Static Function ModelDef()
	Local oStruPai := FWFormStruct(1, cTabPai)
	Local oStruFilho := FWFormStruct(1, cTabFilho, { |x| ! Alltrim(x) $ 'ZD2_NOME' })
    Local oStruNeto := FWFormStruct(1, cTabNeto)
	Local aRelFilho := {}
    Local aRelNeto := {}
	Local oModel
	Local bPre := Nil
	Local bPos := Nil
	Local bCommit := Nil
	Local bCancel := Nil


	//Cria o modelo de dados para cadastro
	oModel := MPFormModel():New("zVid58M", bPre, bPos, bCommit, bCancel)
	oModel:AddFields("ZD1MASTER", /*cOwner*/, oStruPai)
	oModel:AddGrid("ZD2DETAIL","ZD1MASTER",oStruFilho,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)
    oModel:AddGrid("ZD3DETAIL","ZD2DETAIL",oStruNeto,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)
	oModel:SetPrimaryKey({})

    //Fazendo o relacionamento (pai e filho)
    oStruFilho:SetProperty("ZD2_ARTIST", MODEL_FIELD_OBRIGAT, .F.)
	aAdd(aRelFilho, {"ZD2_FILIAL", "FWxFilial('ZD2')"} )
	aAdd(aRelFilho, {"ZD2_ARTIST", "ZD1_CODIGO"})
	oModel:SetRelation("ZD2DETAIL", aRelFilho, ZD2->(IndexKey(1)))

	//Fazendo o relacionamento (filho e neto)
	aAdd(aRelNeto, {"ZD3_FILIAL", "FWxFilial('ZD3')"} )
	aAdd(aRelNeto, {"ZD3_CD", "ZD2_CD"})
	oModel:SetRelation("ZD3DETAIL", aRelNeto, ZD3->(IndexKey(1)))

	//Definindo campos unicos da linha
    oModel:GetModel("ZD2DETAIL"):SetUniqueLine({'ZD2_CD'})
	oModel:GetModel("ZD3DETAIL"):SetUniqueLine({'ZD3_MUSICA'})

    //Adicionando totalizadores de campos
    oModel:AddCalc('TOTAIS', 'ZD1MASTER', 'ZD2DETAIL', 'ZD2_CD',     'XX_TOTCDS', 'COUNT', , , "Total de CDs:" )
    oModel:AddCalc('TOTAIS', 'ZD2DETAIL', 'ZD3DETAIL', 'ZD3_MUSICA', 'XX_TOTMUS', 'COUNT', , , "Total de Musicas:" )

Return oModel

/*/{Protheus.doc} ViewDef
Visualizacao de dados na funcao zVid0058
@author Daniel Atilio
@since 04/02/2022
@version 1.0
@type function
/*/

Static Function ViewDef()
	Local oModel     := FWLoadModel("zVid0058")
	Local oStruPai   := FWFormStruct(2, cTabPai)
	Local oStruFilho := FWFormStruct(2, cTabFilho, { |x| ! Alltrim(x) $ 'ZD2_NOME' })
    Local oStruNeto  := FWFormStruct(2, cTabNeto)
    Local oStruTot   := FWCalcStruct(oModel:GetModel('TOTAIS'))
	Local oView

	//Cria a visualizacao do cadastro
	oView := FWFormView():New()
	oView:SetModel(oModel)
	oView:AddField("VIEW_ZD1", oStruPai,   "ZD1MASTER")
	oView:AddGrid("VIEW_ZD2",  oStruFilho, "ZD2DETAIL")
    oView:AddGrid("VIEW_ZD3",  oStruNeto,  "ZD3DETAIL")
    oView:AddField("VIEW_TOT", oStruTot,   "TOTAIS")

	//Partes da tela
	oView:CreateHorizontalBox("CABEC_PAI", 25)
	oView:CreateHorizontalBox("GRID_FILHO", 30)
    oView:CreateHorizontalBox("GRID_NETO", 30)
    oView:CreateHorizontalBox("ENCH_TOT", 15)
	oView:SetOwnerView("VIEW_ZD1", "CABEC_PAI")
	oView:SetOwnerView("VIEW_ZD2", "GRID_FILHO")
    oView:SetOwnerView("VIEW_ZD3", "GRID_NETO")
    oView:SetOwnerView("VIEW_TOT", "ENCH_TOT")

	//Titulos
    oView:EnableTitleView("VIEW_ZD1", "Pai - ZD1 (Artistas)")
	oView:EnableTitleView("VIEW_ZD2", "Filho - ZD2 (CDs)")
	oView:EnableTitleView("VIEW_ZD3", "Neto - ZD3 (Musicas dos CDs)")

	//Removendo campos
    oStruFilho:RemoveField("ZD2_ARTIST")
    oStruFilho:RemoveField("ZD2_NOME")
	oStruNeto:RemoveField("ZD3_CD")

	//Adicionando campo incremental na grid
	oView:AddIncrementField("VIEW_ZD3", "ZD3_ITEM")

    //Adiciona botões no outras ações para demonstrar em como pegar os dados dos totaolizadores
	oView:addUserButton("* Procurar Música", "MAGIC_BMP", {|| u_zVid58Pr()}, , , , .T.)

Return oView

/*/{Protheus.doc} User Function zVid58Pr
Função que procurar uma música na grid
@type  Function
@author Atilio
@since 29/08/2022
/*/

User Function zVid58Pr()
    Local aArea     := FWGetArea()
    Local oModel    := FWModelActive()
    Local oModelMus := oModel:GetModel("ZD3DETAIL")
    Local cBusca    := ""

    //Mostra a tela para o usuário digitar o nome da música
    cBusca := FWInputBox("Informe o nome da música")

    //Se o usuário inseriu a música, realiza a busca
    If ! Empty(cBusca)
        //Documentação do SeekLine em : https://tdn.totvs.com/display/public/framework/FWFormGridModel
        //Parâmetros: <aBusca >, [ lDeleted ], [lLocate]
        oModelMus:SeekLine({{"ZD3_MUSICA", cBusca}})
    EndIf

    FWRestArea(aArea)
Return
