//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zOutlook
Função que abre o outlook para escrever um novo e-mail
@type function
@author Atilio
@since 14/04/2017
@version 1.0
	@param cEmail, character, Endereço de e-Mail
	@example
	u_zOutlook("suporte@terminaldeinformacao.com")
	u_zOutlook(SA3->A3_EMAIL)
	@obs Caso queira ver a opção de adicionar assunto ou corpo do e-Mail, veja
	https://support.microsoft.com/pt-br/help/287573/how-to-use-command-line-switches-to-create-a-pre-addressed-e-mail-message-in-outlook
/*/

User Function zOutlook(cEmail)
	Local cExecute := "/c ipm.note /m "+Alltrim(cEmail)
	Default cEmail := ""
	
	//Se tiver email, abre o outlook
	If !Empty(Alltrim(cEmail))
		ShellExecute("OPEN", "outlook.exe", cExecute, "", 1)
	EndIf
Return