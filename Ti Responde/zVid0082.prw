/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2024/09/17/como-imprimir-um-texto-manualmente-em-um-treport-ti-responde-0082/ 
    
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zVid0082
Listagem de Cidades
@author Atilio
@since 10/01/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function zVid0082()
	Local aArea := FWGetArea()
	Local oReport
	Local aPergs   := {}
	Local cEstDe := "  "
	Local cEstAte := "ZZ"
	Local nOrdPor := 1
	
	//Adicionando os parametros do ParamBox
	aAdd(aPergs, {1, "Estado De", cEstDe,  "", ".T.", "12", ".T.", 40,  .F.})
	aAdd(aPergs, {1, "Estado Até", cEstAte,  "", ".T.", "12", ".T.", 40,  .T.})
	aAdd(aPergs, {2, "Ordenar por", nOrdPor, {"1=Nome da Cidade", "2=Código da Cidade"}, 090, ".T.", .T.})
	
	//Se a pergunta for confirma, cria as definicoes do relatorio
	If ParamBox(aPergs, 'Informe os parâmetros', /*aRet*/, /*bOk*/, /*aButtons*/, /*lCentered*/, /*nPosx*/, /*nPosy*/, /*oDlgWizard*/, /*cLoad*/, .F., .F.)
		MV_PAR03 := Val(cValToChar(MV_PAR03))
		oReport := fReportDef()
		oReport:PrintDialog()
	EndIf
	
	FWRestArea(aArea)
Return

/*/{Protheus.doc} fReportDef
Definicoes do relatorio zVid0082
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
	oReport := TReport():New( "zVid0082",;
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

	//Define que irá imprimir os títulos após a quebra
	oSection:SetHeaderBreak(.T.)

	//Esconde a célula de sigla do estado (foi usada para usar o TRBreak e TRFunction)
	oSection:Cell("CC2_EST"):Hide()
	oSection:Cell("CC2_EST"):HideHeader()

Return oReport

/*/{Protheus.doc} fRepPrint
Impressao do relatorio zVid0082
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
