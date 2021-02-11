/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2017/03/14/funcao-cria-cliente-partir-de-fornecedor-em-advpl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zCliFor
Função que cadastra cliente a partir dos dados do fornecedor
@type function
@author Atilio
@since 12/10/2016
@version 1.0
	@param nRecSA2, numérico, RecNO do Fornecedor
	@return lRet, Retorna se deu certo ou não a inclusão do cliente
	@example
	u_zCliFor(888)
	@obs Os campos A2_X_CLCOD e A2_X_CLLOJ devem estar criados na base
	Verificar os parÃ¢metros MV_X_CLNAT, MV_X_CLVEN e MV_X_CLSAT
/*/

User Function zCliFor(nRecSA2)
	Local aArea     := GetArea()
	Local lRet      := .T.
	Local aSA1      := {}
	Local cCodCli   := ""
	Local nAtual    := 0
	Local cNatAux   := SuperGetMV('MV_X_CLNAT', .F., "")
	Local cVenAux   := SuperGetMV('MV_X_CLVEN', .F., "")
	Local cSatAux   := SuperGetMV('MV_X_CLSAT', .F., "")
	Default nRecSA2 := 0
	
	//Se tiver recno
	If nRecSA2 != 0
		//Se não for o mesmo recno, posiciona no fornecedor
		DbSelectArea('SA2')
		If SA2->(RecNo()) != nRecSA2
			SA2->(DbGoTo(nRecSA2))
		EndIf
		
		//Somente se não tiver cliente e loja
		If Empty(SA2->A2_X_CLCOD) .And. Empty(SA2->A2_X_CLLOJ)
			DbSelectArea('SA1')
			SA1->(DbSetOrder(3)) //A1_FILIAL + A1_CGC
			SA1->(DbGoTop())
		
			//Se o CNPJ já existir, usa o cliente como referÃªncia
			If SA1->(DbSeek(FWxFilial('SA1') + SA2->A2_CGC))
				//Grava o cliente no fornecedor
				RecLock('SA2', .F.)
					A2_X_CLCOD := SA1->A1_COD
					A2_X_CLLOJ := SA1->A1_LOJA
				SA2->(MsUnlock())
				
			Else
				//Adiciona os campos
				cCodCli := GetSXENum("SA1","A1_COD")
				ConfirmSX8()
				aAdd(aSA1, {"A1_FILIAL",  FWxFilial("SA1"), Nil})
				aAdd(aSA1, {"A1_COD",     cCodCli,          Nil})
				aAdd(aSA1, {"A1_LOJA",    "01",             Nil})
				aAdd(aSA1, {"A1_CGC",     SA2->A2_CGC,      Nil})
				aAdd(aSA1, {"A1_EST",     SA2->A2_EST,      Nil})
				aAdd(aSA1, {"A1_PESSOA",  SA2->A2_TIPO,     Nil})
				aAdd(aSA1, {"A1_NOME",    SA2->A2_NOME,     Nil})
				aAdd(aSA1, {"A1_NREDUZ",  SA2->A2_NREDUZ,   Nil})
				aAdd(aSA1, {"A1_END",     SA2->A2_END,      Nil})
				aAdd(aSA1, {"A1_INSCR",   SA2->A2_INSCR,    Nil})
				aAdd(aSA1, {"A1_COD_MUN", SA2->A2_COD_MUN,  Nil})
				aAdd(aSA1, {"A1_MUN",     SA2->A2_MUN,      Nil})
				aAdd(aSA1, {"A1_BAIRRO",  SA2->A2_BAIRRO,   Nil})
				aAdd(aSA1, {"A1_CEP",     SA2->A2_CEP,      Nil})
				aAdd(aSA1, {"A1_DDD",     SA2->A2_DDD,      Nil})
				aAdd(aSA1, {"A1_TEL",     SA2->A2_TEL,      Nil})
				aAdd(aSA1, {"A1_FAX",     SA2->A2_FAX,      Nil})
				aAdd(aSA1, {"A1_EMAIL",   SA2->A2_EMAIL,    Nil})
				aAdd(aSA1, {"A1_CONTATO", SA2->A2_CONTATO,  Nil})
				aAdd(aSA1, {"A1_NATUREZ", cNatAux,          Nil})
				aAdd(aSA1, {"A1_VEND",    cVenAux,          Nil})
				aAdd(aSA1, {"A1_SATIV1",  cSatAux,          Nil})
				
				Begin Transaction
					lMsErroAuto := .F.
					MSExecAuto({|x, y| Mata030(x, y)}, aSA1, 3)
					
					//Se houve erro, disarma a transação
					If lMsErroAuto
						lRet := .F.
						MostraErro()
						DisarmTransaction()
						
					Else
						//Grava o cliente no fornecedor
						RecLock('SA2', .F.)
							A2_X_CLCOD   := cCodCli
							A2_X_CLLOJ := "01"
						SA2->(MsUnlock())
					EndIf
				End Transaction
			EndIf
		EndIf
	Else
		lRet := .F.
	EndIf
	
	RestArea(aArea)
Return lRet