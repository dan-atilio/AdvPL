/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2022/07/18/duas-grids-para-um-cabecalho-em-mvc-ti-responde-014/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Totvs.ch"
#Include "FWMVCDef.ch"

//Variveis Estaticas
Static cTitulo    := "Visualização Pedidos x Itens x Liberações"
Static cTabPai    := "SC5"
Static cTabFilho1 := "SC6"
Static cTabFilho2 := "SC9"

/*/{Protheus.doc} User Function zVid0014
Visualização Pedidos x Itens x Liberações
@author Daniel Atilio
@since 15/07/2021
@version 1.0
/*/

User Function zVid0014()
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

    //Adicionando as Legendas
    oBrowse:AddLegend("Empty(SC5->C5_LIBEROK).And.Empty(SC5->C5_NOTA) .And. Empty(SC5->C5_BLQ)" , 'ENABLE'     ,    "Pedido em Aberto"          )
    oBrowse:AddLegend("!Empty(SC5->C5_NOTA).Or.SC5->C5_LIBEROK=='E' .And. Empty(SC5->C5_BLQ)"   , 'DISABLE'    ,    "Pedido Encerrado"          )
    oBrowse:AddLegend("!Empty(SC5->C5_LIBEROK).And.Empty(SC5->C5_NOTA).And. Empty(SC5->C5_BLQ)" , 'BR_AMARELO' ,    "Pedido Liberado"           )
    oBrowse:AddLegend("SC5->C5_BLQ == '1'"                                                      , 'BR_AZUL'    ,    "Pedido Bloquedo por regra" )
    oBrowse:AddLegend("SC5->C5_BLQ == '2'"                                                      , 'BR_LARANJA' ,    "Pedido Bloquedo por verba" )

    //Ativa a Browse
    oBrowse:Activate()

    RestArea(aArea)
Return Nil

Static Function MenuDef()
    Local aRotina := {}

    //Adicionando opcoes do menu
    ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.zVid0014" OPERATION 1 ACCESS 0

Return aRotina

Static Function ModelDef()
    Local oStrPai := FWFormStruct(1, cTabPai)
    Local oStrFilho1 := FWFormStruct(1, cTabFilho1, {|cCampo| .Not. Alltrim(cCampo) $ "C6_CODINF;C6_INFAD;"})
    Local oStrFilho2 := FWFormStruct(1, cTabFilho2)
    Local aRelation  := {}
    Local aRelation2 := {}
    Local oModel
    Local bPre := Nil
    Local bPos := Nil
    Local bCommit := Nil
    Local bCancel := Nil

    //Cria o modelo de dados para cadastro
    oModel := MPFormModel():New("zVid0014M", bPre, bPos, bCommit, bCancel)
    oModel:AddFields("SC5MASTER", /*cOwner*/, oStrPai)
    oModel:AddGrid("SC6DETAIL","SC5MASTER",oStrFilho1,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)
    oModel:AddGrid("SC9DETAIL","SC5MASTER",oStrFilho2,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)
    oModel:SetDescription("Modelo de dados - " + cTitulo)
    oModel:GetModel("SC5MASTER"):SetDescription( "Dados de - " + cTitulo)
    oModel:GetModel("SC6DETAIL"):SetDescription( "Grid SC6 de - " + cTitulo)
    oModel:GetModel("SC9DETAIL"):SetDescription( "Grid SC9 de - " + cTitulo)
    oModel:SetPrimaryKey({"C5_FILIAL", "C5_NUM"})

    //Fazendo o relacionamento
    aAdd(aRelation, {"C6_FILIAL", "FWxFilial('SC6')"} )
    aAdd(aRelation, {"C6_NUM", "C5_NUM"})
    oModel:SetRelation("SC6DETAIL", aRelation, SC6->(IndexKey(1)))

    aAdd(aRelation2, {"C9_FILIAL", "FWxFilial('SC9')"} )
    aAdd(aRelation2, {"C9_PEDIDO", "C5_NUM"})
    oModel:SetRelation("SC9DETAIL", aRelation2, SC9->(IndexKey(1)))

Return oModel

Static Function ViewDef()
    Local oModel := FWLoadModel("zVid0014")
    Local oStrPai := FWFormStruct(2, cTabPai)
    Local oStrFilho1 := FWFormStruct(2, cTabFilho1, {|cCampo| .Not. Alltrim(cCampo) $ "C6_CODINF;C6_INFAD;"})
    Local oStrFilho2 := FWFormStruct(2, cTabFilho2)
    Local oView

    //Cria a visualizacao do cadastro
    oView := FWFormView():New()
    oView:SetModel(oModel)

    //Adicionando os campos do cabeçalho
    oView:AddField("VIEW_SC5", oStrPai, "SC5MASTER")
    oView:EnableTitleView("VIEW_SC5", "Cabeçalho do Pedido (SC5)")
     
    //Grids dos filhos
    oView:AddGrid("VIEW_SC6",  oStrFilho1,  "SC6DETAIL")
    oView:AddGrid("VIEW_SC9",  oStrFilho2,  "SC9DETAIL")

    //Setando o dimensionamento de tamanho
    oView:CreateHorizontalBox('SUPERIOR', 50)
    oView:CreateHorizontalBox('INFERIOR', 50)

    //Criando a folder dos produtos (filhos)
    oView:CreateFolder('PASTA_FILHOS', 'INFERIOR')
    oView:AddSheet('PASTA_FILHOS', 'ABA_FILHO01', "Produtos Vendidos (SC6)")
    oView:AddSheet('PASTA_FILHOS', 'ABA_FILHO02', "Liberações (SC9)")

    //Criando os vinculos onde serão mostrado os dados
    oView:CreateHorizontalBox('ITENS_FILHO01', 100,,, 'PASTA_FILHOS', 'ABA_FILHO01' )
    oView:CreateHorizontalBox('ITENS_FILHO02', 100,,, 'PASTA_FILHOS', 'ABA_FILHO02' )
     
    //Amarrando a view com as box
    oView:SetOwnerView('VIEW_SC5', 'SUPERIOR')
    oView:SetOwnerView('VIEW_SC6', 'ITENS_FILHO01')
    oView:SetOwnerView('VIEW_SC9', 'ITENS_FILHO02')

    //Removendo campos
    oStrFilho1:RemoveField("C6_FILIAL")
    oStrFilho1:RemoveField("C6_NUM")
    oStrFilho2:RemoveField("C9_FILIAL")
    oStrFilho2:RemoveField("C9_PEDIDO")

    //Adicionando campo incremental na grid
    oView:AddIncrementField("VIEW_SC6", "C6_ITEM")
    oView:AddIncrementField("VIEW_SC9", "C9_ITEM")

Return oView
