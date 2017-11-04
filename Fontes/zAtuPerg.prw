//Bibiliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zAtuPerg
Função que atualiza o conteúdo de uma pergunta no X1_CNT01 / SXK / Profile
@author Atilio
@since 06/10/2016
@version 1.0
@type function
	@param cPergAux, characters, Código do grupo de Pergunta
	@param cParAux, characters, Código do parâmetro
	@param xConteud, variavel, Conteúdo do parâmetro
	@example u_zAtuPerg("LIBAT2", "MV_PAR01", "000001")
/*/

User Function zAtuPerg(cPergAux, cParAux, xConteud)
	Local aArea      := GetArea()
	Local nPosCont   := 8
	Local nPosPar    := 14
	Local nLinEncont := 0
	Local aPergAux   := {}
	Default xConteud := ''
	
	//Se não tiver pergunta, ou não tiver ordem
	If Empty(cPergAux) .Or. Empty(cParAux)
		Return
	EndIf
	
	//Chama a pergunta em memória
	Pergunte(cPergAux, .F., /*cTitle*/, /*lOnlyView*/, /*oDlg*/, /*lUseProf*/, @aPergAux)
	
	//Procura a posição do MV_PAR
	nLinEncont := aScan(aPergAux, {|x| Upper(Alltrim(x[nPosPar])) == Upper(cParAux) })
	
	//Se encontrou o parâmetro
	If nLinEncont > 0
		//Caracter
		If ValType(xConteud) == 'C'
			&(cParAux+" := '"+xConteud+"'")
		
		//Data
		ElseIf ValType(xConteud) == 'D'
			&(cParAux+" := sToD('"+dToS(xConteud)+")'")
			
		//Numérico ou Lógico
		ElseIf ValType(xConteud) == 'N' .Or. ValType(xConteud) == 'L'
			&(cParAux+" := "+cValToChar(xConteud)+"")
		
		EndIf
		
		//Chama a rotina para salvar os parâmetros
		__SaveParam(cPergAux, aPergAux)
	EndIf
	
	RestArea(aArea)
Return