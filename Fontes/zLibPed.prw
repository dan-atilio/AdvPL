//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zLibPed
Função para liberação de pedido de venda
@type function
@author Atilio
@since 28/08/2016
@version 1.0
	@param cPedido, character, Número do Pedido
	@example
	u_zLibPed("000001")
	@obs Função utilizada para testes!
/*/

User Function zLibPed(cPedido)
	Local aArea     := GetArea()
	Local aAreaC5   := SC5->(GetArea())
	Local aAreaC6   := SC6->(GetArea())
	Local aAreaC9   := SC9->(GetArea())
	Local aAreaAux  := {}
	Local cBlqCred  := "  "
	Local cBlqEst   := "  "
	Local aLocal    := {}
	Default cPedido := ""
	
	DbSelectArea('SC5')
	SC5->(DbSetOrder(1)) //C5_FILIAL + C5_NUM
	SC5->(DbGoTop())
	
	DbSelectArea('SC6')
	SC6->(DbSetOrder(1)) //C6_FILIAL + C6_NUM + C6_ITEM
	SC6->(DbGoTop())

	DbSelectArea('SC9')
	SC9->(DbSetOrder(1)) //C9_FILIAL + C9_PEDIDO + C9_ITEM
	SC9->(DbGoTop())
	
	//Se conseguir posicionar no pedido
	If SC5->(DbSeek(FWxFilial('SC5') + cPedido))
	
		//Se conseguir posicionar nos itens do pedido
		If SC6->(DbSeek(FWxFilial('SC6') + cPedido))
			aAreaAux := SC6->(GetArea())
	
			//Percorre todos os itens
			While ! SC6->(EoF()) .And. SC6->C6_FILIAL = FWxFilial('SC6') .And. SC6->C6_NUM == cPedido
				//Posiciona na liberação do item do pedido e estorna a liberação
				SC9->(DbSeek(FWxFilial('SC9')+SC6->C6_NUM+SC6->C6_ITEM))
				While  (!SC9->(Eof())) .AND. SC9->(C9_FILIAL+C9_PEDIDO+C9_ITEM) == FWxFilial('SC9')+SC6->(C6_NUM+C6_ITEM)
					SC9->(a460Estorna(.T.))
					SC9->(DbSkip())
				EndDo
	
				SC6->(DbSkip())
			EndDo
	
			RecLock("SC5", .F.)
				C5_LIBEROK := ""
			SC5->(MsUnLock())
	
			//Percorre todos os itens
			RestArea(aAreaAux)
			While ! SC6->(EoF()) .And. SC6->C6_FILIAL = FWxFilial('SC6') .And. SC6->C6_NUM == cPedido
				StaticCall(FATXFUN, MaGravaSC9, SC6->C6_QTDVEN, cBlqCred, cBlqEst, aLocal)
	
				SC6->(DbSkip())
			EndDo
		EndIf
	EndIf

	RestArea(aAreaC9)
	RestArea(aAreaC6)
	RestArea(aAreaC5)
	RestArea(aArea)
Return