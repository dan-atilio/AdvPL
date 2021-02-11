/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2015/06/04/pegando-o-mac-address-via-advpl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zPegaMac
Pegando o MAC Address de máquinas hospedeiras com Windows
@author Atilio
@since 23/09/2014
@version 1.0
	@example
	u_zPegaMac()
	@see http://terminaldeinformacao.com/advpl/
/*/

User Function zPegaMac()
	Local cComando	:= "getmac > "
	Local cDir			:= GetTempPath()
	Local cNomBat		:= "comando_mac.bat"
	Local cArquivo	:= "mac_address.txt"
	Local cMac			:= ""
	
	//Gravando em um .bat o comando
	MemoWrite(cDir + cNomBat, cComando + cDir + cArquivo)
	
	//Executando o comando através do .bat
	ShellExecute("OPEN", cDir+cNomBat, "", cDir, 0 )
	
	//Se existe o arquivo
	If File(cDir+cArquivo)
		ConOut("[zPegaMac] > Arquivo gerado.")
		
		//Gerando o MacAddress
		cMac := MemoRead(cDir + cArquivo)
		cMac := SubStr(cMac, RAt("=", cMac)+1, Len(cMac)) //Pegando a partir do ultimo igual
		cMac := SubStr(cMac, 1, At(" ", cMac)-1) //Pegando até o primeiro espaço
		cMac := StrTran(cMac, Chr(13)+Chr(10), "") //retirando os -enters-
	EndIf
	//Alert("|"+cMac+"|")
Return cMac