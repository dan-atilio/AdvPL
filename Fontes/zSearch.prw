//Bibliotecas
#Include "Protheus.ch"

//Posições da Grid
#Define POS_ITE    0001 
#Define POS_VAR    0002
#Define POS_ABA    0003
#Define POS_DES    0004

/*/{Protheus.doc} zSearch
Função para pesquisar campos de uma tela de cadastro
@author Atilio
@since 01/12/2017
@version 1.0
@type function
@obs Inicializar ele em um ponto de entrada, por exemplo, no ChkExec ou AfterLogin:

	...
	User Function AfterLogin()
		SetKey(K_CTRL_L, { || u_zSearch() })    //Ctrl + L
	Return
	...
	
	Essa rotina foi testada no cadastro de TES - MATA080
/*/

User Function zSearch()
	Local aArea        := GetArea()
	Local nAtual       := 0
	Local nAbaAux      := 0
	Local cAbaAux      := ""
	//Variáveis de controle
	Private nAtuPvt    := 0
	Private nAbaPvt    := 0
	Private oPai       := GetWndDefault()
	Private aControles := oPai:aControls
	Private cAbaEsc    := ""
	Private cTipoAba   := ""
	//Grid
	Private aDadosOrig := {}
	Private oMsObj
	Private aHeadObj   := {}
	Private aColsObj   := {}
	//Janela
	Private oDlgPesq
	Private nJanLarg   := 500
	Private nJanAltu   := 300
	//Objetos da Janela
	Private oGrpPesq
	Private oSayPesq
	Private oGetPesq
	Private cGetPesq   := Space(100)
	Private oGetAux
	Private cGetAux    := ""
	Private oBtnConf
	Private oBtnCanc
	
	//Percorrendo os objetos criados da tela
	For nAtual := 1 To Len(aControles)
		nAtuPvt := nAtual
		
		//Se tiver variável e descrição
		If Type("aControles[nAtuPvt]:cReadVar") != "U" .And. Type("aControles[nAtuPvt]:cToolTip") != "U"
			//Somente se tiver conteúdo
			If ! Empty(aControles[nAtuPvt]:cReadVar) .And. ! Empty(aControles[nAtuPvt]:cToolTip) .And. 'M->' $ Upper(aControles[nAtuPvt]:cReadVar)
				cAbaAux := GetSx3Cache(StrTran(Upper(aControles[nAtuPvt]:cReadVar), 'M->', ''), "X3_FOLDER")
				
				aAdd(aDadosOrig, {	nAtual,;                                                                               //ID
									aControles[nAtual]:cReadVar,;                                                          //Variável
									cAbaAux,;                                                                              //Aba
									GetSx3Cache(StrTran(Upper(aControles[nAtuPvt]:cReadVar), 'M->', ''), "X3_TITULO"),;    //Descrição
									.F.})                                                                                  //Excluído?
				
				//Somente se houver aba
				If cAbaAux != Nil
					cTipoAba += Iif(" " $ cTipoAba, "", Iif(cAbaAux $ cTipoAba, "", cAbaAux))
				EndIf
			EndIf
		EndIf
	Next
	aColsObj := aClone(aDadosOrig)
	
	//Percorrendo os objetos criados da tela, procurando por abas
	For nAtual := 1 To Len(aControles)
		nAtuPvt := nAtual
		
		//Se tiver aba, guarda a posição dela
		If Type("aControles[nAtuPvt]:aDialogs") == 'A'
			//Somente se o tamanho dela for maior que a variável encontrada
			If Len(aControles[nAtuPvt]:aDialogs) >= Len(cTipoAba)
				nAbaPvt := nAtual
			EndIf
		EndIf
	Next
	
	//Se tiver objetos, monta a tela
	If Len(aDadosOrig) > 0
		//Cabeçalho ... Titulo       Campo      Mask         Tamanho     Dec    Valid   Usado  Tip  F3  CBOX
		aAdd(aHeadObj, {"Item",      "XX_ITEM", "@E 9999",   0004,       0000,  ".F.",  ".F.", "N", "", ""})
		aAdd(aHeadObj, {"Variável",  "XX_VAR",  "",          0020,       0000,  ".F.",  ".F.", "C", "", ""})
		aAdd(aHeadObj, {"Nº Aba",    "XX_ABA",  "",          0001,       0000,  ".F.",  ".F.", "C", "", ""})
		aAdd(aHeadObj, {"Título",    "XX_DESC", "",          0020,       0000,  ".F.",  ".F.", "C", "", ""})
		
		//Criando a janela
		DEFINE MSDIALOG oDlgPesq TITLE "Pesquisar" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
		
			//Título do Grupo
			@ 003, 003 GROUP oGrpPesq TO (nJanAltu/2)-1, (nJanLarg/2)-1 PROMPT "zSearch - Pesquisa de Campos: " OF oDlgPesq COLOR 0, 16777215 PIXEL
			
				//Campo para pesquisar
				@ 016, 006   SAY   oSayPesq PROMPT "Pesquisar: " SIZE 030,             012 OF oDlgPesq PIXEL
				@ 013, 036   MSGET oGetPesq VAR	   cGetPesq	     SIZE (nJanLarg/2)-42, 012 OF oDlgPesq COLORS 0, 16777215 VALID (fVldPesq()) PIXEL
			
				//Dados dos Objetos encontrados
				oMsObj := MsNewGetDados():New(	030,;                    //nTop
												006,;                    //nLeft
												(nJanAltu/2)-23,;        //nBottom
												(nJanLarg/2)-4,;         //nRight
												0,;                      //nStyle
												"",;                     //cLinhaOk
												,;                       //cTudoOk
												"",;                     //cIniCpos
												{},;                     //aAlter
												,;                       //nFreeze
												99999,;                  //nMax
												,;                       //cFieldOK
												,;                       //cSuperDel
												,;                       //cDelOk
												oDlgPesq,;               //oWnd
												aHeadObj,;               //aHeader
												aColsObj)                //aCols
				oMsObj:lActive := .F.
				oMsObj:bChange := {|| fAtuAux()}
				oMsObj:oBrowse:blDblClick := {|| fConfirma() }
				
				//Criando get invisível que terá dados do registro posicionado
				@ (nJanAltu / 2) - 022, 005 MSGET oGetAux VAR cGetAux      SIZE 200, 18  NO BORDER  OF oDlgPesq PIXEL
				oGetAux:setCSS("QLineEdit{color:#FF0000; background-color:#FEFEFE;}")
				oGetAux:lActive := .F.
				
				//Botões
				@ (nJanAltu/2)-18, (nJanLarg/2)-((0042*1)+6) BUTTON oBtnConf PROMPT "Confirmar" SIZE 040, 013 OF oDlgPesq ACTION(fConfirma())     PIXEL
				@ (nJanAltu/2)-18, (nJanLarg/2)-((0042*2)+6) BUTTON oBtnCanc PROMPT "Cancelar"  SIZE 040, 013 OF oDlgPesq ACTION(oDlgPesq:End())  PIXEL
				
				//Colocando o foco na pesquisa
				oGetPesq:SetFocus()
		ACTIVATE MSDIALOG oDlgPesq CENTERED
	EndIf
	
	//Posiciona no campo
	If nAtuPvt != 0
		//Se tiver abas
		If nAbaPvt != 0
			nAbaAux := 0
			
			//Se a aba estiver em branco, será a última aba
			If Empty(cAbaEsc)
				nAbaAux := Len(aControles[nAbaPvt]:aDialogs)
				
			//Se for numérico, posicionará corretamente
			ElseIf cAbaEsc $ ("0,1,2,3,4,5,6,7,8,9")
				nAbaAux := Val(cAbaEsc)
			
			//Se for letra, converte para número e posiciona corretamente
			Else
				nAbaAux := (Asc(Upper(cAbaEsc)) - 64) + 9
			EndIf
			
			//Tratativa para não colocar em aba que não deve
			If nAbaAux > Len(aControles[nAbaPvt]:aDialogs)
				nAbaAux := Len(aControles[nAbaPvt]:aDialogs)
			EndIf
			
			aControles[nAbaPvt]:SetOption(nAbaAux)
			aControles[nAbaPvt]:Refresh()
		EndIf
		
		//Coloca o foco no campo
		aControles[nAtuPvt]:SetFocus()
	EndIf
	
	RestArea(aArea)
Return

/*---------------------------------------------------------------------*
 | Func:  fVldPesq                                                     |
 | Desc:  Função que filtra a pesquisa na grid                         |
 *---------------------------------------------------------------------*/

Static Function fVldPesq()
	Local lRet      := .T.
	Local aDadosAux := {}
	Local nAtual    := 0
	Local cFiltro   := Alltrim(FWNoAccent(Upper(cGetPesq)))
	
	//Caso não tenha filtro
	If Empty(cFiltro)
		aDadosAux := aClone(aDadosOrig)
	Else
		//Percorre os dados originais
		For nAtual := 1 To Len(aDadosOrig)
			If ! Empty(aDadosOrig[nAtual][POS_VAR]) .And. ! Empty(aDadosOrig[nAtual][POS_DES])
				If cFiltro $ FWNoAccent(Upper(aDadosOrig[nAtual][POS_VAR])) .Or. cFiltro $ FWNoAccent(Upper(aDadosOrig[nAtual][POS_DES]))
					aAdd(aDadosAux, aClone(aDadosOrig[nAtual]))
				EndIf
			EndIf
		Next
	EndIf
	
	//Se não tiver dados
	If Len(aDadosAux) == 0
		aAdd(aDadosAux, {	0,;        //ID
							"",;       //Variável
							"",;       //Aba
							"",;       //Descrição
							.F.}) 
	EndIf
	
	//Seta o novo array filtrado
	oMsObj:SetArray(aDadosAux)
	oMsObj:Refresh()
	fAtuAux()
Return lRet

/*---------------------------------------------------------------------*
 | Func:  fConfirma                                                    |
 | Desc:  Função que confirma para posicionar no campo pesquisado      |
 *---------------------------------------------------------------------*/

Static Function fConfirma()
	Local aColsAux := oMsObj:aCols
	Local nLinAtu  := oMsObj:nAt
	
	//Pegando o item atual
	nAtuPvt := 0
	nAtuPvt := aColsAux[nLinAtu][POS_ITE]
	cAbaEsc := ""
	cAbaEsc := aColsAux[nLinAtu][POS_ABA]
	
	//Fecha a tela
	oDlgPesq:End()
Return

/*---------------------------------------------------------------------*
 | Func:  fAtuAux                                                      |
 | Desc:  Função que atualiza a descrição                              |
 *---------------------------------------------------------------------*/

Static Function fAtuAux()
	Local aColsAux := oMsObj:aCols
	Local nLinAtu  := oMsObj:nAt
	
	//Atualiza o texto auxiliar
	cGetAux := Alltrim(aColsAux[nLinAtu][POS_DES])
	oGetAux:Refresh()
Return