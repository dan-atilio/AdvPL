/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/01/07/como-fazer-um-mesmo-relatorio-gerar-tanto-em-pdf-como-excel-ti-responde-0114/ 
    
*/


//Bibliotecas
#Include "Totvs.ch"
#Include "TopConn.ch"
#Include "RPTDef.ch"
#Include "FWPrintSetup.ch"

//Alinhamentos
#Define PAD_LEFT    0
#Define PAD_RIGHT   1
#Define PAD_CENTER  2
#Define PAD_JUSTIFY 3 //Opção disponível somente a partir da versão 1.6.2 da TOTVS Printer

//Cor(es)
Static nCorCinza := RGB(110, 110, 110)
Static nCorLinha := RGB(207, 255, 204)

/*/{Protheus.doc} User Function zVid0114
Exemplo de gerar o relatório tanto em PDF como Excel
@author Atilio
@since 15/03/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function zVid0114()
	Local aArea := FWGetArea()
	Local aPergs   := {}
	Local cEstDe := Space(2)
	Local cEstAte := StrTran(cEstDe, ' ', 'Z')
	
	//Adicionando os parametros do ParamBox
	aAdd(aPergs, {1, "Estado De",      cEstDe,  "", ".T.", "12", ".T.", 80,  .F.})
	aAdd(aPergs, {1, "Estado Até",     cEstAte, "", ".T.", "12", ".T.", 80,  .T.})
    aAdd(aPergs, {2, "Tipo Relatório", 1, {"1=PDF",  "2=Excel"},     90, ".T.", .F.})

	
	//Se a pergunta for confirma, cria o relatorio
	If ParamBox(aPergs, 'Informe os parâmetros', /*aRet*/, /*bOk*/, /*aButtons*/, /*lCentered*/, /*nPosx*/, /*nPosy*/, /*oDlgWizard*/, /*cLoad*/, .F., .F.)
        MV_PAR03 := Val(cValToChar(MV_PAR03))
		Processa({|| fImprime()})
	EndIf
	
	FWRestArea(aArea)
Return

/*/{Protheus.doc} fImprime
Monta a query e aciona a impressão em PDF ou Excel
@author Atilio
@since 15/03/2024
@version 1.0
@type function
/*/

Static Function fImprime()
    Private cQryAux := ""

    //Faz a montagem da query com os dados
    cQryAux += "SELECT "		+ CRLF
    cQryAux += "    CC2_EST, "		+ CRLF
    cQryAux += "    X5_DESCRI, "		+ CRLF
    cQryAux += "    CC2_CODMUN, "		+ CRLF
    cQryAux += "    CC2_MUN "		+ CRLF
    cQryAux += "FROM "		+ CRLF
    cQryAux += "    " + RetSQLName("CC2") + " CC2 "		+ CRLF
    cQryAux += "    INNER JOIN " + RetSQLName("SX5") + " SX5 ON ( "		+ CRLF
    cQryAux += "        X5_FILIAL = '" + FWxFilial("SX5") + "' "		+ CRLF
    cQryAux += "        AND X5_TABELA = '12' "		+ CRLF
    cQryAux += "        AND X5_CHAVE = CC2_EST "		+ CRLF
    cQryAux += "        AND SX5.D_E_L_E_T_ = ' ' "		+ CRLF
    cQryAux += "    ) "		+ CRLF
    cQryAux += "WHERE "		+ CRLF
    cQryAux += "    CC2_FILIAL = '" + FWxFilial("CC2") + "' "		+ CRLF
    cQryAux += "    AND CC2_EST >= '" + MV_PAR01 + "' "		+ CRLF
    cQryAux += "    AND CC2_EST <= '" + MV_PAR02 + "' "		+ CRLF
    cQryAux += "    AND CC2.D_E_L_E_T_ = ' ' "		+ CRLF
    cQryAux += "ORDER BY "		+ CRLF
    cQryAux += "    CC2_EST, "		+ CRLF
    cQryAux += "    CC2_CODMUN"		+ CRLF

    //Se for 1, vai ser PDF
    If MV_PAR03 == 1
        fGeraPDF()
    
    //Senão, vai gerar Excel
    //Obs.: Baixe a zQry2Excel disponível nesse link - https://terminaldeinformacao.com/2017/10/03/funcao-gera-arquivo-excel-atraves-de-uma-query-sql/
    Else
        u_zQry2Excel(cQryAux)
    EndIf
Return

/*/{Protheus.doc} fGeraPDF
Faz a impressão do relatório zVid0114
@author Atilio
@since 15/03/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fGeraPDF()
    Local aArea        := FWGetArea()
    Local nTotAux      := 0
    Local nAtuAux      := 0
    Local cArquivo     := 'zVid0114'+RetCodUsr()+'_' + dToS(Date()) + '_' + StrTran(Time(), ':', '-') + '.pdf'
    Private oPrintPvt
    Private oBrushLin  := TBrush():New(,nCorLinha)
    Private cHoraEx    := Time()
    Private nPagAtu    := 1
    Private cLogoEmp   := fLogoEmp()
    //Linhas e colunas
    Private nLinAtu    := 0
    Private nLinFin    := 800
    Private nColIni    := 010
    Private nColFin    := 580
    Private nColMeio   := (nColFin-nColIni)/2
    //Colunas dos relatorio
    Private nColDad1    := nColIni
    Private nColDad2    := nColIni + 80
    Private nColDad3    := nColIni + 280
    //Declarando as fontes
    Private cNomeFont  := 'Arial'
    Private oFontDet   := TFont():New(cNomeFont, /*uPar2*/, -11, /*uPar4*/, .F., /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .F.)
    Private oFontDetN  := TFont():New(cNomeFont, /*uPar2*/, -13, /*uPar4*/, .T., /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .F.)
    Private oFontRod   := TFont():New(cNomeFont, /*uPar2*/, -8,  /*uPar4*/, .F., /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .F.)
    Private oFontMin   := TFont():New(cNomeFont, /*uPar2*/, -7,  /*uPar4*/, .F., /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .F.)
    Private oFontTit   := TFont():New(cNomeFont, /*uPar2*/, -15, /*uPar4*/, .T., /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .F.)
     
    //Monta a consulta de dados
    PLSQuery(cQryAux, 'QRY_AUX')
 
    //Define o tamanho da régua
    DbSelectArea('QRY_AUX')
    QRY_AUX->(DbGoTop())
    Count to nTotAux
    ProcRegua(nTotAux)
    QRY_AUX->(DbGoTop())
     
    //Somente se tiver dados
    If ! QRY_AUX->(EoF())
        //Criando o objeto de impressao
        oPrintPvt := FWMSPrinter():New(;
        	cArquivo,;    // cFilePrinter
        	IMP_PDF,;     // nDevice
        	.F.,;         // lAdjustToLegacy
        	,;            // cPathInServer
        	.T.,;         // lDisabeSetup
        	,;            // lTReport
        	@oPrintPvt,;  // oPrintSetup
        	,;            // cPrinter
        	,;            // lServer
        	,;            // lParam10
        	,;            // lRaw
        	.T.;          // lViewPDF
        )
        oPrintPvt:cPathPDF := GetTempPath()
        oPrintPvt:SetResolution(72)
        oPrintPvt:SetPortrait()
        oPrintPvt:SetPaperSize(DMPAPER_A4)
        oPrintPvt:SetMargin(0, 0, 0, 0)
 
        //Imprime os dados
        fImpCab()
        While ! QRY_AUX->(EoF())
            nAtuAux++
            IncProc('Imprimindo registro ' + cValToChar(nAtuAux) + ' de ' + cValToChar(nTotAux) + '...')
 
            //Se atingiu o limite, quebra de pagina
            fQuebra()
             
            //Faz o zebrado ao fundo
            If nAtuAux % 2 == 0
                oPrintPvt:FillRect({nLinAtu - 2, nColIni, nLinAtu + 12, nColFin}, oBrushLin)
            EndIf
 
            //Imprime a linha atual
            oPrintPvt:SayAlign(nLinAtu, nColDad1, Alltrim(QRY_AUX->CC2_CODMUN), oFontDet, 80, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
            oPrintPvt:SayAlign(nLinAtu, nColDad2, Alltrim(QRY_AUX->CC2_MUN), oFontDet, 200, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
 
            nLinAtu += 15
            oPrintPvt:Line(nLinAtu-3, nColIni, nLinAtu-3, nColFin, nCorCinza)
 
            //Se atingiu o limite, quebra de pagina
            fQuebra()
             
            QRY_AUX->(DbSkip())
        EndDo

        //Imprime o rodapé última vez e encerra o relatório
        fImpRod()
        oPrintPvt:Preview()
    Else
        FWAlertError('Não foi encontrado informações com os parâmetros informados!', 'Atenção')
    EndIf
    QRY_AUX->(DbCloseArea())
     
    FWRestArea(aArea)
Return

/*/{Protheus.doc} fLogoEmp
Função que retorna o logo da empresa conforme configuração da DANFE
@author Atilio
@since 15/03/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fLogoEmp()
    Local cLogo       := '\x_imagens\logo.png'
Return cLogo

/*/{Protheus.doc} fImpCab
Função que imprime o cabeçalho do relatório
@author Atilio
@since 15/03/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fImpCab()
    Local cTexto   := ''
    Local nLinCab  := 015
     
    //Iniciando Pagina
    oPrintPvt:StartPage()
    
    //Imprime o logo
    If File(cLogoEmp)
        oPrintPvt:SayBitmap(005, nColIni, cLogoEmp, 030, 030)
    EndIf
     
    //Cabecalho
    cTexto := 'Listagem de Cidades'
    oPrintPvt:SayAlign(nLinCab, nColMeio-200, cTexto, oFontTit, 400, 20, /*nClrText*/, PAD_CENTER, /*nAlignVert*/)
     
    //Linha Separatoria
    nLinCab += 020
    oPrintPvt:Line(nLinCab,   nColIni, nLinCab,   nColFin)
     
    //Atualizando a linha inicial do relatorio
    nLinAtu := nLinCab + 5
    
    If nPagAtu == 1
        //Imprimindo os parâmetros
        cTexto := MV_PAR01
        oPrintPvt:SayAlign(nLinAtu, nColIni, 'Estado De', oFontDetN, 200, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
        oPrintPvt:SayAlign(nLinAtu, nColIni+200, cTexto, oFontDet, 200, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
        nLinAtu += 15
        
        cTexto := MV_PAR02
        oPrintPvt:SayAlign(nLinAtu, nColIni, 'Estado Até', oFontDetN, 200, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
        oPrintPvt:SayAlign(nLinAtu, nColIni+200, cTexto, oFontDet, 200, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
        nLinAtu += 15
        
        oPrintPvt:Line(nLinAtu-3, nColIni, nLinAtu-3, nColFin, nCorCinza)
        nLinAtu += 5
    EndIf
    
    oPrintPvt:SayAlign(nLinAtu, nColDad1, 'Código', oFontMin, 80, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
    oPrintPvt:SayAlign(nLinAtu, nColDad2, 'Nome', oFontMin, 200, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
    nLinAtu += 15
Return

/*/{Protheus.doc} fImpRod
Função que imprime o rodapé e encerra a página
@author Atilio
@since 15/03/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fImpRod()
    Local nLinRod:= nLinFin
    Local cTexto := ''
 
    //Linha Separatoria
    oPrintPvt:Line(nLinRod,   nColIni, nLinRod,   nColFin)
    nLinRod += 3
     
    //Dados da Esquerda
    cTexto := dToC(dDataBase) + '     ' + cHoraEx + '     ' + FunName() + ' (zVid0114)     ' + UsrRetName(RetCodUsr())
    oPrintPvt:SayAlign(nLinRod, nColIni, cTexto, oFontRod, 500, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
     
    //Direita
    cTexto := 'Pagina '+cValToChar(nPagAtu)
    oPrintPvt:SayAlign(nLinRod, nColFin-40, cTexto, oFontRod, 040, 10, /*nClrText*/, PAD_RIGHT, /*nAlignVert*/)
     
    //Finalizando a pagina e somando mais um
    oPrintPvt:EndPage()
    nPagAtu++
Return

/*/{Protheus.doc} fQuebra
Função que valida se a linha esta próxima do final, se sim quebra a página
@author Atilio
@since 15/03/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fQuebra()
    If nLinAtu >= nLinFin-10
        fImpRod()
        fImpCab()
    EndIf
Return
