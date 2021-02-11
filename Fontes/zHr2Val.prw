/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2017/07/04/funcao-converte-hora-para-valor-em-advpl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zHr2Val
Função que converte Hora para Valor
@author Atilio
@since 16/02/2017
@version 1.0
@param cHora, characters, Parâmetro que contém o conteúdo da hora e minutos (por exemplo, 100:50)
@param cSep, characters, Parâmetro que contém o separador da hora (por exemplo, ':' ou 'h')
@type function
@example u_zHr2Val("01:30", ":") --> 1,50
u_zHr2Val("01h45", "h") --> 1,75
/*/

User Function zHr2Val(cHora, cSep)
	Local aArea   := GetArea()
	Local nAux    := 0
	Local cMin    := ""
	Local nValor  := 0
	Local nPosSep := 0
	Default cHora := ""
	Default cSep  := ':'
	
	//Se tiver a hora
	If !Empty(cHora)
		nPosSep := RAt(cSep, cHora)
		nAux    := Val(SubStr(cHora, nPosSep+1, 2))
		nAux    := Int(Round((nAux*100)/60, 0))
		cMin    := Iif(nAux > 10, cValToChar(nAux), "0"+cValToChar(nAux))
		nValor  := Val(SubStr(cHora, 1, nPosSep-1)+"."+cMin)
	EndIf
	
	RestArea(aArea)
Return nValor