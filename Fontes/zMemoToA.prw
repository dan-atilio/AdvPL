//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zMemoToA
Função Memo To Array, que quebra um texto em um array conforme número de colunas
@author Atilio
@since 15/08/2014
@version 1.0
	@param cTexto, Caracter, Texto que será quebrado (campo MEMO)
	@param nMaxCol, Numérico, Coluna máxima permitida de caracteres por linha
	@param cQuebra, Caracter, Quebra adicional, forçando a quebra de linha além do enter (por exemplo '<br>')
	@param lTiraBra, Lógico, Define se em toda linha será retirado os espaços em branco (Alltrim)
	@return nMaxLin, Número de linhas do array
	@example
	cCampoMemo := SB1->B1_X_TST
	nCol        := 200
	aDados      := u_zMemoToA(cCampoMemo, nCol)
	@obs Difere da MemoLine(), pois já retorna um Array pronto para impressão
/*/

User Function zMemoToA(cTexto, nMaxCol, cQuebra, lTiraBra)
	Local aArea     := GetArea()
	Local aTexto    := {}
	Local aAux      := {}
	Local nAtu      := 0
	Default cTexto  := ''
	Default nMaxCol := 80
	Default cQuebra := ';'
	Default lTiraBra:= .T.

	//Quebrando o Array, conforme -Enter-
	aAux:= StrTokArr(cTexto,Chr(13))
	
	//Correndo o Array e retirando o tabulamento
	For nAtu:=1 TO Len(aAux)
		aAux[nAtu]:=StrTran(aAux[nAtu],Chr(10),'')
	Next
	
	//Correndo as linhas quebradas
	For nAtu:=1 To Len(aAux)
	
		//Se o tamanho de Texto, for maior que o número de colunas
		If (Len(aAux[nAtu]) > nMaxCol)
		
			//Enquanto o Tamanho for Maior
			While (Len(aAux[nAtu]) > nMaxCol)
				//Pegando a quebra conforme texto por parâmetro
				nUltPos:=RAt(cQuebra,SubStr(aAux[nAtu],1,nMaxCol))
				
				//Caso não tenha, a última posição será o último espaço em branco encontrado
				If nUltPos == 0
					nUltPos:=Rat(' ',SubStr(aAux[nAtu],1,nMaxCol))
				EndIf
				
				//Se não encontrar espaço em branco, a última posição será a coluna máxima
				If(nUltPos==0)
					nUltPos:=nMaxCol
				EndIf
				
				//Adicionando Parte da Sring (de 1 até a Úlima posição válida)
				aAdd(aTexto,SubStr(aAux[nAtu],1,nUltPos))
				
				//Quebrando o resto da String
				aAux[nAtu] := SubStr(aAux[nAtu], nUltPos+1, Len(aAux[nAtu]))
			EndDo
			
			//Adicionando o que sobrou
			aAdd(aTexto,aAux[nAtu])
		Else
			//Se for menor que o Máximo de colunas, adiciona o texto
			aAdd(aTexto,aAux[nAtu])
		EndIf
	Next
	
	//Se for para tirar os brancos
	If lTiraBra
		//Percorrendo as linhas do texto e aplica o AllTrim
		For nAtu:=1 To Len(aTexto)
			aTexto[nAtu] := Alltrim(aTexto[nAtu])
		Next
	EndIf
	
	RestArea(aArea)
Return aTexto