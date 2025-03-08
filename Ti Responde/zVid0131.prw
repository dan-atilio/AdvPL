/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/03/06/como-fazer-um-relatorio-com-quadros-no-fwmsprinter-ti-responde-0131/ 
    
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
Static nCorLinha := RGB(165, 255, 203)

/*/{Protheus.doc} User Function zVid0131
Lista de Produtos
@author Atilio
@since 20/03/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function zVid0131()
	Local aArea := FWGetArea()
	Local aPergs   := {}
	Local xPar0 := Space(15)
	Local xPar1 := StrTran(xPar0, " ", "Z")
	
	//Adicionando os parametros do ParamBox
	aAdd(aPergs, {1, "Produto De", xPar0,  "", ".T.", "SB1", ".T.", 80,  .F.})
	aAdd(aPergs, {1, "Produto Até", xPar1,  "", ".T.", "SB1", ".T.", 80,  .T.})
	
	//Se a pergunta for confirma, cria o relatorio
	If ParamBox(aPergs, 'Informe os parâmetros', /*aRet*/, /*bOk*/, /*aButtons*/, /*lCentered*/, /*nPosx*/, /*nPosy*/, /*oDlgWizard*/, /*cLoad*/, .F., .F.)
		Processa({|| fImprime()})
	EndIf
	
	FWRestArea(aArea)
Return

/*/{Protheus.doc} fImprime
Faz a impressão do relatório zVid0138
@author Atilio
@since 20/03/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fImprime()
    Local aArea        := FWGetArea()
    Local nTotAux      := 0
    Local nAtuAux      := 0
    Local cQryAux      := ''
    Local cArquivo     := 'zVid0138'+RetCodUsr()+'_' + dToS(Date()) + '_' + StrTran(Time(), ':', '-') + '.pdf'
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
    Private nAlturLin  := 15
    Private nColAtual  := 0
    Private nColLargu  := ((nColFin - nColIni) / 3) - 10
    //Declarando as fontes
    Private cNomeFont  := 'Arial'
    Private oFontDet   := TFont():New(cNomeFont, /*uPar2*/, -11, /*uPar4*/, .F., /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .F.)
    Private oFontDetN  := TFont():New(cNomeFont, /*uPar2*/, -13, /*uPar4*/, .T., /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .F.)
    Private oFontRod   := TFont():New(cNomeFont, /*uPar2*/, -8,  /*uPar4*/, .F., /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .F.)
    Private oFontMin   := TFont():New(cNomeFont, /*uPar2*/, -7,  /*uPar4*/, .F., /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .F.)
    Private oFontTit   := TFont():New(cNomeFont, /*uPar2*/, -15, /*uPar4*/, .T., /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .F.)
     
    //Monta a consulta de dados
    cQryAux += "SELECT B1_COD, B1_DESC, B1_UM, B1_TIPO "		+ CRLF
    cQryAux += "FROM SB1990 SB1 "		+ CRLF
    cQryAux += "WHERE B1_FILIAL = '' "		+ CRLF
    cQryAux += "AND B1_MSBLQL != '1' "		+ CRLF
    cQryAux += "AND B1_COD >= '" + MV_PAR01 + "' "		+ CRLF
    cQryAux += "AND B1_COD <= '" + MV_PAR02 + "' "		+ CRLF
    cQryAux += "AND SB1.D_E_L_E_T_ = ' ' "		+ CRLF
    cQryAux += "ORDER BY B1_COD"		+ CRLF
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

            //Se a coluna atingiu 3
            If nColAtual == 3
                //Volta pra coluna 1
                nColAtual := 1

                //Incrementa as 5 linhas (produto, descrição, tipo e u.m.)
                nLinAtu += (nAlturLin * 5)

            //Senão, incrementa a coluna
            Else
                nColAtual++
            EndIf

            //Define a coluna inicial da impressão e a coluna final
            nColTxtIni := nColIni + ((nColAtual-1) * nColLargu) + 10
            
            //Faz um quadro envolvendo todas as 5 linhas
            oPrintPvt:Box(nLinAtu, nColTxtIni, nLinAtu + (nAlturLin * 4), nColTxtIni + nColLargu)

            //Faz o zebrado ao fundo (nos pares)
            If nAtuAux % 2 == 0
                oPrintPvt:FillRect({nLinAtu + 2, nColTxtIni + 2, nLinAtu + (nAlturLin * 4) - 2, nColTxtIni + nColLargu - 2}, oBrushLin)
            EndIf

            //Imprime os textos dentro do quadro
            oPrintPvt:SayAlign(nLinAtu + (nAlturLin * 0), nColTxtIni + 3,  'Cód.:',                   oFontMin,   30, 10, nCorCinza,    PAD_LEFT, /*nAlignVert*/)
            oPrintPvt:SayAlign(nLinAtu + (nAlturLin * 1), nColTxtIni + 3,  'Des.:',                   oFontMin,   30, 10, nCorCinza,    PAD_LEFT, /*nAlignVert*/)
            oPrintPvt:SayAlign(nLinAtu + (nAlturLin * 2), nColTxtIni + 3,  'U.M.:',                   oFontMin,   30, 10, nCorCinza,    PAD_LEFT, /*nAlignVert*/)
            oPrintPvt:SayAlign(nLinAtu + (nAlturLin * 3), nColTxtIni + 3,  'Tipo:',                   oFontMin,   30, 10, nCorCinza,    PAD_LEFT, /*nAlignVert*/)
            oPrintPvt:SayAlign(nLinAtu + (nAlturLin * 0), nColTxtIni + 23, Alltrim(QRY_AUX->B1_COD),  oFontDetN,  60, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
            oPrintPvt:SayAlign(nLinAtu + (nAlturLin * 1), nColTxtIni + 23, Alltrim(QRY_AUX->B1_DESC), oFontDet,  120, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
            oPrintPvt:SayAlign(nLinAtu + (nAlturLin * 2), nColTxtIni + 23, Alltrim(QRY_AUX->B1_UM),   oFontDet,   60, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
            oPrintPvt:SayAlign(nLinAtu + (nAlturLin * 3), nColTxtIni + 23, Alltrim(QRY_AUX->B1_TIPO), oFontDet,   60, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)

            //Se atingiu o limite, quebra de pagina
            fQuebra()

            QRY_AUX->(DbSkip())
        EndDo
        
        //Imprime o último rodapé
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
@since 20/03/2024
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
@since 20/03/2024
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
    cTexto := 'Lista Produtos'
    oPrintPvt:SayAlign(nLinCab, nColMeio-200, cTexto, oFontTit, 400, 20, /*nClrText*/, PAD_CENTER, /*nAlignVert*/)
     
    //Linha Separatoria
    nLinCab += 020
    oPrintPvt:Line(nLinCab,   nColIni, nLinCab,   nColFin)
     
    //Atualizando a linha inicial do relatorio
    nLinAtu := nLinCab + 5
    
    If nPagAtu == 1
        //Imprimindo os parâmetros
        cTexto := MV_PAR01
        oPrintPvt:SayAlign(nLinAtu, nColIni, 'Produto De', oFontDetN, 200, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
        oPrintPvt:SayAlign(nLinAtu, nColIni+200, cTexto, oFontDet, 200, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
        nLinAtu += 15
        
        cTexto := MV_PAR02
        oPrintPvt:SayAlign(nLinAtu, nColIni, 'Produto Até', oFontDetN, 200, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
        oPrintPvt:SayAlign(nLinAtu, nColIni+200, cTexto, oFontDet, 200, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
        nLinAtu += 15
        
        oPrintPvt:Line(nLinAtu-3, nColIni, nLinAtu-3, nColFin, nCorCinza)
        nLinAtu += 5
    EndIf

Return

/*/{Protheus.doc} fImpRod
Função que imprime o rodapé e encerra a página
@author Atilio
@since 20/03/2024
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
    cTexto := dToC(dDataBase) + '     ' + cHoraEx + '     ' + FunName() + ' (zVid0138)     ' + UsrRetName(RetCodUsr())
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
@since 20/03/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fQuebra()
    //Linha atual + 5 linhas (produto, descrição, unid medida, tipo e linha vazia) for estourar a página, ai faz a quebra
    If nLinAtu + (nAlturLin * 5) >= nLinFin-10
        fImpRod()
        fImpCab()
    EndIf
Return
