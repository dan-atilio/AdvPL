/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2015/11/19/vd-advpl-008/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zBanco
Exemplo de manipulação de Banco de Dados via AdvPL
@author Atilio
@since 15/11/2015
@version 1.0
	@example
	u_zBanco()
/*/

User Function zBanco()
	Local aArea		:= GetArea()
	Local aAreaB1		:= SB1->(GetArea())
	Local cMens		:= ""
	
	//Se a tabela já estiver posicionada
	If Select("SB1") > 0
		MsgStop("Tabela SB1 já está aberta!", "Atenção")
	EndIf
	
	//Selecionando a tabela de produtos
	DbSelectArea("SB1")
	SB1->(DbSetOrder(1)) // B1_FILIAL+B1_COD
	SB1->(DbGoTop())
	
	//Posicionando no produto de código F00002
	If SB1->(DbSeek(FWxFilial("SB1") + "F00002"))
		Alert(SB1->B1_DESC)
	EndIf
	
	//Agora, percorro todos os registros e adiciono a descrição em uma variável
	SB1->(DbGoTop())
	While !SB1->(EoF())
		cMens += Alltrim(SB1->B1_DESC)+";"+Chr(13)+Chr(10)
	
		SB1->(DbSkip())
	EndDo
	
	//Mostrando a mensagem
	Aviso('Atenção', cMens, {'OK'}, 03)
	
	RestArea(aAreaB1)
	RestArea(aArea)
Return

/*
O ideal de usar referências:
Modo Errado:
	DbSelectArea("SB1")
	
	While ! EoF()
		//Tratamentos para o relatório....
		
		DbSelectArea("SB2")
		//Pega o saldo do produto
		
		DbSkip()
	EndDo

Modo Certo:
	DbSelectArea("SB1")
	DbSelectArea("SB2")
	
	//Referencia a tabela de produtos
	While ! SB1->(EoF())
		//Tratamentos para o relatório....
		
		DbSelectArea("SB2")
		//Pega o saldo do produto
		
		SB1->(DbSkip())
	EndDo
*/