/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"
#Include "RPTDef.ch"
#Include "FWPrintSetup.ch"

//Variável do Setup
Static oSetupRel := Nil

//Alinhamentos
#Define PAD_LEFT    0
#Define PAD_RIGHT   1
#Define PAD_CENTER  2
#Define PAD_JUSTIFY 3 //Opção disponível somente a partir da versão 1.6.2 da TOTVS Printer

/*/{Protheus.doc} zFonte53
Exemplo de geração de relatório com FWMSPrinter (com Setup)
@author Atilio
@since 11/12/2022
@version 1.0
@type function
/*/
 
User Function zFonte53()
    Local aArea  := FWGetArea()
    Local aPergs   := {}
	Local cProdDe  := Space(TamSX3('B1_COD')[1])
	Local cProdAte := StrTran(cProdDe, ' ', 'Z')
	Local cTipoDe  := Space(TamSX3('B1_TIPO')[1])
	Local cTipoAte := StrTran(cTipoDe, ' ', 'Z')
	Local nOrden   := 1
    Private lJob := IsBlind()
     
    //Se for execução automática, não mostra pergunta, executa direto
    If lJob
        Processa({|| fMontaRel()}, "Processando...")
         
    //Senão, se a pergunta for confirmada, executa o relatório
    Else
        //Adicionando os parametros do ParamBox
        aAdd(aPergs, {1, "Produto De",  cProdDe,  "", ".T.", "SB1", ".T.", 80,  .F.}) // MV_PAR01
        aAdd(aPergs, {1, "Produto Até", cProdAte, "", ".T.", "SB1", ".T.", 80,  .T.}) // MV_PAR02
        aAdd(aPergs, {1, "Tipo De",     cTipoDe,  "", ".T.", "02",  ".T.", 40,  .F.}) // MV_PAR03
        aAdd(aPergs, {1, "Tipo Até",    cTipoAte, "", ".T.", "02",  ".T.", 40,  .T.}) // MV_PAR04
        aAdd(aPergs, {2, "Ordenar por", nOrden, {"1=Código do Produto", "2=Descrição do Produto", "3=Unidade de Medida"},  100, ".T.", .T.}) // MV_PAR05
        
        //Se a pergunta for confirma, cria as definicoes do relatorio
        If ParamBox(aPergs, "Informe os parâmetros", , , , , , , , , .F., .F.)
            MV_PAR05 := Val(cValToChar(MV_PAR05))

            //Aciona o setup do relatório
            fConfImpr()

            //Somente se foi confirmado
            If ValType(oSetupRel) != "U"
                Processa({|| fMontaRel()}, "Processando...")
            Endif
        EndIf
    EndIf
     
    FWRestArea(aArea)
Return
 
/*---------------------------------------------------------------------*
 | Func:  fMontaRel                                                    |
 | Desc:  Função que monta o relatório                                 |
 *---------------------------------------------------------------------*/
 
Static Function fMontaRel()
    Local cCaminho    := ""
    Local cArquivo    := ""
    Local lNegrito    := .T.
    Local lSublinhado := .T.
    Local lItalico    := .T.
    Local nRegAtu     := 0
    Local nRegTot     := 0
    Local cQryRel     := ""
    //Linhas e colunas
    Private nLinAtu   := 000
    Private nTamLin   := 010
    Private nLinFin   := 820
    Private nColIni   := 010
    Private nColFin   := 550
    Private nColMeio  := (nColFin-nColIni)/2
    Private nEspLin   := 015
    //Colunas dos campos
    Private nColProd  := nColIni
    Private nColDescr := nColIni + 060
    Private nColTipo  := nColFin - 280
    Private nColTpDes := nColFin - 240
    Private nColUnMed := nColFin - 140
    Private nColUMDes := nColFin - 100
    //Variáveis auxiliares
    Private dDataGer  := Date()
    Private cHoraGer  := Time()
    Private nPagAtu   := 1
    //Cores usadas
    Private nCorFraca := RGB(198, 239, 206)
    Private nCorForte := RGB(003, 101, 002)
    Private nCorCinza := RGB(150, 150, 150)
    Private oBrush    := TBrush():New(, nCorFraca)
    //Objetos de impressão e fonte
    Private oPrintPvt
    Private cNomeFont  := "Arial"
    Private oFontCabN  := TFont():New(cNomeFont, /*uPar2*/, -15, /*uPar4*/,   lNegrito, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, ! lSublinhado, ! lItalico)
    Private oFontDet   := TFont():New(cNomeFont, /*uPar2*/, -11, /*uPar4*/, ! lNegrito, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, ! lSublinhado, ! lItalico)
    Private oFontDetN  := TFont():New(cNomeFont, /*uPar2*/, -13, /*uPar4*/,   lNegrito, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, ! lSublinhado, ! lItalico)
    Private oFontDetI  := TFont():New(cNomeFont, /*uPar2*/, -11, /*uPar4*/, ! lNegrito, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, ! lSublinhado,   lItalico)
    Private oFontMin   := TFont():New(cNomeFont, /*uPar2*/, -09, /*uPar4*/, ! lNegrito, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, ! lSublinhado, ! lItalico)
    Private oFontRod   := TFont():New(cNomeFont, /*uPar2*/, -08, /*uPar4*/, ! lNegrito, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, ! lSublinhado, ! lItalico)
     
    //Montando consulta de dados
	cQryRel := "SELECT "		+ CRLF
	cQryRel += "    B1_COD, "		+ CRLF
	cQryRel += "    B1_DESC, "		+ CRLF
	cQryRel += "    B1_TIPO, "		+ CRLF
	cQryRel += "    ISNULL(X5_DESCRI, '') AS TIPODESCR, "		+ CRLF
	cQryRel += "    B1_UM, "		+ CRLF
	cQryRel += "    ISNULL(AH_DESCPO, '') AS UMDESCR "		+ CRLF
	cQryRel += "FROM "		+ CRLF
	cQryRel += "    " + RetSQLName("SB1") + " SB1 "		+ CRLF
	cQryRel += "    LEFT JOIN " + RetSQLName("SX5") + " SX5 ON ( "		+ CRLF
	cQryRel += "       X5_FILIAL = '" + FWxFilial("SX5") + "' "		+ CRLF
	cQryRel += "       AND X5_TABELA = '02' "		+ CRLF
	cQryRel += "       AND X5_CHAVE = B1_TIPO "		+ CRLF
	cQryRel += "       AND SX5.D_E_L_E_T_ = ' ' "		+ CRLF
	cQryRel += "    ) "		+ CRLF
	cQryRel += "    LEFT JOIN " + RetSQLName("SAH") + " SAH ON ( "		+ CRLF
	cQryRel += "       AH_FILIAL = '" + FWxFilial("SAH") + "' "		+ CRLF
	cQryRel += "       AND AH_UNIMED = B1_UM "		+ CRLF
	cQryRel += "       AND SAH.D_E_L_E_T_ = ' ' "		+ CRLF
	cQryRel += "    ) "		+ CRLF
	cQryRel += "WHERE "		+ CRLF
	cQryRel += "    B1_FILIAL = '" + FWxFilial("SB1") + "' "		+ CRLF
	cQryRel += "    AND B1_COD >= '" + MV_PAR01 + "' "		+ CRLF
	cQryRel += "    AND B1_COD <= '" + MV_PAR02 + "' "		+ CRLF
	cQryRel += "    AND B1_TIPO >= '" + MV_PAR03 + "' "		+ CRLF
	cQryRel += "    AND B1_TIPO <= '" + MV_PAR04 + "' "		+ CRLF
	cQryRel += "    AND B1_MSBLQL != '1' "		+ CRLF
	cQryRel += "    AND SB1.D_E_L_E_T_ = ' ' "		+ CRLF
	cQryRel += "ORDER BY "		+ CRLF
    cQryRel += "    B1_TIPO, "		+ CRLF
    If MV_PAR05 == 1
	    cQryRel += "    B1_COD "		+ CRLF
    ElseIf MV_PAR05 == 2
        cQryRel += "    B1_DESC "		+ CRLF
    ElseIf MV_PAR05 == 3
        cQryRel += "    B1_UM "		+ CRLF
    EndIf

    //Executando consulta e setando o total da regua
	PlsQuery(cQryRel, "QRY_REL")
	DbSelectArea("QRY_REL")
	Count To nRegTot
    ProcRegua(nRegTot)
    QRY_REL->(DbGoTop())

    //Somente se tiver dados
    If ! QRY_REL->(EoF())
        //Se for via JOB, muda as parametrizações
        If lJob
            //Define o caminho dentro da protheus data e o nome do arquivo
            cCaminho := "\x_relatorios\"
            cArquivo := "zFonte53_job_" + dToS(dDataGer) + "_" + StrTran(cHoraGer, ':', '-') + ".pdf"
            
            //Se não existir a pasta na Protheus Data, cria ela
            If ! ExistDir(cCaminho)
                MakeDir(cCaminho)
            EndIf
            
            //Cria o objeto FWMSPrinter
            oPrintPvt := FWMSPrinter():New(;
                cArquivo,; // cFilePrinter
                IMP_PDF,;  // nDevice
                .F.,;      // lAdjustToLegacy
                '',;       // cPathInServer
                .T.,;      // lDisabeSetup
                .F.,;      // lTReport
                ,;         // oPrintSetup
                ,;         // cPrinter
                .T.,;      // lServer
                .T.,;      // lParam10
                ,;         // lRaw
                .F.;       // lViewPDF
            )
            oPrintPvt:cPathPDF := cCaminho
            oPrintPvt:SetResolution(72)
            oPrintPvt:SetPortrait()
            oPrintPvt:SetPaperSize(DMPAPER_A4)
            oPrintPvt:SetMargin(60, 60, 60, 60)
            
        Else
            //Definindo o diretório como a temporária do S.O. e o nome do arquivo com a data e hora (sem dois pontos)
            cCaminho  := GetTempPath()
            cArquivo  := "zFonte53_" + dToS(dDataGer) + "_" + StrTran(cHoraGer, ':', '-')
            
            //Criando o objeto do FMSPrinter
            oPrintPvt := FWMSPrinter():New(;
                cArquivo,; // cFilePrinter
                ,;         // nDevice
                .F.,;      // lAdjustToLegacy
                "",;       // cPathInServer
                .T.,;      // lDisabeSetup
                ,;         // lTReport
                ,;         // oPrintSetup
                "",;       // cPrinter
                ,;         // lServer
                ,;         // lParam10
                ,;         // lRaw
                .T.;       // lViewPDF
            )
            oPrintPvt:nDevice := IMP_SPOOL
			oPrintPvt:cPrinter := oSetupRel:aOptions[PD_VALUETYPE]
        EndIf

        //Imprime o primeiro cabeçalho
        fImpCab()

        //Percorre os registros da tabela
        While ! QRY_REL->(EoF())
            //Incrementa a régua
            nRegAtu++
            IncProc("Imprimindo registro (" + cValToChar(nRegAtu) + " de " + cValToChar(nRegTot) + ")...")

            //Verifica a quebra de página
            fQuebra()

            //Se for par, irá pintar o fundo da linha
            If nRegAtu % 2 == 0
                oPrintPvt:FillRect({nLinAtu - 2, nColIni+1, nLinAtu + nEspLin - 3, nColFin - 1}, oBrush)
            EndIf

            //Aciona a impressão dos dados
            oPrintPvt:SayAlign(nLinAtu, nColProd  ,  Alltrim(QRY_REL->B1_COD),    oFontDet,  060,    10, , PAD_LEFT,   )
            oPrintPvt:SayAlign(nLinAtu, nColDescr ,  Alltrim(QRY_REL->B1_DESC),   oFontDet,  100,    10, , PAD_LEFT,   )
            oPrintPvt:SayAlign(nLinAtu, nColTipo  ,  Alltrim(QRY_REL->B1_TIPO),   oFontDet,  040,    10, , PAD_CENTER,   )
            oPrintPvt:SayAlign(nLinAtu, nColTpDes ,  Alltrim(QRY_REL->TIPODESCR), oFontDet,  100,    10, , PAD_LEFT,   )
            oPrintPvt:SayAlign(nLinAtu, nColUnMed ,  Alltrim(QRY_REL->B1_UM),     oFontDet,  040,    10, , PAD_CENTER,   )
            oPrintPvt:SayAlign(nLinAtu, nColUMDes ,  Alltrim(QRY_REL->UMDESCR),   oFontDet,  100,    10, , PAD_LEFT,   )
            nLinAtu += nEspLin

            //Faz uma linha de separação
            oPrintPvt:Line(nLinAtu-3, nColIni, nLinAtu-3, nColFin, nCorCinza)

            QRY_REL->(DbSkip())
        EndDo

        //Verifica a quebra de página
        fQuebra()

        //Encerra a última página
        fImpRod()
        
        //Se for via job, imprime o arquivo para gerar corretamente o pdf
        If lJob
            oPrintPvt:Print()

        //Se for via manual, mostra o relatório
        Else
            oPrintPvt:Preview()
        EndIf
    Else
        If ! lJob
            FWAlertError("Não foi encontrado dados com os filtros informados", "Falha")
        EndIf
    EndIf
    QRY_REL->(DbCloseArea())
Return

/*---------------------------------------------------------------------*
 | Func:  fImpCab                                                      |
 | Desc:  Função que imprime o cabeçalho                               |
 *---------------------------------------------------------------------*/

Static Function fImpCab()
    nLinAtu   := 40

	//Inicializa a página
    oPrintPvt:StartPage()

    //Somente se for na primeira página
    If nPagAtu == 1
        //Impressão do box e das linhas
        nFimQuadr := nLinAtu + ((nEspLin*6) + 5)
        oPrintPvt:Box(nLinAtu, nColIni, nFimQuadr, nColFin)
        oPrintPvt:FillRect({nLinAtu + 1, nColIni+1, nLinAtu + nEspLin - 1, nColFin - 1}, oBrush)
        oPrintPvt:Line(nLinAtu + nEspLin,           nColIni,       nLinAtu + nEspLin,           nColFin,                ) //Linha separando o título dos dados
        oPrintPvt:Line(nLinAtu + nEspLin,           nColIni + 195, nFimQuadr,                   nColIni + 195,          ) //Coluna entre Logo e Textos
        oPrintPvt:Line(nLinAtu + nEspLin,           nColFin - 085, nFimQuadr,                   nColFin - 085,          ) //Coluna entre Textos e QRCode
        oPrintPvt:Line(nLinAtu + (nEspLin * 2) + 2, nColIni + 200, nLinAtu + (nEspLin * 2) + 2, nColIni + 360, nCorFraca) //Linha abaixo do texto principal

        //Impressão do quadro de dados
        oPrintPvt:SayAlign(nLinAtu, nColIni + 005 , "Dados:",                            oFontDetN,  200,    015, nCorForte, PAD_LEFT,  )
        nLinAtu += nEspLin

        //Imprimindo o logo
        cLogoRel := "\x_imagens\logo.png"
        oPrintPvt:SayBitmap(nLinAtu + 5, nColIni + 065, cLogoRel, 070, 070) // 100 é a metade de 200, - 35 que é a metade da largura, dá 065

        //Imprimindo o QRCode
        cUrlSite := "https://terminaldeinformacao.com"
        oPrintPvt:QRCode(nLinAtu + 70, nColFin - 73, cUrlSite, 65)

        //Impressão de informações internas
        oPrintPvt:SayAlign(nLinAtu, nColIni + 200, "Terminal de Informação",            oFontCabN,  200,    015, nCorForte, PAD_LEFT,  )
        nLinAtu += nEspLin + 5

        oPrintPvt:SayAlign(nLinAtu, nColIni + 200, "Site:",                             oFontDetN,  200,    015, , PAD_LEFT,  )
        oPrintPvt:SayAlign(nLinAtu, nColIni + 270, "https://terminaldeinformacao.com",  oFontDet,   200,    015, , PAD_LEFT,  )
        nLinAtu += nEspLin

        oPrintPvt:SayAlign(nLinAtu, nColIni + 200, "e-Mail:",                           oFontDetN,  200,    015, , PAD_LEFT,  )
        oPrintPvt:SayAlign(nLinAtu, nColIni + 270, "suporte@terminaldeinformacao.com",  oFontDet,   200,    015, , PAD_LEFT,  )
        nLinAtu += nEspLin

        oPrintPvt:SayAlign(nLinAtu, nColIni + 200, "WhatsApp:",                         oFontDetN,  200,    015, , PAD_LEFT,  )
        oPrintPvt:SayAlign(nLinAtu, nColIni + 270, "(14) 9 9738-5495",                  oFontDet,   200,    015, , PAD_LEFT,  )
        nLinAtu += nEspLin

        oPrintPvt:SayAlign(nLinAtu, nColIni + 200, "Um projeto da *Atilio Sistemas*",   oFontDetI,  200,    015, , PAD_LEFT,  )
        nLinAtu += nEspLin

        //Imprime textos laterais com o método Say
        cTextoAux := "Esse é um exemplo da Assinatura Premium do Terminal de Informação, veja em https://terminaldeinformacao.com/hotmart"
        oPrintPvt:Say(040,     nColIni - 15, "Esq: " + cTextoAux, oFontMin, , nCorForte, 90)
        oPrintPvt:Say(nLinFin, nColFin + 15, "Dir: " + cTextoAux, oFontMin, , nCorForte, 270)
    EndIf
	
	nLinAtu += 010
    oPrintPvt:SayAlign(nLinAtu+05, nColProd  ,     "Produto",        oFontMin,  060,    10, nCorCinza, PAD_LEFT,   )
    oPrintPvt:SayAlign(nLinAtu+05, nColDescr ,     "Descrição",      oFontMin,  100,    10, nCorCinza, PAD_LEFT,   )
    oPrintPvt:SayAlign(nLinAtu+05, nColTipo  ,     "Tp.",            oFontMin,  040,    10, nCorCinza, PAD_CENTER,   )
    oPrintPvt:SayAlign(nLinAtu+00, nColTpDes ,     "Tipo",           oFontMin,  100,    10, nCorCinza, PAD_LEFT,   )
    oPrintPvt:SayAlign(nLinAtu+10, nColTpDes ,     "Descrição",      oFontMin,  100,    10, nCorCinza, PAD_LEFT,   )
    oPrintPvt:SayAlign(nLinAtu+05, nColUnMed ,     "U.M.",           oFontMin,  040,    10, nCorCinza, PAD_CENTER,   )
    oPrintPvt:SayAlign(nLinAtu+00, nColUMDes ,     "Unidade Medida", oFontMin,  100,    10, nCorCinza, PAD_LEFT,   )
    oPrintPvt:SayAlign(nLinAtu+10, nColUMDes ,     "Descrição",      oFontMin,  100,    10, nCorCinza, PAD_LEFT,   )
	
	//Linha Separatória
	nLinAtu += 020
	oPrintPvt:Line(nLinAtu, nColIni, nLinAtu, nColFin, )
	nLinAtu += 005
Return

/*---------------------------------------------------------------------*
 | Func:  fImpRod                                                      |
 | Desc:  Função que imprime o rodapé                                  |
 *---------------------------------------------------------------------*/

Static Function fImpRod()
	Local nLinRod:= nLinFin + 10
	Local cTexto := ''

	//Linha Separatória
	oPrintPvt:Line(nLinRod,   nColIni, nLinRod,   nColFin, nCorFraca)
	nLinRod += 5
	
	//Dados da Esquerda
	cTexto := dToC(dDataGer)+"     "+cHoraGer+"     "+FunName()+" (zFonte53)     "+cUserName
	oPrintPvt:SayAlign(nLinRod, nColIni, cTexto, oFontRod, 400, 10, nCorForte, PAD_LEFT, )
	
	//Direita
	cTexto := "Página "+cValToChar(nPagAtu)
	oPrintPvt:SayAlign(nLinRod, nColFin-40, cTexto, oFontRod, 040, 10, nCorForte, PAD_RIGHT, )
	
	//Finalizando a página e somando mais um
	oPrintPvt:EndPage()
	nPagAtu++
Return

/*---------------------------------------------------------------------*
 | Func:  fQuebra                                                      |
 | Desc:  Função que faz a lógica da quebra de página                  |
 *---------------------------------------------------------------------*/

Static Function fQuebra()
    //Se atingiu o limite, quebra de página
	If nLinAtu >= nLinFin-5
		fImpRod()
		fImpCab()
	EndIf
Return

/*---------------------------------------------------------------------*
 | Func:  fConfImpr                                                    |
 | Desc:  Função para configurar a impressora que será usada           |
 *---------------------------------------------------------------------*/

Static Function fConfImpr()
	Local aDevice       := {"DISCO", "SPOOL", "EMAIL", "EXCEL", "HTML", "PDF"}
	Local oSetup
	Local cSession  	:= GetPrinterSession()
	Local cDevice     	:= If(Empty(fwGetProfString(cSession,"PRINTTYPE","SPOOL",.T.)),"PDF",fwGetProfString(cSession,"PRINTTYPE","SPOOL",.T.))
	Local nPrintType    := aScan(aDevice, {|x| x == cDevice })
	Local nOrientation  := 1 //If(fwGetProfString(cSession, "ORIENTATION", "PORTRAIT", .T.) == "PORTRAIT", 1, 2)
	Local nLocal        := 2 //If(fwGetProfString(cSession, "LOCAL", "SERVER", .T.) == "SERVER", 1, 2)
	Local nFlags        := PD_ISTOTVSPRINTER + PD_DISABLEPREVIEW //+ PD_DISABLEPAPERSIZE + PD_DISABLEMARGIN

	//Cria o setup do relatório
	oSetup := FWPrintSetup():New(nFlags, "ETIQUETA")
	oSetup:SetProperty(PD_DESTINATION , nLocal)
	oSetup:SetProperty(PD_ORIENTATION , nOrientation)
	oSetup:SetProperty(PD_PRINTTYPE   , nPrintType)
	oSetupRel := Nil

	//Se a tela for confirmada, atualiza o setup default do relatório
	If oSetup:Activate() == PD_OK //.And. oSetup:GetProperty(PD_PRINTTYPE) == IMP_SPOOL
		oSetupRel := oSetup
	EndIf
Return
