/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2017/03/28/funcao-testa-se-esta-utilizando-sigamdi-em-advpl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zIsMDI
Função que retorna se está utilizando o MDI (SIGAMDI)
@type function
@author Atilio
@since 06/11/2016
@version 1.0
@return lRet, .T. (se está utilizanod o MDI) ou .F. (caso não esteja, como SIGAADV, SIGAFAT, etc)
	@example
	u_zIsMDI()
/*/

User Function zIsMDI()
	Local aArea := GetArea()
	Local lRet  := .F.

	//Se tiver instanciado no objeto oApp
	If Type("oApp") == "O"
		lRet := oApp:lMDI
	EndIf

	RestArea(aArea)
Return lRet