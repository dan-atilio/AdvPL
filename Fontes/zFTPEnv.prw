//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zFTPEnv
Função que envia um arquivo para um servidor FTP
@author Atilio
@since 28/03/2017
@version 1.0
	@param cEndereco, Caracter, Endereço do FTP
	@param nPorta, Numerico, Porta de Conexão
	@param cUsr, Caracter, Usuário
	@param cPass, Caracter, Senha
	@param cArq, Caracter, Arquivo a ser enviado (deve estar dentro da \System\)
	@return lRet, Retorno lógico se deu certo ou não o envio
/*/

User Function zFTPEnv(cEndereco, nPorta, cUsr, cPass, cArq)
	Local aArea   := GetArea()
	Local lRet    := .T.
	Local cDirAbs := GetSrvProfString("STARTPATH","")  
	cDirAbs       += "\" + cArq
	
	//Se conseguir conectar
	If FTPConnect(cEndereco ,nPorta ,cUsr , cPass )
		
		//Desativa o firewall
		FTPSetPasv(.F.)		
		
		//Se não conseguir dar o upload
		If !FTPUpload(cDirAbs, cArq)
			//Realiza mais uma tentativa
			If !FTPUpload(cDirAbs, cArq)
				lRet:=.F.
			EndIf
		EndIf
		
		//Desconecta do FTP
		FTPDisconnect()
	EndIf

	RestArea(aArea)
Return lRet