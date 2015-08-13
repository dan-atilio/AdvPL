#Include "Protheus.ch"

/*/{Protheus.doc} zAbreArq
Função para abrir arquivos conforme preferências do Sistema Operacional
@author Atilio
@since 06/08/2014
@version 1.0
	@param cDirP, Caracter, Diretório do arquivo
	@param cNomeArqP, Caracter, Nome do arquivo
	@example
	//...
	u_zAbreArq("C:\","teste.txt")
	u_zAbreArq("E:\Documentos\","novo.pdf")
	//...
	@see http://terminaldeinformacao.com/advpl/
/*/

User Function zAbreArq(cDirP, cNomeArqP)
	Local aArea:= GetArea()
	
	//Tentando abrir o objeto
	nRet := ShellExecute("open", cNomeArqP, "", cDirP, 1)
	
	//Se houver algum erro
	If nRet <= 32
		MsgStop("Não foi possível abrir o arquivo " +cDirP+cNomeArqP+ "!", "Atenção")
	EndIf 
	
	RestArea(aArea)
Return
