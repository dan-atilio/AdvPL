/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2015/02/05/data-extenso-advpl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zDtExtenso
Retorna a data por extenso
@author Atilio
@since 27/08/2014
@version 1.0
	@param dDataAtual, Data, Data que ficará em extenso
	@param lAbreviado, Lógico, Define se a data será abreviada com números
	@return cRetorno, Retorna a data por extenso
	@example
	u_zDtExtenso(dDataBase, .T.) //27 de Agosto de 2014
	u_zDtExtenso(dDataBase, .F.) //Vinte e Sete de Agosto de Dois Mil e Quatorze
	@see http://terminaldeinformacao.com/advpl/
/*/

User Function zDtExtenso(dDataAtual, lAbreviado)
	Local cRetorno := ""
	Default dDataAtual := dDataBase
	Default lAbreviado := .F.
	
	//Se for da forma abreviada, mostra números
	If lAbreviado
		cRetorno += cValToChar(Day(dDataAtual))
		cRetorno += " de "
		cRetorno += MesExtenso(dDataAtual)
		cRetorno += " de "
		cRetorno += cValToChar(Year(dDataAtual))
	
	//Senão for abreviado, mostra texto completo
	Else
		cRetorno += Capital(Extenso(Day(dDataAtual), .T.))
		cRetorno += " de "
		cRetorno += MesExtenso(dDataAtual)
		cRetorno += " de "
		cRetorno += Capital(Extenso(Year(dDataAtual), .T.))
	EndIf
	
Return cRetorno