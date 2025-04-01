/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFonte32
Efetua um laço de repetição enquanto uma condição for verdadeira
@type Function
@author Atilio
@since 07/04/2023
@see https://tdn.totvs.com/display/tec/O+Comando+WHILE...ENDDO
/*/


User Function zFonte32()
	Local aArea   := FWGetArea()
	Local aAreaSA2 := SA2->(FWGetArea())
	Local cMsg    := ""
	Local nAtual  := 0
	
	//Abrindo a tabela de fornecedores e posicionando no topo
	DbSelectArea('SA2')
	SA2->(DbSetOrder(1))
	SA2->(DbGoTop())
	
	//Enquanto houver dados nos fornecedores e for menos que 100 registros
	While ! SA2->(EoF())
		nAtual++
		cMsg += "[" + cValToChar(nAtual) + "] " + Alltrim(SA2->A2_NOME) + ";" + CRLF
		
		SA2->(DbSkip())
	EndDo

	/*
	//Exemplo de laço duplo, um dentro do outro (um laço no documento de entrada e depois nos itens desse documento)

	//Executo query QRY_SF1

	While ! QRY_SF1->(EoF())

		//Executo query QRY_SD1
		
		While ! QRY_SD1->(EoF())
		
			QRY_SD1->(DbSkip())
		EndDo
		QRY_SD1->(DbCloseArea())

		QRY_SF1->(DbSkip())
	EndDo
	*/
	
	//Mostrando os fornecedores
	Aviso("Atenção", cMsg, {"OK"}, 2)
	
	FWRestArea(aAreaSA2)
	FWRestArea(aArea)
Return
