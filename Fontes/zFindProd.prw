/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2019/06/19/funcao-para-procurar-produtos-em-uma-grid-de-forma-rapida/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zFindProd
Função feita para agilizar a procura de produtos na grid de rotinas padrÃµes
@author Atilio
@since 31/10/2018
@version undefined
@type function
@example Inserir em um ponto de entrada no carregamento do sistema, por exemplo:

	User Function AfterLogin()
		SetKey(K_CTRL_Y, { || u_zFindProd() })  //Ctrl + Y
	Return
	
@obs Essa rotina foi feita usando o padrão de grids que usam aCols e aHeader, se for em MVC, para posicionar na linha seria algo +- assim:
	
	...
	oModelPad  := FWModelActive()
	oModelGrid := oModelPad:GetModel('XXXDETAIL')
	oModelGrid:GoLine(nLinhaNew)
	...
/*/

User Function zFindProd()
	Private nPosProd   := 0
	Private cCampo     := ""
	Private oPai       := GetWndDefault()
	Private aControles := oPai:aControls
	
	//Se for chamada pela tela de pedido de vendas, o campo será o C6_PRODUTO
	If IsInCallStack("MATA410")
		cCampo := "C6_PRODUTO"
	
	//Senão, se for chamada pela tela de pedido de compras, o campo será o C7_PRODUTO
	ElseIf IsInCallStack("MATA121")
		cCampo := "C7_PRODUTO"
	EndIf
	
	//Se houver campo, será carregado a tela
	If ! Empty(cCampo)
		//Pega a posição do aCols
		nPosProd := GDFieldPos(cCampo)
		
		//Chama a função de procura
		fProcura()
		
	Else
		MsgStop("Procura de Produtos não pode ser chamada!", "Atenção")
	EndIf
	
Return

/*---------------------------------------*
 | Func.: fProcura                       |
 | Desc.: Função que procura o registro  |
 *---------------------------------------*/

Static Function fProcura()
	//Variáveis da tela
	Private oDlgPesq
	Private oGrpPesq
	Private oGetPesq
	Private cGetPesq := Space(TamSX3('B1_COD')[01])
	Private oBtnExec
	//Tamanho da Janela
	Private nJanLarg := 500
	Private nJanAltu := 065
	
	//Criando a janela
	DEFINE MSDIALOG oDlgPesq TITLE "zFindProd - Pesquisa de Produtos" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
		//Grupo Fórmula com o Get
		@ 003, 003  GROUP oGrpPesq TO (nJanAltu/2)-3, (nJanLarg/2)-1        PROMPT "Produto: " OF oDlgPesq COLOR 0, 16777215 PIXEL
			@ 010, 006  MSGET oGetPesq VAR cGetPesq SIZE (nJanLarg/2)-29, 013 OF oDlgPesq COLORS 0, 16777215 VALID (fConfirma()) PIXEL
			oGetPesq:cPlaceHold := "Insira o código do Produto ou um trecho do código..."
			
			@ 010, (nJanLarg/2)-21 BUTTON oBtnExec PROMPT "OK" SIZE 016, 015 OF oDlgPesq ACTION(fConfirma()) PIXEL
		
	//Ativando a janela
	ACTIVATE MSDIALOG oDlgPesq CENTERED
	
Return

/*---------------------------------------*
 | Func.: fConfirma                      |
 | Desc.: Efetua a busca na grid         |
 *---------------------------------------*/

Static Function fConfirma()
	Local nLinNov   := 0
	Local cPesquisa := Alltrim(cGetPesq)
	
	//Primeiro tenta encontrar exatamente igual
	nLinNov := aScan(aCols, {|x| AllTrim(x[nPosProd]) == cPesquisa})
	
	//Se não encontrou, busca pelo trecho
	If nLinNov == 0
		nLinNov := aScan(aCols, {|x| cPesquisa $ AllTrim(x[nPosProd])})
	Endif
	
	//Se mesmo assim não encontrou, mostra mensagem
	If nLinNov == 0
		MsgStop("Trecho '" + cPesquisa + "' não foi encontrado!", "Atenção")
		
	//Do contrário, posiciona na linha correta e encerra a tela
	Else
		fPosiciona(nLinNov)
		oDlgPesq:End()
	EndIf
Return

/*---------------------------------------*
 | Func.: fPosiciona                     |
 | Desc.: Posiciona na linha correta     |
 *---------------------------------------*/

Static Function fPosiciona(nLinhaNew)
	Local nAtual     := 0
	Local oGrid
	
	//Percorrendo os objetos criados da tela
	For nAtual := 1 To Len(aControles)
	
		//Se tiver Colunas, é uma grid
		If Type("aControles[" + cValToChar(nAtual) + "]:aColumns") != "U"
			
			//Se tiver o mesmo número de colunas que o aHeader
			If Len(aControles[nAtual]:aColumns) == Len(aHeader)
				
				//Pega a Grid
				oGrid := aControles[nAtual]
				
				//Muda a Linha atual
				n := nLinhaNew
				oGrid:nAt := n
				
				//Atualiza a grid
				oGrid:Refresh()
				oGrid:SetFocus()
			EndIf
		EndIf
	Next
Return