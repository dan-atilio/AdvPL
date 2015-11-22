//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zCpySX1
Copia um grupo de perguntas para um novo grupo, clonando seus conteúdos
@author Atilio
@since 10/08/2015
@version 1.0
	@param cPergAnt, Caracter, Código da Pergunta antiga
	@param cPergNov, Caracter, Código da Pergunta nova
	@param lExcNov, Lógico, Define se será excluído o grupo de perguntas novo antes da cópia
	@example
	u_zCpySX1("RELLAS", "X_RELLAS", .T.)
	u_zCpySX1("PERG01", "X_PERG01", .T.)
	u_zCpySX1("X_PRINTER", "X_PRINTER2", .T.)
/*/

User Function zCpySX1(cPergAnt, cPergNov, lExcNov)
	Local aArea		:= GetArea()
	Local aAreaX1		:= SX1->(GetArea())
	Local aX1Estr		:= SX1->(DbStruct())
	Local aAreaAux
	Local nColuna		:= 0
	Local aConteu		:= {}
	Default cPergAnt	:= ""
	Default cPergNov	:= ""
	Default lExcNov	:= .T.

	DbSelectArea("SX1")
	SX1->(DbSetOrder(1)) //X1_GRUPO + X1_ORDEM
	SX1->(DbGoTop())

	//Se a pergunta antiga ou a nova estiverem em branco, mostra mensagem de erro
	If Empty(cPergAnt) .Or. Empty(cPergNov)
		MsgStop("Pergunta antiga e/ou nova estão em branco!", "Atenção")
	
	//Senão, se as perguntas forem iguais, mostra erro
	ElseIf Alltrim(cPergAnt) == Alltrim(cPergNov)
		MsgStop("Pergunta antiga é igual à nova!", "Atenção")
	
	//Senão, define que as perguntas terão um tamanho de 10 de caracteres, pega a estrutura da SX1 e efetua a cópia
	Else
		cPergAnt := PadR(cPergAnt, Len(SX1->X1_GRUPO))
		cPergNov := PadR(cPergNov, Len(SX1->X1_GRUPO))
		
		//Se o grupo de perguntas não existir, mostra mensagem de erro
		If !SX1->(DbSeek(cPergAnt))
			MsgStop("Pergunta antiga não existe! Logo, não pode ser copiada!", "Atenção")
				
		//Senão prossegue com a cópia
		Else
			aAreaAux := SX1->(GetArea())
		
			//Se for para excluir o grupo novo
			If lExcNov
				//Posiciona no grupo novo
				If SX1->(DbSeek(cPergNov))
					//Enquanto não for fim da tabela e tiver registros da pergunta nova
					While !SX1->(EoF()) .And. SX1->X1_GRUPO == cPergNov
						RecLock("SX1", .F.)
							DbDelete()
						SX1->(MsUnlock())
					
						SX1->(DbSkip())
					EndDo
				EndIf
			EndIf
			
			RestArea(aAreaAux)
			//Enquanto não for o fim da tabela e tiver registros na pergunta antiga
			While !SX1->(EoF()) .And. SX1->X1_GRUPO == cPergAnt
				aAreaAux := SX1->(GetArea())
				aConteu := {}
				
				//Primeiro é armazenado tudo em um array, para não divergir os ponteiros de registros
				For nColuna := 1 To Len(aX1Estr)
					//Se a coluna for a X1_GRUPO, define o nome da pergunta nova
					If Alltrim(aX1Estr[nColuna][1]) == "X1_GRUPO"
						aAdd(aConteu, cPergNov)
					//Senão, efetua a cópia da coluna
					Else
						aAdd(aConteu, &("SX1->"+aX1Estr[nColuna][1]))
					EndIf
				Next
				
				//Gravando os dados na tabela nova, conforme estrutura da SX1
				RecLock("SX1", .T.)
					For nColuna := 1 To Len(aX1Estr)
						&(aX1Estr[nColuna][1]) := aConteu[nColuna]
					Next
				SX1->(MsUnlock())
				
				//Restaurando a área da pergunta antiga
				RestArea(aAreaAux)
				SX1->(DbSkip())
			EndDo
		EndIf
	EndIf
	
	RestArea(aAreaX1)
	RestArea(aArea)
Return