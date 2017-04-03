//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zVldGrid
Executa as validações da Grid
@author Atilio
@since 18/02/2017
@version 1.0
@type function
/*/

User Function zVldGrid()
	Local aArea      := GetArea()
	Local lOk        := .T.
	Local aColsAux   := aCols
	Local aHeaderAux := aHeader
	Local nLinBkp    := n
	Local nAtual     := 0
	Local nColAtu    := 0
	Local cCampoAtu  := 0
	Local cVldPad    := ""
	Local cVldUsr    := ""
	Local cMsgAux    := ""
	Local cVarBkp    := __ReadVar
	
	//Percorre as linhas
	For nAtual := 1 To Len(aColsAux)
		n := nAtual
		
		//Percorre o cabeçalho da linha atual
		For nColAtu := 1 To Len(aHeaderAux)
			cCampoAtu := aHeaderAux[nColAtu][2]
			__ReadVar := cCampoAtu
			cVldPad := GetSX3Cache(cCampoAtu, 'X3_VALID')
			cVldUsr := GetSX3Cache(cCampoAtu, 'X3_VLDUSR')
			
			//Se tiver validação padrão, executa
			If !Empty(cVldPad)
				lOk := &(cVldPad)
				If !lOk
					cMsg += "- Campo "+cCampoAtu+CRLF
				EndIf
			EndIf
			
			//Se tiver ok e tiver validação de usuário, executa
			If lOk .And. !Empty(cVldUsr)
				lOk := &(cVldUsr)
				If !lOk
					cMsg += "- Campo "+cCampoAtu+CRLF
				EndIf
			EndIf
		Next
	Next
	
	//Caso tenha mensagem de erro nos campos, mostra ao usuário
	If !Empty(cMsg)
		Aviso("Atenção", "Erros nos campos: "+CRLF+cMsg, {"OK"}, 2)
	EndIf
	
	__ReadVar := cVarBkp
	n := nLinBkp
	RestArea(aArea)
Return lOk