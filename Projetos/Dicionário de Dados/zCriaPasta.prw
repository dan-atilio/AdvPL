/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2016/12/13/funcao-para-criar-pastas-abas-sxa-em-advpl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zCriaPasta
Função que verifica se a pasta já existe, se não existir, cria a pasta
@type function
@author Atilio
@since 02/12/2015
@version 1.0
	@param cTabela, character, (Descrição do parÃ¢metro)
	@param cDescPasta, character, (Descrição do parÃ¢metro)
	@return cPasta, Código da pasta criada / existente
	@example
	u_zCriaPasta("SB1", "TESTE")
/*/

User Function zCriaPasta(cTabela, cDescPasta)
	Local aArea := GetArea()
	Local cPasta := ''

	//Abrindo a tabela de pastas
	DbSelectArea('SXA')
	SXA->(DbSetOrder(1)) //XA_ALIAS+XA_ORDEM
	SXA->(DbGoTop())
	
	//Se conseguir posicionar na tabela
	If (SXA->(DbSeek(cTabela)))
		cPasta := ''
		
		//Enquanto houver registros na tabela de pastas / abas e for a mesma tabela
		While !SXA->(EOF()) .And. (SXA->XA_ALIAS == cTabela)
			//Se for a mesma descrição de tabela, pega o código da pasta atual e sai do laço de repetição
			If Upper(AllTrim(SXA->XA_DESCRIC)) == Upper(AllTrim(cDescPasta))
				cPasta := SXA->XA_ORDEM
				Exit
			EndIf
			
			SXA->(DbSkip())
		EndDo
		
		//Se ele não encontrou a pasta
		If Empty(cPasta)
			//Enquanto houver registros na tabela de pastas / abas e for a mesma tabela
			SXA->(DbGoTop())
			SXA->(DbSeek(cTabela))
			While !SXA->(EOF()) .And. (SXA->XA_ALIAS == cTabela)
				cPasta := SXA->XA_ORDEM
				
				SXA->(DbSkip())
			EndDo
			
			//Somando a pasta
			cPasta := Soma1(cPasta)
		EndIf
	
	//Senão, será a primeira pasta
	Else
		cPasta := StrTran(Space(Len(SXA->XA_ORDEM)), ' ', '0')
		cPasta := Soma1(cPasta)
	EndIf

	//Se não conseguir posicionar na aba dessa tabela
	If !SXA->(DbSeek(cTabela + cPasta))
		RecLock('SXA',.T.)
			XA_ALIAS    := cTabela
			XA_ORDEM    := cPasta
			XA_DESCRIC  := cDescPasta
			XA_DESCSPA  := cDescPasta
			XA_DESCENG  := cDescPasta
			XA_PROPRI   := 'U'
		SXA->(MsUnlock())
	EndIf

	RestArea(aArea)
Return cPasta