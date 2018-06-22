//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zParComma
Função para edição de um parâmetro (SX6) que tenha separadores como ponto e vírgula
@author Atilio
@since 25/05/2018
@version 1.0
@param cParametro, characters, Nome do Parâmetro
@param cSeparador, characters, Qual separador é utilizado
@type function
@example
	u_zParComma("MV_ALIQICM", "/")
/*/

User Function zParComma(cParametro, cSeparador)
	Local aArea        := GetArea()
	Local aDados       := ""
	Local nAtual       := 0
	Local nTamBtn      := 40
	Local oSayCont
	Local oGrpDados
	Local oGrpAcoes
	Local oBtnConf
	Local oBtnCanc
	Private lOk        := .F.
	Private cContNov   := ""
	Private oDlgPvt
	Private oGetCont
	Private cGetCont := ""
	Private oMsGetPar
	Private aHeadPar := {}
	Private aColsPar := {}
	Private nJanLarg := 0500
	Private nJanAltu := 0400
	//Parâmetros que vem pela função
	Default cParametro := ""
	Default cSeparador := ""
	
	//Se tiver parametro e separador
	If ! Empty(cParametro) .And. ! Empty(cSeparador)
		
		//Pega o conteúdo do parâmetro
		cGetCont := GetMV(cParametro)
		
		//Busca todos os dados quebrando pelo separador
		aDados := StrTokArr(cGetCont, cSeparador)
		
		//Monta o aHeader
		//Cabeçalho ...  Titulo       Campo          Mask    Tamanho   Dec   Valid  Usado  Tip  F3  CBOX
		aAdd(aHeadPar, { "Conteúdo",  "XX_CONTEUD",  "",     10,       0,    ".T.", ".T.", "C", "", ""})
		
		//Percorre as linhas, e adiciona no aCols
		For nAtual := 1 To Len(aDados)
			aAdd(aColsPar, {;
				aDados[nAtual],;
				.F.;
			})
		Next
		
		//Monta a tela
		DEFINE MSDIALOG oDlgPvt TITLE "Alteração do Parâmetro " + cParametro FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
			@ 008, 003 SAY   oSayCont PROMPT "Origem:" SIZE 030, 007 OF oDlgPvt PIXEL
			@ 005, 038 MSGET oGetCont  VAR cGetCont SIZE 160, 010 OF oDlgPvt PIXEL
			oGetCont:lReadOnly := .T.
			
			//Dados
			@ 020, 003 GROUP oGrpDados TO (nJanAltu/2)-28, (nJanLarg/2)-3 PROMPT "Dados: "	OF oDlgPvt COLOR 0, 16777215 PIXEL
				oMsGetPar := MsNewGetDados():New(;
					026,;                                        //nTop
					006,;                                        //nLeft
					(nJanAltu/2) - 31,;                          //nBottom
					(nJanLarg/2) - 6,;                           //nRight
					GD_INSERT + GD_DELETE + GD_UPDATE,;          //nStyle
					"AllwaysTrue()",;                            //cLinhaOk
					,;                                           //cTudoOk
					"",;                                         //cIniCpos
					{"XX_CONTEUD"},;                             //aAlter
					,;                                           //nFreeze
					999,;                                        //nMax
					,;                                           //cFieldOK
					,;                                           //cSuperDel
					,;                                           //cDelOk
					oDlgPvt,;                                    //oWnd
					aHeadPar,;                                   //aHeader
					aColsPar)                                    //aCols                                    
			
			//Ações
			@ (nJanAltu/2)-25, 003 GROUP oGrpAcoes TO (nJanAltu/2)-3, (nJanLarg/2)-3 PROMPT "Ações: "	OF oDlgPvt COLOR 0, 16777215 PIXEL
				@ (nJanAltu/2)-19, (nJanLarg/2)-((nTamBtn*1)+06) BUTTON oBtnConf PROMPT "Confirmar" SIZE nTamBtn, 013 OF oDlgPvt ACTION(fValidConf(cSeparador))     PIXEL
				@ (nJanAltu/2)-19, (nJanLarg/2)-((nTamBtn*2)+09) BUTTON oBtnCanc PROMPT "Cancelar"  SIZE nTamBtn, 013 OF oDlgPvt ACTION(oDlgPvt:End())    PIXEL
			
			oMsGetPar:oBrowse:SetFocus()
			
		//Ativando a janela
		ACTIVATE MSDIALOG oDlgPvt CENTERED
		
		//Se a rotina foi confirmada, atualiza o parâmetro
		If lOk
			PutMV(cParametro, cContNov)
		EndIf
	EndIf
	
	RestArea(aArea)
Return

/*---------------------------------------------------------*
 | Função: fValidConf                                      |
 | Descr.: Função que valida os conteúdos digitados        |
 *---------------------------------------------------------*/

Static Function fValidConf(cSeparador)
	Local lRet     := .T.
	Local nPosCont := 1
	Local nPosDel  := 2
	Local aDadAux  := oMsGetPar:aCols
	Local nAtual   := 0
	Local cMsg     := ""
	
	//Percorrendo todos os dados, e preenchendo o conteúdo novo
	cContNov := ""
	For nAtual := 1 To Len(aDadAux)
		
		//Se não estiver deletada a linha
		If ! aDadAux[nAtual][nPosDel]
			cContNov += Alltrim(aDadAux[nAtual][nPosCont]) + cSeparador
		EndIf
	Next
	
	//Se o conteúdo passar de 250 caracteres, mostra aviso ao usuário
	If Len(cContNov) > 250
		cMsg := "Conteúdo do parâmetro <b>excedeu 250</b> caracteres!<br><br>"
		cMsg += "<b>Conteúdo Novo:</b> '" + cContNov + "' <br><br>"
		cMsg += "<b>Conteúdo Máximo:</b> '" + SubStr(cContNov, 1, 250) + "'"
		
		MsgStop(cMsg, "Atenção")
		lRet := .F.
	EndIf
	
	//Se o retorno estiver ok, finaliza a rotina
	If lRet
		lOk := .T.
		oDlgPvt:End()
	EndIf
	
Return lRet