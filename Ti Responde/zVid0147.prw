/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/05/01/como-fazer-relatorio-em-paisagem-e-retrato-com-fwprintsetup-ti-responde-0147/ 
    
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
Static nCorLinha := RGB(204, 255, 214)

//Variável de setup que será acionada na primeira impressão
Static oSetupRel

/*/{Protheus.doc} User Function zVid0147
Exemplo de Paisagem (800 pixels) e Retrato (580 pixels de largura) - baseado no zVid0147
@author Atilio
@since 20/11/2023
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function zVid0147()
	Local aArea := FWGetArea()
	Local aPergs   := {}
	Local cProdDe := Space(TamSX3("B1_COD")[1])
	Local cProdAte := StrTran(cProdDe, " ", "Z")
	
	//Adicionando os parametros do ParamBox
	aAdd(aPergs, {1, "Produto De", cProdDe,  "", ".T.", "SB1", ".T.", 80,  .F.})
	aAdd(aPergs, {1, "Produto Até", cProdAte,  "", ".T.", "SB1", ".T.", 80,  .T.})
	
	//Se a pergunta for confirma, cria o relatorio
	If ParamBox(aPergs, 'Informe os parâmetros', /*aRet*/, /*bOk*/, /*aButtons*/, /*lCentered*/, /*nPosx*/, /*nPosy*/, /*oDlgWizard*/, /*cLoad*/, .F., .F.)
		Processa({|| fImprime()})
	EndIf
	
	FWRestArea(aArea)
Return

/*/{Protheus.doc} fImprime
Faz a impressão do relatório zVid0147
@author Atilio
@since 20/11/2023
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
    Private lRetrato   := .F.
    Private oPrintPvt
    Private oBrushLin  := TBrush():New(,nCorLinha)
    Private cHoraEx    := Time()
    Private nPagAtu    := 1
    Private cLogoEmp   := fLogoEmp()
    //Linhas e colunas
    Private nLinAtu    := 0
    Private nLinFin    := 0
    Private nColIni    := 0
    Private nColFin    := 0
    Private nColMeio   := 0
    //Colunas dos relatorio
    Private nColCodPro := 0
    Private nColDescri := 0
    Private nColTipPro := 0
    Private nColUniMed := 0
    //Declarando as fontes
    Private cNomeFont  := 'Arial'
    Private oFontDet   := TFont():New(cNomeFont, /*uPar2*/, -11, /*uPar4*/, .F., /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .F.)
    Private oFontDetN  := TFont():New(cNomeFont, /*uPar2*/, -13, /*uPar4*/, .T., /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .F.)
    Private oFontRod   := TFont():New(cNomeFont, /*uPar2*/, -8,  /*uPar4*/, .F., /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .F.)
    Private oFontMin   := TFont():New(cNomeFont, /*uPar2*/, -7,  /*uPar4*/, .F., /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .F.)
    Private oFontTit   := TFont():New(cNomeFont, /*uPar2*/, -15, /*uPar4*/, .T., /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .F.)
    
    //Zera o Setup
    oSetupRel := Nil
	While ValType(oSetupRel) == 'U'
		fConfImpr()
	EndDo

    //Busca do Setup a configuração
    lRetrato := oSetupRel:aOptions[PD_ORIENTATION] == 1

    //Se for Retrato
    If lRetrato
        nLinAtu    := 0
        nLinFin    := 800
        nColIni    := 010
        nColFin    := 580
        nColMeio   := (nColFin-nColIni)/2
        nColCodPro := nColIni
        nColDescri := nColCodPro + 050
        nColTipPro := nColDescri + 200
        nColUniMed := nColTipPro + 050

    //Se for Paisagem
    Else
        nLinAtu    := 0
        nLinFin    := 580
        nColIni    := 010
        nColFin    := 820
        nColMeio   := (nColFin-nColIni)/2
        nColCodPro := nColIni
        nColDescri := nColCodPro + 080
        nColTipPro := nColDescri + 300
        nColUniMed := nColTipPro + 080
    EndIf

    //Monta a consulta de dados
    cQryAux += "SELECT "		+ CRLF
    cQryAux += "    B1_COD, B1_DESC, B1_TIPO, B1_UM "		+ CRLF
    cQryAux += "FROM "		+ CRLF
    cQryAux += "    " + RetSQLName("SB1") + " SB1 "		+ CRLF
    cQryAux += "WHERE "		+ CRLF
    cQryAux += "    B1_FILIAL = '" + FWxFilial("SB1") + "' "		+ CRLF
    cQryAux += "    AND B1_COD >= '" + MV_PAR01 + "' "		+ CRLF
    cQryAux += "    AND B1_COD <= '" + MV_PAR02 + "' "		+ CRLF
    cQryAux += "    AND B1_MSBLQL != '1' "		+ CRLF
    cQryAux += "    AND SB1.D_E_L_E_T_ = ' '"		+ CRLF
    PLSQuery(cQryAux, 'QRY_AUX')
 
    //Define o tamanho da régua
    DbSelectArea('QRY_AUX')
    QRY_AUX->(DbGoTop())
    Count to nTotAux
    ProcRegua(nTotAux)
    QRY_AUX->(DbGoTop())
     
    //Somente se tiver dados
    If ! QRY_AUX->(EoF())
        //Criando a impressão
        oPrintPvt := FWMSPrinter():New(;
            'RELATORIO_0147',; // cFilePrintert
            ,;                 // nDevice
            .F.,;              // lAdjustToLegacy
            GetTempPath(),;    // cPathInServer
            .T.;               // lDisabeSetup
        )

        //Puxa as definições da impressora
        If oSetupRel:GetProperty(PD_PRINTTYPE) == IMP_SPOOL
            oPrintPvt:nDevice  := IMP_SPOOL
            oPrintPvt:cPrinter := oSetupRel:aOptions[PD_VALUETYPE]
        EndIf

        //Se for Retrato
        If lRetrato
            oPrintPvt:SetPortrait()

        //Se for Paisagem
        Else
            oPrintPvt:SetLandscape()
        EndIf
 
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
            oPrintPvt:SayAlign(nLinAtu, nColCodPro, Alltrim(QRY_AUX->B1_COD),  oFontDetN, (nColDescri - nColCodPro), 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
            oPrintPvt:SayAlign(nLinAtu, nColDescri, Alltrim(QRY_AUX->B1_DESC), oFontDet,  (nColTipPro - nColDescri), 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
            oPrintPvt:SayAlign(nLinAtu, nColTipPro, Alltrim(QRY_AUX->B1_TIPO), oFontDet,  (nColUniMed - nColTipPro), 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
            oPrintPvt:SayAlign(nLinAtu, nColUniMed, Alltrim(QRY_AUX->B1_UM),   oFontDet,  (nColFin    - nColUniMed), 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
 
            nLinAtu += 15
            oPrintPvt:Line(nLinAtu-3, nColIni, nLinAtu-3, nColFin, nCorCinza)
 
            //Se atingiu o limite, quebra de pagina
            fQuebra()
             
            QRY_AUX->(DbSkip())
        EndDo
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
@since 20/11/2023
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
@since 20/11/2023
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
        oPrintPvt:SayBitmap(015, nColIni, cLogoEmp, 020, 020)
    EndIf
     
    //Cabecalho
    cTexto := 'Listagem de Produtos'
    oPrintPvt:SayAlign(nLinCab, nColMeio-200, cTexto, oFontTit, 400, 20, /*nClrText*/, PAD_CENTER, /*nAlignVert*/)
     
    //Linha Separatoria
    nLinCab += 020
    oPrintPvt:Line(nLinCab,   nColIni, nLinCab,   nColFin)
     
    //Atualizando a linha inicial do relatorio
    nLinAtu := nLinCab + 5
    
    If nPagAtu == 1
        //Imprimindo os parâmetros
        oPrintPvt:SayAlign(nLinAtu, nColIni, 'Produto De', oFontDetN, 200, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
        oPrintPvt:SayAlign(nLinAtu, nColIni+200, MV_PAR01, oFontDet, 200, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
        nLinAtu += 15
        oPrintPvt:SayAlign(nLinAtu, nColIni, 'Produto Até', oFontDetN, 200, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
        oPrintPvt:SayAlign(nLinAtu, nColIni+200, MV_PAR02, oFontDet, 200, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
        nLinAtu += 15
        cTexto := ""
        If lRetrato
            cTexto := "1 - Retrato"
        Else
            cTexto := "2 - Paisagem"
        EndIf
        oPrintPvt:SayAlign(nLinAtu, nColIni, 'Tipo do Relatório', oFontDetN, 200, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
        oPrintPvt:SayAlign(nLinAtu, nColIni+200, cTexto, oFontDet, 200, 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
        nLinAtu += 15
        oPrintPvt:Line(nLinAtu-3, nColIni, nLinAtu-3, nColFin, nCorCinza)
        nLinAtu += 5
    EndIf
    
    oPrintPvt:SayAlign(nLinAtu, nColCodPro, 'Codigo',      oFontMin, (nColDescri - nColCodPro), 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
    oPrintPvt:SayAlign(nLinAtu, nColDescri, 'Descricao',   oFontMin, (nColTipPro - nColDescri), 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
    oPrintPvt:SayAlign(nLinAtu, nColTipPro, 'Tipo',        oFontMin, (nColUniMed - nColTipPro), 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
    oPrintPvt:SayAlign(nLinAtu, nColUniMed, 'Unid.Medida', oFontMin, (nColFin    - nColUniMed), 10, /*nClrText*/, PAD_LEFT, /*nAlignVert*/)
    nLinAtu += 15
Return

/*/{Protheus.doc} fImpRod
Função que imprime o rodapé e encerra a página
@author Atilio
@since 20/11/2023
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
    cTexto := dToC(dDataBase) + '     ' + cHoraEx + '     ' + FunName() + ' (zVid0147)     ' + UsrRetName(RetCodUsr())
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
@since 20/11/2023
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

/*/{Protheus.doc} fConfImpr
Abre a tela para selecionar a impressora da zZebra
@author Daniel Atilio
@since 13/02/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fConfImpr()
	Local aArea         := FWGetArea()
	Local aDevice       := {'DISCO', 'SPOOL', 'EMAIL', 'EXCEL', 'HTML', 'PDF'}
	Local oSetup
	Local cSession  	:= GetPrinterSession()
	Local cDevice     	:= If(Empty(fwGetProfString(cSession,'PRINTTYPE','SPOOL',.T.)),'PDF',fwGetProfString(cSession,'PRINTTYPE','SPOOL',.T.))
	Local nPrintType    := aScan(aDevice, {|x| x == cDevice })
	Local nOrientation  := 1 //If(fwGetProfString(cSession, 'ORIENTATION', 'PORTRAIT', .T.) == 'PORTRAIT', 1, 2)
	Local nLocal        := 2 //If(fwGetProfString(cSession, 'LOCAL', 'SERVER', .T.) == 'SERVER', 1, 2)
	Local nFlags        := PD_ISTOTVSPRINTER + PD_DISABLEPAPERSIZE + PD_DISABLEPREVIEW + PD_DISABLEMARGIN
	
	//Cria o setup do relatório
	oSetup := FWPrintSetup():New(nFlags, 'TST_IMPRESSORA')
	oSetup:SetPropert(PD_DESTINATION , nLocal)
	oSetup:SetPropert(PD_ORIENTATION , nOrientation)
	oSetup:SetPropert(PD_PRINTTYPE   , nPrintType)
	oSetup:SetPropert(PD_MARGIN      , {0,0,0,0})
	
	oSetupRel := Nil
	
	//Se a tela for confirmada, atualiza o setup default do relatório
	If oSetup:Activate() == PD_OK
		If oSetup:GetProperty(PD_PRINTTYPE) == IMP_SPOOL .And. oSetup:GetProperty(PD_DESTINATION) == 2
			oSetupRel := oSetup
		Else
			FWAlertInfo('Escolha o tipo SPOOL e LOCAL para impressão!')
		EndIf
	EndIf
	
	FWRestArea(aArea)
Return
