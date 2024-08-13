/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/25/definindo-um-atalho-do-teclado-com-a-setkey-maratona-advpl-e-tl-437/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe437
Adiciona um atalho do teclado para executar funcionalidades
@type Function
@author Atilio
@since 30/03/2023
@see https://tdn.totvs.com/display/tec/SetKey
@obs 
    Função SetKey
    Parâmetros
        + nCodKey     , Numérico        , Número do atalho (veja mais sobre no link do TDN acima)
        + bAcao       , Bloco de Código , Bloco com a função que será executada
    Retorno
        + bRet        , Bloco de Código , Bloco que estava definido anteriormente

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe437()
    Local aArea := FWGetArea()

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
