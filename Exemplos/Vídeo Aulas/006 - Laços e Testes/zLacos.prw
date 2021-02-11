/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2015/11/09/vd-advpl-006/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zLacos
Exemplo de laços de repetição em AdvPL
@author Atilio
@since 08/11/2015
@version 1.0
	@example
	u_zLacos()
/*/

User Function zLacos()
	Local aArea := GetArea()
	Local nValor:= 1
	Local cNome := ""
	
	//Exemplo de For (Fazer do Valor de 1 Até 10)
	For nValor := 1 To 10
	Next
	Alert("For (++): "+cValToChar(nValor))
	
	//Exemplo de For Inverso (Fazer do Valor de 10 Até 1)
	For nValor := 10 To 1 Step -1
	Next
	Alert("For (--): "+cValToChar(nValor))
	
	//Exemplo de While (Faça Enquanto o valor for diferente de 10)... Também pode ser utilizado o Do While
	nValor := 1
	While nValor != 10
		nValor++
	EndDo
	Alert("While: "+cValToChar(nValor))
	
	//Exemplo do While composto (mais de 1 teste no laço de repetição)
	nValor := 1
	While nValor != 10 .And. cNome != "Daniel"
		//Se chegar no meio do laço
		If nValor == 5
			cNome := "Daniel"
		EndIf
		
		nValor++
	EndDo
	Alert("While Composto: "+cValToChar(nValor))
	
	//Exemplo de quebra de laço de repetição (Fazer do Valor de 1 Até 10 incrementando de 2 em 2)
	For nValor := 1 To 10 Step 2
		//Se o valor for igual a 6, diminui um valor (será 5), e pula o laço
		If nValor == 6
			nValor--
			Loop
		EndIf
		
		//Se o valor for igual a 7, encerra o laço de repetição
		If nValor == 7
			Exit
		EndIf
	Next
	Alert("For (Quebra): "+cValToChar(nValor))
	
	RestArea(aArea)
Return