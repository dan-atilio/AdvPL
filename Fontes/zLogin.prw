//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zLogin
Função para montar a tela de login simplificada
@type function
@author Atilio
@since 17/09/2015
@version 1.0
	@param cUsrLog, Caracter, Usuário para o login (ex.: "admin")
	@param cPswLog, Caracter, Senha para o login (ex.: "123")
	@return lRet, Retorno lógico se conseguiu encontrar o usuário digitado
	@example
	//Verificando se o login deu certo
	If u_zLogin(@cUsrAux, @cPswAux)
		//....
	EndIf
/*/

User Function zLogin(cUsrLog, cPswLog)
	Local aArea := GetArea()
	Local oGrpLog
	Local oBtnConf
	Private lRetorno := .F.
	Private oDlgPvt
	//Says e Gets
	Private oSayUsr
	Private oGetUsr, cGetUsr := Space(25)
	Private oSayPsw
	Private oGetPsw, cGetPsw := Space(20)
	Private oGetErr, cGetErr := ""
	//Dimensões da janela
	Private nJanLarg := 200
	Private nJanAltu := 200
	
	//Criando a janela
	DEFINE MSDIALOG oDlgPvt TITLE "Login" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
		//Grupo de Login
		@ 003, 001 	GROUP oGrpLog TO (nJanAltu/2)-1, (nJanLarg/2)-3 		PROMPT "Login: " 	OF oDlgPvt COLOR 0, 16777215 PIXEL
			//Label e Get de Usuário
			@ 013, 006   SAY   oSayUsr PROMPT "Usuário:"        SIZE 030, 007 OF oDlgPvt                    PIXEL
			@ 020, 006   MSGET oGetUsr VAR    cGetUsr           SIZE (nJanLarg/2)-12, 007 OF oDlgPvt COLORS 0, 16777215 PIXEL
		
			//Label e Get da Senha
			@ 033, 006   SAY   oSayPsw PROMPT "Senha:"          SIZE 030, 007 OF oDlgPvt                    PIXEL
			@ 040, 006   MSGET oGetPsw VAR    cGetPsw           SIZE (nJanLarg/2)-12, 007 OF oDlgPvt COLORS 0, 16777215 PIXEL PASSWORD
		
			//Get de Log, pois se for Say, não da para definir a cor
			@ 060, 006   MSGET oGetErr VAR    cGetErr        SIZE (nJanLarg/2)-12, 007 OF oDlgPvt COLORS 0, 16777215 NO BORDER PIXEL
			oGetErr:lActive := .F.
			oGetErr:setCSS("QLineEdit{color:#FF0000; background-color:#FEFEFE;}")
		
			//Botões
			@ (nJanAltu/2)-18, 006 BUTTON oBtnConf PROMPT "Confirmar"             SIZE (nJanLarg/2)-12, 015 OF oDlgPvt ACTION (fVldUsr()) PIXEL
			oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")
	ACTIVATE MSDIALOG oDlgPvt CENTERED
	
	//Se a rotina foi confirmada e deu certo, atualiza o usuário e a senha
	If lRetorno
		cUsrLog := Alltrim(cGetUsr)
		cPswLog := Alltrim(cGetPsw)
	EndIf
	
	RestArea(aArea)
Return lRetorno

/*---------------------------------------------------------------------*
 | Func:  fVldUsr                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  17/09/2015                                                   |
 | Desc:  Função para validar se o usuário existe                      |
 *---------------------------------------------------------------------*/

Static Function fVldUsr()
	Local cUsrAux := Alltrim(cGetUsr)
	Local cPswAux := Alltrim(cGetPsw)
	Local cCodAux := ""
	
	//Pega o código do usuário
	PswOrder(2)
	If !Empty(cUsrAux) .And. PswSeek(cUsrAux)
 		cCodAux := PswRet(1)[1][1]
 	
 		//Agora verifica se a senha bate com o usuário
 		If !PswName(cPswAux)
 			cGetErr := "Senha inválida!"
 			oGetErr:Refresh()
			Return
		
		//Senão, atualiza o retorno como verdadeiro
		Else
			lRetorno := .T.
		endif
 	
 	//Senão atualiza o erro e retorna para a rotina
 	Else
 		cGetErr := "Usuário não encontrado!"
 		oGetErr:Refresh()
 		Return
	EndIf
	
	//Se o retorno for válido, fecha a janela
	If lRetorno
		oDlgPvt:End()
	EndIf
Return