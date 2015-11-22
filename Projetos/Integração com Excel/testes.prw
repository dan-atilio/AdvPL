//Bibliotecas
#Include "Protheus.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} zTstPro
Função que testa a classe zExcelXML para a tabela de produtos
@author Atilio
@since 31/07/2015
@version 1.0
	@example
	u_zTstPro()
/*/

User Function zTstPro()
	DbSelectArea("SB1")
	SB1->(DbGoTop())
	
	oExcelXML := zExcelXML():New(.F.)									//Instância o Objeto
	oExcelXML:SetOrigem("\xmls\teste_sb1.xml")						//Indica o caminho do arquivo Origem (que será aberto e clonado)
	oExcelXML:SetDestino(GetTempPath()+"xml_sb1.xml")				//Indica o caminho do arquivo Destino (que será gerado)
	oExcelXML:CopyTo("C:\TOTVS\copia.xml")								//Adiciona caminho de cópia que será gerado ao montar o arquivo
	oExcelXML:AddExpression("#SB1-B1_COD", SB1->B1_COD)				//Adiciona expressão que será substituída
	oExcelXML:AddExpression("#SB1-B1_DESC", SB1->B1_DESC)			//Adiciona expressão que será substituída
	oExcelXML:AddExpression("#SB1-B1_TIPO", SB1->B1_TIPO)			//Adiciona expressão que será substituída
	oExcelXML:AddTabExcel("#TABELA_SB1", "SB1")						//Adiciona tabela dinâmica
	oExcelXML:MountFile()												//Monta o arquivo
	oExcelXML:ViewSO()													//Abre o .xml conforme configuração do Sistema Operacional,
																			// ou seja, se tiver Linux + LibreOffice ele irá abrir
	//oExcelXML:View()													//Utilizar apenas se não for utilizado o método ViewSO
																			// pois dessa forma é forçado a abrir pelo Excel
	oExcelXML:Destroy(.F.)												//Destrói os atributos do objeto
	oExcelXML:ShowMessage("")											//Testa demonstração de mensagem em branco
Return

/*/{Protheus.doc} zTstAux
Função que testa a classe zExcelXML para a tabela de clientes e fornecedores
@author Atilio
@since 31/07/2015
@version 1.0
	@example
	u_zTstAux()
/*/

User Function zTstAux()
	Local nTotCli := 0
	Local nTotFor := 0

	//Fornecedor
	DbSelectArea("SA2")
	SA2->(DbGoTop())
	Count To nTotFor
	SA2->(DbGoTop())
	
	//Cliente
	DbSelectArea("SA1")
	SA1->(DbGoTop())
	Count To nTotCli
	SA1->(DbGoTop())
	
	oExcelXML := zExcelXML():New(.F.)									//Instância o Objeto
	oExcelXML:SetOrigem("\xmls\teste_aux.xml")						//Indica o caminho do arquivo Origem (que será aberto e clonado)
	oExcelXML:SetDestino(GetTempPath()+"xml_aux.xml")				//Indica o caminho do arquivo Destino (que será gerado)
	oExcelXML:CopyTo("C:\TOTVS\copia2.xml")							//Adiciona caminho de cópia que será gerado ao montar o arquivo
	oExcelXML:AddTabExcel("#TABELA_SA1", "SA1")						//Adiciona tabela dinâmica
	oExcelXML:AddExpression("#TOTAL_SA1", cValToChar(nTotCli))		//Adiciona expressão que será substituída
	oExcelXML:AddTabExcel("#TABELA_SA2", "SA2")						//Adiciona tabela dinâmica
	oExcelXML:AddExpression("#TOTAL_SA2", cValToChar(nTotFor))		//Adiciona expressão que será substituída
	oExcelXML:MountFile()												//Monta o arquivo
	oExcelXML:ViewSO()													//Abre o .xml conforme configuração do Sistema Operacional,
																			// ou seja, se tiver Linux + LibreOffice ele irá abrir
	oExcelXML:Destroy(.F.)												//Destrói os atributos do objeto
Return


/*/{Protheus.doc} zTstPV
Função que testa a classe zExcelXML gerando um pedido de vendas gráfico (SC5 / SC6)
@author Atilio
@since 04/08/2015
@version 1.0
	@example
	u_zTstPV()
/*/

User Function zTstPV()
	Local aArea := GetArea()
	Local aAreaC5 := SC5->(GetArea())
	Local aAreaA1 := SA1->(GetArea())
	Local aAreaE4 := SE4->(GetArea())
	Local cQrySC6 := ""
	Local nTotQtd := 0
	Local nTotUni := 0
	Local nTotVal := 0

	DbSelectArea("SC5")
	DbSelectArea("SA1")
	SA1->(DbSetOrder(1))
	DbSelectArea("SE4")
	SE4->(DbSetOrder(1))

	//Posicionando no topo (primeiro pedido de venda) e no cliente e condição de pagamento
	SC5->(DbGoTop())
	SA1->(DbSeek(FWxFilial('SA1') + SC5->C5_CLIENTE + SC5->C5_LOJACLI))
	SE4->(DbSeek(FWxFilial('SE4') + SC5->C5_CONDPAG))

	cQrySC6 := " SELECT "
	cQrySC6 += "    C6_ITEM, "
	cQrySC6 += "    C6_PRODUTO, "
	cQrySC6 += "    ISNULL(B1_DESC, '') AS B1_DESC, "
	cQrySC6 += "    C6_QTDVEN, "
	cQrySC6 += "    C6_PRCVEN, "
	cQrySC6 += "    C6_VALOR "
	cQrySC6 += " FROM "
	cQrySC6 += "    "+RetSQLName("SC6")+" SC6 "
	cQrySC6 += "    INNER JOIN "+RetSQLName("SB1")+" SB1 ON ( "
	cQrySC6 += "       B1_FILIAL = '"+FWxFilial('SB1')+"' "
	cQrySC6 += "       AND B1_COD = C6_PRODUTO "
	cQrySC6 += "       AND SB1.D_E_L_E_T_ = '' "
	cQrySC6 += "    ) "
	cQrySC6 += " WHERE "
	cQrySC6 += "    C6_FILIAL = '"+FWxFilial('SC6')+"' "
	cQrySC6 += "    AND C6_NUM = '"+SC5->C5_NUM+"' "
	cQrySC6 += "    AND SC6.D_E_L_E_T_ = '' "
	cQrySC6 += " ORDER BY "
	cQrySC6 += "    C6_ITEM "
	TCQuery cQrySC6 New Alias "QRY_SC6"
	
	//Atualizando valores
	While !QRY_SC6->(EoF())
		nTotQtd += QRY_SC6->C6_QTDVEN
		nTotUni += QRY_SC6->C6_PRCVEN
		nTotVal += QRY_SC6->C6_VALOR
	
		QRY_SC6->(DbSkip())
	EndDo
	QRY_SC6->(DbGoTop())

	oExcelXML := zExcelXML():New(.F.)									//Instância o Objeto
	oExcelXML:SetOrigem("\xmls\teste_pedido.xml")						//Indica o caminho do arquivo Origem (que será aberto e clonado)
	oExcelXML:SetDestino(GetTempPath()+"xml_pedido.xml")				//Indica o caminho do arquivo Destino (que será gerado)
	oExcelXML:CopyTo("C:\TOTVS\copia_pedido.xml")						//Adiciona caminho de cópia que será gerado ao montar o arquivo
	oExcelXML:AddExpression("#COD_PEDIDO", SC5->C5_NUM)				//Adiciona expressão que será substituída
	oExcelXML:AddExpression("#NOME_CLIENTE", SA1->A1_NOME)
	oExcelXML:AddExpression("#COND_PGTO", SE4->E4_DESCRI)
	oExcelXML:AddExpression("#DT_EMISSAO", dToC(SC5->C5_EMISSAO))
	oExcelXML:AddExpression("#TOT_QTD", Alltrim(Transform(nTotQtd, PesqPict('SC6', 'C6_QTDVEN'))))
	oExcelXML:AddExpression("#TOT_UNI", Alltrim(Transform(nTotUni, PesqPict('SC6', 'C6_PRCVEN'))))
	oExcelXML:AddExpression("#TOT_VAL", Alltrim(Transform(nTotVal, PesqPict('SC6', 'C6_VALOR'))))
	oExcelXML:AddExpression("#DIA_ATU", dToC(dDataBase))
	oExcelXML:AddExpression("#HORA_ATU", Time())
	oExcelXML:AddExpression("#USR_ATU", UsrRetName(RetCodUsr()))
	oExcelXML:AddExpression("#AMBIENTE", GetEnvServer())
	oExcelXML:AddExpression("#FUNCAO", FunName())
	oExcelXML:AddTabExcel("#TABELA_SC6", "QRY_SC6")					//Adiciona tabela dinâmica
	oExcelXML:MountFile()												//Monta o arquivo
	oExcelXML:ViewSO()													//Abre o .xml conforme configuração do Sistema Operacional,
																			// ou seja, se tiver Linux + LibreOffice ele irá abrir
	oExcelXML:Destroy(.F.)												//Destrói os atributos do objeto

	QRY_SC6->(DbCloseArea())

	RestArea(aAreaE4)
	RestArea(aAreaA1)
	RestArea(aAreaC5)
	RestArea(aArea)
Return