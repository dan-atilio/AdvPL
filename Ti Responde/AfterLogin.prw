/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2022/05/30/canivete-suico-de-atalhos-uteis-ti-responde-009/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function AfterLogin
Ponto de Entrada ao abrir o sistema ou alguma tela se for SIGAMDI
@type  Function
@author Atilio
@since 22/09/2021
@see https://tdn.totvs.com/pages/viewpage.action?pageId=6815186
/*/

User Function AfterLogin()
	Local aArea := FWGetArea()

	u_zVid0028()

	/*
		Atalho:    Ctrl + L
		Função:    zSearch
		Descrição: Abre uma tela de pesquisa de campos em um cadastro do Protheus
		Download:  https://terminaldeinformacao.com/2018/04/03/pesquisa-de-campos-em-telas-protheus/
	*/
	SetKey(K_CTRL_L, {|| u_zSearch() })

	/*
		Atalho:    Shift + F7
		Função:    zIsMVC
		Descrição: Verifica se uma rotina é em MVC, montando também um exemplo de ponto de entrada
		Download:  https://terminaldeinformacao.com/2018/04/24/saiba-como-identificar-se-uma-funcao-e-em-mvc-como-fazer-seu-ponto-de-entrada/
	*/
	SetKey(K_SH_F7, {|| u_zIsMVC() })

	/*
		Atalho:    Shift + F8
		Função:    zMiniForm
		Descrição: Abre uma tela para executar fórmulas no Protheus
		Download:  https://terminaldeinformacao.com/2018/02/13/funcao-para-executar-formulas-protheus-12/
	*/
	SetKey(K_SH_F8, {|| u_zMiniForm() })
	
	/*
		Atalho:    Shift + F9
		Função:    zFazErro
		Descrição: Força um Error Log para analisar a pilha de chamadas e ver onde a função esta travada
	*/
	SetKey(K_SH_F9, {|| u_zFazErro() })

	/*
		Atalho:    Shift + F11
		Função:    zTiSQL
		Descrição: Abre uma tela para execução de queries SQL, ideal para quem usa Cloud
		Download:  https://terminaldeinformacao.com/2021/11/05/tela-que-executa-consultas-sql-via-advpl/
	*/
	SetKey(K_SH_F11, { || u_zTiSQL() }) //Shift + F11
	
	FWRestArea(aArea)
Return

/*/{Protheus.doc} User Function zFazErro
Função criada, com intuito de gerar error log para análise de pilha de chamadas
@type  Function
@author Atilio
@since 28/01/2022
/*/

User Function zFazErro()
	Local cVar := ""
	Local nVar := 0
	
	Alert(cVar + nVar)
Return
