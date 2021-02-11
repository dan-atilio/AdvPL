/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2017/01/16/vd-advpl-023/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*--------------------------------------------------------------------------*
 | P.E.:   OS010BTN                                                         |
 | Autor:  Daniel Atilio                                                    |
 | Data:   27/08/2016                                                       |
 | Descr.: Função que adiciona Ações Relacionadas dentro da Tabela de Preço |
 *--------------------------------------------------------------------------*/
 
User Function OS010BTN()
	Local aArea    := GetArea()
	Local aButtons := {}
	
	//Adicionando o botão no Ações Relacionadas
	aAdd(aButtons,{ "* Atualiza Produtos", {|| u_zAtuGrid()}, "* Atualiza Produtos" })
	
	RestArea(aArea)
Return aButtons

/*/{Protheus.doc} zAtuGrid
Função para atualizar a DA1 - MVC
@type function
@author Atilio
@since 27/08/2016
@version 1.0
/*/

User Function zAtuGrid()
	Local aArea      := GetArea()
	Local nJanAltu   := 100
	Local nJanLarg   := 700
	Local oFontPad   := TFont():New("Arial", , -14)
	Private lNovo    := .F.
	Private oDlgAtu
	Private cMaskDA1 := PesqPict('DA1', 'DA1_PRCVEN')
	
	//Carregando os modelos de dados do cabeçalho e grid
	Private oModelPad  := FWModelActive()
	Private oModelGrid := oModelPad:GetModel('DA1DETAIL')
	Private nOperacao  := oModelPad:nOperation
	
	//Pegando posições do aHeader
	Private nPosProd   := aScan(oModelGrid:aHeader, {|x| AllTrim(x[2]) == AllTrim("DA1_CODPRO")})
	Private nPosDesc   := aScan(oModelGrid:aHeader, {|x| AllTrim(x[2]) == AllTrim("DA1_DESCRI")})	
	Private nPosPrcV   := aScan(oModelGrid:aHeader, {|x| AllTrim(x[2]) == AllTrim("DA1_PRCVEN")})
	
	//Linha Atual
	Private nLinAtu    := oModelGrid:nLine
	
	//Linha encontrada
	Private nLinEnc    := 0
	
	//Gets
	Private oGetCod, cGetCod := Space(TamSX3('B1_COD')[01])
	Private oGetDes, cGetDes := Space(TamSX3('B1_DESC')[01])
	Private oGetPrc, nGetPrc := 0
	Private oGetMsg, cGetMsg := ""
	
	//Montando a janela
	DEFINE MSDIALOG oDlgAtu TITLE "Atualização Preço" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
		//Produto
		nColAux := 3
		@ 007, nColAux      SAY oSayCod PROMPT "Produto: " 				SIZE 050, 007 OF oDlgAtu COLORS 0, 16777215  PIXEL
		@ 004, nColAux+40   MSGET 	oGetCod VAR cGetCod                SIZE 060, 010 OF oDlgAtu COLORS 0, 16777215  F3 'SB1' VALID (fPesqSB1()) PIXEL
		
		//Descrição
		nColAux += 103
		@ 007, nColAux      SAY oSayDes PROMPT "Descrição: " 			SIZE 050, 007 OF oDlgAtu COLORS 0, 16777215  PIXEL
		@ 004, nColAux+40   MSGET 	oGetDes VAR cGetDes                SIZE 100, 010 OF oDlgAtu COLORS 0, 16777215  PIXEL
		oGetDes:lActive := .F.
		
		//Preço Venda
		nColAux += 143
		@ 007, nColAux      SAY oSayPrc PROMPT "Preço Venda: " 			SIZE 050, 007 OF oDlgAtu COLORS 0, 16777215  PIXEL
		@ 004, nColAux+40   MSGET 	oGetPrc VAR nGetPrc                SIZE 060, 010 OF oDlgAtu COLORS 0, 16777215  PICTURE cMaskDA1 PIXEL
		
		//Get de Log
		@ 023, 003   MSGET oGetMsg VAR    cGetMsg        SIZE (nJanLarg/2)-12, 012 OF oDlgAtu COLORS 0, 16777215 NO BORDER FONT oFontPad PIXEL
		oGetMsg:lActive := .F.
		oGetMsg:setCSS("QLineEdit{color:#FF0000; background-color:#FEFEFE;}")
		
		//Botão confirmar
		If nOperacao == 3 .Or. nOperacao == 4
			@ (nJanAltu/2)-24, (nJanLarg/2)-53        BUTTON oBtnCon  PROMPT "Confirmar"  SIZE 048, 018 OF oDlgAtu ACTION(fConfirmar() )                                                 PIXEL
		EndIf
	ACTIVATE MSDIALOG oDlgAtu CENTERED
	
	//Volta pra primeira linha
	oModelGrid:nLine := 1
	
	RestArea(aArea)
Return

/*---------------------------------------------------------------------*
 | Func:  fPesqSB1                                                     |
 | Autor: Daniel Atilio                                                |
 | Data:  27/08/2016                                                   |
 | Desc:  Função que valida o código do produto digitado               |
 *---------------------------------------------------------------------*/

Static Function fPesqSB1()
	Local lRet := .T.
	
	DbSelectArea('SB1')
	SB1->(DbSetOrder(1)) //B1_FILIAL + B1_COD
	
	//Se conseguir posicionar no produto
	If SB1->(DbSeek(FWxFilial('SB1') + cGetCod))
		cGetDes := SB1->B1_DESC
		lRet := .T.
		
		//Busca a linha
		nLinEnc := aScan(oModelGrid:aCols, {|x| AllTrim(x[nPosProd]) == AllTrim(cGetCod)})
		
		//Caso não encontre
		If nLinEnc == 0
			cGetMsg := "Item Novo"
			nGetPrc := 0
			lNovo   := .T.
		Else
			cGetMsg := "Item Existente"
			nGetPrc := oModelGrid:aCols[nLinEnc][nPosPrcV]
			lNovo   := .F.
		EndIf
		
	Else
		lRet := .F.
		MsgAlert("Produto não encontrado!", "Atenção")
	EndIf
	
Return lRet

/*---------------------------------------------------------------------*
 | Func:  fConfirmar                                                   |
 | Autor: Daniel Atilio                                                |
 | Data:  27/08/2016                                                   |
 | Desc:  Função chamada pelo botão confirmar                          |
 *---------------------------------------------------------------------*/

Static Function fConfirmar()
	Local nLin
	
	//Se for novo, adiciona uma nova linha
	If lNovo
		oModelGrid:AddLine()
		nLin := Len(oModelGrid:aCols)
	
	//Senão pega a linha encontrada
	Else
		nLin := nLinEnc
	EndIf
	
	//Define a linha que será utilizada
	oModelGrid:nLine := nLin
	oModelPad:SetValue('DA1DETAIL', 'DA1_CODPRO', cGetCod)
	oModelPad:SetValue('DA1DETAIL', 'DA1_DESCRI', cGetDes)
	oModelPad:SetValue('DA1DETAIL', 'DA1_PRCVEN', nGetPrc)
	
	//Atualiza os textos
	cGetCod := Space(TamSX3('B1_COD')[01])
	cGetDes := Space(TamSX3('B1_DESC')[01])
	nGetPrc := 0
	cGetMsg := ""
	oGetCod:Refresh() 
	oGetDes:Refresh() 
	oGetPrc:Refresh() 
	oGetMsg:Refresh()
Return