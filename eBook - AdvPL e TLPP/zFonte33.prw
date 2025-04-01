/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFonte33
Exemplo de como acionar o Exit ou Loop em um laço
@type Function
@author Atilio
@since 07/04/2023
/*/


User Function zFonte33()
	Local aArea   := FWGetArea()
	Local aAreaSA2 := SA2->(FWGetArea())
	Local cMsg    := ""
	Local nAtual  := 0
	
	//Enquanto for verdadeiro
	While .T.
		
		//Se a pergunta for confirmada, volta o laço
		If MsgYesNo("Deseja continuar o laço?", "Atenção")
			Loop
		Else
			Exit
		EndIf
		
	EndDo
	
	FWRestArea(aAreaSA2)
	FWRestArea(aArea)
Return
