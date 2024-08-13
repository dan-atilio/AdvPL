/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/06/faturando-um-pedido-atraves-da-mapvlnfs-maratona-advpl-e-tl-339/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe338
Efetua a liberação dos itens de um pedido de venda
@type Function
@author Atilio
@since 12/03/2023
@obs 

    Função MaLibDoFat
    Parâmetros
        Recno da SC6
        Quantidade a ser liberada
        Bloqueio de Crédito
        Bloqueio de Estoque
        Avaliação do Crédito
        Avaliação do Estoque
        Permite Liberação Parcial
        Transfere Locais Automaticamente
    Retorno
        A quantidade liberada para aquele item do pedido

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe338()
    Local aArea     := FWGetArea()
    Local cPedido   := FWInputBox("Digite um número de pedido:")

    DbSelectArea("SC5")
    SC5->(DbSetOrder(1)) // C5_FILIAL + C5_NUM
    DbSelectArea("SC6")
    SC6->(DbSetOrder(1)) // C6_FILIAL + C6_NUM + C6_ITEM + C6_PRODUTO
    DbSelectArea("SC9")
    SC9->(DbSetOrder(1)) // C9_FILIAL + C9_PEDIDO + C9_ITEM + C9_SEQUEN + C9_PRODUTO + C9_BLEST + C9_BLCRED

    //Somente se encontrar o pedido e ele não tiver tido nota emitida ainda
    If SC5->(MsSeek(FWxFilial("SC5") + cPedido)) .And. Empty(SC5->C5_NOTA)
        SC6->(DbGoTop())
        SC6->( MsSeek( SC5->C5_FILIAL + SC5->C5_NUM ) )

        //Estorna as liberações
        While ! SC6->(EoF()) .And. SC6->C6_FILIAL = SC5->C5_FILIAL .And. SC6->C6_NUM == SC5->C5_NUM
            //Posiciona na liberação do item do pedido e estorna a liberação
            SC9->(DbSeek(FWxFilial('SC9')+SC6->C6_NUM+SC6->C6_ITEM))
            While  ! SC9->(EoF()) .And. SC9->(C9_FILIAL+C9_PEDIDO+C9_ITEM) == FWxFilial('SC9')+SC6->(C6_NUM+C6_ITEM)
                SC9->(a460Estorna(.T.))
                SC9->(DbSkip())
            EndDo
    
            SC6->(DbSkip())
        EndDo

        //Define que o pedido foi liberado
        RecLock("SC5", .F.)
            SC5->C5_LIBEROK := 'S'            
        SC5->(MsUnlock())

        SC6->(DbGoTop())
        SC6->( MsSeek( SC5->C5_FILIAL + SC5->C5_NUM ) )
        While !SC6->(Eof()) .And. SC5->C5_NUM == SC6->C6_NUM

            MaLibDoFat(;
                SC6->(RecNo()),; //nRegSC6
                SC6->C6_QTDVEN,; //nQtdaLib
                ,;               //lCredito
                ,;               //lEstoque
                .T.,;            //lAvCred
                .T.,;            //lAvEst
                .F.,;            //lLibPar
                .F.;             //lTrfLocal
            )
            SC6->(DbSkip())   
        EndDo
    EndIf

    FWRestArea(aArea)
Return
