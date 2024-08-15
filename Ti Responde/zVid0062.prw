/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2023/06/26/fazer-uma-condicao-em-um-trfunction-ti-responde-062/ 
    
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zVid0062
Itens de PV
@author Atilio
@since 30/08/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function zVid0062()
	Local aArea := FWGetArea()
	Local oReport
	Local aPergs   := {}
	Local cPedDe := Space(TamSX3('C6_NUM')[1])
	Local cPedAt := StrTran(cPedDe, ' ', 'Z')
    Local nTotaliz    := 1
	
	//Adicionando os parametros do ParamBox
	aAdd(aPergs, {1, "Pedido De",  cPedDe,  "", ".T.", "SC5", ".T.", 80,  .F.})
	aAdd(aPergs, {1, "Pedido Até", cPedAt,  "", ".T.", "SC5", ".T.", 80,  .T.})
    aAdd(aPergs, {2, "Totalizar", nTotaliz, {"1=Tudo", "2=Apenas com Documento emitido", "3=Apenas sem Documento emitido"}, 105, ".T.", .F.})
	
	//Se a pergunta for confirma, cria as definicoes do relatorio
	If ParamBox(aPergs, "Informe os parametros", , , , , , , , , .F., .F.)
        MV_PAR03 := Val(cValToChar(MV_PAR03))

		oReport := fReportDef()
		oReport:PrintDialog()
	EndIf
	
	FWRestArea(aArea)
Return

/*/{Protheus.doc} fReportDef
Definicoes do relatorio zVid0062
@author Atilio
@since 30/08/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fReportDef()
	Local oReport
	Local oSection := Nil
	
	//Criacao do componente de impressao
	oReport := TReport():New( "zVid0062",;
		"Itens de Ped. Venda",;
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
	TRCell():New(oSection, "C6_NUM", "QRY_REP", "Pedido", /*cPicture*/, 6, /*lPixel*/, /*{|| code-block de impressao }*/, "LEFT", /*lLineBreak*/, "LEFT", /*lCellBreak*/, /*nColSpace*/, /*lAutoSize*/, /*nClrBack*/, /*nClrFore*/, .F.)
	TRCell():New(oSection, "C6_ITEM", "QRY_REP", "Item", /*cPicture*/, 2, /*lPixel*/, /*{|| code-block de impressao }*/, "LEFT", /*lLineBreak*/, "LEFT", /*lCellBreak*/, /*nColSpace*/, /*lAutoSize*/, /*nClrBack*/, /*nClrFore*/, .F.)
	TRCell():New(oSection, "C6_PRODUTO", "QRY_REP", "Produto", /*cPicture*/, 15, /*lPixel*/, /*{|| code-block de impressao }*/, "LEFT", /*lLineBreak*/, "LEFT", /*lCellBreak*/, /*nColSpace*/, /*lAutoSize*/, /*nClrBack*/, /*nClrFore*/, .F.)
	TRCell():New(oSection, "B1_DESC", "QRY_REP", "Descrição", /*cPicture*/, 30, /*lPixel*/, /*{|| code-block de impressao }*/, "LEFT", /*lLineBreak*/, "LEFT", /*lCellBreak*/, /*nColSpace*/, /*lAutoSize*/, /*nClrBack*/, /*nClrFore*/, .F.)
    TRCell():New(oSection, "C6_NOTA", "QRY_REP", "Documento", /*cPicture*/, 9, /*lPixel*/, /*{|| code-block de impressao }*/, "LEFT", /*lLineBreak*/, "LEFT", /*lCellBreak*/, /*nColSpace*/, /*lAutoSize*/, /*nClrBack*/, /*nClrFore*/, .F.)
	TRCell():New(oSection, "C6_VALOR", "QRY_REP", "Valor", "@E 999,999,999.99 ", 12, /*lPixel*/, /*{|| code-block de impressao }*/, "RIGHT", /*lLineBreak*/, "RIGHT", /*lCellBreak*/, /*nColSpace*/, /*lAutoSize*/, /*nClrBack*/, /*nClrFore*/, .F.)
	
	//Totalizadores
    If MV_PAR03 == 1
        TRFunction():New(oSection:Cell("C6_VALOR"), /*cName*/, "SUM", /*oBreak*/, /*cTitle*/, "@E 999,999,999.99", /*uFormula*/, .F.)
    ElseIf MV_PAR03 == 2
        TRFunction():New(oSection:Cell("C6_VALOR"), /*cName*/, "SUM", /*oBreak*/, /*cTitle*/, "@E 999,999,999.99", /*uFormula*/, .F., /*lEndReport*/, /*lEndPage*/, /*oParent*/, {|| ! Empty(QRY_REP->C6_NOTA) })
    ElseIf MV_PAR03 == 3
        TRFunction():New(oSection:Cell("C6_VALOR"), /*cName*/, "SUM", /*oBreak*/, /*cTitle*/, "@E 999,999,999.99", /*uFormula*/, .F., /*lEndReport*/, /*lEndPage*/, /*oParent*/, {|| Empty(QRY_REP->C6_NOTA) })
    EndIf
	
Return oReport

/*/{Protheus.doc} fRepPrint
Impressao do relatorio zVid0062
@author Atilio
@since 30/08/2022
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
	
	//Pegando as secoes do relatorio
	oSectDad := oReport:Section(1)
	
	//Montando consulta de dados
	cQryReport += "SELECT "		+ CRLF
	cQryReport += " C6_NUM, "		+ CRLF
	cQryReport += " C6_ITEM, "		+ CRLF
	cQryReport += " C6_PRODUTO, "		+ CRLF
	cQryReport += " B1_DESC, "		+ CRLF
	cQryReport += " C6_VALOR, "		+ CRLF
	cQryReport += " C6_NOTA "		+ CRLF
	cQryReport += "FROM "		+ CRLF
	cQryReport += " " + RetSQLName("SC6") + " SC6 "		+ CRLF
	cQryReport += " INNER JOIN " + RetSQLName("SB1") + " SB1 ON ( "		+ CRLF
	cQryReport += " B1_FILIAL = '" + FWxFilial('SB1') + "' "		+ CRLF
	cQryReport += " AND B1_COD = C6_PRODUTO "		+ CRLF
	cQryReport += " AND SB1.D_E_L_E_T_ = ' ' "		+ CRLF
	cQryReport += " ) "		+ CRLF
	cQryReport += "WHERE "		+ CRLF
	cQryReport += " C6_FILIAL = '" + FWxFilial('SC6') + "' "		+ CRLF
	cQryReport += " AND C6_NUM >= '" + MV_PAR01 + "' "		+ CRLF
	cQryReport += " AND C6_NUM <= '" + MV_PAR02 + "' "		+ CRLF
	cQryReport += " AND SC6.D_E_L_E_T_ = ' ' "		+ CRLF
	cQryReport += "ORDER BY "		+ CRLF
	cQryReport += " C6_NUM, C6_ITEM"		+ CRLF
	
	//Executando consulta e setando o total da regua
	PlsQuery(cQryReport, "QRY_REP")
	DbSelectArea("QRY_REP")
	Count to nTotal
	oReport:SetMeter(nTotal)
	
	//Enquanto houver dados
	oSectDad:Init()
	QRY_REP->(DbGoTop())
	While ! QRY_REP->(Eof())
	
		//Incrementando a regua
		nAtual++
		oReport:SetMsgPrint("Imprimindo registro " + cValToChar(nAtual) + " de " + cValToChar(nTotal) + "...")
		oReport:IncMeter()
		
		//Imprimindo a linha atual
		oSectDad:PrintLine()
		
		QRY_REP->(DbSkip())
	EndDo
	oSectDad:Finish()
	QRY_REP->(DbCloseArea())
	
	FWRestArea(aArea)
Return
