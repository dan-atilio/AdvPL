/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2019/09/19/funcao-que-retorna-o-total-de-paginas-em-advpl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zTotPag
Retorna o número total de páginas para imprimir em um relatório
@author Atilio
@since 02/06/2019
@param nRegistros, numeric, Quantidade total de registros que serão impressos, por exemplo, 520
@param nPorPag, numeric, Quantidade de registros / linhas que cabem em uma página, por exemplo, 30
@version 1.0
@example
	...
	Local nLinhas := 30

	...
	DbSelectArea('SEU_ALIAS')
	SEU_ALIAS->(DbGoTop())
	Count To nTotRegis

	...
	nPagFim := u_zTotPag(nTotRegis, nLinhas)

	...
	oPrint:Say(nLinRod+20, 3100, 'Página ' + cValToChar(nPag) + ' de ' + cValToChar(nPagFim), oFontRod,,,,PAD_RIGHT)
/*/

User Function zTotPag(nRegistros, nPorPag)
	Local aArea        := GetArea()
	Local nTotPag      := 0
	Default nRegistros := 0
	Default nPorPag    := 0
	
	//Se tiver mais registros do que cabe por página
	If nRegistros > nPorPag
		
		//O total de páginas, será a parte inteira da divisão de quantidade de registros pelo número de linhas que cabe numa página
		nTotPag := Int(nRegistros / nPorPag)
		
		//Se houver resto na divisão, então sobrou 1 página
		If nRegistros % nPorPag != 0
			nTotPag++
		EndIf
	
	//Senão será apenas 1 página
	Else
		nTotPag  := 1
	EndIf
	
	RestArea(aArea)
Return nTotPag