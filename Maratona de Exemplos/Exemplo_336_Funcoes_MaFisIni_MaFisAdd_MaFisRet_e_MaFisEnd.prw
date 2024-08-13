/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/05/calculando-impostos-com-mafisini-mafisadd-mafisret-e-mafisend-maratona-advpl-e-tl-336/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe336
Cálcula os impostos de um pedido ou documento
@type Function
@author Atilio
@since 12/03/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=605868324 e https://tdn.totvs.com/pages/releaseview.action?pageId=605867908
@obs 

    Função MaFisIni
    Parâmetros
        01 - Codigo Cliente/Fornecedor
        02 - Loja do Cliente/Fornecedor
        03 - C:Cliente , F:Fornecedor
        04 - Tipo da NF
        05 - Tipo do Cliente/Fornecedor
        06 - Relacao de Impostos que suportados no arquivo
        07 - Tipo de complemento
        08 - Permite Incluir Impostos no Rodape .T./.F.
        09 - Alias do Cadastro de Produtos - ("SBI" P/ Front Loja)
        10 - Nome da rotina que esta utilizando a funcao
    Retorno
        Função não tem retorno

    Função MaFisAdd
    Parâmetros
        01 - Codigo do Produto
        02 - Codigo do TES
        03 - Quantidade
        04 - Preco Unitario
        05 - Desconto
        06 - Numero da NF Original  ( Devolucao/Benef )
        07 - Serie da NF Original  ( Devolucao/Benef )
        08 - RecNo da NF Original no arq SD1/SD2
        09 - Valor do Frete do Item
        10 - Valor da Despesa do item
        11 - Valor do Seguro do item
        12 - Valor do Frete Autonomo
        13 - Valor da Mercadoria
        14 - Valor da Embalagem
        15 - RecNo do SB1
        16 - RecNo do SF4
    Retorno
        Função não tem retorno

    Função MaFisRet
    Parâmetros
        Posição do item (ou vazio se for do documento)
        Nome do valor a ser buscado
    Retorno
        Retorna o valor pesquisado

    Função MaFisEnd
    Parâmetros
        Função não tem parâmetros
    Retorno
        Função não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe336()
    Local aArea     := FWGetArea()
    Local aAreaBkp
    Local cPedido   := FWInputBox("Digite um número de pedido:")
    Local cMensagem := ""

    DbSelectArea("SC5")
    SC5->(DbSetOrder(1)) // Filial + Pedido
    DbSelectArea("SC6")
    SC6->(DbSetOrder(1)) // Filial + Pedido + Item + Produto
    DbSelectArea("SB1")
    SB1->(DbSetOrder(1)) // Filial + Produto

    //Posicionar na SC5 com MsSeek antes desse trecho
    If SC5->(MsSeek(FWxFilial("SC5") + cPedido))
    
        MaFisIni(;
            SC5->C5_CLIENTE,;                        // 01 - Codigo Cliente/Fornecedor
            SC5->C5_LOJACLI,;                        // 02 - Loja do Cliente/Fornecedor
            Iif(SC5->C5_TIPO $ "D;B", "F", "C"),;    // 03 - C:Cliente , F:Fornecedor
            SC5->C5_TIPO,;                           // 04 - Tipo da NF
            SC5->C5_TIPOCLI,;                        // 05 - Tipo do Cliente/Fornecedor
            MaFisRelImp("MT100", {"SF2", "SD2"}),;   // 06 - Relacao de Impostos que suportados no arquivo
            ,;                                       // 07 - Tipo de complemento
            ,;                                       // 08 - Permite Incluir Impostos no Rodape .T./.F.
            "SB1",;                                  // 09 - Alias do Cadastro de Produtos - ("SBI" P/ Front Loja)
            "MATA461";                               // 10 - Nome da rotina que esta utilizando a funcao
        )

        //Enquanto houver itens
        SC6->(MsSeek(FWxFilial('SC6') + SC5->C5_NUM))
        aAreaBkp := SC6->(FWGetArea())
        nItAtu := 0
        While ! SC6->(EoF()) .And. SC6->C6_NUM == SC5->C5_NUM
            nItAtu++
        
            //Adiciona o item nos tratamentos de impostos
            SB1->(MsSeek(FWxFilial("SB1")+SC6->C6_PRODUTO))
            nQtdPeso := SB1->B1_PESO
            MaFisAdd(;
                SC6->C6_PRODUTO,;    // 01 - Codigo do Produto                    ( Obrigatorio )
                SC6->C6_TES,;        // 02 - Codigo do TES                        ( Opcional )
                SC6->C6_QTDVEN,;     // 03 - Quantidade                           ( Obrigatorio )
                SC6->C6_PRCVEN,;     // 04 - Preco Unitario                       ( Obrigatorio )
                SC6->C6_VALDESC,;    // 05 - Desconto
                SC6->C6_NFORI,;      // 06 - Numero da NF Original                ( Devolucao/Benef )
                SC6->C6_SERIORI,;    // 07 - Serie da NF Original                 ( Devolucao/Benef )
                0,;                  // 08 - RecNo da NF Original no arq SD1/SD2
                0,;                  // 09 - Valor do Frete do Item               ( Opcional )
                0,;                  // 10 - Valor da Despesa do item             ( Opcional )
                0,;                  // 11 - Valor do Seguro do item              ( Opcional )
                0,;                  // 12 - Valor do Frete Autonomo              ( Opcional )
                SC6->C6_VALOR,;      // 13 - Valor da Mercadoria                  ( Obrigatorio )
                0,;                  // 14 - Valor da Embalagem                   ( Opcional )
                SB1->(RecNo()),;     // 15 - RecNo do SB1
                0;                   // 16 - RecNo do SF4
            )

            MaFisLoad("IT_VALMERC", SC6->C6_VALOR, nItAtu)                
            MaFisAlt("IT_PESO", nQtdPeso, nItAtu)
                
            SC6->(DbSkip())
        EndDo
                    
        //Altera dados do cabeçalho
        MaFisAlt("NF_FRETE", SC5->C5_FRETE)
        MaFisAlt("NF_SEGURO", SC5->C5_SEGURO)
        MaFisAlt("NF_DESPESA", SC5->C5_DESPESA) 
        MaFisAlt("NF_AUTONOMO", SC5->C5_FRETAUT)
        If SC5->C5_DESCONT > 0
            MaFisAlt("NF_DESCONTO", Min(MaFisRet(, "NF_VALMERC")-0.01, SC5->C5_DESCONT+MaFisRet(, "NF_DESCONTO")) )
        EndIf
        If SC5->C5_PDESCAB > 0
            MaFisAlt("NF_DESCONTO", A410Arred(MaFisRet(, "NF_VALMERC")*SC5->C5_PDESCAB/100, "C6_VALOR") + MaFisRet(, "NF_DESCONTO"))
        EndIf
            
        //Agora reposiciona nos itens para poder pegar os dados
        FWRestArea(aAreaBkp)
        nItAtu    := 0
        nTotalST  := 0
        nTotIPI   := 0
        nValorTot := 0
        While ! SC6->(EoF()) .And. SC6->C6_NUM == SC5->C5_NUM                
            nItAtu++
        
            //Pega os valores
            nBasICM    := MaFisRet(nItAtu, "IT_BASEICM")
            nValICM    := MaFisRet(nItAtu, "IT_VALICM")
            nValIPI    := MaFisRet(nItAtu, "IT_VALIPI")
            nAlqICM    := MaFisRet(nItAtu, "IT_ALIQICM")
            nAlqIPI    := MaFisRet(nItAtu, "IT_ALIQIPI")
            nValSol    := (MaFisRet(nItAtu, "IT_VALSOL") / SC6->C6_QTDVEN) 
            nBasSol    := MaFisRet(nItAtu, "IT_BASESOL")
            nPrcUniSol := SC6->C6_PRCVEN + nValSol
            nTotSol    := nPrcUniSol * SC6->C6_QTDVEN
            nTotalST   += MaFisRet(nItAtu, "IT_VALSOL")
            nTotIPI    += nValIPI
            nValorTot  += SC6->C6_VALOR
                
            SC6->(DbSkip())
        EndDo
        nTotFrete := MaFisRet(, "NF_FRETE")
        nTotVal := MaFisRet(, "NF_TOTAL")
        MaFisEnd()

        //Monta a mensagem e exibe
        cMensagem := "Pedido " + SC5->C5_NUM + CRLF + CRLF
        cMensagem += "Total ST:    " + cValToChar(nTotalST)  + CRLF
        cMensagem += "Total IPI:   " + cValToChar(nTotIPI)   + CRLF
        cMensagem += "Total Frete: " + cValToChar(nTotFrete) + CRLF
        cMensagem += "Total Valor: " + cValToChar(nTotVal)   + CRLF
        ShowLog(cMensagem)
    EndIf

    FWRestArea(aArea)
Return
