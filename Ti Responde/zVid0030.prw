//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function A410EXC
Ponto de Entrada na Exclusão do Pedido de Venda
@type  Function
@author Atilio
@since 28/04/2022
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6784034
/*/

User Function A410EXC(param_name)
	Local aArea     := FWGetArea()
	Local cNumPed   := SC5->C5_NUM
	Local cFilPed   := SC5->C5_FILIAL
	Local cEntidade := 'SC5'
	
	//Abre a tabela SC9, e coloca o índice do código da entidade (índice número 2)
	DbSelectArea("AC9")
	AC9->(DbSetOrder(2)) // AC9_FILIAL + AC9_ENTIDA + AC9_FILENT + AC9_CODENT + AC9_CODOBJ
	
	//Se conseguiu encontrar documentos vinculados ao pedido, significa que tem documentos para serem excluídos
	If AC9->(MsSeek(FWxFilial('AC9') + cEntidade + cFilPed + cNumPed ))
		
		//Enquanto houver documentos com a mesma chave de pesquisa
		While ! AC9->(EoF()) .And. AC9->AC9_ENTIDA == cEntidade .And. AC9->AC9_FILENT == cFilPed .And. AC9->AC9_CODENT == cNumPed
			
			//Exclui o registro
			RecLock('AC9', .F.)
				DbDelete()
			AC9->(MsUnlock())
		
			AC9->(DbSkip())
		EndDo
		
	EndIf

	FWRestArea(aArea)
Return
