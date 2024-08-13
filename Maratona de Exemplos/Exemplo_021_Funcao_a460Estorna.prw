/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/08/29/funcao-a460estorna-para-estornar-as-liberacoes-de-pedido-na-sc9-maratona-advpl-e-tl-021/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe021
Exemplo de função para estornar a liberação de um pedido de venda
@type Function
@author Atilio
@since 26/11/2022
@obs Função a460Estorna
    Parâmetros
        + Identifica se o programa chamador é o pedido de venda
        + Indica se deve atualizar os empenhos
        + Valor a ser adicionado no limite de crédito
        + Tipo da liberação (igual o C5_TIPLIB = "1" por itens e "2" por pedido)
    Retorno
        + Define se o estorno foi executado com sucesso (.T.) ou não (.F.)

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe021()
    Local aArea        := FWGetArea()
    Local cNumPedido   := "000003"

    DbSelectArea("SC5")
	SC5->(DbSetOrder(1)) // C5_FILIAL + C5_NUM
    DbSelectArea('SC6')
	SC6->(DbSetOrder(1)) // C6_FILIAL + C6_NUM + C6_ITEM + C6_PRODUTO
    DbSelectArea('SC9')
	SC9->(DbSetOrder(1)) // C9_FILIAL + C9_PEDIDO + C9_ITEM + C9_SEQUEN + C9_PRODUTO + C9_BLEST + C9_BLCRED

	//Somente se encontrar o pedido
	If SC5->(MsSeek(FWxFilial("SC5") + cNumPedido))
		
        //Posiciona no item do pedido
		If SC6->( MsSeek( SC5->C5_FILIAL + SC5->C5_NUM ) )

            //Percorre todos os itens do pedido de venda
            While ! SC6->(EoF()) .And. SC6->C6_FILIAL == SC5->C5_FILIAL .And. SC6->C6_NUM == SC5->C5_NUM

                //Posiciona na liberação do item do pedido e enquanto houver dados estorna a liberação
                SC9->(MsSeek(FWxFilial('SC9') + SC6->C6_NUM + SC6->C6_ITEM))
                While  ! SC9->(EoF()) .And. SC9->(C9_FILIAL + C9_PEDIDO + C9_ITEM) == FWxFilial('SC9') + SC6->(C6_NUM + C6_ITEM)
                    SC9->(a460Estorna(.T.))
                    SC9->(DbSkip())
                EndDo
    
                SC6->(DbSkip())
            EndDo
        EndIf
    EndIf

    FWRestArea(aArea)
Return
