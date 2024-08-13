/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/14/abrindo-telas-de-processamento-com-fwmsgrun-e-msgrun-maratona-advpl-e-tl-235/
*/


//Bibliotecas
#Include "Totvs.ch"
#Include "FWMVCDef.ch"

/*/{Protheus.doc} User Function zExe234
Gera um arquivo do Excel e abre
@type Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/display/public/framework/FWMsExcel e https://tdn.totvs.com/display/public/framework/FWMsExcelXlsx
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe234()
    Local aArea    := FWGetArea()
	Local aPergs   := {}
	Local cProdDe  := Space(TamSX3('B1_COD')[1])
	Local cProdAte := StrTran(cProdDe, ' ', 'Z')
	Local cTipoDe  := Space(TamSX3('B1_TIPO')[1])
	Local cTipoAte := StrTran(cTipoDe, ' ', 'Z')
	Local nOrden   := 1
    Local nTipoRel := 1
	
	//Adicionando os parametros do ParamBox
    aAdd(aPergs, {1, "Produto De",  cProdDe,  "", ".T.", "SB1", ".T.", 80,  .F.}) // MV_PAR01
    aAdd(aPergs, {1, "Produto Até", cProdAte, "", ".T.", "SB1", ".T.", 80,  .T.}) // MV_PAR02
    aAdd(aPergs, {1, "Tipo De",     cTipoDe,  "", ".T.", "02",  ".T.", 40,  .F.}) // MV_PAR03
    aAdd(aPergs, {1, "Tipo Até",    cTipoAte, "", ".T.", "02",  ".T.", 40,  .T.}) // MV_PAR04
    aAdd(aPergs, {2, "Ordenar por", nOrden,   {"1=Código do Produto", "2=Descrição do Produto", "3=Unidade de Medida"},  100, ".T.", .T.}) // MV_PAR05
    aAdd(aPergs, {2, "Tipo Relat.", nTipoRel, {"1=Excel XML", "2=Excel XLSX"},  80, ".T.", .T.}) // MV_PAR06
    
    //Se a pergunta for confirma, cria as definicoes do relatorio
    If ParamBox(aPergs, "Informe os parâmetros", , , , , , , , , .F., .F.)
        MV_PAR05 := Val(cValToChar(MV_PAR05))
        MV_PAR06 := Val(cValToChar(MV_PAR06))
		Processa({|| fGeraExcel()})
	EndIf
	
	FWRestArea(aArea)
Return

/*/{Protheus.doc} fGeraExcel
Criacao do arquivo Excel na funcao zRel21
@author Atilio
@since 11/12/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fGeraExcel()
	Local cQryDad  := ""
	Local oFWMsExcel
	Local oExcel
	Local cArquivo    := GetTempPath() + "zRel21.xml"
	Local cWorkSheet := "Produtos"
	Local cTitulo    := "Listagem de Produtos"
	Local nAtual := 0
	Local nTotal := 0
	
	//Montando consulta de dados
	cQryDad := "SELECT "		+ CRLF
	cQryDad += "    B1_COD, "		+ CRLF
	cQryDad += "    B1_DESC, "		+ CRLF
	cQryDad += "    B1_TIPO, "		+ CRLF
	cQryDad += "    ISNULL(X5_DESCRI, '') AS TIPODESCR, "		+ CRLF
	cQryDad += "    B1_UM, "		+ CRLF
	cQryDad += "    ISNULL(AH_DESCPO, '') AS UMDESCR, "		+ CRLF
    cQryDad += "    B1_PESO "		+ CRLF
	cQryDad += "FROM "		+ CRLF
	cQryDad += "    " + RetSQLName("SB1") + " SB1 "		+ CRLF
	cQryDad += "    LEFT JOIN " + RetSQLName("SX5") + " SX5 ON ( "		+ CRLF
	cQryDad += "       X5_FILIAL = '" + FWxFilial("SX5") + "' "		+ CRLF
	cQryDad += "       AND X5_TABELA = '02' "		+ CRLF
	cQryDad += "       AND X5_CHAVE = B1_TIPO "		+ CRLF
	cQryDad += "       AND SX5.D_E_L_E_T_ = ' ' "		+ CRLF
	cQryDad += "    ) "		+ CRLF
	cQryDad += "    LEFT JOIN " + RetSQLName("SAH") + " SAH ON ( "		+ CRLF
	cQryDad += "       AH_FILIAL = '" + FWxFilial("SAH") + "' "		+ CRLF
	cQryDad += "       AND AH_UNIMED = B1_UM "		+ CRLF
	cQryDad += "       AND SAH.D_E_L_E_T_ = ' ' "		+ CRLF
	cQryDad += "    ) "		+ CRLF
	cQryDad += "WHERE "		+ CRLF
	cQryDad += "    B1_FILIAL = '" + FWxFilial("SB1") + "' "		+ CRLF
	cQryDad += "    AND B1_COD >= '" + MV_PAR01 + "' "		+ CRLF
	cQryDad += "    AND B1_COD <= '" + MV_PAR02 + "' "		+ CRLF
	cQryDad += "    AND B1_TIPO >= '" + MV_PAR03 + "' "		+ CRLF
	cQryDad += "    AND B1_TIPO <= '" + MV_PAR04 + "' "		+ CRLF
	cQryDad += "    AND B1_MSBLQL != '1' "		+ CRLF
	cQryDad += "    AND SB1.D_E_L_E_T_ = ' ' "		+ CRLF
	cQryDad += "ORDER BY "		+ CRLF
    cQryDad += "    B1_TIPO, "		+ CRLF
    If MV_PAR05 == 1
	    cQryDad += "    B1_COD "		+ CRLF
    ElseIf MV_PAR05 == 2
        cQryDad += "    B1_DESC "		+ CRLF
    ElseIf MV_PAR05 == 3
        cQryDad += "    B1_UM "		+ CRLF
    EndIf
	
	//Executando consulta e setando o total da regua
	PlsQuery(cQryDad, "QRY_DAD")
	DbSelectArea("QRY_DAD")
	
	//Cria a planilha do excel
    If MV_PAR06 == 1
	    oFWMsExcel := FWMSExcel():New()
    ElseIf MV_PAR06 == 2
        oFWMsExcel := FWMSExcelXLSX():New()
    EndIf
	
	//Criando a aba da planilha
	oFWMsExcel:AddworkSheet(cWorkSheet)
	
	//Criando a Tabela e as colunas
	oFWMsExcel:AddTable(cWorkSheet, cTitulo)
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Produto", 1, 1, .F.)
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Descrição", 1, 1, .F.)
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Tipo", 1, 1, .F.)
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Tp. Descrição", 1, 1, .F.)
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "UM", 1, 1, .F.)
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "UM Descrição", 1, 1, .F.)
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Peso", 3, 2, .F.)
	
	//Definindo o tamanho da regua
	Count To nTotal
	ProcRegua(nTotal)
	QRY_DAD->(DbGoTop())
	
	//Percorrendo os dados da query
	While !(QRY_DAD->(EoF()))
		
		//Incrementando a regua
		nAtual++
		IncProc("Adicionando registro " + cValToChar(nAtual) + " de " + cValToChar(nTotal) + "...")
		
		//Adicionando uma nova linha
		oFWMsExcel:AddRow(cWorkSheet, cTitulo, {;
			QRY_DAD->B1_COD,;
			QRY_DAD->B1_DESC,;
			QRY_DAD->B1_TIPO,;
			QRY_DAD->TIPODESCR,;
			QRY_DAD->B1_UM,;
			QRY_DAD->UMDESCR,;
			QRY_DAD->B1_PESO;
		})
		
		QRY_DAD->(DbSkip())
	EndDo
	QRY_DAD->(DbCloseArea())
	
	//Ativando o arquivo e gerando o xml
	oFWMsExcel:Activate()
	oFWMsExcel:GetXMLFile(cArquivo)
	
	//Abrindo o excel e abrindo o arquivo xml
	oExcel := MsExcel():New()
	oExcel:WorkBooks:Open(cArquivo)
	oExcel:SetVisible(.T.)
	oExcel:Destroy()
	
Return

