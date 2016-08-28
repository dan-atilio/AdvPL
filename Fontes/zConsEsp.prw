//Bibliotecas
#Include "Protheus.ch"
#Include "TopConn.ch"

//Constantes
#Define STR_PULA		Chr(13)+ Chr(10)

/*/{Protheus.doc} zConsEsp
Função para consulta genérica
@author Daniel Atilio
@since 24/02/2015
@version 1.0
	@param cAliasM, Caracter, Alias da tabela consultada
	@param aCamposM, Array, Campos que serão montados na grid de marcação
	@param cFiltroM, Caracter, Filtragem da tela (SQL)
	@param cRetorM, Caracter, Campo que será checado
	@param aColsM, Array, Conteúdo de campos específicos, que iniciam com XX_ no aCamposM
	@param cOrdM, Caracter, Campos utilizados no Order By
	@return lRetorn, retorno se a consulta foi confirmada ou não
	@example
	u_zConsEsp("SED", {"ED_CODIGO","ED_DESCRIC"}, " AND ED_FILIAL = '"+xFilial("SED")+"' ", "ED_CODIGO")
	u_zConsEsp("SB1", {"B1_COD","B1_DESC","B1_TIPO"}, " AND B1_FILIAL = '"+xFilial("SB1")+"' ", "B1_COD")
	...
	User Function zConsSC2()
		lOk := u_zConsEsp("SC2", {"C2_NUM","C2_ITEM","C2_SEQUEN","C2_OBS","C2_PRODUTO","C2_CC","XX_SALDO"},, "C2_NUM+C2_ITEM+C2_SEQUEN",{"u_zRetSC2Sld(QRY_DAD->XX_RECNUM)"})
	Return lOk
	@obs O retorno da consulta é pública (__cRetorn) para ser usada em consultas específicas
	Caso seja necessário incluir campos específicos na grid, utilize o prefixo XX_ antes do nome do campo no aCamposM,
	   e seu conteúdo preencha no aColsM
/*/

User Function zConsEsp(cAliasM, aCamposM, cFiltroM, cRetorM, aColsM, cOrdM)
	Local aArea := GetArea()
	Local nTamBtn := 50
	//Defaults
	Default cAliasM := ""
	Default aCamposM := {}
	Default cFiltroM := ""
	Default cRetorM := ""
	Default aColsM := {}
	Default cOrdM := ""
	//Privates
	Private cFiltro := cFiltroM
	Private cAliasPvt := cAliasM
	Private aCampos := aCamposM
	Private nTamanRet := 0
	Private cCampoRet := cRetorM
	Private aColsEsp := aColsM
	Private cOrder := cOrdM
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
	Public  __cRetorn := ""
	
	//Se tiver o alias em branco ou não tiver campos
	If Empty(cAliasM) .Or. Len(aCamposM) <= 0 .Or. Empty(cRetorM)
		MsgStop("Alias em branco e/ou Sem campos para marcação!", "Atenção")
		Return lRetorn
	EndIf
	
	//Criando a estrutura para a MsNewGetDados
	fCriaMsNew()
	__cRetorn := Space(nTamanRet)
	
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
		
		//Ações
		@ (nJanAltu/2)-25, 003 GROUP oGrpAcoes TO (nJanAltu/2)-3, (nJanLarg/2)-3 PROMPT "Ações: "	OF oDlgEspe COLOR 0, 16777215 PIXEL
			@ (nJanAltu/2)-19, (nJanLarg/2)-((nTamBtn*1)+06) BUTTON oBtnConf PROMPT "Confirmar" SIZE nTamBtn, 013 OF oDlgEspe ACTION(fConfirm())     PIXEL
			@ (nJanAltu/2)-19, (nJanLarg/2)-((nTamBtn*2)+09) BUTTON oBtnLimp PROMPT "Limpar" SIZE nTamBtn, 013 OF oDlgEspe ACTION(fLimpar())     PIXEL
			@ (nJanAltu/2)-19, (nJanLarg/2)-((nTamBtn*3)+12) BUTTON oBtnCanc PROMPT "Cancelar" SIZE nTamBtn, 013 OF oDlgEspe ACTION(fCancela())     PIXEL
			@ (nJanAltu/2)-19, (nJanLarg/2)-((nTamBtn*4)+15) BUTTON oBtnVisu PROMPT "Visualizar" SIZE nTamBtn, 013 OF oDlgEspe ACTION(fVisual())     PIXEL
		
		oMsNew:oBrowse:SetFocus()
	//Ativando a janela
	ACTIVATE MSDIALOG oDlgEspe CENTERED
	
	RestArea(aArea)
Return lRetorn

/*---------------------------------------------------------------------*
 | Func:  fCriaMsNew                                                   |
 | Autor: Daniel Atilio                                                |
 | Data:  24/02/2015                                                   |
 | Desc:  Função para criar a estrutura da MsNewGetDados               |
 | Obs.:  /                                                            |
 *---------------------------------------------------------------------*/

Static Function fCriaMsNew()
	Local aAreaX3 := SX3->(GetArea())

	//Zerando o cabeçalho e a estrutura
	aHeadAux := {}
	aColsAux := {}
	
	DbSelectArea("SX3")
	SX3->(DbSetOrder(2)) // Campo
	SX3->(DbGoTop())
	
	//Percorrendo os campos
	For nAtual := 1 To Len(aCampos)
		cCampoAtu := aCampos[nAtual]
		
		//Se iniciar com XX_
		If SubStr(cCampoAtu, 1, 3) == "XX_"
			//Cabeçalho ...	Titulo											Campo			Mask		Tamanho	Dec		Valid	Usado	Tip		F3	CBOX
			aAdd(aHeadAux,{	Capital(StrTran(cCampoAtu, "XX_", "")),	cCampoAtu,		"",			18,			0,		".F.",	".F.",	"C",	"",	""})
		ElseIf SubStr(cCampoAtu, 1, 3) == "YY_"
			//Cabeçalho ...	Titulo											Campo			Mask		Tamanho	Dec		Valid	Usado	Tip		F3	CBOX
			aAdd(aHeadAux,{	Capital(StrTran(cCampoAtu, "YY_", "")),	cCampoAtu,		"",			100,			0,		".F.",	".F.",	"C",	"",	""})
		Else
	
			//Se coneguir posicionar no campo
			If SX3->(DbSeek(cCampoAtu))
			
				//Cabeçalho ...	Titulo			Campo		Mask									Tamanho					Dec							Valid	Usado	Tip				F3	CBOX
				aAdd(aHeadAux,{	X3Titulo(),	cCampoAtu,	PesqPict(cAliasPvt  , cCampoAtu),	TamSX3(cCampoAtu)[01],	TamSX3(cCampoAtu)[02],	".F.",	".F.",	SX3->X3_TIPO,	"",	""})
				
				//Se o campo atual for retornar, aumenta o tamanho do retorno
				If cCampoAtu $ cCampoRet
					nTamanRet += TamSX3(cCampoAtu)[01]
				EndIf
			EndIf
		
		EndIf
	Next
	
	//Cabeçalho ...	Titulo		Campo			Mask						Tamanho	Dec		Valid	Usado	Tip		F3	CBOX
	aAdd(aHeadAux,{	"RecNo",	"XX_RECNUM",	"@E 999999999999999999",	18,			0,		".F.",	".F.",	"C",	"",	""})
	
	RestArea(aAreaX3)
Return

/*---------------------------------------------------------------------*
 | Func:  fPopula                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  24/02/2015                                                   |
 | Desc:  Função que popula a tabela auxiliar da MsNewGetDados         |
 | Obs.:  /                                                            |
 *---------------------------------------------------------------------*/

Static Function fPopula()
	aColsAux :={}
	nCampAux := 1

	//Faz a consulta
	cQuery := " SELECT "	+ STR_PULA
	cQuery += "    TOP 100 R_E_C_N_O_ AS RECNUM, "
	For nAtual := 1 To Len(aCampos)
		cCampoAtu := aCampos[nAtual]
		If SubStr(cCampoAtu, 1, 3) == "YY_"
			cQuery += " "+aColsEsp[nCampAux]+" AS "+cCampoAtu+","
			nCampAux++
		ElseIf SubStr(cCampoAtu, 1, 3) != "XX_"
			cQuery += " "+cCampoAtu+","
		EndIf
	Next
	cQuery := SubStr(cQuery, 1, Len(cQuery)-1)	+ STR_PULA
	cQuery += " FROM "	+ STR_PULA
	cQuery += "   "+RetSQLName(cAliasPvt)+" "+cAliasPvt+" "	+ STR_PULA
	cQuery += " WHERE "	+ STR_PULA
	cQuery += "   "+cAliasPvt+".D_E_L_E_T_='' " + STR_PULA
	cQuery += "   "+cFiltro+" " + STR_PULA
	cQuery += "   AND ("
	For nAtual := 1 To Len(aCampos)
		cCampoAtu := aCampos[nAtual]
		If SubStr(cCampoAtu, 1, 3) != "XX_" .And. SubStr(cCampoAtu, 1, 3) != "YY_"
			cQuery += " UPPER("+cCampoAtu+") LIKE '%"+Upper(Alltrim(cGetPesq))+"%' OR"
		EndIf
	Next
	cQuery := SubStr(cQuery, 1, Len(cQuery)-2)
	cQuery += ")"+STR_PULA
	cQuery += " ORDER BY "	+ STR_PULA
	If !Empty(cOrder)
		cQuery += "   "+cOrder
	Else
		cQuery += "   "+cCampoRet
	EndIf
	TCQuery cQuery New Alias "QRY_DAD"
	
	//Percorrendo a estrutura, procurando campos de data
	For nAtual := 1 To Len(aHeadAux)
		//Se for data
		If aHeadAux[nAtual][8] == "D" .And. SubStr(aHeadAux[nAtual][1], 1, 3) != "XX_"
			TCSetField('QRY_DAD', aHeadAux[nAtual][2], 'D')
		EndIf
	Next
	
	//Enquanto tiver dados
	While ! QRY_DAD->(EoF())
		nCampAux := 1
		aAux := {}
		//Percorrendo os campos e adicionando no acols (junto com o recno e com o delet
		For nAtual := 1 To Len(aCampos)
			cCampoAtu := aCampos[nAtual]
			//Se iniciar com XX_
			If SubStr(cCampoAtu, 1, 3) == "XX_"
				aAdd(aAux, &(aColsEsp[nCampAux]))
				nCampAux++
				
			//Senão, adiciona conforme consulta
			Else
				aAdd(aAux, cValToChar( &("QRY_DAD->"+cCampoAtu) ))
			EndIf
		Next
		aAdd(aAux, QRY_DAD->RECNUM)
		aAdd(aAux, .F.)
	
		aAdd(aColsAux, aClone(aAux))
		QRY_DAD->(DbSkip())
	EndDo
	QRY_DAD->(DbCloseArea())
	
	//Se não tiver dados, adiciona linha em branco
	If Len(aColsAux) == 0
		aAux := {}
		//Percorrendo os campos e adicionando no acols (junto com o recno e com o delet
		For nAtual := 1 To Len(aCampos)
			aAdd(aAux, '')
		Next
		aAdd(aAux, 0)
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
 | Data:  24/02/2015                                                   |
 | Desc:  Função de confirmação da rotina                              |
 | Obs.:  /                                                            |
 *---------------------------------------------------------------------*/

Static Function fConfirm()
	Local aAreaX3 := SX3->(GetArea())
	Local cAux := ""
	Local aColsNov := oMsNew:aCols
	Local nLinAtu  := oMsNew:nAt
	
	DbSelectArea("SX3")
	SX3->(DbSetOrder(2)) // Campo
	SX3->(DbGoTop())

	//Percorrendo os campos
	For nAtual := 1 To Len(aHeadAux)
		cCampoAtu := aHeadAux[nAtual][2]
	
		//Se coneguir posicionar no campo
		If SX3->(DbSeek(cCampoAtu))
			//Se o campo atual for retornar, soma com o auxiliar
			If cCampoAtu $ cCampoRet
				cAux += aColsNov[nLinAtu][nAtual]
			EndIf
		EndIf
	Next

	//Setando o retorno conforme auxiliar e finalizando a tela
	lRetorn := .T.
	__cRetorn := cAux
	
	//Se o tamanho for menor, adiciona
	If Len(__cRetorn) < nTamanRet
		__cRetorn += Space(nTamanRet - Len(__cRetorn))
	
	//Senão se for maior, diminui
	ElseIf Len(__cRetorn) > nTamanRet
		__cRetorn := SubStr(__cRetorn, 1, nTamanRet)
	EndIf
	
	oDlgEspe:End()
	RestArea(aAreaX3)
Return

/*---------------------------------------------------------------------*
 | Func:  fLimpar                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  24/02/2015                                                   |
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
 | Data:  24/02/2015                                                   |
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
 | Data:  24/02/2015                                                   |
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

/*---------------------------------------------------------------------*
 | Func:  fVisual                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  24/02/2015                                                   |
 | Desc:  Função de visualizar o registro                              |
 | Obs.:  /                                                            |
 *---------------------------------------------------------------------*/

Static Function fVisual()
	Local cAux := ""
	Local aColsNov := oMsNew:aCols
	Local nLinAtu  := oMsNew:nAt
	Local nPosRec  := aScan(aHeadAux,{|x| AllTrim(Upper(x[2]))=="XX_RECNUM" })
	
	//Visualizando o registro
	(cAliasPvt)->(DbGoTo(aColsNov[nLinAtu][nPosRec]))
	AxVisual(cAliasPvt, aColsNov[nLinAtu][nPosRec], 2)
Return