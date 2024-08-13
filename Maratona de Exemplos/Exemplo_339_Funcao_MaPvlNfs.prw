/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/06/liberando-pedidos-de-venda-com-a-malibdofat-maratona-advpl-e-tl-338/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe339
Efetua a geração do documento de saída pelo pedido de venda liberado
@type Function
@author Atilio
@since 12/03/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=578374528
@obs 

    Função MaPvlNfs
    Parâmetros
        + aPvlNfs       , Array           , Array com os itens a serem gerados
        + cSerieNFS     , Caractere       , Serie da Nota Fiscal
        + lMostraCtb    , Lógico          , Mostra Lançamento Contábil
        + lAglutCtb     , Lógico          , Aglutina Lançamento Contábil
        + lCtbOnLine    , Lógico          , Contabiliza On-Line
        + lCtbCusto     , Lógico          , Contabiliza Custo On-Line
        + lReajuste     , Lógico          , Reajuste de preço na Nota Fiscal
        + nCalAcrs      , Numérico        , Tipo de Acréscimo Financeiro
        + nArredPrcLis  , Numérico        , Tipo de Arredondamento
        + lAtuSA7       , Lógico          , Atualiza Amarração Cliente x Produto
        + lECF          , Lógico          , Cupom Fiscal
        + cEmbExp       , Caractere       , Número do Embarque de Exportação
        + bAtuFin       , Bloco de Código , Bloco de Código para complemento de atualização dos títulos financeiros
        + bAtuPGerNF    , Bloco de Código , Bloco de Código para complemento de atualização dos dados após a geração da Nota Fiscal
        + bAtuPvl       , Bloco de Código , Bloco de Código de atualização do Pedido de Venda antes da geração da Nota Fiscal
        + bFatSE1       , Bloco de Código , Bloco de Código para indicar se o valor do Titulo a Receber será gravado no campo F2_VALFAT quando o parâmetro MV_TMSMFAT estiver com o valor igual a "2".
        + dDataMoe      , Data            , Data da cotação para conversão dos valores da Moeda do Pedido de Venda para a Moeda Forte
        + lJunta        , Lógico          , Aglutina Pedido Iguais
    Retorno
        + cNumNFS       , Caractere       , Número da NF gerada

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe339()
    Local aArea     := FWGetArea()
    Local cPedido   := FWInputBox("Digite um número de pedido:")
    Local aPvlDocS  := {}
    Local cDocument := ""
    Local cSerie    := "B"
    Local cFunBkp   := ""
    Local lAbortar

    //Somente se não tiver sido abortado
    If ! lAbortar

        DbSelectArea("SC5")
        SC5->(DbSetOrder(1)) // C5_FILIAL + C5_NUM

        //Somente se encontrar o pedido e ele não tiver tido nota emitida ainda
        If SC5->(MsSeek(FWxFilial("SC5") + cPedido)) .And. Empty(SC5->C5_NOTA)

            DbSelectArea('SC6')
            SC6->(DbSetOrder(1)) // C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
            SC6->(DbGoTop())
            SC6->( MsSeek( SC5->C5_FILIAL + SC5->C5_NUM ) )

            //É necessário carregar a pergunta em memória
            Pergunte("MT460A", .F.)

            //Abre as tabelas que serão usadas
            DbSelectArea("SC9")
            SC9->(DbSetOrder(1)) //C9_FILIAL + C9_PEDIDO + C9_ITEM + C9_SEQUEN + C9_PRODUTO + C9_BLEST + C9_BLCRED
            DbSelectArea("SE4")
            SE4->(DbSetOrder(1)) //E4_FILIAL + E4_CODIGO
            DbSelectArea("SB1")
            SB1->(DbSetOrder(1)) //B1_FILIAL + B1_COD
            DbSelectArea("SB2")
            SB2->(DbSetOrder(1)) //B2_FILIAL + B2_COD + B2_LOCAL
            DbSelectArea("SF4")
            SF4->(DbSetOrder(1)) //F4_FILIAL + F4_CODIGO

            //Percorre todos os itens do pedido para pode carregar o array que irá gerar a NF
            While ! SC6->(Eof()) .And. SC6->C6_FILIAL == SC5->C5_FILIAL .And. SC6->C6_NUM == SC5->C5_NUM

                //Posiciona nas tabelas
                SC9->(MsSeek(FWxFilial("SC9")+SC6->(C6_NUM+C6_ITEM)))
                SE4->(MsSeek(FWxFilial("SE4")+SC5->C5_CONDPAG) )
                SB1->(MsSeek(FWxFilial("SB1")+SC6->C6_PRODUTO))
                SB2->(MsSeek(FWxFilial("SB2")+SC6->(C6_PRODUTO+C6_LOCAL)))
                SF4->(MsSeek(FWxFilial("SF4")+SC6->C6_TES))

                //Se tiver liberado o BLEST e BLCRED
                If Empty(SC9->C9_BLEST) .And. Empty(SC9->C9_BLCRED)
                    aAdd(aPvlDocS,{ SC9->C9_PEDIDO,;
                                    SC9->C9_ITEM,;
                                    SC9->C9_SEQUEN,;
                                    SC9->C9_QTDLIB,;
                                    SC9->C9_PRCVEN,;
                                    SC9->C9_PRODUTO,;
                                    .F.,;
                                    SC9->(RecNo()),;
                                    SC5->(RecNo()),;
                                    SC6->(RecNo()),;
                                    SE4->(RecNo()),;
                                    SB1->(RecNo()),;
                                    SB2->(RecNo()),;
                                    SF4->(RecNo())})
                EndIf

                SC6->(DbSkip())
            EndDo

            If Len(aPvlDocS) > 0
                cFunBkp := FunName()
                SetFunName("MATA461")
                cDocument := MaPvlNfs(;
                    aPvlDocS,;  // 01 - aPvlNfs      - Array com os itens a serem gerados
                    cSerie,;    // 02 - cSerieNFS   - Serie da Nota Fiscal
                    .F.,;       // 03 - lMostraCtb   - Mostra Lançamento Contábil
                    .F.,;       // 04 - lAglutCtb    - Aglutina Lançamento Contábil
                    .F.,;       // 05 - lCtbOnLine   - Contabiliza On-Line
                    .T.,;       // 06 - lCtbCusto    - Contabiliza Custo On-Line
                    .F.,;       // 07 - lReajuste    - Reajuste de preço na Nota Fiscal
                    0,;         // 08 - nCalAcrs     - Tipo de Acréscimo Financeiro
                    0,;         // 09 - nArredPrcLis - Tipo de Arredondamento
                    .T.,;       // 10 - lAtuSA7      - Atualiza Amarração Cliente x Produto
                    .F.,;       // 11 - lECF         - Cupom Fiscal
                    "",;        // 12 - cEmbExp      - Número do Embarque de Exportação
                    {||},;      // 13 - bAtuFin      - Bloco de Código para complemento de atualização dos títulos financeiros
                    {||},;      // 14 - bAtuPGerNF   - Bloco de Código para complemento de atualização dos dados após a geração da Nota Fiscal
                    {||},;      // 15 - bAtuPvl      - Bloco de Código de atualização do Pedido de Venda antes da geração da Nota Fiscal
                    {|| .T. },; // 16 - bFatSE1      - Bloco de Código para indicar se o valor do Titulo a Receber será gravado no campo F2_VALFAT quando o parâmetro MV_TMSMFAT estiver com o valor igual a "2".
                    Date(),;    // 17 - dDataMoe     - Data da cotação para conversão dos valores da Moeda do Pedido de Venda para a Moeda Forte
                    .F.;        // 18 - lJunta       - Aglutina Pedido Iguais
                )
                SetFunName(cFunBkp)
                
                If Empty(cDocument)
                    lAbortar := .T.
                Else
                    FWAlertSuccess("Documento gerado: " + cDocument, "Teste MaPvlNfs")
                EndIf
            Else
                lAbortar := .T.
            EndIf
        EndIf

        If lAbortar
            FWAlertError("Não foi possível gerar o Documento de Saída!", "Atenção")
        EndIf
    EndIf

    FWRestArea(aArea)
Return
