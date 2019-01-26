//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zNameFile
Função que serve para retirar caracteres especiais para nome de arquivos
@author Atilio
@since 10/08/2018
@version 1.0
@param cString, characters, Nome do arquivo que será recomposto
@type function
@example //...
	cCaminho := "C:\spool\"
	cArquivo := SA1->A1_NREDUZ + ".txt"          //Teste | Cliente: 01.txt
	cCamFull := cCaminho + u_zNameFile(cArquivo) //Resultado será: C:\spool\Teste  Cliente 01.txt
	//...
@obs A função foi baseada no Windows, onde ao renomear um arquivo, não pode ser usado \ / : * ? " < > |
/*/

User Function zNameFile(cString)
	Local aArea      := GetArea()
	Local cStringNov := ""
	Local aSubstit   := {}
	Local nAtual     := 0
	Default cString  := ""
	
	//Se houver dados
	If ! Empty(cString)
		
		//Adiciona caracteres que serão retirados
		aAdd(aSubstit, '\')
		aAdd(aSubstit, '/')
		aAdd(aSubstit, ':')
		aAdd(aSubstit, '*')
		aAdd(aSubstit, '?')
		aAdd(aSubstit, '"')
		aAdd(aSubstit, '<')
		aAdd(aSubstit, '>')
		aAdd(aSubstit, '|')
		
		//Pega o conteúdo original e joga na nova variável
		cStringNov := cString
		
		//Percorre os dados
		For nAtual := 1 To Len(aSubstit)
			cStringNov := StrTran(cStringNov, aSubstit[nAtual], "")
		Next
	EndIf
	
	RestArea(aArea)
Return cStringNov