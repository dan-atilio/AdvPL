/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/10/17/buscando-o-saldo-de-um-produto-atraves-da-funcao-calcest-maratona-advpl-e-tl-070/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe070
Exemplo para retornar o saldo do estoque de um produto
@type Function
@author Atilio
@since 06/12/2022
@see https://centraldeatendimento.totvs.com/hc/pt-br/articles/4880693700375-Cross-Segmento-Backoffice-Linha-Protheus-SIGAEST-Fun%C3%A7%C3%A3o-CalcEst-
@obs 
    Função CalcEst
    Parâmetros
        + cCod           , Caractere     , Código do Produto
        + cLocal         , Caractere     , Código do Armazém
        + dData          , Data          , Data a computar o saldo
        + cFilAux        , Caractere     , Filial (parâmetro em desuso)
        + lConsTesTerc   , Lógico        , .T. se considera poder de terceiros ou .F. se não
        + lCusRep        , Lógico        , .T. se considera custo de reposição ou .F. se não
    Retorno
        + aSaldo         , Array         , Array contendo os dados encontrados (verificar as posições abaixo)

    Posições do aSaldo:
    aSaldo[01] : Quantidade
	aSaldo[02] : Valor Moeda 1
	aSaldo[03] : Valor Moeda 2
	aSaldo[04] : Valor Moeda 3
	aSaldo[05] : Valor Moeda 4
	aSaldo[06] : Valor Moeda 5
	aSaldo[07] : Quantidade da segunda unidade de medida
	aSaldo[08] : Custo Médio 1
	aSaldo[09] : Custo Médio 2
	aSaldo[10] : Custo Médio 3
	aSaldo[11] : Custo Médio 4
	aSaldo[12] : Custo Médio 5

	Caso seja informado o lCusRep:
	aSaldo[13] : Custo de Reposição Unitário da Moeda 1
	aSaldo[14] : Custo de Reposição Unitário da Moeda 2
	aSaldo[15] : Custo de Reposição Unitário da Moeda 3
	aSaldo[16] : Custo de Reposição Unitário da Moeda 4
	aSaldo[17] : Custo de Reposição Unitário da Moeda 5
	aSaldo[18] : Custo de Reposição da Moeda 1
	aSaldo[19] : Custo de Reposição da Moeda 2
	aSaldo[20] : Custo de Reposição da Moeda 3
	aSaldo[21] : Custo de Reposição da Moeda 4
	aSaldo[22] : Custo de Reposição da Moeda 5

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe070()
    Local aArea    := FWGetArea()
    Local cProduto := ""
    Local cArmazem := ""
    Local dDataFim
    Local aSaldos  := {}

    //Define os parâmetros que serão usados no CalcEst
    cProduto := AvKey("F0001", "B1_COD")
    cArmazem := "01"
    dDataFim := DaySum(Date(), 1)

    //Abre a tabela de produtos
    DbSelectArea("SB1")
    SB1->(DbSetOrder(1)) // B1_FILIAL + B1_COD

    //Posiciona no cadastro
    If SB1->(MsSeek(FWxFilial("SB1") + cProduto))

        //Busca os saldos
        aSaldos := CalcEst(cProduto, cArmazem, dDataFim)
        FWAlertInfo("Saldo atual é de: " + cValToChar(aSaldos[1]), "Teste CalcEst")
    EndIf

    FWRestArea(aArea)
Return
