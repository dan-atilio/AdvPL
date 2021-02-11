/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2017/09/12/funcao-para-alterar-um-parametro-logico-sx6/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zAltPar
Função que altera parÃ¢metros do tipo Lógico (deve ser um parÃ¢metro com conteúdo lógico na SX6, por exemplo, "MV_CHVNFE")
@author Atilio
@since 25/04/2017
@version 1.0
@type function
	@param cParametro, Character, Código do parÃ¢metro que será atualizado
/*/

User Function zAltPar(cParametro)
	Local aArea    := GetArea()
	Local lConsAtu := Nil
	Local lConsNov := Nil
	Local nOpcao   := 0
	Local aBotoes  := {}
	Local cMensag  := ""
	Default cParametro := ""
	
	//Se tiver parÃ¢metro
	If !Empty(cParametro)
		lConsAtu := GetNewPar(cParametro, .F.)
		
		//Adiciona os botÃµes
		aAdd(aBotoes, Iif(lConsAtu,  "Manter Habilitado",   "Habilitar"))   //Opção 1
		aAdd(aBotoes, Iif(!lConsAtu, "Manter Desabilitado", "Desabilitar")) //Opção 2
		aAdd(aBotoes, "Cancelar")                                           //Opção 3
		
		//Mostra o aviso e pega o botão
		cMensag := "Atualmente o parÃ¢metro esta " + Iif(lConsAtu, "HABILITADO", "DESABILITADO") + "." + CRLF
		cMensag += "Deseja alterar?"
		nOpcao := Aviso("Atenção", cMensag, aBotoes, 2)
		
		//Definindo a opção nova
		If nOpcao == 1
			lConsNov := .T.
		ElseIf nOpcao == 2
			lConsNov := .F.
		EndIf
		
		//Se não for nulo
		If lConsNov != Nil
			//Se o conteúdo novo for diferente do atual
			If lConsNov != lConsAtu
				PutMV(cParametro, lConsNov)
				
				Final("Atenção", "A tela será fechada e deve ser aberta novamente!")
			EndIf
		EndIf
	EndIf
	
	RestArea(aArea)
Return