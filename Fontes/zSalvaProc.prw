/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2016/09/13/funcao-salva-pilha-de-chamadas-em-um-arquivo-advpl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

//Constantes
#Define STR_PULA	Chr(13)+Chr(10)

/*/{Protheus.doc} zSalvaProc
Função que salva as chamadas dos ProcNames em um arquivo
@author Atilio
@since 10/12/2014
@version 1.0
	@param cArquivo, Caracter, Caminho do arquivo a ser gerado
	@example
	u_zSalvaProc("C:\TOTVS\arquivo.txt")
/*/

User Function zSalvaProc(cArquivo)
	Local aArea := GetArea()
	Local nCont := 1
	Local nHdl  := 0
	
	//Gerando o arquivo e pegando o handle (ponteiro)
	FErase(cArquivo)
	nHdl := FCreate(cArquivo)
	fWrite(nHdl, 'FunName: '+FunName()+STR_PULA)

	//Enquanto houver procname que não estão em branco
	While !Empty(ProcName(nCont))
		//Escrevendo o número do procname e a descrição
		fWrite(nHdl, 'ProcName > '+StrZero(nCont, 6)+' - '+ProcName(nCont)+STR_PULA)
		nCont++
	EndDo
	
	//Fechando o arquivo
	FClose(nHdl)
	
	RestArea(aArea)
Return