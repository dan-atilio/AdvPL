/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/01/09/como-fazer-uma-quebra-e-totalizador-em-relatorio-com-fwmsprinter-ti-responde-0115/ 
    
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

/*/{Protheus.doc} User Function zVid0115
Exemplo de quebra com totalizador
@author Atilio
@since 15/01/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function zVid0115()
	Local aArea := FWGetArea()
	Local aPergs   := {}
	Local cEstDe := Space(2)
	Local cEstAte := StrTran(cEstDe, ' ', 'Z')
	
	//Adicionando os parametros do ParamBox
	aAdd(aPergs, {1, "Estado De", cEstDe,  "", ".T.", "12", ".T.", 80,  .F.})
	aAdd(aPergs, {1, "Estado Até", cEstAte,  "", ".T.", "12", ".T.", 80,  .T.})
	
	//Se a pergunta for confirma, cria o relatorio
	If ParamBox(aPergs, 'Informe os parâmetros', /*aRet*/, /*bOk*/, /*aButtons*/, /*lCentered*/, /*nPosx*/, /*nPosy*/, /*oDlgWizard*/, /*cLoad*/, .F., .F.)
		Processa({|| fImprime()})
	EndIf
	
	FWRestArea(aArea)
Return

/*/{Protheus.doc} fImprime
Faz a impressão do relatório zVid0115
@author Atilio
@since 15/01/2024
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
    Local cArquivo     := 'zVid0115'+RetCodUsr()+'_' + dToS(Date()) + '_' + StrTran(Time(), ':', '-') + '.pdf'
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
    //Variáveis responsáveis pela quebra e total
    Private cChaveAtu  := ""
    Private nValorTot  := 0
     
    //Monta a consulta de dados
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

            //Aciona a função que valida o totalizador e imprime
            fTotal()
             
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

            //Incrementa o totalizador, contando uma cidade a mais
            nValorTot++
             
            QRY_AUX->(DbSkip())
        EndDo

        //Aciona a função que valida o totalizador e imprime uma última vez antes de imprimir o último rodapé
        fTotal()
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
@since 15/01/2024
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
@since 15/01/2024
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
@since 15/01/2024
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
    cTexto := dToC(dDataBase) + '     ' + cHoraEx + '     ' + FunName() + ' (zVid0115)     ' + UsrRetName(RetCodUsr())
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
@since 15/01/2024
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

/*/{Protheus.doc} fTotal
Função que valida a quebra e imprime as informações do total
@author Atilio
@since 15/01/2024
@version 1.0
@type function
/*/

Static Function fTotal()
    Local nCorDestaq := RGB(255, 000, 000)
    Local cTexto     := ""

    //Se estiver no fim do alias (já tiver acabado o while) ou a chave for diferente
    If QRY_AUX->(EoF()) .Or. cChaveAtu != QRY_AUX->CC2_EST
        //Se tiver chave, irá imprimir o valor total (quantidade de cidades)
        If ! Empty(cChaveAtu)
            cTexto := "Quantidade total de cidades: " + Alltrim(Transform(nValorTot, "@E 999,999"))
            oPrintPvt:SayAlign(nLinAtu, nColIni, cTexto, oFontDet, 200, 10, nCorDestaq, PAD_LEFT, /*nAlignVert*/)
            nLinAtu += 15
        EndIf

        //Se houver dados ainda na query, atualiza a chave, zera o total, e imprime a sigla e nome do estado
        If ! QRY_AUX->(EoF())
            cChaveAtu := QRY_AUX->CC2_EST
            nValorTot := 0

            cTexto := cChaveAtu + " - " + Alltrim(QRY_AUX->X5_DESCRI)
            oPrintPvt:SayAlign(nLinAtu, nColIni, cTexto, oFontDet, 200, 10, nCorDestaq, PAD_LEFT, /*nAlignVert*/)
            nLinAtu += 15
        EndIf
    EndIf
Return
