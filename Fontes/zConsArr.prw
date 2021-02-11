/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2016/08/16/consulta-padrao-dados-de-array/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"
#Include "TopConn.ch"

//Constantes
#Define STR_PULA		Chr(13)+Chr(10)

/*/{Protheus.doc} zTstCons
Função de exemplo de consulta de dados via Array (zConsArr)
@type function
@author Atilio
@since 30/07/2016
@version 1.0
/*/

User Function zTstCons()
	Local lOk := .F.
	Local aDados := {}
	
	//Adicionando os dados no array
	aAdd(aDados, {"0001", "Daniel", 23})
	aAdd(aDados, {"0002", "Hudson", 33})
	aAdd(aDados, {"0003", "Atilio", 43})
	
	//Chamando a consulta
	lOk := u_zConsArr(aDados, 1, 3, {"Codigo","Nome","Idade"}, {04, 50, 3})
	
	//Se foi confirmado, mostra mensagem
	If lOk
		MsgInfo("O escolhido foi: "+__cRetorn+"!", "Atenção")
	EndIf
Return lOk

/*/{Protheus.doc} zConsArr
Função para consulta genérica
@author Daniel Atilio
@since 05/06/2015
@version 1.0
	@param aDadosM, Array, Array multidimensional que tem o retorno
	@param nPosRetM, Numérico, Posição de retorno
	@param nColsM, Numérico, Quantidade de colunas
	@param aTitulosM, Array, Array com os tÃ­tulos dos campos
	@return lRetorn, retorno se a consulta foi confirmada ou não
	@example
	u_zConsArr(aDados, 1, 3, {"Campo1","Campo2","Campo3"}, {10, 10, 20})
	@obs O retorno da consulta é pública (__cRetorn) para ser usada em consultas especÃ­ficas
/*/

User Function zConsArr(aDadosM, nPosRetM, nColsM, aTitulosM, aTamanM)
	Local aArea := GetArea()
	Local nTamBtn := 50
	//Defaults
	Default aDadosM := {}
	Default nPosRetM := 0
	Default nColsM := 0
	Default aTitulosM := {}
	Default aTamanM := {}
	//Privates
	Private aCampos := aDadosM
	Private nPosRet := nPosRetM
	Private nCols	:= nColsM
	Private aTitulos := aTitulosM
	Private aTaman := aTamanM
	//MsNewGetDados
	Private oMsNew
	Private aHeadAux := {}
	Private aColsAux := {}
	//Tamanho da janela
	Private nJanLarg := 0800
	Private nJanAltu := 0500
	//Gets e Dialog
	Private oDlgEspe
	Private oGetPesq, cGetPesq := Space(100)
	//Retorno
	Private lRetorn := .F.
	Private nTamanRet := Iif(Len(aDadosM) >= 1, Len(aDadosM[1][nPosRet]), 18)
	Public  __cRetorn := ""
	
	//Se tiver o alias em branco ou não tiver campos
	If Len(aDadosM) <= 0 .Or. (nPosRetM == 0) .Or. (nColsM == 0)
		MsgStop("Sem campos!", "Atenção")
		Return lRetorn
	EndIf
	
	//Criando a estrutura para a MsNewGetDados
	fCriaMsNew()
	
	//Criando a janela
	DEFINE MSDIALOG oDlgEspe TITLE "Consulta de Dados" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
		//Pesquisar
		@ 003, 003 GROUP oGrpPesqui TO 025, (nJanLarg/2)-3 PROMPT "Pesquisar: "	OF oDlgEspe COLOR 0, 16777215 PIXEL
			@ 010, 006 MSGET oGetPesq VAR cGetPesq SIZE (nJanLarg/2)-12, 010 OF oDlgEspe COLORS 0, 16777215  VALID (fVldPesq())      PIXEL
		
		//Dados
		@ 028, 003 GROUP oGrpDados TO (nJanAltu/2)-28, (nJanLarg/2)-3 PROMPT "Dados: "	OF oDlgEspe COLOR 0, 16777215 PIXEL
			oMsNew := MsNewGetDados():New(	035,;										//nTop
    											006,;										//nLeft
    											(nJanAltu/2)-31,;							//nBottom
    											(nJanLarg/2)-6,;							//nRight
    											GD_INSERT+GD_DELETE+GD_UPDATE,;			//nStyle
    											"AllwaysTrue()",;							//cLinhaOk
    											,;											//cTudoOk
    											"",;										//cIniCpos
    											,;											//aAlter
    											,;											//nFreeze
    											999,;										//nMax
    											,;											//cFieldOK
    											,;											//cSuperDel
    											,;											//cDelOk
    											oDlgEspe,;									//oWnd
    											aHeadAux,;									//aHeader
    											aColsAux)									//aCols                                    
			oMsNew:lActive := .F.
			oMsNew:oBrowse:blDblClick := {|| fConfirm()}
		
			//Populando os dados da MsNewGetDados
			fPopula()
		
		//AçÃµes
		@ (nJanAltu/2)-25, 003 GROUP oGrpAcoes TO (nJanAltu/2)-3, (nJanLarg/2)-3 PROMPT "AçÃµes: "	OF oDlgEspe COLOR 0, 16777215 PIXEL
			@ (nJanAltu/2)-19, (nJanLarg/2)-((nTamBtn*1)+06) BUTTON oBtnConf PROMPT "Confirmar" SIZE nTamBtn, 013 OF oDlgEspe ACTION(fConfirm())     PIXEL
			@ (nJanAltu/2)-19, (nJanLarg/2)-((nTamBtn*2)+09) BUTTON oBtnLimp PROMPT "Limpar" SIZE nTamBtn, 013 OF oDlgEspe ACTION(fLimpar())     PIXEL
			@ (nJanAltu/2)-19, (nJanLarg/2)-((nTamBtn*3)+12) BUTTON oBtnCanc PROMPT "Cancelar" SIZE nTamBtn, 013 OF oDlgEspe ACTION(fCancela())     PIXEL
		
		oMsNew:oBrowse:SetFocus()
	//Ativando a janela
	ACTIVATE MSDIALOG oDlgEspe CENTERED
	
	RestArea(aArea)
Return lRetorn

/*---------------------------------------------------------------------*
 | Func:  fCriaMsNew                                                   |
 | Autor: Daniel Atilio                                                |
 | Data:  05/06/2015                                                   |
 | Desc:  Função para criar a estrutura da MsNewGetDados               |
 | Obs.:  /                                                            |
 *---------------------------------------------------------------------*/

Static Function fCriaMsNew()
	Local cCampoAtu := "XX_CAMP000"
	Local nTamanAtu := 0
	
	//Percorrendo os campos
	For nAtual := 1 To nCols
		cCampoAtu := Soma1(cCampoAtu)
		nTamanAtu := 10
		
		//Se tiver tÃ­tulo
		If ! (nAtual > Len(aTitulos))
			cTituloAux := aTitulos[nAtual]
		Else
			cTituloAux := Capital(StrTran(cCampoAtu, "XX_", ""))
		EndIf

		//Se tiver tamanho
		If nAtual >= Len(aTaman)
			nTamanAtu := aTaman[nAtual]
		EndIf
		
		//Cabeçalho ...	Titulo			Campo			Mask		Tamanho	Dec		Valid	Usado	Tip		F3	CBOX
		aAdd(aHeadAux,{	cTituloAux,	cCampoAtu,		"",			nTamanAtu,			0,		".F.",	".F.",	"C",	"",	""})
	Next
Return

/*---------------------------------------------------------------------*
 | Func:  fPopula                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  05/06/2015                                                   |
 | Desc:  Função que popula a tabela auxiliar da MsNewGetDados         |
 | Obs.:  /                                                            |
 *---------------------------------------------------------------------*/

Static Function fPopula()
	Local xAux := ""
	aColsAux :={}
	
	//Percorrendo linhas
	For nLinha := 1 To Len(aCampos)
		lFiltro := .F.
		
		//Se tiver filtro, verifica um a um se tem a expressão
		If !Empty(cGetPesq)
			//percorrendo colunas
			For nColuna := 1 To nCols
				xAux := aCampos[nLinha][nColuna]
				If ValType(xAux) != 'C'
					xAux := cValToChar(xAux)
				EndIf
				
				//Se tiver na pesquisa
				If Alltrim(Lower(cGetPesq)) $ Lower(xAux)
					lFiltro := .T.
				EndIf
			Next
		
		//Se não tiver filtro, traz tudo
		Else
			lFiltro := .T.
		EndIf
		
		
		//Se tiver filtrado ok
		If lFiltro
			aAux := {}
			//percorrendo colunas
			For nColuna := 1 To nCols
				aAdd(aAux, aCampos[nLinha][nColuna])
			Next
			aAdd(aAux, .F.)
			aAdd(aColsAux, aClone(aAux))
		EndIf
	Next
	
	//Se não tiver dados, adiciona linha em branco
	If Len(aColsAux) == 0
		aAux := {}
		//Percorrendo os campos e adicionando no acols (junto com o recno e com o delet
		For nAtual := 1 To nCols
			aAdd(aAux, '')
		Next
		aAdd(aAux, .F.)
	
		aAdd(aColsAux, aClone(aAux))
	EndIf
	
	//Posiciona no topo e atualiza grid
	oMsNew:SetArray(aColsAux)
	oMsNew:oBrowse:Refresh()
Return

/*---------------------------------------------------------------------*
 | Func:  fConfirm                                                     |
 | Autor: Daniel Atilio                                                |
 | Data:  05/06/2015                                                   |
 | Desc:  Função de confirmação da rotina                              |
 | Obs.:  /                                                            |
 *---------------------------------------------------------------------*/

Static Function fConfirm()
	Local cAux := ""
	Local aColsNov := oMsNew:aCols
	Local nLinAtu  := oMsNew:nAt
	lRetorn := .T.
	
	__cRetorn := aColsNov[nLinAtu][nPosRet]
	
	oDlgEspe:End()
Return

/*---------------------------------------------------------------------*
 | Func:  fLimpar                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  05/06/2015                                                   |
 | Desc:  Função que limpa os dados da rotina                          |
 | Obs.:  /                                                            |
 *---------------------------------------------------------------------*/

Static Function fLimpar()
	//Zerando gets
	cGetPesq := Space(100)
	oGetPesq:Refresh()

	//Atualiza grid
	fPopula()
	
	//Setando o foco na pesquisa
	oGetPesq:SetFocus()
Return

/*---------------------------------------------------------------------*
 | Func:  fCancela                                                     |
 | Autor: Daniel Atilio                                                |
 | Data:  05/06/2015                                                   |
 | Desc:  Função de cancelamento da rotina                             |
 | Obs.:  /                                                            |
 *---------------------------------------------------------------------*/

Static Function fCancela()
	//Setando o retorno em branco e finalizando a tela
	lRetorn := .F.
	__cRetorn := Space(nTamanRet)
	oDlgEspe:End()
Return

/*---------------------------------------------------------------------*
 | Func:  fVldPesq                                                     |
 | Autor: Daniel Atilio                                                |
 | Data:  05/06/2015                                                   |
 | Desc:  Função que valida o campo digitado                           |
 | Obs.:  /                                                            |
 *---------------------------------------------------------------------*/

Static Function fVldPesq()
	Local lRet := .T.
	
	//Se tiver apóstrofo ou porcentagem, a pesquisa não pode prosseguir
	If "'" $ cGetPesq .Or. "%" $ cGetPesq
		lRet := .F.
		MsgAlert("<b>Pesquisa inválida!</b><br>A pesquisa não pode ter <b>'</b> ou <b>%</b>.", "Atenção")
	EndIf
	
	//Se houver retorno, atualiza grid
	If lRet
		fPopula()
	EndIf
Return lRet