//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zCriaGat
Função que cria os gatilhos na base
@type function
@author Atilio
@since 22/09/2015
@version 1.0
	@param aSX7, Array, Array com os dados da SX7
	@example
	u_zCriaGat(aSX7)
	@obs Abaixo a estrutura do array:
	SX7:
		[nLinha][01] - Campo
		[nLinha][02] - Conta Domínio
		[nLinha][03] - Regra
		[nLinha][04] - Tipo
		[nLinha][05] - Seek
		[nLinha][06] - Alias
		[nLinha][07] - Ordem
		[nLinha][08] - Chave
		[nLinha][09] - Condição
/*/

User Function zCriaGat(aSX7)
	Local aAreaX7 := SX7->(GetArea())
	Local nAtual := 0
	Local lCria := .T.
	Local cTabAux := ""
	Local cSeqAux := ""
	
	DbSelectArea("SX7")
	SX7->(DbSetOrder(1))
	DbSelectArea("SX3")
	SX3->(dbSetOrder(2)) // X3_CAMPO
	
	//Percorrendo os gatilhos
	For nAtual := 1 To Len(aSX7)
		lCria := .T.
		
		//Percorrendo a SX7, verificando se já não existe o campo com a conta domínio e a regra
		SX7->(DbGoTop())
		While ! SX7->(EoF())
			//Se encontrar o gatilho, não será criado
			If	Alltrim(SX7->X7_CAMPO) == Alltrim(aSX7[nAtual][01]) .And.;
				Alltrim(SX7->X7_CDOMIN) == Alltrim(aSX7[nAtual][02]) .And.;
				Alltrim(SX7->X7_REGRA) == Alltrim(aSX7[nAtual][03])
				lCria := .F.
			EndIf
			
			SX7->(DbSkip())
		EndDo
		
		//Se for para criar os dados
		If lCria
			cTabAux := AliasCpo(aSX7[nAtual][01])
			cSeqAux := fSeqSX7(aSX7[nAtual][01])
			
			//Grava a informação
			RecLock("SX7", .T.)
				X7_CAMPO	:= aSX7[nAtual][01]
				X7_SEQUENC	:= cSeqAux
				X7_REGRA	:= aSX7[nAtual][03]
				X7_CDOMIN	:= aSX7[nAtual][02]
				X7_TIPO	:= aSX7[nAtual][04]
				X7_SEEK	:= aSX7[nAtual][05]
				X7_ALIAS	:= aSX7[nAtual][06]
				X7_ORDEM	:= aSX7[nAtual][07]
				X7_CHAVE	:= aSX7[nAtual][08]
				X7_CONDIC	:= aSX7[nAtual][09]
				X7_PROPRI	:= "U"
				DbCommit()
			SX7->(MsUnlock())
			
			//Se posicionar no campo
			SX3->(DbGoTop())
			If SX3->(DbSeek(aSX7[nAtual][01]))
				//Se o controle de gatilho, estiver em branco
				If Empty(SX3->X3_TRIGGER)
					RecLock("SX3", .F.)
						X3_TRIGGER := "S"
					SX3->(MsUnlock())
				EndIf
			EndIf
			
			//Atualiza o Dicionário
			X31UpdTable(cTabAux)

			//Se houve Erro na Rotina
			If __GetX31Error()
				cMsgAux := "Houveram erros na atualização do gatilho "+aSX7[nAtual][01]+" -> "+aSX7[nAtual][02]+", com a regra '"+aSX7[nAtual][03]+"':"+Chr(13)+Chr(10)
				cMsgAux += __GetX31Trace()
				Aviso('Atenção', cMsgAux, {'OK'}, 03)
			EndIf
		EndIf
	Next
	
	RestArea(aAreaX7)
Return

/*---------------------------------------------------------------------*
 | Func:  fSeqSX7                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  22/09/2015                                                   |
 | Desc:  Função que pega a próxima sequencia da SX7 conforme campo    |
 *---------------------------------------------------------------------*/
 
Static Function fSeqSX7(cCampo)
	Local aAreaX7 := SX7->(GetArea())
	Local cSequen := "001"
	
	SX7->(DbSetOrder(1))
	SX7->(DbGoTop())
	
	//Se conseguir posicionar no campo
	If SX7->(DbSeek(cCampo))
		//Enquanto houver registros
		While ! SX7->(EoF()) .And. Alltrim(SX7->X7_CAMPO) == Alltrim(cCampo)
			cSequen := SX7->X7_SEQUENC
			SX7->(DbSkip())
		EndDo
		
		cSequen := Soma1(cSequen)
	EndIf
	
	RestArea(aAreaX7)
Return cSequen