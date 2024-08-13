/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/18/lendo-e-gravando-em-antigos-campos-memo-com-a-msmm-maratona-advpl-e-tl-362/
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"
 
//Legendas
Static oBmpVerde    := LoadBitmap( GetResources(), "BR_VERDE")
Static oBmpVermelho := LoadBitmap( GetResources(), "BR_VERMELHO")
Static oBmpPreto    := LoadBitmap( GetResources(), "BR_PRETO")
 
/*/{Protheus.doc} User Function zExe363
Cria uma grid usando a classe antiga
@type Function
@author Atilio
@since 27/03/2023
@see https://tdn.totvs.com/display/public/framework/MsNewGetDados
@obs 
    Essa classe foi depreciada, este aqui é só um exemplo, caso precisem algum dia dar manutenção
    em códigos antigos. Para novos códigos, tentem utilizar a FWBrowse.

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

 
User Function zExe363()
    Local aArea := GetArea()
    //Objetos da Janela
    Private oDlgPvt
    Private oMsGetSBM
    Private aHeadSBM := {}
    Private aColsSBM := {}
    Private oBtnSalv
    Private oBtnFech
    Private oBtnLege
    //Tamanho da Janela
    Private nJanLarg    := 700
    Private nJanAltu    := 500
    //Fontes
    Private cFontUti   := "Tahoma"
    Private oFontAno   := TFont():New(cFontUti,,-38)
    Private oFontSub   := TFont():New(cFontUti,,-20)
    Private oFontSubN  := TFont():New(cFontUti,,-20,,.T.)
    Private oFontBtn   := TFont():New(cFontUti,,-14)
     
    //Criando o cabeçalho da Grid
    //              Título               Campo        Máscara                        Tamanho                   Decimal                   Valid               Usado  Tipo F3     Combo
    aAdd(aHeadSBM, {"",                  "XX_COR",    "@BMP",                        002,                      0,                        ".F.",              "   ", "C", "",    "V",     "",      "",        "", "V"})
    aAdd(aHeadSBM, {"Código",            "BM_GRUPO",  "",                            TamSX3("BM_GRUPO")[01],   0,                        ".T.",              ".T.", "C", "",    ""} )
    aAdd(aHeadSBM, {"Descrição",         "BM_DESC",   "",                            TamSX3("BM_DESC")[01],    0,                        "NaoVazio()",       ".T.", "C", "",    ""} )
    aAdd(aHeadSBM, {"Status Grupo",      "BM_STATUS", "",                            TamSX3("BM_STATUS")[01],  0,                        "PERTENCE('1234')", ".T.", "C", "",    "1=Novo;2=Remanufaturado;3=Reciclado;4=Usado"} )
    aAdd(aHeadSBM, {"Procedencia",       "BM_PROORI", "",                            TamSX3("BM_PROORI")[01],  0,                        "Pertence('01')",   ".T.", "C", "",    "1=Original;0=Nao Original"} )
    aAdd(aHeadSBM, {"Total de Produtos", "XX_TOTAL",  "@E 999,999,999,999,999,999",  018,                      0,                        ".T.",              ".T.", "N", "",    ""} )
    aAdd(aHeadSBM, {"SBM Recno",         "XX_RECNO",  "@E 999,999,999,999,999,999",  018,                      0,                        ".T.",              ".T.", "N", "",    ""} )
 
    Processa({|| fCarAcols()}, "Processando")
 
    //Criação da tela com os dados que serão informados
    DEFINE MSDIALOG oDlgPvt TITLE "Grupos de Produto" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
        //Labels gerais
        @ 004, 003 SAY "TST"                SIZE 200, 030 FONT oFontAno  OF oDlgPvt COLORS RGB(149,179,215) PIXEL
        @ 004, 050 SAY "Listagem de"        SIZE 200, 030 FONT oFontSub  OF oDlgPvt COLORS RGB(031,073,125) PIXEL
        @ 014, 050 SAY "Grupos de Produtos" SIZE 200, 030 FONT oFontSubN OF oDlgPvt COLORS RGB(031,073,125) PIXEL
         
        //Botões
        @ 006, (nJanLarg/2-001)-(0052*01) BUTTON oBtnFech  PROMPT "Fechar"        SIZE 050, 018 OF oDlgPvt ACTION (oDlgPvt:End())                               FONT oFontBtn PIXEL
        @ 006, (nJanLarg/2-001)-(0052*02) BUTTON oBtnLege  PROMPT "Legenda"       SIZE 050, 018 OF oDlgPvt ACTION (fLegenda())                                  FONT oFontBtn PIXEL
        @ 006, (nJanLarg/2-001)-(0052*03) BUTTON oBtnSalv  PROMPT "Salvar"        SIZE 050, 018 OF oDlgPvt ACTION (fSalvar())                                   FONT oFontBtn PIXEL
         
        //Grid dos grupos
        oMsGetSBM := MsNewGetDados():New(    029,;                //nTop      - Linha Inicial
                                            003,;                //nLeft     - Coluna Inicial
                                            (nJanAltu/2)-3,;     //nBottom   - Linha Final
                                            (nJanLarg/2)-3,;     //nRight    - Coluna Final
                                            GD_INSERT + GD_UPDATE + GD_DELETE,;                   //nStyle    - Estilos para edição da Grid (GD_INSERT = Inclusão de Linha; GD_UPDATE = Alteração de Linhas; GD_DELETE = Exclusão de Linhas)
                                            "AllwaysTrue()",;    //cLinhaOk  - Validação da linha
                                            ,;                   //cTudoOk   - Validação de todas as linhas
                                            "",;                 //cIniCpos  - Função para inicialização de campos
                                            ,;                   //aAlter    - Colunas que podem ser alteradas
                                            ,;                   //nFreeze   - Número da coluna que será congelada
                                            9999,;               //nMax      - Máximo de Linhas
                                            ,;                   //cFieldOK  - Validação da coluna
                                            ,;                   //cSuperDel - Validação ao apertar '+'
                                            ,;                   //cDelOk    - Validação na exclusão da linha
                                            oDlgPvt,;            //oWnd      - Janela que é a dona da grid
                                            aHeadSBM,;           //aHeader   - Cabeçalho da Grid
                                            aColsSBM)            //aCols     - Dados da Grid
         
    ACTIVATE MSDIALOG oDlgPvt CENTERED
     
    RestArea(aArea)
Return
 
Static Function fCarAcols()
    Local aArea  := GetArea()
    Local cQry   := ""
    Local nAtual := 0
    Local nTotal := 0
    Local oBmpAux
     
    //Seleciona dados do documento de entrada
    cQry := " SELECT "                                                  + CRLF
    cQry += "     BM_GRUPO, "                                           + CRLF
    cQry += "     BM_DESC, "                                            + CRLF
    cQry += "     BM_STATUS, "                                          + CRLF
    cQry += "     BM_PROORI, "                                          + CRLF
    cQry += "     ( "                                                   + CRLF
    cQry += "         SELECT "                                          + CRLF
    cQry += "             COUNT(*) "                                    + CRLF
    cQry += "         FROM "                                            + CRLF
    cQry += "             " + RetSQLName('SB1') + " SB1 "               + CRLF
    cQry += "         WHERE "                                           + CRLF
    cQry += "             B1_FILIAL = '" + FWxFilial('SB1') + "' "      + CRLF
    cQry += "             AND B1_GRUPO = BM_GRUPO "                     + CRLF
    cQry += "             AND B1_MSBLQL != '1' "                        + CRLF
    cQry += "             AND SB1.D_E_L_E_T_ = ' ' "                    + CRLF
    cQry += "     ) AS TOT_PROD, "                                      + CRLF
    cQry += "     SBM.R_E_C_N_O_ AS SBMREC "                            + CRLF
    cQry += " FROM "                                                    + CRLF
    cQry += "     " + RetSQLName('SBM') + " SBM "                       + CRLF
    cQry += " WHERE "                                                   + CRLF
    cQry += "     BM_FILIAL = '" + FWxFilial('SBM') + "' "              + CRLF
    cQry += "     AND SBM.D_E_L_E_T_ = ' ' "                            + CRLF
    cQry += " ORDER BY "                                                + CRLF
    cQry += "     BM_GRUPO "                                            + CRLF
    TCQuery cQry New Alias "QRY_SBM"
     
    //Setando o tamanho da régua
    Count To nTotal
    ProcRegua(nTotal)
     
    //Enquanto houver dados
    QRY_SBM->(DbGoTop())
    While ! QRY_SBM->(EoF())
     
        //Atualizar régua de processamento
        nAtual++
        IncProc("Adicionando " + Alltrim(QRY_SBM->BM_GRUPO) + " (" + cValToChar(nAtual) + " de " + cValToChar(nTotal) + ")...")
         
        //Definindo a legenda padrão como preto
        oBmpAux := oBmpPreto
         
        //Se for Original será verde
        If QRY_SBM->BM_PROORI == '1'
            oBmpAux := oBmpVerde
         
        //Senão, se for Não Original, será vermelho
        ElseIf QRY_SBM->BM_PROORI == '0'
            oBmpAux := oBmpVermelho
        EndIf
         
        //Adiciona o item no aCols
        aAdd(aColsSBM, { ;
            oBmpAux,;
            QRY_SBM->BM_GRUPO,;
            QRY_SBM->BM_DESC,;
            QRY_SBM->BM_STATUS,;
            QRY_SBM->BM_PROORI,;
            QRY_SBM->TOT_PROD,;
            QRY_SBM->SBMREC,;
            .F.;
        })
         
        QRY_SBM->(DbSkip())
    EndDo
    QRY_SBM->(DbCloseArea())
     
    RestArea(aArea)
Return
 
Static Function fLegenda()
    Local aLegenda := {}
     
    aAdd(aLegenda, {"BR_PRETO",    "Sem Classificação"})    
    aAdd(aLegenda, {"BR_VERDE",    "Original"})
    aAdd(aLegenda, {"BR_VERMELHO", "Não Original"})
     
    BrwLegenda("Grupo de Produtos", "Legenda", aLegenda)
Return
 
Static Function fSalvar()
    Local aColsAux := oMsGetSBM:aCols
    Local nPosCod  := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "BM_GRUPO"})
    Local nPosDes  := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "BM_DESC"})
    Local nPosSta  := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "BM_STATUS"})
    Local nPosPro  := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "BM_PROORI"})
    Local nPosTot  := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "XX_TOTAL"})
    Local nPosRec  := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "XX_RECNO"})
    Local nPosDel  := Len(aHeadSBM) + 1
    Local nLinha   := 0
     
    DbSelectArea('SBM')
     
    //Percorrendo todas as linhas
    For nLinha := 1 To Len(aColsAux)
     
        //Posiciona no registro
        If aColsAux[nLinha][nPosRec] != 0
            SBM->(DbGoTo(aColsAux[nLinha][nPosRec]))
        EndIf
         
        //Se a linha estiver excluída
        If aColsAux[nLinha][nPosDel]
             
            //Se não for uma linha nova
            If aColsAux[nLinha][nPosRec] != 0
             
                //Se não tiver produtos, ai prossegue com exclusão
                If aColsAux[nLinha][nPosTot] == 0
                    RecLock("SBM", .F.)
                        DbDelete()
                    SBM->(MsUnlock())
                EndIf
                 
            EndIf
             
        //Se a linha for incluída
        ElseIf aColsAux[nLinha][nPosRec] == 0
            RecLock('SBM', .T.)
                SBM->BM_GRUPO  := aColsAux[nLinha][nPosCod]
                SBM->BM_DESC   := aColsAux[nLinha][nPosDes]
                SBM->BM_STATUS := aColsAux[nLinha][nPosSta]
                SBM->BM_PROORI := aColsAux[nLinha][nPosPro]
            SBM->(MsUnlock())
             
        //Senão, será alteração
        Else
            RecLock('SBM', .F.)
                SBM->BM_DESC   := aColsAux[nLinha][nPosDes]
                SBM->BM_STATUS := aColsAux[nLinha][nPosSta]
                SBM->BM_PROORI := aColsAux[nLinha][nPosPro]
            SBM->(MsUnlock())
        EndIf
         
    Next
     
    MsgInfo("Manipulações finalizadas!", "Atenção")
    oDlgPvt:End()
Return
