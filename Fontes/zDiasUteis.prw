/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2017/03/21/funcao-retorna-numero-de-dias-uteis-entre-duas-datas-utilizando-advpl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zDiasUteis
Função que retorna a quantidade de dias úteis entre duas datas
@author Atilio
@since 25/10/2016
@version 1.0
@type function
	@param dDtIni, date, Data inicial a ser considerada
	@param dDtFin, date, Data final a ser considerada
	@example u_zDiasUteis(sToD("20161001"), sToD("20161025"))
	u_zDiasUteis(FirstDate(dDataBase), LastDate(dDataBase))
	@obs Quanto as feriados, eles devem estar cadastrados na SX5, tabela "63"
/*/

User Function zDiasUteis(dDtIni, dDtFin)
	Local aArea    := GetArea()
	Local nDias    := 0
	Local dDtAtu   := sToD("")
	Default dDtIni := dDataBase
	Default dDtFin := dDataBase
	
	//Enquanto a data atual for menor ou igual a data final
	dDtAtu := dDtIni
	While dDtAtu <= dDtFin
		//Se a data atual for uma data Válida
		If dDtAtu == DataValida(dDtAtu) 
			nDias++
		EndIf
		
		dDtAtu := DaySum(dDtAtu, 1)
	EndDo
	
	RestArea(aArea)
Return nDias