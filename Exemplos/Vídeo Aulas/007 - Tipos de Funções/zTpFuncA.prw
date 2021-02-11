/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2015/11/17/vd-advpl-007/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zTpFuncA
Teste de Função de Usuário
@type function
@author Atilio
@since 13/11/2015
@version 1.0
	@example
	u_zTpFuncA()
/*/

User Function zTpFuncA()
	Local aArea := GetArea()
	
	//Chamada de função padrão
	Mata010()

	//Chamada de função de usuário
	u_zTpFuncB()
	
	//Chamada de função estática no mesmo prw
	fTesteA()
	
	//Chamada de função estática de outro prw
	StaticCall(zTpFuncB, fTesteB, "Daniel")
	
	RestArea(aArea)
Return


/*-------------------------------------------------*
 | Função: fTesteA                                 |
 | Autor:  Daniel Atilio                           |
 | Data:   13/11/2015                              |
 | Descr.: Função estática de teste                |
 *-------------------------------------------------*/

Static Function fTesteA()
	Local aArea := GetArea()
	
	//Mostrando mensagem
	MsgInfo("Estou em uma função estática <b>(A)</b>!", "Atenção")
	
	RestArea(aArea)
Return