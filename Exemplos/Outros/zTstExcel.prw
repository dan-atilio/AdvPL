//Bibliotecas
#Include "Protheus.ch"
#Include "TopConn.ch"

//Constantes
#Define STR_PULA	Chr(13)+Chr(10)

/*/{Protheus.doc} zTstExc1
Função que cria um exemplo de FWMsExcel
@author Atilio
@since 06/08/2016
@version 1.0
	@example
	u_zTstExc1()
/*/

User Function zTstExc1()
	Local aArea		:= GetArea()
	Local cQuery		:= ""
	Local oFWMsExcel
	Local oExcel
	Local cArquivo	:= GetTempPath()+'zTstExc1.xml'

	//Pegando os dados
	cQuery := " SELECT "													+ STR_PULA
	cQuery += " 	SB1.B1_COD, "											+ STR_PULA
	cQuery += " 	SB1.B1_DESC, "										+ STR_PULA
	cQuery += " 	SB1.B1_TIPO, "										+ STR_PULA
	cQuery += " 	SBM.BM_GRUPO, "										+ STR_PULA
	cQuery += " 	SBM.BM_DESC, "										+ STR_PULA
	cQuery += " 	SBM.BM_PROORI "										+ STR_PULA
	cQuery += " FROM "													+ STR_PULA
	cQuery += " 	"+RetSQLName('SB1')+" SB1 "							+ STR_PULA
	cQuery += " 	INNER JOIN "+RetSQLName('SBM')+" SBM ON ( "		+ STR_PULA
	cQuery += " 		SBM.BM_FILIAL = '"+FWxFilial('SBM')+"' "		+ STR_PULA
	cQuery += " 		AND SBM.BM_GRUPO = B1_GRUPO "					+ STR_PULA
	cQuery += " 		AND SBM.D_E_L_E_T_='' "							+ STR_PULA
	cQuery += " 	) "														+ STR_PULA
	cQuery += " WHERE "													+ STR_PULA
	cQuery += " 	SB1.B1_FILIAL = '"+FWxFilial('SBM')+"' "			+ STR_PULA
	cQuery += " 	AND SB1.D_E_L_E_T_ = '' "							+ STR_PULA
	cQuery += " ORDER BY "												+ STR_PULA
	cQuery += " 	SB1.B1_COD "											+ STR_PULA
	TCQuery cQuery New Alias "QRYPRO"
	
	//Criando o objeto que irá gerar o conteúdo do Excel
	oFWMsExcel := FWMSExcel():New()
	
	//Aba 01 - Teste
	oFWMsExcel:AddworkSheet("Aba 1 Teste") //Não utilizar número junto com sinal de menos. Ex.: 1-
		//Criando a Tabela
		oFWMsExcel:AddTable("Aba 1 Teste","Titulo Tabela")
		//Criando Colunas
		oFWMsExcel:AddColumn("Aba 1 Teste","Titulo Tabela","Col1",1,1) //1 = Modo Texto
		oFWMsExcel:AddColumn("Aba 1 Teste","Titulo Tabela","Col2",2,2) //2 = Valor sem R$
		oFWMsExcel:AddColumn("Aba 1 Teste","Titulo Tabela","Col3",3,3) //3 = Valor com R$
		oFWMsExcel:AddColumn("Aba 1 Teste","Titulo Tabela","Col4",1,1)
		//Criando as Linhas
		oFWMsExcel:AddRow("Aba 1 Teste","Titulo Tabela",{11,12,13,sToD('20140317')})
		oFWMsExcel:AddRow("Aba 1 Teste","Titulo Tabela",{21,22,23,sToD('20140217')})
		oFWMsExcel:AddRow("Aba 1 Teste","Titulo Tabela",{31,32,33,sToD('20140117')})
		oFWMsExcel:AddRow("Aba 1 Teste","Titulo Tabela",{41,42,43,sToD('20131217')})
	
	
	//Aba 02 - Produtos
	oFWMsExcel:AddworkSheet("Aba 2 Produtos")
		//Criando a Tabela
		oFWMsExcel:AddTable("Aba 2 Produtos","Produtos")
		oFWMsExcel:AddColumn("Aba 2 Produtos","Produtos","Codigo",1)
		oFWMsExcel:AddColumn("Aba 2 Produtos","Produtos","Descricao",1)
		oFWMsExcel:AddColumn("Aba 2 Produtos","Produtos","Tipo",1)
		oFWMsExcel:AddColumn("Aba 2 Produtos","Produtos","Grupo",1)
		oFWMsExcel:AddColumn("Aba 2 Produtos","Produtos","Desc.Grupo",1)
		oFWMsExcel:AddColumn("Aba 2 Produtos","Produtos","Procedencia",1)
		//Criando as Linhas... Enquanto não for fim da query
		While !(QRYPRO->(EoF()))
			oFWMsExcel:AddRow("Aba 2 Produtos","Produtos",{;
																	QRYPRO->B1_COD,;
																	QRYPRO->B1_DESC,;
																	QRYPRO->B1_TIPO,;
																	QRYPRO->BM_GRUPO,;
																	QRYPRO->BM_DESC,;
																	Iif(QRYPRO->BM_PROORI == '0', 'Não Original', 'Original');
			})
		
			//Pulando Registro
			QRYPRO->(DbSkip())
		EndDo
	
	//Ativando o arquivo e gerando o xml
	oFWMsExcel:Activate()
	oFWMsExcel:GetXMLFile(cArquivo)
		
	//Abrindo o excel e abrindo o arquivo xml
	oExcel := MsExcel():New() 			//Abre uma nova conexão com Excel
	oExcel:WorkBooks:Open(cArquivo) 	//Abre uma planilha
	oExcel:SetVisible(.T.) 				//Visualiza a planilha
	oExcel:Destroy()						//Encerra o processo do gerenciador de tarefas
	
	QRYPRO->(DbCloseArea())
	RestArea(aArea)
Return

/*/{Protheus.doc} zTstExc2
Função que cria um exemplo de FWMSExcelEx
@author Atilio
@since 06/08/2016
@version 1.0
	@example
	u_zTstExc2()
/*/

User Function zTstExc2()
	Local cArquivo	:= GetTempPath()+'zTstExc2c.xml'
	Local oFWMSEx		:= FWMsExcelEx():New()
	Local oExcel
	
	//Criando a Aba Teste 1
	oFWMSEx:AddworkSheet("Teste - 1")
		//Adicionando a tabela
		oFWMSEx:AddTable ("Teste - 1","Titulo de teste 1")
			//Adicionando as colunas
			oFWMSEx:AddColumn("Teste - 1","Titulo de teste 1","Col1",1,1)
			oFWMSEx:AddColumn("Teste - 1","Titulo de teste 1","Col2",2,2)
			oFWMSEx:AddColumn("Teste - 1","Titulo de teste 1","Col3",3,3)
			oFWMSEx:AddColumn("Teste - 1","Titulo de teste 1","Col4",1,1)
			
				//Alterando atributos da linha e adicionando
				oFWMSEx:SetCelBold(.T.)
				oFWMSEx:SetCelFont('Arial')
				oFWMSEx:SetCelItalic(.T.)
				oFWMSEx:SetCelUnderLine(.T.)
				oFWMSEx:SetCelSizeFont(10)
				oFWMSEx:AddRow("Teste - 1","Titulo de teste 1",{11,12,13,14},{1,3})
				
				//Alterando atributos da linha e adicionando
				oFWMSEx:SetCelBold(.T.)
				oFWMSEx:SetCelFont('Arial')
				oFWMSEx:SetCelItalic(.T.)
				oFWMSEx:SetCelUnderLine(.T.)
				oFWMSEx:SetCelSizeFont(15)
				oFWMSEx:SetCelFrColor("#FFFFFF")
				oFWMSEx:SetCelBgColor("#000666")
				oFWMSEx:AddRow("Teste - 1","Titulo de teste 1",{21,22,23,24},{1})
				
				//Alterando atributos da linha e adicionando
				oFWMSEx:SetCelBold(.T.)
				oFWMSEx:SetCelFont('Courier New')
				oFWMSEx:SetCelItalic(.F.)
				oFWMSEx:SetCelUnderLine(.T.)
				oFWMSEx:SetCelSizeFont(10)
				oFWMSEx:SetCelFrColor("#FFFFFF")
				oFWMSEx:SetCelBgColor("#000333")
				oFWMSEx:AddRow("Teste - 1","Titulo de teste 1",{31,32,33,34},{2,4})
				
				//Alterando atributos da linha e adicionando
				oFWMSEx:SetCelBold(.T.)
				oFWMSEx:SetCelFont('Line Draw')
				oFWMSEx:SetCelItalic(.F.)
				oFWMSEx:SetCelUnderLine(.F.)
				oFWMSEx:SetCelSizeFont(12)
				oFWMSEx:SetCelFrColor("#FFFFFF")
				oFWMSEx:SetCelBgColor("#D7BCFB")
				oFWMSEx:AddRow("Teste - 1","Titulo de teste 1",{41,42,43,44},{3})
	
	//Adicionando aba Teste 2
	oFWMSEx:AddworkSheet("Teste - 2")
		//Adicionando a tabela
		oFWMSEx:AddTable("Teste - 2","Titulo de teste 1")
			//Adicionando as colunas
			oFWMSEx:AddColumn("Teste - 2","Titulo de teste 1","Col1",1)
			oFWMSEx:AddColumn("Teste - 2","Titulo de teste 1","Col2",2)
			oFWMSEx:AddColumn("Teste - 2","Titulo de teste 1","Col3",3)
			oFWMSEx:AddColumn("Teste - 2","Titulo de teste 1","Col4",1)
			//Adicionando as linhas
			oFWMSEx:AddRow("Teste - 2","Titulo de teste 1",{11,12,13,stod("20121212")})
			oFWMSEx:AddRow("Teste - 2","Titulo de teste 1",{21,22,23,stod("20121212")})
			oFWMSEx:AddRow("Teste - 2","Titulo de teste 1",{31,32,33,stod("20121212")})
			oFWMSEx:AddRow("Teste - 2","Titulo de teste 1",{41,42,43,stod("20121212")})
			oFWMSEx:AddRow("Teste - 2","Titulo de teste 1",{51,52,53,stod("20121212")})
		
	//Criando o XML
	oFWMSEx:Activate()
	oFWMSEx:GetXMLFile(cArquivo)
	
	//Abrindo o excel e abrindo o arquivo xml
	oExcel := MsExcel():New() 			//Abre uma nova conexão com Excel
	oExcel:WorkBooks:Open(cArquivo) 	//Abre uma planilha
	oExcel:SetVisible(.T.) 				//Visualiza a planilha
	oExcel:Destroy()						//Encerra o processo do gerenciador de tarefas
Return

/*/{Protheus.doc} zTstExc3
Função que cria um exemplo de FWMsExcel utilizando outras cores e fontes
@author Atilio
@since 06/08/2016
@version 1.0
	@example
	u_zTstExc3()
/*/

User Function zTstExc3()
	Local aArea		:= GetArea()
	Local cQuery		:= ""
	Local oFWMsExcel
	Local oExcel
	Local cArquivo	:= GetTempPath()+'zTstExc3.xml'

	//Pegando os dados
	cQuery := " SELECT "													+ STR_PULA
	cQuery += " 	SB1.B1_COD, "											+ STR_PULA
	cQuery += " 	SB1.B1_DESC, "										+ STR_PULA
	cQuery += " 	SB1.B1_TIPO, "										+ STR_PULA
	cQuery += " 	SBM.BM_GRUPO, "										+ STR_PULA
	cQuery += " 	SBM.BM_DESC, "										+ STR_PULA
	cQuery += " 	SBM.BM_PROORI "										+ STR_PULA
	cQuery += " FROM "													+ STR_PULA
	cQuery += " 	"+RetSQLName('SB1')+" SB1 "							+ STR_PULA
	cQuery += " 	INNER JOIN "+RetSQLName('SBM')+" SBM ON ( "		+ STR_PULA
	cQuery += " 		SBM.BM_FILIAL = '"+FWxFilial('SBM')+"' "		+ STR_PULA
	cQuery += " 		AND SBM.BM_GRUPO = B1_GRUPO "					+ STR_PULA
	cQuery += " 		AND SBM.D_E_L_E_T_='' "							+ STR_PULA
	cQuery += " 	) "														+ STR_PULA
	cQuery += " WHERE "													+ STR_PULA
	cQuery += " 	SB1.B1_FILIAL = '"+FWxFilial('SBM')+"' "			+ STR_PULA
	cQuery += " 	AND SB1.D_E_L_E_T_ = '' "							+ STR_PULA
	cQuery += " ORDER BY "												+ STR_PULA
	cQuery += " 	SB1.B1_COD "											+ STR_PULA
	TCQuery cQuery New Alias "QRYPRO"
	
	//Criando o objeto que irá gerar o conteúdo do Excel
	oFWMsExcel := FWMSExcel():New()
	
	//Alterando atributos
	oFWMsExcel:SetFontSize(12)                 //Tamanho Geral da Fonte
	oFWMsExcel:SetFont("Arial")                //Fonte utilizada
	oFWMsExcel:SetBgGeneralColor("#000000")    //Cor de Fundo Geral
	oFWMsExcel:SetTitleBold(.T.)               //Título Negrito
	oFWMsExcel:SetTitleFrColor("#94eaff")      //Cor da Fonte do título - Azul Claro
	oFWMsExcel:SetLineFrColor("#d4d4d4")       //Cor da Fonte da primeira linha - Cinza Claro
	oFWMsExcel:Set2LineFrColor("#ffffff")      //Cor da Fonte da segunda linha - Branco
	
	//Aba 01 - Teste
	oFWMsExcel:AddworkSheet("Aba 1 Teste") //Não utilizar número junto com sinal de menos. Ex.: 1-
		//Criando a Tabela
		oFWMsExcel:AddTable("Aba 1 Teste","Titulo Tabela")
		//Criando Colunas
		oFWMsExcel:AddColumn("Aba 1 Teste","Titulo Tabela","Col1",1,1) //1 = Modo Texto
		oFWMsExcel:AddColumn("Aba 1 Teste","Titulo Tabela","Col2",2,2) //2 = Valor sem R$
		oFWMsExcel:AddColumn("Aba 1 Teste","Titulo Tabela","Col3",3,3) //3 = Valor com R$
		oFWMsExcel:AddColumn("Aba 1 Teste","Titulo Tabela","Col4",1,1)
		//Criando as Linhas
		oFWMsExcel:AddRow("Aba 1 Teste","Titulo Tabela",{11,12,13,sToD('20140317')})
		oFWMsExcel:AddRow("Aba 1 Teste","Titulo Tabela",{21,22,23,sToD('20140217')})
		oFWMsExcel:AddRow("Aba 1 Teste","Titulo Tabela",{31,32,33,sToD('20140117')})
		oFWMsExcel:AddRow("Aba 1 Teste","Titulo Tabela",{41,42,43,sToD('20131217')})
	
	
	//Aba 02 - Produtos
	oFWMsExcel:AddworkSheet("Aba 2 Produtos")
		//Criando a Tabela
		oFWMsExcel:AddTable("Aba 2 Produtos","Produtos")
		oFWMsExcel:AddColumn("Aba 2 Produtos","Produtos","Codigo",1)
		oFWMsExcel:AddColumn("Aba 2 Produtos","Produtos","Descricao",1)
		oFWMsExcel:AddColumn("Aba 2 Produtos","Produtos","Tipo",1)
		oFWMsExcel:AddColumn("Aba 2 Produtos","Produtos","Grupo",1)
		oFWMsExcel:AddColumn("Aba 2 Produtos","Produtos","Desc.Grupo",1)
		oFWMsExcel:AddColumn("Aba 2 Produtos","Produtos","Procedencia",1)
		//Criando as Linhas... Enquanto não for fim da query
		While !(QRYPRO->(EoF()))
			oFWMsExcel:AddRow("Aba 2 Produtos","Produtos",{;
																	QRYPRO->B1_COD,;
																	QRYPRO->B1_DESC,;
																	QRYPRO->B1_TIPO,;
																	QRYPRO->BM_GRUPO,;
																	QRYPRO->BM_DESC,;
																	Iif(QRYPRO->BM_PROORI == '0', 'Não Original', 'Original');
			})
		
			//Pulando Registro
			QRYPRO->(DbSkip())
		EndDo
	
	//Ativando o arquivo e gerando o xml
	oFWMsExcel:Activate()
	oFWMsExcel:GetXMLFile(cArquivo)
		
	//Abrindo o excel e abrindo o arquivo xml
	oExcel := MsExcel():New() 			//Abre uma nova conexão com Excel
	oExcel:WorkBooks:Open(cArquivo) 	//Abre uma planilha
	oExcel:SetVisible(.T.) 				//Visualiza a planilha
	oExcel:Destroy()						//Encerra o processo do gerenciador de tarefas
	
	QRYPRO->(DbCloseArea())
	RestArea(aArea)
Return

/*/{Protheus.doc} zTstExc4
Função que cria um exemplo de FWMsExcel com colunas dinâmicas
@author Atilio
@since 06/08/2016
@version 1.0
	@example
	u_zTstExc4()
/*/

User Function zTstExc4()
	Local aArea		:= GetArea()
	Local cQryCol		:= ""
	Local cQryPro		:= ""
	Local cQryVen		:= ""
	Local nAux			:= 0
	Local oFWMsExcel
	Local oExcel
	Local cArquivo	:= GetTempPath()+'zTstExc4.xml'
	Local cWorkSheet	:= "Aba - Produtos"
	Local cTable		:= "Produtos x Datas"
	Local aColunas	:= {}
	Local dDataDe		:= sToD("20150101")
	Local dDataAt		:= sToD("20161231")
	Local aLinhaAux	:= {}
	
	//Buscando as datas que tiveram pedidos
	cQryCol := " SELECT DISTINCT "
	cQryCol += " 	C5_EMISSAO "
	cQryCol += " FROM "
	cQryCol += " 	"+RetSQLName('SC5')+" SC5 "
	cQryCol += " WHERE "
	cQryCol += " 	C5_FILIAL = '"+FWxFilial('SC5')+"' "
	cQryCol += " 	AND C5_TIPO = 'N' "
	cQryCol += " 	AND C5_EMISSAO >= '"+dToS(dDataDe)+"' "
	cQryCol += " 	AND C5_EMISSAO <= '"+dToS(dDataAt)+"' "
	cQryCol += " 	AND SC5.D_E_L_E_T_ = ' ' "
	cQryCol += " ORDER BY "
	cQryCol += " 	C5_EMISSAO "
	TCQuery cQryCol New Alias "QRY_COL"
	TCSetField("QRY_COL", "C5_EMISSAO", "D")

	//Compondo as colunas do relatório
	aAdd(aColunas, "Produto")
	aAdd(aColunas, "Descrição")
	While !QRY_COL->(EoF())
		aAdd(aColunas, dToC(QRY_COL->C5_EMISSAO))
		QRY_COL->(DbSkip())
	EndDo
	QRY_COL->(DbCloseArea())
	
	//Montando a consulta de produtos
	cQryPro := " SELECT "
	cQryPro += " 	B1_COD, "
	cQryPro += " 	B1_DESC "
	cQryPro += " FROM "
	cQryPro += " 	"+RetSQLName('SB1')+" SB1 "
	cQryPro += " WHERE "
	cQryPro += " 	B1_FILIAL = '"+FWxFilial('SB1')+"' "
	cQryPro += " 	AND B1_TIPO = 'PA' "
	cQryPro += " 	AND SB1.D_E_L_E_T_ = ' ' "
	cQryPro += " ORDER BY "
	cQryPro += " 	B1_COD "
	TCQuery cQryPro New Alias "QRY_PRO"
	
	//Criando o objeto que irá gerar o conteúdo do Excel
	oFWMsExcel := FWMSExcel():New()
	
	//Aba 01 - Teste
	oFWMsExcel:AddworkSheet(cWorkSheet) //Não utilizar número junto com sinal de menos. Ex.: 1-
		
		//Criando a Tabela
		oFWMsExcel:AddTable(cWorkSheet, cTable)
		
		//Criando Colunas
		For nAux := 1 To Len(aColunas)
			oFWMsExcel:AddColumn(cWorkSheet, cTable, aColunas[nAux], 1, 1)
		Next
		
		//Percorrendo os produtos
		While !QRY_PRO->(EoF())
			//Criando a linha
			aLinhaAux := Array(Len(aColunas))
			aLinhaAux[1] := QRY_PRO->B1_COD
			aLinhaAux[2] := QRY_PRO->B1_DESC
			For nAux := 3 To Len(aColunas)
				cQryVen := " SELECT "
				cQryVen += " 	ISNULL(SUM(C6_QTDVEN),0) AS TOT "
				cQryVen += " FROM "
				cQryVen += " 	"+RetSQLName('SC6')+" SC6 "
				cQryVen += " 	INNER JOIN "+RetSQLName('SC5')+" SC5 ON ( "
				cQryVen += " 		C5_FILIAL = '"+FWxFilial('SC5')+"' "
				cQryVen += " 		AND C5_NUM = C6_NUM "
				cQryVen += " 		AND C5_TIPO = 'N' "
				cQryVen += " 		AND C5_EMISSAO = '"+dToS(cToD(aColunas[nAux]))+"' "
				cQryVen += " 		AND SC5.D_E_L_E_T_ = ' ' "
				cQryVen += " 	) "
				cQryVen += " 	INNER JOIN "+RetSQLName('SB1')+" SB1 ON ( "
				cQryVen += " 		B1_FILIAL = '"+FWxFilial('SB1')+"' "
				cQryVen += " 		AND B1_COD = C6_PRODUTO "
				cQryVen += " 		AND B1_TIPO = 'PA' "
				cQryVen += " 		AND SB1.D_E_L_E_T_ = ' ' "
				cQryVen += " 	) "
				cQryVen += " WHERE "
				cQryVen += " 	C6_FILIAL = '"+FWxFilial('SC6')+"' "
				cQryVen += " 	AND C6_PRODUTO = '"+QRY_PRO->B1_COD+"' "
				cQryVen += " 	AND SC6.D_E_L_E_T_ = ' ' "
				TCQuery cQryVen New Alias "QRY_VEN"
				
				//Atribuindo o valor
				aLinhaAux[nAux] := QRY_VEN->TOT
				QRY_VEN->(DbCloseArea())
			Next
			
			//Adiciona a linha no Excel
			oFWMsExcel:AddRow(cWorkSheet, cTable, aLinhaAux)
			
			QRY_PRO->(DbSkip())
		EndDo
		
		//Tratativa para o Total
		aLinhaAux := Array(Len(aColunas))
		aLinhaAux[1] := "Total: "
		aLinhaAux[2] := ""
		For nAux := 3 To Len(aColunas)
			cQryVen := " SELECT "
			cQryVen += " 	ISNULL(SUM(C6_QTDVEN),0) AS TOT "
			cQryVen += " FROM "
			cQryVen += " 	"+RetSQLName('SC6')+" SC6 "
			cQryVen += " 	INNER JOIN "+RetSQLName('SC5')+" SC5 ON ( "
			cQryVen += " 		C5_FILIAL = '"+FWxFilial('SC5')+"' "
			cQryVen += " 		AND C5_NUM = C6_NUM "
			cQryVen += " 		AND C5_TIPO = 'N' "
			cQryVen += " 		AND C5_EMISSAO = '"+dToS(cToD(aColunas[nAux]))+"' "
			cQryVen += " 		AND SC5.D_E_L_E_T_ = ' ' "
			cQryVen += " 	) "
			cQryVen += " 	INNER JOIN "+RetSQLName('SB1')+" SB1 ON ( "
			cQryVen += " 		B1_FILIAL = '"+FWxFilial('SB1')+"' "
			cQryVen += " 		AND B1_COD = C6_PRODUTO "
			cQryVen += " 		AND B1_TIPO = 'PA' "
			cQryVen += " 		AND SB1.D_E_L_E_T_ = ' ' "
			cQryVen += " 	) "
			cQryVen += " WHERE "
			cQryVen += " 	C6_FILIAL = '"+FWxFilial('SC6')+"' "
			cQryVen += " 	AND SC6.D_E_L_E_T_ = ' ' "
			TCQuery cQryVen New Alias "QRY_VEN"
			
			//Atribuindo o valor
			aLinhaAux[nAux] := QRY_VEN->TOT
			QRY_VEN->(DbCloseArea())
		Next
		
		//Adiciona a linha no Excel
		oFWMsExcel:AddRow(cWorkSheet, cTable, aLinhaAux)
		
	//Ativando o arquivo e gerando o xml
	oFWMsExcel:Activate()
	oFWMsExcel:GetXMLFile(cArquivo)
		
	//Abrindo o excel e abrindo o arquivo xml
	oExcel := MsExcel():New() 			//Abre uma nova conexão com Excel
	oExcel:WorkBooks:Open(cArquivo) 	//Abre uma planilha
	oExcel:SetVisible(.T.) 				//Visualiza a planilha
	oExcel:Destroy()						//Encerra o processo do gerenciador de tarefas
	
	QRY_PRO->(DbCloseArea())
	RestArea(aArea)
Return