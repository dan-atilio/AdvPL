/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2015/01/29/abrindo-arquivos-via-advpl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

#Include "Protheus.ch"

/*/{Protheus.doc} zAbreArq
Função para abrir arquivos conforme preferÃªncias do Sistema Operacional
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
		MsgStop("Não foi possÃ­vel abrir o arquivo " +cDirP+cNomeArqP+ "!", "Atenção")
	EndIf 
	
	RestArea(aArea)
Return
