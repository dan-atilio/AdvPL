/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2017/04/04/funcao-conta-repeticao-de-caracteres-em-uma-string-em-advpl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zConta
Função que conta quantos caracteres repetem em uma string
@type function
@author Atilio
@since 13/11/2016
@version 1.0
	@param cPalavra, character, Palavra a ser considerada
	@param cCaracter, character, Caracter a ser procurado
	@param lMaiusculo, logic, Transforma tudo em maiusculo
	@return nTotal, Total de caracteres encontrados
	@example
	u_zConta("Daniel Atilio", "a", .T.) //retorna 2
/*/

User Function zConta(cPalavra, cCaracter, lMaiusculo)
	Local aArea       := GetArea()
	Local nTotal      := 0
	Local nAtual      := 0
	Default cPalavra  := ""
	Default cCaracter := ""
	
	//Se transforma tudo em maiusculo
	If lMaiusculo
		cPalavra  := Upper(cPalavra)
		cCaracter := Upper(cCaracter)
	EndIf
	
	//Percorre todas as letras da palavra
	For nAtual := 1 To Len(cPalavra)
		//Se a posição atual for igual ao caracter procurado, incrementa o valor
		If SubStr(cPalavra, nAtual, 1) == cCaracter
			nTotal++
		EndIf
	Next
	
	RestArea(aArea)
Return nTotal