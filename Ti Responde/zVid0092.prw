/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2024/10/22/exemplos-de-codigos-de-barras-em-fwmsprinter-ti-responde-0092/ 
    
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
Static nCorCinza  := RGB(110, 110, 110)
Static nCorDestaq := RGB(000, 208, 028)

/*/{Protheus.doc} User Function zVid0092
Testes de Código de Barras
@author Atilio
@since 28/02/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function zVid0092()
	Local aArea := FWGetArea()
	
	//Cria as o relatorio
	Processa({|| fImprime()})
	
	FWRestArea(aArea)
Return

/*/{Protheus.doc} fImprime
Faz a impressão do relatório zVid0092
@author Atilio
@since 28/02/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fImprime()
    Local aArea        := FWGetArea()
    Local cArquivo     := 'zVid0092'+RetCodUsr()+'_' + dToS(Date()) + '_' + StrTran(Time(), ':', '-') + '.pdf'
    Local cCodBarra    := "01234567890123456789012345678901234567890123456" //47 caracteres
    Private oPrintPvt
    Private cHoraEx    := Time()
    Private nPagAtu    := 1
    Private cLogoEmp   := fLogoEmp()
    //Linhas e colunas
    Private nLinAtu    := 0
    Private nLinFin    := 800
    Private nColIni    := 010
    Private nColFin    := 580
    Private nColMeio   := (nColFin-nColIni)/2
    //Declarando as fontes
    Private cNomeFont  := 'Arial'
    Private oFontDet   := TFont():New(cNomeFont, /*uPar2*/, -11, /*uPar4*/, .F., /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .F.)
    Private oFontDetN  := TFont():New(cNomeFont, /*uPar2*/, -13, /*uPar4*/, .T., /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .F.)
    Private oFontRod   := TFont():New(cNomeFont, /*uPar2*/, -8,  /*uPar4*/, .F., /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .F.)
    Private oFontMin   := TFont():New(cNomeFont, /*uPar2*/, -7,  /*uPar4*/, .F., /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .F.)
    Private oFontTit   := TFont():New(cNomeFont, /*uPar2*/, -15, /*uPar4*/, .T., /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .F.)
     
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

    //Inicia a página imprimindo o cabeçalho
    fImpCab()

    //Método FWMSBar
    oPrintPvt:SayAlign(nLinAtu, nColMeio-200, "Método FWMSBar", oFontTit, 400, 20, nCorCinza, PAD_CENTER, /*nAlignVert*/)
    oPrintPvt:FWMSBar(;
        "INT25",;     // cTypeBar
        nLinAtu / 8,; // nRow
        nColIni / 8,; // nCol
        cCodBarra,;   // cCode
        oPrintPvt,;   // oPrint
        ,;            // lCheck
        ,;            // Color
        .T.,;         // lHorz
        ,;            // nWidth
        ,;            // nHeigth
        ,;            // lBanner
        ,;            // cFont
        ,;            // cMode
        .F.,;         // lPrint
        ,;            // nPFWidth
        ,;            // nPFHeigth
        ;             // lCmtr2Pix
    )

    //Método Code128
    nLinAtu += 90
    oPrintPvt:SayAlign(nLinAtu, nColMeio-200, "Método Code128", oFontTit, 400, 20, nCorCinza, PAD_CENTER, /*nAlignVert*/)
    oPrintPvt:Code128(;
        nLinAtu + 20,; // nRow
        nColIni,;      // nCol
        cCodBarra,;    // cCodeBar
        1,;            // nWidth
        30,;           // nHeight
        .T.,;          // lSay
        oFontMin,;     // oFont
        300;           // nTotalWidth
    )

    //Método Ean13
    nLinAtu += 70
    oPrintPvt:SayAlign(nLinAtu, nColMeio-200, "Método Ean13", oFontTit, 400, 20, nCorCinza, PAD_CENTER, /*nAlignVert*/)
    oPrintPvt:Ean13(;
        nLinAtu + 20,;        // nRow
        nColIni + 20,;        // nCol
        Left(cCodBarra, 13),; // cCodeBar
        100,;                 // nTotalWidth
        30;                   // nHeight
    )

    //Método Code128C
    nLinAtu += 70
    oPrintPvt:SayAlign(nLinAtu, nColMeio-200, "Método Code128C", oFontTit, 400, 20, nCorCinza, PAD_CENTER, /*nAlignVert*/)
    oPrintPvt:Code128C(;
        nLinAtu + 65,;           // nRow
        nColIni,;                // nCol
        Left(cCodBarra, 40),;    // cCodeBar
        50;                      // nSizeBar
    )

    //Método Pdf417
    nLinAtu += 70
    oPrintPvt:SayAlign(nLinAtu, nColMeio-200, "Método Pdf417", oFontTit, 400, 20, nCorCinza, PAD_CENTER, /*nAlignVert*/)
    oPrintPvt:Pdf417(;
        nLinAtu + 50,;           // nRow
        nColIni,;                // nCol
        Left(cCodBarra, 40),;    // cCodeBar
        150,;                    // nSizeBar
        30;                      // nHeight
    )

    //Método QRCode
    nLinAtu += 70
    oPrintPvt:SayAlign(nLinAtu, nColMeio-200, "Método QRCode", oFontTit, 400, 20, nCorCinza, PAD_CENTER, /*nAlignVert*/)
    oPrintPvt:QRCode(;
        nLinAtu + 90,;   // nRow
        nColIni,;        // nCol
        cCodBarra,;      // cCodeBar
        65;              // nSizeBar
    )

    //Método FWMSBar (Vertical)
    nLinAtu += 110
    oPrintPvt:SayAlign(nLinAtu, nColMeio-200, "Método FWMSBar (Vertical)", oFontTit, 400, 20, nCorCinza, PAD_CENTER, /*nAlignVert*/)
    oPrintPvt:FWMSBar(;
        "CODE128",;            // cTypeBar
        nLinAtu / 8 - 19,;     // nRow
        nColIni / 8,;          // nCol
        Left(cCodBarra, 15),;  // cCode
        oPrintPvt,;            // oPrint
        ,;                     // lCheck
        ,;                     // Color
        .F.,;                  // lHorz
        ,;                     // nWidth
        ,;                     // nHeigth
        ,;                     // lBanner
        ,;                     // cFont
        ,;                     // cMode
        .F.,;                  // lPrint
        ,;                     // nPFWidth
        ,;                     // nPFHeigth
        ;                      // lCmtr2Pix
    )
    
    //Imprime o último rodapé e abre o PDF
    fImpRod()
    oPrintPvt:Preview()
     
    FWRestArea(aArea)
Return

/*/{Protheus.doc} fLogoEmp
Função que retorna o logo da empresa conforme configuração da DANFE
@author Atilio
@since 28/02/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fLogoEmp()
    Local cLogo       := "\x_imagens\logo.png"
Return cLogo

/*/{Protheus.doc} fImpCab
Função que imprime o cabeçalho do relatório
@author Atilio
@since 28/02/2024
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
    cTexto := 'Testes Códigos de Barras'
    oPrintPvt:SayAlign(nLinCab, nColMeio-200, cTexto, oFontTit, 400, 20, nCorDestaq, PAD_CENTER, /*nAlignVert*/)
     
    //Linha Separatoria
    nLinCab += 020
    oPrintPvt:Line(nLinCab,   nColIni, nLinCab,   nColFin, nCorDestaq)
     
    //Atualizando a linha inicial do relatorio
    nLinAtu := nLinCab + 5
Return

/*/{Protheus.doc} fImpRod
Função que imprime o rodapé e encerra a página
@author Atilio
@since 28/02/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fImpRod()
    Local nLinRod:= nLinFin
    Local cTexto := ''
 
    //Linha Separatoria
    oPrintPvt:Line(nLinRod,   nColIni, nLinRod,   nColFin, nCorDestaq)
    nLinRod += 3
     
    //Dados da Esquerda
    cTexto := dToC(dDataBase) + '     ' + cHoraEx + '     ' + FunName() + ' (zVid0092)     ' + UsrRetName(RetCodUsr())
    oPrintPvt:SayAlign(nLinRod, nColIni, cTexto, oFontRod, 500, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
     
    //Direita
    cTexto := 'Pagina '+cValToChar(nPagAtu)
    oPrintPvt:SayAlign(nLinRod, nColFin-40, cTexto, oFontRod, 040, 10, /*nClrText*/, PAD_RIGHT, /*nAlignVert*/)
     
    //Finalizando a pagina e somando mais um
    oPrintPvt:EndPage()
    nPagAtu++
Return

