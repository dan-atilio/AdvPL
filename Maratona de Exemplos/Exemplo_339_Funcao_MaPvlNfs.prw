/*
    Esse exemplo faz parte da s�rie do YouTube, Maratona de Exemplos, do canal Terminal de Informa��o, 
    caso queira ver esse exemplo rodando em v�deo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/06/liberando-pedidos-de-venda-com-a-malibdofat-maratona-advpl-e-tl-338/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe339
Efetua a gera��o do documento de sa�da pelo pedido de venda liberado
@type Function
@author Atilio
@since 12/03/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=578374528
@obs 

    Fun��o MaPvlNfs
    Par�metros
        + aPvlNfs       , Array           , Array com os itens a serem gerados
        + cSerieNFS     , Caractere       , Serie da Nota Fiscal
        + lMostraCtb    , L�gico          , Mostra Lan�amento Cont�bil
        + lAglutCtb     , L�gico          , Aglutina Lan�amento Cont�bil
        + lCtbOnLine    , L�gico          , Contabiliza On-Line
        + lCtbCusto     , L�gico          , Contabiliza Custo On-Line
        + lReajuste     , L�gico          , Reajuste de pre�o na Nota Fiscal
        + nCalAcrs      , Num�rico        , Tipo de Acr�scimo Financeiro
        + nArredPrcLis  , Num�rico        , Tipo de Arredondamento
        + lAtuSA7       , L�gico          , Atualiza Amarra��o Cliente x Produto
        + lECF          , L�gico          , Cupom Fiscal
        + cEmbExp       , Caractere       , N�mero do Embarque de Exporta��o
        + bAtuFin       , Bloco de C�digo , Bloco de C�digo para complemento de atualiza��o dos t�tulos financeiros
        + bAtuPGerNF    , Bloco de C�digo , Bloco de C�digo para complemento de atualiza��o dos dados ap�s a gera��o da Nota Fiscal
        + bAtuPvl       , Bloco de C�digo , Bloco de C�digo de atualiza��o do Pedido de Venda antes da gera��o da Nota Fiscal
        + bFatSE1       , Bloco de C�digo , Bloco de C�digo para indicar se o valor do Titulo a Receber ser� gravado no campo F2_VALFAT quando o par�metro MV_TMSMFAT estiver com o valor igual a "2".
        + dDataMoe      , Data            , Data da cota��o para convers�o dos valores da Moeda do Pedido de Venda para a Moeda Forte
        + lJunta        , L�gico          , Aglutina Pedido Iguais
    Retorno
        + cNumNFS       , Caractere       , N�mero da NF gerada

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe339()
    Local aArea     := FWGetArea()
    Local cPedido   := FWInputBox("Digite um n�mero de pedido:")
    Local aPvlDocS  := {}
    Local cDocument := ""
    Local cSerie    := "B"
    Local cFunBkp   := ""
    Local lAbortar

    //Somente se n�o tiver sido abortado
    If ! lAbortar

        DbSelectArea("SC5")
        SC5->(DbSetOrder(1)) // C5_FILIAL + C5_NUM

        //Somente se encontrar o pedido e ele n�o tiver tido nota emitida ainda
        If SC5->(MsSeek(FWxFilial("SC5") + cPedido)) .And. Empty(SC5->C5_NOTA)

            DbSelectArea('SC6')
            SC6->(DbSetOrder(1)) // C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
            SC6->(DbGoTop())
            SC6->( MsSeek( SC5->C5_FILIAL + SC5->C5_NUM ) )

            //� necess�rio carregar a pergunta em mem�ria
            Pergunte("MT460A", .F.)

            //Abre as tabelas que ser�o usadas
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

            //Percorre todos os itens do pedido para pode carregar o array que ir� gerar a NF
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
                    .F.,;       // 03 - lMostraCtb   - Mostra Lan�amento Cont�bil
                    .F.,;       // 04 - lAglutCtb    - Aglutina Lan�amento Cont�bil
                    .F.,;       // 05 - lCtbOnLine   - Contabiliza On-Line
                    .T.,;       // 06 - lCtbCusto    - Contabiliza Custo On-Line
                    .F.,;       // 07 - lReajuste    - Reajuste de pre�o na Nota Fiscal
                    0,;         // 08 - nCalAcrs     - Tipo de Acr�scimo Financeiro
                    0,;         // 09 - nArredPrcLis - Tipo de Arredondamento
                    .T.,;       // 10 - lAtuSA7      - Atualiza Amarra��o Cliente x Produto
                    .F.,;       // 11 - lECF         - Cupom Fiscal
                    "",;        // 12 - cEmbExp      - N�mero do Embarque de Exporta��o
                    {||},;      // 13 - bAtuFin      - Bloco de C�digo para complemento de atualiza��o dos t�tulos financeiros
                    {||},;      // 14 - bAtuPGerNF   - Bloco de C�digo para complemento de atualiza��o dos dados ap�s a gera��o da Nota Fiscal
                    {||},;      // 15 - bAtuPvl      - Bloco de C�digo de atualiza��o do Pedido de Venda antes da gera��o da Nota Fiscal
                    {|| .T. },; // 16 - bFatSE1      - Bloco de C�digo para indicar se o valor do Titulo a Receber ser� gravado no campo F2_VALFAT quando o par�metro MV_TMSMFAT estiver com o valor igual a "2".
                    Date(),;    // 17 - dDataMoe     - Data da cota��o para convers�o dos valores da Moeda do Pedido de Venda para a Moeda Forte
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
            FWAlertError("N�o foi poss�vel gerar o Documento de Sa�da!", "Aten��o")
        EndIf
    EndIf

    FWRestArea(aArea)
Return
