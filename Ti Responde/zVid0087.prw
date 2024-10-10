/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2024/10/03/gerar-treport-em-excel-e-enviar-por-email-ti-responde-0087/ 
    
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zVid0087
Listagem de Cidades
@author Atilio
@since 14/02/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function zVid0087()
	Local aArea
	Local oReport
	Local aPergs   := {}
	Local cEstDe := "  "
	Local cEstAte := "ZZ"
	Local nOrdPor := 1
    Local lContinua := .F.
    Local lAuto := .F.
    Local cArqExcel := ""
    Local cAssunto := ""
    Local cCorpo := ""
    Local cPara := ""
    Local aAnexos := {}

    //Se veio via programa inicial / agendamento, vamos preparar o ambiente
    If Select("SX2") <= 0
		RPCSetEnv("99", "01", "Administrador", "", "", "")
        lContinua := .T.
        lAuto := .T.

        //Define os valores dos parâmetros
        MV_PAR01 := "  "
        MV_PAR02 := "ZZ"
        MV_PAR03 := 2

    //Senão, veio pelo sistema normalmente
    Else
        //Adicionando os parametros do ParamBox
        aAdd(aPergs, {1, "Estado De", cEstDe,  "", ".T.", "12", ".T.", 40,  .F.})
        aAdd(aPergs, {1, "Estado Até", cEstAte,  "", ".T.", "12", ".T.", 40,  .T.})
        aAdd(aPergs, {2, "Ordenar por", nOrdPor, {"1=Nome da Cidade", "2=Código da Cidade"}, 090, ".T.", .T.})

        //Verifica se o usuário confirmou a pergunta
        lContinua := ParamBox(aPergs, 'Informe os parâmetros', /*aRet*/, /*bOk*/, /*aButtons*/, /*lCentered*/, /*nPosx*/, /*nPosy*/, /*oDlgWizard*/, /*cLoad*/, .F., .F.)
        MV_PAR03 := Val(cValToChar(MV_PAR03))
    EndIf
	aArea := FWGetArea()

    //Se é para continuar com a geração do relatório
	If lContinua
        //Cria as definições do relatório (seções, células, etc)
        oReport := fReportDef()

        //Se for automático
        If lAuto
            //Define o nome do arquivo, tem que estar dentro da pasta setada no parâmetro
            cArqExcel := Alltrim(GetMV("MV_RELT"))
            If Right(cArqExcel, 1) != "\"
                cArqExcel += "\"
            EndIf
            cArqExcel += "lista_cidades_" + dToS(Date()) + "_" + StrTran(Time(), ":", "-") + ".xls"

            //Aciona a geração do arquivo
            oReport:nDevice  := 4        //Planilha
            oReport:nExcelPrintType := 3 //Formato de tabela
            oReport:cFile    := cArqExcel
            oReport:cXlsFile := oReport:cFile
            oReport:lPreview := .F.
            oReport:nRemoteType := NO_REMOTE
            oReport:Print(.F., "", .T.)

            //Aguarda 5 segundos antes de fazer o disparo (pra dar tempo de processar o spool)
            Sleep(5000)

            //Se o arquivo existir
            If File(cArqExcel)
                //Adiciona no array de anexos e define as informações do disparo do eMail
                aAdd(aAnexos, cArqExcel)
                cAssunto := "Listagem de Cidades"
                cPara := "contato@atiliosistemas.com;"
                cCorpo := "<p>Ola.</p>"
                cCorpo += "<p>Segue em anexo a planilha com a lista de cidades cadastradas no sistema <strong>(tabela CC2)</strong>.</p>"
                cCorpo += "<p><font face='red'>eMail gerado automaticamente pelo ERP Protheus</font></p>"

                //Dispara o eMail
                GPEMail(cAssunto, cCorpo, cPara, aAnexos, .T.)
            EndIf

        //Senão, mostra a tela para usuário confirmar como gerar o relatório (spool, planilha, pdf, etc)
        Else
		    oReport:PrintDialog()
	    EndIf
    EndIf
	
	FWRestArea(aArea)
Return

/*/{Protheus.doc} fReportDef
Definicoes do relatorio zVid0087
@author Atilio
@since 10/01/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fReportDef()
	Local oReport
	Local oSection := Nil
	Local oBreak
	
	//Criacao do componente de impressao
	oReport := TReport():New( "zVid0087",;
		"Listagem de Cidades",;
		,;
		{|oReport| fRepPrint(oReport),};
		)
	oReport:SetTotalInLine(.F.)
	oReport:lParamPage := .F.
	oReport:oPage:SetPaperSize(9)
	
	//Orientacao do Relatorio
	oReport:SetPortrait()
	
	//Criando a secao de dados
	oSection := TRSection():New( oReport,;
		"Dados",;
		{"QRY_REP"})
	oSection:SetTotalInLine(.F.)
	
	//Colunas do relatorio
	TRCell():New(oSection, "CC2_EST", "QRY_REP", "Estado", /*cPicture*/, 2, /*lPixel*/, /*{|| code-block de impressao }*/, "LEFT", /*lLineBreak*/, "LEFT", /*lCellBreak*/, /*nColSpace*/, /*lAutoSize*/, /*nClrBack*/, /*nClrFore*/, .F.)
	TRCell():New(oSection, "CC2_CODMUN", "QRY_REP", "Codigo", /*cPicture*/, 5, /*lPixel*/, /*{|| code-block de impressao }*/, "LEFT", /*lLineBreak*/, "LEFT", /*lCellBreak*/, /*nColSpace*/, /*lAutoSize*/, /*nClrBack*/, /*nClrFore*/, .F.)
	TRCell():New(oSection, "CC2_MUN", "QRY_REP", "Nome", /*cPicture*/, 60, /*lPixel*/, /*{|| code-block de impressao }*/, "LEFT", /*lLineBreak*/, "LEFT", /*lCellBreak*/, /*nColSpace*/, /*lAutoSize*/, /*nClrBack*/, /*nClrFore*/, .F.)
	
	//Quebras do relatorio
	oBreak := TRBreak():New(oSection, oSection:Cell("CC2_EST"), {||""}, .F.)

Return oReport

/*/{Protheus.doc} fRepPrint
Impressao do relatorio zVid0087
@author Atilio
@since 10/01/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fRepPrint(oReport)
	Local aArea    := FWGetArea()
	Local cQryReport  := ""
	Local oSectDad := Nil
	Local nAtual   := 0
	Local nTotal   := 0
	Local oFontEst := TFont():New("Arial", /*uPar2*/, -14, /*uPar4*/, .T.)
	Local cEstAtu  := ""
	Local nLinAtu  := 0
	Local nCorImp  := RGB(255, 000, 000)
	
	//Pegando as secoes do relatorio
	oSectDad := oReport:Section(1)
	
	//Montando consulta de dados
	cQryReport := "SELECT "		+ CRLF
	cQryReport += "    CC2_EST, "		+ CRLF
	cQryReport += "    X5_DESCRI, "		+ CRLF
	cQryReport += "    CC2_CODMUN, "		+ CRLF
	cQryReport += "    CC2_MUN "		+ CRLF
	cQryReport += "FROM "		+ CRLF
	cQryReport += "    " + RetSQLName("CC2") + " CC2 "		+ CRLF
	cQryReport += "    INNER JOIN " + RetSQLName("SX5") + " SX5 ON ( "		+ CRLF
	cQryReport += "        X5_FILIAL = '" + FWxFilial("SX5") + "' "		+ CRLF
	cQryReport += "        AND X5_TABELA = '12' "		+ CRLF
	cQryReport += "        AND X5_CHAVE = CC2_EST "		+ CRLF
	cQryReport += "        AND SX5.D_E_L_E_T_ = ' ' "		+ CRLF
	cQryReport += "    ) "		+ CRLF
	cQryReport += "WHERE "		+ CRLF
	cQryReport += "    CC2_FILIAL = '" + FWxFilial("CC2") + "' "		+ CRLF
	cQryReport += "    AND CC2_EST >= '" + MV_PAR01 + "' "		+ CRLF
	cQryReport += "    AND CC2_EST <= '" + MV_PAR02 + "' "		+ CRLF
	cQryReport += "    AND CC2.D_E_L_E_T_ = ' ' "		+ CRLF
	cQryReport += "ORDER BY "		+ CRLF
	cQryReport += "    CC2_EST "		+ CRLF
    If MV_PAR03 == 1
	    cQryReport += "    , CC2_MUN"		+ CRLF
    ElseIf MV_PAR03 == 2
        cQryReport += "    , CC2_CODMUN"		+ CRLF
    EndIf
	
	//Executando consulta e setando o total da regua
	PlsQuery(cQryReport, "QRY_REP")
	DbSelectArea("QRY_REP")
	Count to nTotal
	oReport:SetMeter(nTotal)
	
	//Se houver dados
	QRY_REP->(DbGoTop())
	If ! QRY_REP->(EoF())

		//Temos que acionar a primeira vez o StartPage para poder sair certo o texto do primeiro estado
		oReport:StartPage()

		//Enquanto houver dados
		oSectDad:Init()
		While ! QRY_REP->(Eof())

			//Se o estado atual for diferente
			If cEstAtu != QRY_REP->CC2_EST
				
				//Atualiza a sigla
				cEstAtu := QRY_REP->CC2_EST

				//Pula uma linha e captura a linha atual
				oReport:SkipLine()
				nLinAtu := oReport:Row()

				//Imprime um texto com a sigla do estado e nome
				oReport:Say(nLinAtu, 020, cEstAtu + " - " + QRY_REP->X5_DESCRI, oFontEst, /*nWidth*/, nCorImp)

				//Pula um espaço do relatório
				oReport:SkipLine()
				oReport:SkipLine()
				oReport:SkipLine()
			EndIf
		
			//Incrementando a regua
			nAtual++
			oReport:SetMsgPrint("Imprimindo registro " + cValToChar(nAtual) + " de " + cValToChar(nTotal) + "...")
			oReport:IncMeter()
			
			//Imprimindo a linha atual
			oSectDad:PrintLine()
			
			QRY_REP->(DbSkip())
		EndDo
		oSectDad:Finish()
	EndIf
	QRY_REP->(DbCloseArea())

	
	FWRestArea(aArea)
Return
