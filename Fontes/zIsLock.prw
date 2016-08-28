//Bibliotecas
#Include "Protheus.ch"

//Constantes
#Define POS_ALIAS 001
#Define POS_INDIC 002
#Define POS_RECNO 003

/*/{Protheus.doc} zIsLock
Função que verifica se um registro esta travado na memória (com RecLock por exemplo)
@type function
@author Atilio
@since 03/08/2016
@version 1.0
	@param cAliasLock, character, Alias da Tabela (se não for passado nada, será utilizado a última em memória)
	@param nRegLock, numérico, RecNo pesquisado (se não for passado nada, será utilizado o último em memória)
	@return lTravado, Retorna se o registro esta travado (.T.) ou não (.F.) na memória
	@example
	DbSelectArea('SB1')
	lLock := u_zIsLock()
	
	//ou
	lLock := SB1->(u_zIsLock())
	
	//ou
	lLock := u_zIsLock('SB1', SB1->(RecNo()))
/*/

User Function zIsLock(cAliasLock, nRegLock)
	Local aArea        := GetArea()
	Local lTravado     := .F.
	Local aTravas      := {}
	Default cAliasLock := aArea[POS_ALIAS]
	Default nRegLock   := 0
	
	//Se tiver zerado o RecNo
	If nRegLock == 0
		//Se for o Mesmo Alias do GetArea()
		If cAliasLock == aArea[POS_ALIAS]
			nRegLock := aArea[POS_RECNO]
		
		//Senão, abre a tabela e pega o RecNo atual
		Else
			DbSelectArea(cAliasLock)
			nRegLock := (cAliasLock)->(RecNo())
		EndIf
	EndIf
	
	//Pegando os registros travados em memória
	aTravas := (cAliasLock)->(DBRLockList())
	
	//Se encontrar o recno nos travados na memória, o registro está travado
	If aScan(aTravas,{|x| x == nRegLock }) > 0
		lTravado := .T.
	EndIf
	
	RestArea(aArea)
Return lTravado