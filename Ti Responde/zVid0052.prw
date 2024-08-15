/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2023/04/17/gerar-treport-em-pdf-ti-responde-052/ 
    
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zVid0052
Produtos
@author Daniel Atilio
@since 25/08/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function zVid0052()
	Local aArea := FWGetArea()
	Local oReport
	Local aPergs   := {}
	Local xPar0 := Space(TamSX3('B1_COD')[1])
	Local xPar1 := StrTran(xPar0, ' ', 'Z')
	
	//Adicionando os parametros do ParamBox
	aAdd(aPergs, {1, "Produto De", xPar0,  "", ".T.", "SB1", ".T.", 80,  .F.})
	aAdd(aPergs, {1, "Produto Até", xPar1,  "", ".T.", "SB1", ".T.", 80,  .T.})
	
	//Se a pergunta for confirma, cria as definicoes do relatorio
	If ParamBox(aPergs, "Informe os parametros", , , , , , , , , .F., .F.)
		oReport := fReportDef()
		
        //Se usar esse comando, ele mostra a tela para selecionar, arquivo, spool, planilha, etc
        //oReport:PrintDialog()

        //Já o trecho abaixo, já gera o arquivo pdf em uma pasta
		//  O relatório será gerado em %temp%/totvsprinter
        oReport:nDevice  := 6 // 6 = PDF
        oReport:cFile    := "produtos_" + dToS(Date()) + "_" + StrTran(Time(), ":", "-")
        oReport:lPreview := .F.
        oReport:lViewPDF := .F.
        oReport:Print()
	EndIf
	
	FWRestArea(aArea)
Return

/*/{Protheus.doc} fReportDef
Definicoes do relatorio zVid0052
@author Daniel Atilio
@since 25/08/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fReportDef()
	Local oReport
	Local oSection := Nil
	
	//Criacao do componente de impressao
	oReport := TReport():New( "zVid0052",;
		"Produtos",;
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
	TRCell():New(oSection, "B1_COD", "QRY_REP", "Produto", /*cPicture*/, 15, /*lPixel*/, /*{|| code-block de impressao }*/, "LEFT", /*lLineBreak*/, "LEFT", /*lCellBreak*/, /*nColSpace*/, /*lAutoSize*/, /*nClrBack*/, /*nClrFore*/, .F.)
	TRCell():New(oSection, "B1_DESC", "QRY_REP", "Descrição", /*cPicture*/, 50, /*lPixel*/, /*{|| code-block de impressao }*/, "LEFT", /*lLineBreak*/, "LEFT", /*lCellBreak*/, /*nColSpace*/, /*lAutoSize*/, /*nClrBack*/, /*nClrFore*/, .F.)
	
Return oReport

/*/{Protheus.doc} fRepPrint
Impressao do relatorio zVid0052
@author Daniel Atilio
@since 25/08/2022
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
	cQryReport += "SELECT B1_COD, B1_DESC "		+ CRLF
	cQryReport += "FROM " + RetSQLName("SB1") + " SB1 "		+ CRLF
	cQryReport += "WHERE B1_FILIAL = '" + FWxFilial('SB1') + "' "		+ CRLF
	cQryReport += "AND B1_COD >= '" + MV_PAR01 + "' "		+ CRLF
	cQryReport += "AND B1_COD <= '" + MV_PAR02 + "' "		+ CRLF
	cQryReport += "AND SB1.D_E_L_E_T_ = ' '"		+ CRLF
	
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
