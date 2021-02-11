/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2016/12/06/funcao-para-pegar-descricao-de-um-campo-combo-em-advpl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zCmbDesc
Função que retorna a descrição da opção do Combo selecionada
@type function
@author Atilio
@since 28/08/2016
@version 1.0
	@param cChave, character, Chave de pesquisa dentro do combo
	@param cCampo, character, Campo do tipo combo
	@param cConteudo, character, Conteúdo no formato de combo
	@return cDescri, Descrição da opção do combo
	@example
	u_zCmbDesc("D", "C5_TIPO", "") //Utilizando por Campo
	u_zCmbDesc("S", "", "S=Sim;N=Não;A=Ambos;") //Utilizando por Conteúdo
/*/

User Function zCmbDesc(cChave, cCampo, cConteudo)
	Local aArea       := GetArea()
	Local aCombo      := {}
	Local nAtual      := 1
	Local cDescri     := ""
	Default cChave    := ""
	Default cCampo    := ""
	Default cConteudo := ""
	
	//Se o campo e o conteúdo estiverem em branco, ou a chave estiver em branco, não há descrição a retornar
	If (Empty(cCampo) .And. Empty(cConteudo)) .Or. Empty(cChave)
		cDescri := ""
	Else
		//Se tiver campo
		If !Empty(cCampo)
			aCombo := RetSX3Box(GetSX3Cache(cCampo, "X3_CBOX"),,,1)
			
			//Percorre as posiçÃµes do combo
			For nAtual := 1 To Len(aCombo)
				//Se for a mesma chave, seta a descrição
				If cChave == aCombo[nAtual][2]
					cDescri := aCombo[nAtual][3]
				EndIf
			Next
			
		//Se tiver conteúdo
		ElseIf !Empty(cConteudo)
			aCombo := StrTokArr(cConteudo, ';')
			
			//Percorre as posiçÃµes do combo
			For nAtual := 1 To Len(aCombo)
				//Se for a mesma chave, seta a descrição
				If cChave == SubStr(aCombo[nAtual], 1, At('=', aCombo[nAtual])-1)
					cDescri := SubStr(aCombo[nAtual], At('=', aCombo[nAtual])+1, Len(aCombo[nAtual]))
				EndIf
			Next
		EndIf
	EndIf
	
	RestArea(aArea)
Return cDescri