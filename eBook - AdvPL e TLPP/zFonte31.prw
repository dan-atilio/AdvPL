/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFonte31
Faz um laço de repetição de um valor até outro
@type Function
@author Atilio
@since 21/12/2022
@see https://tdn.totvs.com/display/public/framework/FOR+...+NEXT
/*/

User Function zFonte31()
    Local aArea    := FWGetArea()
	Local nAtual   := 0
	Local aNomes   := {}
	Local cPares   := ""
	Local cMsg     := ""
	
	//Percorrendo de 1 a 10
	For nAtual := 1 To 10
		
		//Se o resto da divisão por 2 der 0, então é número par
		If nAtual % 2 == 0
			cPares += cValToChar(nAtual) + ", "
		EndIf
		
	Next


    
	
	//Adicionando nomes no array
	aAdd(aNomes, "Daniel")
	aAdd(aNomes, "Atilio")
	aAdd(aNomes, "Terminal de Informação")
	
	//Percorrendo o array de nomes
	For nAtual := Len(aNomes) To 1 Step -1
		cMsg += "[" + cValToChar(nAtual) + "] - " + aNomes[nAtual] + CRLF
	Next
	
	FWAlertInfo("Pares: " + cPares + CRLF + "Nomes: " + cMsg, "Teste de For ... Next")
	
	FWRestArea(aArea)
Return
