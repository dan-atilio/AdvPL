/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/01/criando-dois-browses-com-relacionamento-atraves-da-fwbrwrelation-maratona-advpl-e-tl-208/
*/


//Bibliotecas
#Include "Totvs.ch"
#Include "FWMVCDef.ch"

Static lEmExecucao   := .F.

/*/{Protheus.doc} User Function zExe208
Exemplo de tela com 2 browses de cadastro usando FWBrwRelation
@type  Function
@author Atilio
@since 20/02/2023
@obs 
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe208()
	Local aArea   := GetArea()
    Local cFunBkp := FunName()
	Local aCoors  := FWGetDialogSize( oMainWnd )
	Local cIdGrupo
	Local cIdProdut
	Local oPanelUp
	Local oTela
	Local oPanelDown
	Local oRelaction

	//Tratativa para impedir que seja aberta a mesma janela por cima da original do browse
	If ! lEmExecucao
		SetFunName("MATA035")
		DbSelectArea("SBM")
		DbSelectArea("SB1")

		//Cria a janela principal
		Define MsDialog oDlgPrinc Title "Grupos x Produtos" From aCoors[1], aCoors[2] To aCoors[3], aCoors[4] OF oMainWnd Pixel

			//Divide a tela em dois containers, um de 30% e outro de 68%
			oTela     := FWFormContainer():New( oDlgPrinc )
			cIdGrupo  := oTela:CreateHorizontalBox( 30 )
			cIdProdut := oTela:CreateHorizontalBox( 68 )
			oTela:Activate( oDlgPrinc, .F. )

			//Cria os painéis
			oPanelUp  	:= oTela:GetPanel( cIdGrupo )
			oPanelDown  := oTela:GetPanel( cIdProdut )

			//Cria o browse superior trazendo dados da SBM
			oBrowseUp:= FWmBrowse():New()
			oBrowseUp:SetOwner(oPanelUp)
			oBrowseUp:SetDescription("Grupos")
			oBrowseUp:SetAlias('SBM')
			oBrowseUp:DisableDetails()
			oBrowseUp:SetProfileID('1')
			oBrowseUp:ExecuteFilter(.T.)
			oBrowseUp:SetMainProc("MATA010")
			oBrowseUp:ForceQuitButton()
			oBrowseUp:SetMenuDef('MATA035')
			oBrowseUp:SetCacheView (.F.)
			oBrowseUp:SetOnlyFields({'BM_GRUPO', 'BM_DESC'})
			oBrowseUp:Activate()

			//Cria o browse inferior, que irá trazer todos os produtos
			aRotina := FWLoadMenuDef("MATA010")
			oBrowseDwn:= FWMBrowse():New()
			oBrowseDwn:SetOwner(oPanelDown)
			oBrowseDwn:SetDescription("Produtos")
			oBrowseDwn:SetMenuDef('MATA010')
			oBrowseDwn:DisableDetails()
			oBrowseDwn:SetAlias('SB1')
			oBrowseDwn:SetProfileID('2')
			oBrowseDwn:SetMainProc("MATA035")
			oBrowseDwn:SetCacheView (.F.)
			oBrowseDwn:SetOnlyFields({'B1_COD', 'B1_DESC'})

			//Faz o relacionamento entre os dois browses
			oRelaction:= FWBrwRelation():New()
			oRelaction:AddRelation( oBrowseUp  , oBrowseDwn , { { 'B1_GRUPO' , 'BM_GRUPO' } } )
			oRelaction:Activate()
			oBrowseDwn:Activate()

			//Atualiza os browses e cria a janela na tela
			oBrowseUp:Refresh()
			oBrowseDwn:Refresh()
			lEmExecucao := .T.
		Activate MsDialog oDlgPrinc Center

		lEmExecucao := .F.
        SetFunName(cFunBkp)
	EndIf

	RestArea(aArea)
Return

Static Function MenuDef()
	Local aRotina := FWLoadMenuDef("MATA035")
Return aRotina
