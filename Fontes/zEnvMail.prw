//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zEnvMail
Função para disparo do e-mail utilizando TMailMessage e tMailManager com opção de múltiplos anexos
@author Atilio
@since 26/05/2017
@version 1.0
@type function
	@param cPara, characters, Destinatário que irá receber o e-Mail
	@param cAssunto, characters, Assunto do e-Mail
	@param cCorpo, characters, Corpo do e-Mail (com suporte à html)
	@param aAnexos, array, Anexos que estarão no e-mail (devem estar na mesma pasta da protheus data)
	@param lMostraLog, logical, Define se será mostrado mensagem de log ao usuário (uma tela de aviso)
	@param lUsaTLS, logical, Define se irá utilizar o protocolo criptográfico TLS
	@return lRet, Retorna se houve falha ou não no disparo do e-Mail
@example Exemplos:
	-----
	1 - Mensagem Simples de envio
	u_zEnvMail("teste@servidor.com.br", "Teste", "Teste TMailMessage - Protheus", , .T.)
	
	-----
	2 - Mensagem com anexos (devem estar dentro da Protheus Data)
	aAnexos := {}
	aAdd(aAnexos, "\pasta\arquivo1.pdf")
	aAdd(aAnexos, "\pasta\arquivo2.pdf")
	aAdd(aAnexos, "\pasta\arquivo3.pdf")
	u_zEnvMail("teste@servidor.com.br", "Teste", "Teste TMailMessage com anexos - Protheus", aAnexos)
	
@obs Deve-se configurar os parâmetros:
	* MV_RELACNT - Conta de login do e-Mail    - Ex.: email@servidor.com.br
	* MV_RELPSW  - Senha de login do e-Mail    - Ex.: senha
	* MV_RELSERV - Servidor SMTP do e-Mail     - Ex.: smtp.servidor.com.br:587
	* MV_RELTIME - TimeOut do e-Mail           - Ex.: 120
/*/

User Function zEnvMail(cPara, cAssunto, cCorpo, aAnexos, lMostraLog, lUsaTLS)
	Local aArea        := GetArea()
	Local nAtual       := 0
	Local lRet         := .T.
	Local oMsg         := Nil
	Local oSrv         := Nil
	Local nRet         := 0
	Local cFrom        := Alltrim(GetMV("MV_RELACNT"))
	Local cUser        := SubStr(cFrom, 1, At('@', cFrom)-1)
	Local cPass        := Alltrim(GetMV("MV_RELPSW"))
	Local cSrvFull     := Alltrim(GetMV("MV_RELSERV"))
	Local cServer      := Iif(':' $ cSrvFull, SubStr(cSrvFull, 1, At(':', cSrvFull)-1), cSrvFull)
	Local nPort        := Iif(':' $ cSrvFull, Val(SubStr(cSrvFull, At(':', cSrvFull)+1, Len(cSrvFull))), 587)
	Local nTimeOut     := GetMV("MV_RELTIME")
	Local cLog         := ""
	Default cPara      := ""
	Default cAssunto   := ""
	Default cCorpo     := ""
	Default aAnexos    := {}
	Default lMostraLog := .F.
	Default lUsaTLS    := .F.
	
	//Se tiver em branco o destinatário, o assunto ou o corpo do email
	If Empty(cPara) .Or. Empty(cAssunto) .Or. Empty(cCorpo)
		cLog += "001 - Destinatario, Assunto ou Corpo do e-Mail vazio(s)!" + CRLF
		lRet := .F.
	EndIf
	
	If lRet
		//Cria a nova mensagem
		oMsg := TMailMessage():New()
		oMsg:Clear()
		
		//Define os atributos da mensagem
		oMsg:cDate    := cValToChar(Date())
		oMsg:cFrom    := cFrom
		oMsg:cTo      := cPara
		oMsg:cSubject := cAssunto
		oMsg:cBody    := cCorpo
		
		//Percorre os anexos
		For nAtual := 1 To Len(aAnexos)
			//Se o arquivo existir
			If File(aAnexos[nAtual])
			
				//Anexa o arquivo na mensagem de e-Mail
				nRet := oMsg:AttachFile(aAnexos[nAtual])
				If nRet < 0
					cLog += "002 - Nao foi possivel anexar o arquivo '"+aAnexos[nAtual]+"'!" + CRLF
				EndIf
			
			//Senao, acrescenta no log
			Else
				cLog += "003 - Arquivo '"+aAnexos[nAtual]+"' nao encontrado!" + CRLF
			EndIf
		Next
		
		//Cria servidor para disparo do e-Mail
		oSrv := tMailManager():New()
		
		//Define se irá utilizar o TLS
		If lUsaTLS
			oSrv:SetUseTLS(.T.)
		EndIf
		
		//Inicializa conexão
		nRet := oSrv:Init("", cServer, cUser, cPass, 0, nPort)
		If nRet != 0
			cLog += "004 - Nao foi possivel inicializar o servidor SMTP: " + oSrv:GetErrorString(nRet) + CRLF
			lRet := .F.
		EndIf
		
		If lRet
			//Define o time out
			nRet := oSrv:SetSMTPTimeout(nTimeOut)
			If nRet != 0
				cLog += "005 - Nao foi possivel definir o TimeOut '"+cValToChar(nTimeOut)+"'" + CRLF
			EndIf
			
			//Conecta no servidor
			nRet := oSrv:SMTPConnect()
			If nRet <> 0
				cLog += "006 - Nao foi possivel conectar no servidor SMTP: " + oSrv:GetErrorString(nRet) + CRLF
				lRet := .F.
			EndIf
			
			If lRet
				//Realiza a autenticação do usuário e senha
				nRet := oSrv:SmtpAuth(cFrom, cPass)
				If nRet <> 0
					cLog += "007 - Nao foi possivel autenticar no servidor SMTP: " + oSrv:GetErrorString(nRet) + CRLF
					lRet := .F.
				EndIf
				
				If lRet
					//Envia a mensagem
					nRet := oMsg:Send(oSrv)
					If nRet <> 0
						cLog += "008 - Nao foi possivel enviar a mensagem: " + oSrv:GetErrorString(nRet) + CRLF
						lRet := .F.
					EndIf
				EndIf
				
				//Disconecta do servidor
				nRet := oSrv:SMTPDisconnect()
				If nRet <> 0
					cLog += "009 - Nao foi possivel disconectar do servidor SMTP: " + oSrv:GetErrorString(nRet) + CRLF
				EndIf
			EndIf
		EndIf
	EndIf
	
	//Se tiver log de avisos/erros
	If !Empty(cLog)
		cLog := "zEnvMail - "+dToC(Date())+ " " + Time() + CRLF + ;
			"Funcao - " + FunName() + CRLF + CRLF +;
			"Existem mensagens de aviso: "+ CRLF +;
			cLog
		ConOut(cLog)
		
		//Se for para mostrar o log visualmente e for processo com interface com o usuário, mostra uma mensagem na tela
		If lMostraLog .And. ! IsBlind()
			Aviso("Log", cLog, {"Ok"}, 2)
		EndIf
	EndIf
	
	RestArea(aArea)
Return lRet