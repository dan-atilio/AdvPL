//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} User Function zVid0025
Função para preencher o campo de código de fabricação no cadastro de produtos
@type  Function
@author Atilio
@since 15/03/2022
@version version
@obs Na criação do gatilho, tem que ser informado da seguinte forma:
    Campo: B1_GRUPO
    Cnt Dominio: B1_FABRIC
    Tipo: Primário
    Regra: u_zVid0025()
/*/

User Function zVid0025()
	Local aArea    := GetArea()
    Local cGrupo   := FWFldGet("B1_GRUPO")
	Local cUltimo  := PadR(cGrupo, TamSX3("B1_FABRIC")[1], '0')
	Local cQuery   := ""
	
	cQuery += " SELECT " + CRLF
	cQuery += " 	ISNULL(MAX(B1_FABRIC), '" + cUltimo + "') AS ULTIMO " + CRLF
	cQuery += " FROM " + CRLF
	cQuery += " 	" + RetSQLName('SB1') + " SB1 " + CRLF
	cQuery += " WHERE " + CRLF
	cQuery += " 	B1_FILIAL = '" + FWxFilial('SB1') + "' " + CRLF
	cQuery += " 	AND B1_GRUPO = '" + cGrupo + "' " + CRLF
	cQuery += " 	AND SB1.D_E_L_E_T_ = ' ' " + CRLF
	TCQuery cQuery New Alias "QRY_ULT
	
	//Somente se não tiver no fim do arquivo e tiver conteúdo
	If ! QRY_ULT->(EoF()) .And. ! Empty(QRY_ULT->ULTIMO)
		cUltimo := QRY_ULT->ULTIMO
	EndIf
	QRY_ULT->(DbCloseArea())
	
	//Incrementa 1
	cUltimo := Soma1(cUltimo)

	RestArea(aArea)
Return cUltimo
