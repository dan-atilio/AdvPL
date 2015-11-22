//Bibliotecas
#Include "Protheus.ch"
#Include "TopConn.ch"

//Constantes
#Define STR_PULA		Chr(13)+Chr(10)

/*/{Protheus.doc} zVerTrans
Função que verifica se um pedido foi transmitido totalmente
@author Atilio
@since 28/05/2015
@version 1.0
	@param cFilTran, Caracter, Código da filial a ser analisada
	@param cPedTran, Caracter, Código do pedido a ser analisado
	@return lRet, Retorno lógico identificando se foi transmitido totalmente o pedido
	@example
	u_zVerTrans('0102', '000001')
/*/

User Function zVerTrans(cFilTran, cPedTran)
	Local aArea    := GetArea()
	Local lRet     := .T.
	Local aAreaSM0 := SM0->(GetArea())
	Local cFilBkp  := cFilAnt
	Local cBaseTSS := SuperGetMV('MV_X_BATSS', .F., 'TOTVSTSS.dbo.')
	Local cQryNota := ""
	Local cQrySped := ""
	
	//Posiciono na empresa (para poder pegar o ident)
	cFilAnt := cFilTran
	SM0->(DbGoTop())
	SM0->(DbSeek(cEmpAnt+cFilAnt))
	
	//Monto consulta para pegar as NFs do Pedido
	cQryNota := " SELECT DISTINCT "	+ STR_PULA
	cQryNota += "    D2_SERIE+D2_DOC AS NF "	+ STR_PULA
	cQryNota += " FROM "	+ STR_PULA
	cQryNota += "    "+RetSQLName("SD2")+" SD2 "	+ STR_PULA
	cQryNota += " WHERE "	+ STR_PULA
	cQryNota += "    SD2.D_E_L_E_T_ = '' "	+ STR_PULA
	cQryNota += "    AND D2_FILIAL = '"+cFilTran+"' "	+ STR_PULA
	cQryNota += "    AND D2_PEDIDO = '"+cPedTran+"' "	+ STR_PULA
	TCQuery cQryNota New Alias "QRY_NOT"
	
	//Enquanto tiver notas
	While ! QRY_NOT->(EoF())
		//Agora vou na Sped050 verificar se ela já foi assinada
		cQrySped := " SELECT "																+ STR_PULA
		cQrySped += " 	SP50.NFE_ID "														+ STR_PULA
		cQrySped += " FROM "																	+ STR_PULA
		cQrySped += " 	"+cBaseTSS+"SPED050 SP50 "										+ STR_PULA
		cQrySped += " WHERE "																+ STR_PULA
		cQrySped += " 	SP50.NFE_ID        = '"+QRY_NOT->NF+"' "						+ STR_PULA
		cQrySped += " 	AND SP50.ID_ENT    = '"+StaticCall(SPEDNFE,GetIdEnt)+"' "	+ STR_PULA
		cQrySped += " 	AND SP50.DOC_CHV  != '' "										+ STR_PULA
		cQrySped += " 	AND SP50.NFE_PROT != '' "										+ STR_PULA
		TCQuery cQrySped New Alias "QRY_SPED"
		
		//Se não tiver registros não foi transmitida
		If QRY_SPED->(EoF())
			lRet := .F.
		EndIf
		
		QRY_SPED->(DbCloseArea())
		QRY_NOT->(DbSkip())
	EndDo
	QRY_NOT->(DbCloseArea())
	
	cFilAnt := cFilBkp
	RestArea(aAreaSM0)
	RestArea(aArea)
Return lRet