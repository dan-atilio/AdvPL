/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2024/10/17/como-percorrer-um-array-dentro-de-outro-em-mvc-ti-responde-0091/ 
    
*/


//Bibliotecas
#Include "Totvs.ch"
#Include "FWMVCDef.ch"

//Variveis Estaticas
Static cTitulo := "Artistas x CDs x Músicas"
Static cTabPai := "ZD1"
Static cTabFilho := "ZD2"
Static cTabNeto := "ZD3"

/*/{Protheus.doc} User Function zVid0091
Exemplo de Modelo X
@author Daniel Atilio
@since 04/02/2022
@version 1.0
@type function
/*/

User Function zVid0091()
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
Menu de opcoes na funcao zVid0091
@author Daniel Atilio
@since 04/02/2022
@version 1.0
@type function
/*/

Static Function MenuDef()
	Local aRotina := {}

	//Adicionando opcoes do menu
	ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.zVid0091" OPERATION 1 ACCESS 0
	ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.zVid0091" OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.zVid0091" OPERATION 4 ACCESS 0
	ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.zVid0091" OPERATION 5 ACCESS 0

Return aRotina

/*/{Protheus.doc} ModelDef
Modelo de dados na funcao zVid0091
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
	oModel := MPFormModel():New("zVid91M", bPre, bPos, bCommit, bCancel)
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

Return oModel

/*/{Protheus.doc} ViewDef
Visualizacao de dados na funcao zVid0091
@author Daniel Atilio
@since 04/02/2022
@version 1.0
@type function
/*/

Static Function ViewDef()
	Local oModel := FWLoadModel("zVid0091")
	Local oStruPai := FWFormStruct(2, cTabPai)
	Local oStruFilho := FWFormStruct(2, cTabFilho, { |x| ! Alltrim(x) $ 'ZD2_NOME' })
    Local oStruNeto := FWFormStruct(2, cTabNeto)
	Local oView

	//Cria a visualizacao do cadastro
	oView := FWFormView():New()
	oView:SetModel(oModel)
	oView:AddField("VIEW_ZD1", oStruPai, "ZD1MASTER")
	oView:AddGrid("VIEW_ZD2",  oStruFilho,  "ZD2DETAIL")
    oView:AddGrid("VIEW_ZD3",  oStruNeto,  "ZD3DETAIL")

	//Partes da tela
	oView:CreateHorizontalBox("CABEC_PAI", 30)
	oView:CreateHorizontalBox("GRID_FILHO", 30)
    oView:CreateHorizontalBox("GRID_NETO", 40)
	oView:SetOwnerView("VIEW_ZD1", "CABEC_PAI")
	oView:SetOwnerView("VIEW_ZD2", "GRID_FILHO")
    oView:SetOwnerView("VIEW_ZD3", "GRID_NETO")

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

    //Adiciona botões no outras ações para demonstrar em como percorrer um array dentro de outro
	oView:addUserButton("* Percorrer Arrays", "MAGIC_BMP", {|| fExemplo()}, , , , .T.)

Return oView

Static Function fExemplo()
    Local aArea       := FWGetArea()
    Local oModel      := FWModelActive()
	Local oModelFilho := oModel:GetModel('ZD2DETAIL')
    Local oModelNeto  := oModel:GetModel('ZD3DETAIL')
    Local nLinhaFilho := 0
    Local nLinhaNeto  := 0
    Local cMensagem   := ""

    //Percorre as informações da grid de filho
    For nLinhaFilho := 1 To oModelFilho:Length()
        //Posiciona na linha atual do filho
        oModelFilho:GoLine(nLinhaFilho)

        //Incrementa a mensagem
        cMensagem += "[" + cValToChar(nLinhaFilho) + "] Filho: " + oModelFilho:GetValue("ZD2_NOMECD") + CRLF
        
        //Percorre os netos
        For nLinhaNeto := 1 To oModelNeto:Length()
            //Posiciona na linha atual do neto
            oModelNeto:GoLine(nLinhaNeto)

            //Incrementa a mensagem
            cMensagem += "[" + cValToChar(nLinhaFilho) + "][" + cValToChar(nLinhaNeto) + "] Neto: " + oModelNeto:GetValue("ZD3_MUSICA") + CRLF
        Next

        //Volta pra linha 1 dos netos
        oModelNeto:GoLine(1)
    Next

    //Se tiver mensagem, exibe
    If ! Empty(cMensagem)
        ShowLog(cMensagem)
    EndIf

    //Volta para a linha 1 dos filhos
    oModelFilho:GoLine(1)

    FWRestArea(aArea)
Return
