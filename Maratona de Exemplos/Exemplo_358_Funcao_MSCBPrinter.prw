/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/16/abrindo-o-banco-de-conhecimento-com-a-msdocument-maratona-advpl-e-tl-359/
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} User Function zExe358
Realiza a impressão de uma etiqueta em uma impressora térmica
@type Function
@author Atilio
@since 26/03/2023
@see https://tdn.totvs.com/display/public/mp/MSCBPrinter+-+Configura+Impressora+--+30557
@obs 
    Função MSCBPrinter
    Parâmetros
        + cModelPrt   , Caractere        , String com o nome do modelo da impressora
        + cPorta      , Caractere        , String com o número da porta
        + nDensidade  , Numérico         , Número com densidade
        + nTamanho    , Numérico         , Tamanho da etiqueta em milímetros
        + lSrv        , Lógico           , Se .T. imprime no servidor se .F. na estação
        + nPorta      , Numérico         , Número da porta (outro server)
        + cServer     , Caractere        , Endereço de IP (outro server)
        + cEnv        , Caractere        , Ambiente (outro server)
        + nMemoria    , Numérico         , Número do bloco de memória da impressora
        + cFila       , Caractere        , Pasta onde será gravada a fila de impressão
        + lDrvWin     , Lógico           , Indica se será usado os drivers instalados no Windows
        + cPathSpool  , Caractere        , Diretório do spooler de impressão que irá controlar a fila
    Retorno
        Função não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe358()
    Local aArea     := FWGetArea()
    Local aPergs    := {}
	Local cPedido   := Space(TamSX3('C5_NUM')[1])
    
    //Adicionando os parametros do ParamBox
    aAdd(aPergs, {1, "Pedido",  cPedido,  "", ".T.", "SC5", ".T.", 80,  .F.}) // MV_PAR01
    
    //Se a pergunta for confirma, cria as definicoes do relatorio
    If ParamBox(aPergs, "Informe os parâmetros", , , , , , , , , .F., .F.)
         Processa({|| fMontaRel()}, "Processando...")
    EndIf
     
    FWRestArea(aArea)
Return

Static Function fMontaRel()
    Local cPorta     := "LPT1"
    Local nQtdCopias := 1
    Local nVolIniPvt := 1
    Local nVolFimPvt := 1

    DbSelectArea("SC5")
    SC5->(DbSetOrder(1)) // C5_FILIAL + C5_NUM
    DbSelectArea("SA1")
    SA1->(DbSetOrder(1)) // A1_FILIAL + A1_COD + A1_LOJA
    DbSelectArea("SA4")
    SA4->(DbSetOrder(1)) // A4_FILIAL + A4_COD

    //Somente se conseguir posicionar no pedido
    If SC5->(MsSeek(FWxFilial("SC5") + MV_PAR01))
    
        //Cria a etiqueta com configuração de etiqueta de 80mm
        MSCBPrinter("S600", cPorta, , , .F.)
        MSCBChkStatus(.F.) //Alguns modelos exigem esse comando
        MSCBInfoEti("ETIQUETA", "ROTULO")
        MSCBBegin(nQtdCopias, 6, 81) //Qtde de copias, velocidade (1 a 6) e tamanho da etiqueta em mm
        MSCBBox(02, 03, 98, 78, 3)
            
        //Dados da Empresa com linha de separação
        MSCBSay(005, 006, "Remet.: ",                           "N", "0", "029, 036")
        MSCBSay(026, 006, "Nome da Empresa",                    "N", "0", "043, 053", .F.)
        MSCBSay(005, 013, "Rua Teste 123, Fone: 014 0000-1111", "N", "0", "024, 034")
        MSCBSay(023, 017, "CEP 17000-111, Bauru-SP",            "N", "0", "024, 034")
        MSCBLineH(02, 21, 98, 3)
        
        //Dados do Cliente com linha de separação
        If SA1->(MsSeek(FWxFilial("SA1") + SC5->C5_CLIENTE + SC5->C5_LOJACLI))
            MSCBSay(005, 022, "Codigo: " + SC5->C5_CLIENTE,                                             "N", "0", "029, 036")
            MSCBSay(005, 026, "Cliente: " + SubStr(SA1->A1_NOME, 1, 40),                                "N", "0", "029, 036")
            MSCBSay(005, 030, "End.: " + Alltrim(SA1->A1_END),                                          "N", "0", "024, 034")
            MSCBSay(005, 034, "Bairro: " + Alltrim(SA1->A1_BAIRRO) + "   CEP: " + Alltrim(SA1->A1_CEP), "N", "0", "029, 036")
            MSCBSay(005, 038, "Cidade: " + Alltrim(SA1->A1_MUN) + "   UF: " + Alltrim(SA1->A1_EST),     "N", "0", "026, 036")
            MSCBSay(005, 042, "Telefone: (" + Alltrim(SA1->A1_DDD) +  ") " + Alltrim(SA1->A1_TEL),      "N", "0", "029, 036")
        EndIf
        MSCBLineH(02, 46, 98, 3)
        
        //Dados da Transportadora com linha de separação
        If SA4->(MsSeek(FWxFilial("SA4") + SC5->C5_TRANSP))
            MSCBSay(005, 048, "Transp.: " + Alltrim(SA4->A4_NOME),                                                 "N", "0", "029, 036")
            MSCBSay(005, 052, "Munic.:  " + Alltrim(SA4->A4_MUN),                                                  "N", "0", "021, 031")
            MSCBSay(005, 056, "Redesp.: " + SubStr(SA4->A4_NOME, 1, 20) + " (" + SA4->A4_DDD + ") " + SA4->A4_TEL, "N", "0", "021, 031")
            MSCBSay(005, 060, Alltrim(SA4->A4_END),                                                                "N", "0", "021, 031")
            MSCBSay(005, 064, "Munic.: " + AllTrim(SubStr(SA4->A4_MUN, 1, 20)) + "/" + SA4->A4_EST,                "N", "0", "021, 031")
        EndIf
        MSCBLineH(02, 68, 98, 3)
        
        //Dados da NF
        MSCBSay(005, 069, "Nota Fiscal: " + SC5->C5_NOTA,                                      "N", "0", "024, 034")
        MSCBSay(005, 069, "Pedido n.: " + Alltrim(SC5->C5_NUM) + " (Consta no DANFe)",         "N", "0", "024, 034")
        MSCBSay(037, 073, cValToChar(SC5->C5_VOLUME1) + " " + Upper(Alltrim(SC5->C5_ESPECI1)), "N", "0", "043, 053")
        MSCBSay(005, 073, "Volume: " + cValToChar(nVolIniPvt) + "/" + cValToChar(nVolFimPvt),  "N", "0", "024, 034")

        //Finaliza a etiqueta
        MSCBEnd()
        MSCBClosePrinter()
    EndIf

    FWRestArea(aArea)
Return
