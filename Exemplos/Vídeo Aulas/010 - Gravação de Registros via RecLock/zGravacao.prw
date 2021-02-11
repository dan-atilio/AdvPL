/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2015/11/26/vd-advpl-010/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zGravacao
Exemplo de gravação de dados via RecLock
@type function
@author Atilio
@since 25/11/2015
@version 1.0
	@example
	u_zGravacao()
/*/

User Function zGravacao()
	Local aArea := GetArea()
	
	//Abrindo a tabela de produtos e setando o índice
	DbSelectArea('SB1')
	SB1->(DbSetOrder(1)) //B1_FILIAL + B1_COD
	SB1->(DbGoTop())
	
	//Iniciando a transação, tudo dentro da transação, pode ser desarmado (cancelado)
	Begin Transaction
		MsgInfo("Antes da Alteração!", "Atenção")
		
		//Se conseguir posicionar no produto de código E00001
		If SB1->(DbSeek(FWxFilial('SB1') + 'E00001'))
			//Quando passo .F. no RecLock, o registro é travado para Alteração
			RecLock('SB1', .F.)
				B1_X_CAMPO := "XXX"
				B1_DESC := SB1->B1_DESC + "."
			SB1->(MsUnlock())
			
			/*
				Ao invés de só utilizar o :=, pode se também utilizar o comando Replace:
				Replace [CAMPO] With [CONTEUDO]
				Replace B1_X_CAMPO With "XXX"
			*/
		EndIf
		
		//Quando passo .T. no RecLock, o registro é travado para Inclusão
		RecLock('SB1', .T.)
			B1_FILIAL := FWxFilial('SB1')
		SB1->(MsUnlock())
		
		MsgInfo("Após a Alteração!", "Atenção")
		
		//Ao desarmar a transação, toda a manipulação de dados é cancelada
		DisarmTransaction()
	End Transaction
	
	//Se conseguir posicionar no produto de código E00001
	If SB1->(DbSeek(FWxFilial('SB1') + 'E00001'))
		//Quando faço a alteração fora de uma transação, automaticamente os dados são salvos
		RecLock('SB1', .F.)
			B1_DESC := Alltrim(SB1->B1_DESC) + "."
		SB1->(MsUnlock())
	EndIf
	
	RestArea(aArea)
Return