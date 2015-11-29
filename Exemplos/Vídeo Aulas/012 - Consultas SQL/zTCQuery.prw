//Bibliotecas
#Include "Protheus.ch"
#Include "TopConn.ch"

//Constantes
#Define STR_PULA		Chr(13) + Chr(10)

/*/{Protheus.doc} zTCQuery
Exemplo de manipulação de query via AdvPL
@author Atilio
@since 29/11/2015
@version 1.0
	@example
	u_zTCQuery()
/*/

User Function zTCQuery()
	Local aArea	:= GetArea()
	Local cQuery	:= ""
	
	//Montando a Consulta... Tentem evitar o SELECT * pois isso pode travar o TOPCONN
	cQuery := " SELECT "								+ STR_PULA
	cQuery += "   B1_COD AS CODIGO, "				+ STR_PULA
	cQuery += "   B1_DESC AS DESCRI "				+ STR_PULA
	cQuery += " FROM "								+ STR_PULA
	cQuery += "   "+RetSQLName("SB1")+" SB1 "		+ STR_PULA
	cQuery += " WHERE "								+ STR_PULA
	cQuery += "   SB1.D_E_L_E_T_ = '' "			+ STR_PULA
	cQuery += "   AND B1_MSBLQL != '1' "			+ STR_PULA
	cQuery := ChangeQuery(cQuery)
	
	//Executando consulta
	TCQuery cQuery New Alias "QRY_SB1"
	//TCSetField('QRY_SB1', 'CAMPO_DATA', 'D')
	
	//Percorrendo os registros
	While ! QRY_SB1->(EoF())
		ConOut("> QRY_SB1: " + QRY_SB1->CODIGO + "|" + QRY_SB1->DESCRI)
	
		QRY_SB1->(DbSkip())
	EndDo
	
	QRY_SB1->(DbCloseArea())
	RestArea(aArea)
Return