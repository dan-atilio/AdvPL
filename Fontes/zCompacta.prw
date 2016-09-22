//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zCompacta
Função para compactar arquivos utilizando .rar ou .zip
@type function
@author Atilio
@since 21/09/2016
@version 1.0
	@param cDirArqs, character, Diretório de arquivos dentro da Protheus Data (ex.: "\_diretorio\*.pdf")
	@param lRar, lógico, Define se será com a extensão .rar (.T.) ou .zip (.F.)
	@param cArqNovo, character, Nome do arquivo a ser gerado
	@example
	u_zCompacta("\x_arquivos\*.txt", .T., "teste.rar")
	u_zCompacta("\x_arquivos\*.pdf", .F., "teste.zip")
/*/

User Function zCompacta(cDirArqs, lRar, cArqNov)
	Local aArea       := GetArea()
	Local cDirRar     := "C:\Program Files\WinRAR\"
	Local cComando    := ""
	Local cDirSrv     := Alltrim(GetSrvProfString("RootPath",""))
	Local cDirResto   := ""
	Default cDirArqs  := ""
	Default lRar      := .T.
	Default cArqNov   := "arquivo_novo."+Iif(lRar, "rar", "zip")
	
	//Se tiver arquivos para compactar
	If !Empty(cDirArqs)
		cDirResto := SubStr(cDirArqs, 1, RAt("\", cDirArqs))
		
		//Se for com a extensão rar
		If lRar
			cComando := "rar a "+cArqNov+" "+cDirSrv+cDirArqs+" -ep -df"
		
		//Senão, será zip
		Else
			cComando := "winrar a -afzip "+cArqNov+" "+cDirSrv+cDirArqs+" -ep -df"
		EndIf
		
		//Executando o comando no servidor
		WaitRunSrv(cDirRar+cComando, .T., cDirSrv+cDirResto)
	EndIf
	
	RestArea(aArea)
Return