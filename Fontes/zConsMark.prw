//Bibliotecas
#Include "Protheus.ch"
#Include "TopConn.ch"

//Constantes
#Define STR_PULA		Chr(13)+Chr(10)

/*/{Protheus.doc} zConsMark
Função para consulta genérica com marcação de dados
@author Daniel Atilio
@since 19/02/2015
@version 1.0
	@param cAliasM, Caracter, Alias da tabela consultada
	@param aCamposM, Array, Campos que serão montados na grid de marcação
	@param cFiltroM, Caracter, Filtragem da tela (SQL)
	@param nTamanM, Numérico, Tamanho do campo de retorno
	@param cCheckM, Caracter, Campo que será checado
	@param lEditM, Lógico, Permite editar o retorno
	@param cSepM, Caracter, Caracter de separação do texto
	@param lAllFilM, Lógico, Identifica se são todas as filiais (inclusive de todas as empresas)
	@return lRetorn, retorno se a consulta foi confirmada ou não
	@example
	u_zConsMark("SED", {"ED_CODIGO","ED_DESCRIC"}, " AND ED_FILIAL = '"+xFilial("SED")+"' ", 99, "ED_CODIGO", .F., ";")
	u_zConsMark("SB1", {"B1_COD","B1_DESC","B1_TIPO"}, " AND B1_FILIAL = '"+xFilial("SB1")+"' ", 99, "B1_COD", .F., "#")
	u_zConsMark("SZB", {"ZB_CODIGO","ZB_DESCRI"}, " ", 99, "ZB_CODIGO", .F., ";")
	u_zConsMark("SM0", {}, " ", 99, "XX_CODFIL", .F., ";")
	u_zConsMark("SZA", {"ZA_FILCONT","ZA_CONTRAT","ZA_NOMECLI","ZA_DESCPRO"}, " ", 99, "ZA_CONTRAT", .F., ";")
	@obs O retorno da consulta é pública (__cRetorn) para ser usada em consultas específicas
	Para consulta da SM0, não precisa passar colunas, é tratado diretamente no fonte
/*/
                                                                                                                                                          

User Function zConsMark(cAliasM, aCamposM, cFiltroM, nTamanM, cCheckM, lEditM, cSepM, lAllFilM)
	Local cFilBkp := cFilAnt
	Local aAreaM0 := SM0->(GetArea())
	Local aArea := GetArea()
	Local nTamBtn := 50
	//Defaults
	Default cAliasM 	:= ""
	Default aCamposM 	:= {}
	Default cFiltroM 	:= ""
	Default nTamanM 	:= 99
	Default cCheckM 	:= ""
	Default lEditM 		:= .F.
	Default cSepM 		:= ";"
	Default lAllFilM 	:= .T.
	//Privates
	Private cFiltro 	:= cFiltroM
	Private cAliasPvt 	:= cAliasM
	Private aCampos 	:= aCamposM
	Private nTamanRet 	:= nTamanM
	Private cCampoRet 	:= cCheckM
	Private lAllFil 	:= .T.
	//MsSelect
	Private oMAux
	Private cArqs
	Private cMarca := "OK"
	Private aStrut := {}
	Private aHeadRegs := {}
	Private cAliasTmp:="CHK_"+RetCodUsr()
	//Tamanho da janela
	Private nJanLarg := 0800
	Private nJanAltu := 0500
	//Gets e Dialog
	Private oDlgMark
	Private oGetPesq, cGetPesq := Space(100)
	Private oGetReto, cGetReto := Space(nTamanM)
	//Retorno
	Private lRetorn := .F.
	Public  __cRetorn := Space(nTamanM)
	
	//Se tiver o alias em branco ou não tiver campos
	If Empty(cAliasM) .Or. (Len(aCamposM) <= 0 .And. cAliasM != "SM0") .Or. Empty(cCheckM)
		MsgStop("Alias em branco e/ou Sem campos para marcação!", "Atenção")
		Return lRetorn
	EndIf
	
	//Criando a estrutura para a MsSelect
	fCriaMsSel()
	
	//Criando a janela
	DEFINE MSDIALOG oDlgMark TITLE "Consulta de Dados" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
		//Pesquisar
		@ 003, 003 GROUP oGrpPesqui TO 025, (nJanLarg/2)-3 PROMPT "Pesquisar: "	OF oDlgMark COLOR 0, 16777215 PIXEL
			@ 010, 006 MSGET oGetPesq VAR cGetPesq SIZE (nJanLarg/2)-12, 010 OF oDlgMark COLORS 0, 16777215  VALID (fVldPesq())      PIXEL
		
		//Dados
		@ 028, 003 GROUP oGrpDados TO (nJanAltu/2)-28, (nJanLarg/2)-3 PROMPT "Dados: "	OF oDlgMark COLOR 0, 16777215 PIXEL
			oMAux := MsSelect():New( cAliasTmp, "XX_OK",, aHeadRegs,, cMarca, { 035, 006, (nJanAltu/2)-28-028, (nJanLarg/2)-6 } ,,, )
			oMAux:bAval := { || ( fGetMkA( cMarca ), oMAux:oBrowse:Refresh() ) }
			oMAux:oBrowse:lHasMark := .T.
			oMAux:oBrowse:lCanAllMark := .F.
			@ (nJanAltu/2)-28-025, 006 SAY oSayReto PROMPT "Retorno:"     SIZE 040, 007 OF oDlgMark COLORS RGB(0,0,0) PIXEL
			@ (nJanAltu/2)-28-015, 006 MSGET oGetReto VAR cGetReto SIZE (nJanLarg/2)-12, 010 OF oDlgMark COLORS 0, 16777215      PIXEL
		
			//Populando os dados da MsSelect
			fPopula()
		
		//Ações
		@ (nJanAltu/2)-25, 003 GROUP oGrpAcoes TO (nJanAltu/2)-3, (nJanLarg/2)-3 PROMPT "Ações: "	OF oDlgMark COLOR 0, 16777215 PIXEL
			@ (nJanAltu/2)-19, (nJanLarg/2)-((nTamBtn*1)+06) BUTTON oBtnConf PROMPT "Confirmar" SIZE nTamBtn, 013 OF oDlgMark ACTION(fConfirm())     PIXEL
			@ (nJanAltu/2)-19, (nJanLarg/2)-((nTamBtn*2)+09) BUTTON oBtnLimp PROMPT "Limpar" SIZE nTamBtn, 013 OF oDlgMark ACTION(fLimpar())     PIXEL
			@ (nJanAltu/2)-19, (nJanLarg/2)-((nTamBtn*3)+12) BUTTON oBtnCanc PROMPT "Cancelar" SIZE nTamBtn, 013 OF oDlgMark ACTION(fCancela())     PIXEL
			
		//Se não for editável, desabilita o get de retorno
		If ! lEditM
			oGetReto:lReadOnly := .T.
		EndIf
		
		oMAux:oBrowse:SetFocus()
	//Ativando a janela
	ACTIVATE MSDIALOG oDlgMark CENTERED
	
	cFilAnt := cFilBkp
	RestArea(aArea)
	RestArea(aAreaM0)
Return lRetorn

/*---------------------------------------------------------------------*
 | Func:  fCriaMsSel                                                   |
 | Autor: Daniel Atilio                                                |
 | Data:  19/02/2015                                                   |
 | Desc:  Função para criar a estrutura da MsSelect                    |
 | Obs.:  /                                                            |
 *---------------------------------------------------------------------*/

Static Function fCriaMsSel()
	Local aAreaX3 := SX3->(GetArea())

	//Zerando o cabeçalho e a estrutura
	aHeadRegs := {}
	aStrut := {}
	
	//Adicionando coluna de OK
	//					Campo			Titulo		Mascara
	aAdd( aHeadRegs, {	"XX_OK",	,	" ",		"" } )
	
	//				Campo		Tipo	Tamanho		Decimal
	aAdd( aStrut, {	"XX_OK",	"C",	002,		000} )
	
	DbSelectArea("SX3")
	SX3->(DbSetOrder(2)) // Campo
	SX3->(DbGoTop())
	
	//Se for consulta de filiais
	If cAliasPvt == "SM0"
		//						Campo				Titulo			Mascara
		aAdd( aHeadRegs, {	"XX_CODFIL", 	,	"Código",		"@!" } )
		aAdd( aHeadRegs, {	"XX_DESCRI", 	,	"Descrição",	"@!" } )
		aAdd( aHeadRegs, {	"XX_CIDENT", 	,	"Cidade",		"@!" } )
		aAdd( aHeadRegs, {	"XX_ESTENT", 	,	"Estado",		"@!" } )
		aAdd( aHeadRegs, {	"XX_CGC", 		,	"CNPJ",		"@R 99.999.999/9999-99" } )
		
		//					Campo			Tipo	Tamanho		Decimal	
		aAdd( aStrut, {	"XX_CODFIL",	"C",	Len(cFilAnt),	0} )
		aAdd( aStrut, {	"XX_DESCRI",	"C",	30,				0} )
		aAdd( aStrut, {	"XX_CIDENT",	"C",	30,				0} )
		aAdd( aStrut, {	"XX_ESTENT",	"C",	2,				0} )
		aAdd( aStrut, {	"XX_CGC",		"C",	16,				0} )
	
	Else
		//Percorrendo os campos
		For nAtual := 1 To Len(aCampos)
			cCampoAtu := aCampos[nAtual]
		
			//Se coneguir posicionar no campo
			If SX3->(DbSeek(cCampoAtu))
				//					Campo			Titulo		Mascara
				aAdd( aHeadRegs, {	cCampoAtu, 	,	X3Titulo(),	PesqPict(cAliasPvt  , cCampoAtu) } )
				
				//				Campo		Tipo			Tamanho					Decimal	
				aAdd( aStrut, {	cCampoAtu,	SX3->X3_TIPO,	TamSX3(cCampoAtu)[01],	TamSX3(cCampoAtu)[02]} )
			EndIf
		Next
		
		//						Campo				Titulo			Mascara
		aAdd( aHeadRegs, {	"XX_RECNUM", 	,	"RecNo",		"" } )
		
		//					Campo			Tipo	Tamanho		Decimal	
		aAdd( aStrut, {	"XX_RECNUM",	"C",	18,				0} )
		
	EndIf

	//Excluindo dados da tabela temporária, se tiver aberta, fecha a tabela
	If Select(cAliasTmp)>0
		(cAliasTmp)->(DbCloseArea())
	EndIf
	fErase(cAliasTmp+".DBF")
	
	//Criando tabela temporária
	cArqs:= CriaTrab( aStrut, .T. )             
	dbUseArea( .T.,"DBFCDX", cArqs, cAliasTmp, .T., .F. )
	
	RestArea(aAreaX3)
Return

/*---------------------------------------------------------------------*
 | Func:  fPopula                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  19/02/2015                                                   |
 | Desc:  Função que popula a tabela auxiliar da MsSelect              |
 | Obs.:  /                                                            |
 *---------------------------------------------------------------------*/

Static Function fPopula()
	//Excluindo dados da tabela temporária, se tiver aberta, fecha a tabela
	If Select(cAliasTmp)>0
		(cAliasTmp)->(DbCloseArea())
	EndIf
	fErase(cAliasTmp+".DBF")
	
	//Criando tabela temporária
	cArqs:= CriaTrab( aStrut, .T. )             
	dbUseArea( .T.,"DBFCDX", cArqs, cAliasTmp, .T., .F. )
	
	//Se for consulta de filial
	If cAliasPvt == "SM0"
		aAreaM0 := SM0->(GetArea())
		cFilBk  := cFilAnt
		cEmpBk  := cEmpAnt
		aUnitNeg:= Iif(lAllFil, FWAllGrpCompany(), {SM0->M0_CODIGO})
		aEmpAux := Iif(lAllFil, FWAllCompany(), {cEmpAnt})
	
		//Percorrendo os grupos de empresa
		For nGrp := 1 To Len(aUnitNeg)
			cUnidNeg := aUnitNeg[nGrp]
			
			//Percorrendo as empresas
			For nEmp := 1 To Len(aEmpAux)
				cEmpAnt := aEmpAux[nEmp]
				aFilAux := FWAllFilial(cEmpAnt)
				//Percorrendo as filiais listadas
				For nAtu := 1 To Len(aFilAux)
					//Se o tamanho da filial for maior, atualiza
					If Len(cFilAnt) > Len(aFilAux[nAtu])
						cFilAnt := cEmpAnt + aFilAux[nAtu]
					Else
						cFilAnt := aFilAux[nAtu]
					EndIf 
					
					//Posiciono na empresa (para poder pegar o ident)
					SM0->(DbGoTop())
					SM0->(DbSeek(cUnidNeg+cFilAnt)) //é utilizado o 01, por grupo de empresas, caso necessário rotina pode ser adaptada
				
					//Se tiver pesquisa
					If !Empty(cGetPesq)
						//Se não bater a pesquisa, pula o registro
						If !( 	Alltrim(Upper(cGetPesq)) $ Upper(cFilAnt) .Or.;
								Alltrim(Upper(cGetPesq)) $ Upper(SM0->M0_CIDENT) .Or.;
								Alltrim(Upper(cGetPesq)) $ Upper(SM0->M0_ESTENT) .Or.;
								Alltrim(Upper(cGetPesq)) $ Upper(SM0->M0_CGC))
							Loop
						EndIf
					EndIf
					
					cOk := Space(Len(cMarca))
					//Se já existir no retorno, será Ok
					If Alltrim(cFilAnt) $ cGetReto
						cOk := cMarca
					EndIf
				
					//Gravando registro
					RecLock(cAliasTmp, .T.)
						XX_OK		:= cOK
						XX_CODFIL	:= cFilAnt
						XX_DESCRI	:= FWFilialName(cUnidNeg, cFilAnt)
						XX_CIDENT	:= SM0->M0_CIDENT
						XX_ESTENT	:= SM0->M0_ESTENT
						XX_CGC		:= SM0->M0_CGC
					(cAliasTmp)->(MsUnlock())
				Next
			Next
		Next
		
		//Voltando backups
		cEmpAnt := cEmpBk
		cFilAnt := cFilBk
		RestArea(aAreaM0)
	
	Else
		//Faz a consulta
		cQuery := " SELECT "	+ STR_PULA
		cQuery += "    TOP 100 "
		For nAtual := 1 To Len(aCampos)
			cCampoAtu := aCampos[nAtual]
			cQuery += " "+cCampoAtu+","
		Next
		cQuery := SubStr(cQuery, 1, Len(cQuery)-1)	+ STR_PULA
		cQuery += " ,"+cAliasPvt+".R_E_C_N_O_ AS XX_RECNUM "	+ STR_PULA
		cQuery += " FROM "	+ STR_PULA
		cQuery += "   "+RetSQLName(cAliasPvt)+" "+cAliasPvt+" "	+ STR_PULA
		cQuery += " WHERE "	+ STR_PULA
		cQuery += "   "+cAliasPvt+".D_E_L_E_T_='' " + STR_PULA
		cQuery += "   "+cFiltro+" " + STR_PULA
		cQuery += "   AND ("
		For nAtual := 1 To Len(aCampos)
			cCampoAtu := aCampos[nAtual]
			cQuery += " UPPER("+cCampoAtu+") LIKE '%"+Upper(Alltrim(cGetPesq))+"%' OR"
		Next
		cQuery := SubStr(cQuery, 1, Len(cQuery)-2)
		cQuery += ")"+STR_PULA
		cQuery += " ORDER BY "	+ STR_PULA
		cQuery += "   "+cCampoRet
		TCQuery cQuery New Alias "QRY_DAD"
		
		//Percorrendo a estrutura, procurando campos de data
		For nAtual := 1 To Len(aStrut)
			//Se for data
			If aStrut[nAtual][2] == "D"
				TCSetField('QRY_DAD', aStrut[nAtual][1], 'D')
			EndIf
		Next
		
		//Enquanto tiver dados
		While ! QRY_DAD->(EoF())
			cOk := Space(Len(cMarca))
			//Se já existir no retorno, será Ok
			If Alltrim(&("QRY_DAD->"+cCampoRet)) $ cGetReto
				cOk := cMarca
			EndIf
		
			//Gravando registro
			RecLock(cAliasTmp, .T.)
				XX_OK := cOK
				//Percorrendo os campos
				For nAtual := 1 To Len(aCampos)
					cCampoAtu := aCampos[nAtual]
					&(cCampoAtu+" := QRY_DAD->"+cCampoAtu)
				Next
				&("XX_RECNUM := cValToChar(QRY_DAD->XX_RECNUM)")
			(cAliasTmp)->(MsUnlock())
		
			QRY_DAD->(DbSkip())
		EndDo
		QRY_DAD->(DbCloseArea())
	EndIf
	
	//Posiciona no topo e atualiza grid
	(cAliasTmp)->(DbGoTop())
	oMAux:oBrowse:Refresh()
Return

/*---------------------------------------------------------------------*
 | Func:  fConfirm                                                     |
 | Autor: Daniel Atilio                                                |
 | Data:  19/02/2015                                                   |
 | Desc:  Função de confirmação da rotina                              |
 | Obs.:  /                                                            |
 *---------------------------------------------------------------------*/

Static Function fConfirm()
	//Setando o retorno conforme get e finalizando a tela
	lRetorn := .T.
	__cRetorn := cGetReto
	
	//Se o tamanho for menor, adiciona
	If Len(__cRetorn) < nTamanRet
		__cRetorn += Space(nTamanRet - Len(__cRetorn))
	
	//Senão se for maior, diminui
	ElseIf Len(__cRetorn) > nTamanRet
		__cRetorn := SubStr(__cRetorn, 1, nTamanRet)
	EndIf
	
	oDlgMark:End()
Return

/*---------------------------------------------------------------------*
 | Func:  fLimpar                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  19/02/2015                                                   |
 | Desc:  Função que limpa os dados da rotina                          |
 | Obs.:  /                                                            |
 *---------------------------------------------------------------------*/

Static Function fLimpar()
	//Zerando gets
	cGetPesq := Space(100)
	cGetReto := Space(nTamanRet)
	oGetPesq:Refresh()
	oGetReto:Refresh()

	//Atualiza grid
	fPopula()
	
	//Setando o foco na pesquisa
	oGetPesq:SetFocus()
Return

/*---------------------------------------------------------------------*
 | Func:  fCancela                                                     |
 | Autor: Daniel Atilio                                                |
 | Data:  19/02/2015                                                   |
 | Desc:  Função de cancelamento da rotina                             |
 | Obs.:  /                                                            |
 *---------------------------------------------------------------------*/

Static Function fCancela()
	//Setando o retorno em branco e finalizando a tela
	lRetorn := .F.
	__cRetorn := Space(nTamanRet)
	oDlgMark:End()
Return

/*---------------------------------------------------------------------*
 | Func:  fVldPesq                                                     |
 | Autor: Daniel Atilio                                                |
 | Data:  19/02/2015                                                   |
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
 | Func:  fGetMkA                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  19/02/2015                                                   |
 | Desc:  Função que marca o registro                                  |
 | Obs.:  /                                                            |
 *---------------------------------------------------------------------*/

Static Function fGetMkA(cMarca)
	Local lChecado:= .F.
	Local lFalhou := .F.
	
	//Verificando se o registro foi checado
	DbSelectArea(cAliasTmp)
	lChecado:=XX_OK <> cMarca
	cChave := Alltrim(&(cAliasTmp+"->"+cCampoRet))+";"
	
	//Se for checado
	If lChecado
		//Se o tamanho do retorno +chave for maior que o retorno
		If Len(Alltrim(cGetReto) + cChave) > nTamanRet
			MsgAlert("Tamanho de Retorno Excedido!", "Atenção")
			lFalhou := .T.
		
		//Atualiza chave
		Else
			cGetReto := Alltrim(cGetReto)+cChave
		EndIf
	
	//Senão retira do retorno
	Else
		cGetReto := StrTran(cGetReto, cChave, '')
	EndIf
	cGetReto := cGetReto + Space(nTamanRet - Len(cGetReto))
	
	//Se não houve falhas
	If !lFalhou
		//Gravando a marca
		RecLock( cAliasTmp, .F. )
			XX_OK := IIF( lChecado, cMarca, "" )
		&(cAliasTmp)->(MsUnlock())
	EndIf
	
	oGetReto:Refresh()
	oMAux:oBrowse:Refresh()
Return