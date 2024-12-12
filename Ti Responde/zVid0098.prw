/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2024/11/12/como-fazer-um-excel-com-cores-diferentes-via-advpl-ti-responde-0098/ 
    
*/


//Bibliotecas
#Include 'Totvs.ch'

/*/{Protheus.doc} User Function zVid0098
Teste de excel com linhas coloridas
@author Atilio
@since 23/01/2024
@version 1.0
@type function
@see https://tdn.totvs.com/display/public/framework/FwPrinterXlsx
/*/

User Function zVid0098()
	Local aArea    := FWGetArea()
	Local aPergs   := {}
	Local cPedDe   := Space(TamSX3('C6_NUM')[1])
	Local cPedAte  := StrTran(cPedDe, ' ', 'Z')
	Local cProdDe  := Space(TamSX3('C6_PRODUTO')[1])
	Local cProdAte := StrTran(cProdDe, ' ', 'Z')
	
	//Adicionando os parametros do ParamBox
	aAdd(aPergs, {1, 'Pedido De',   cPedDe,   '', '.T.', 'SC5', '.T.', 60,  .F.}) // MV_PAR01
	aAdd(aPergs, {1, 'Pedido Até',  cPedAte,  '', '.T.', 'SC5', '.T.', 60,  .T.}) // MV_PAR02
	aAdd(aPergs, {1, 'Produto De',  cProdDe,  '', '.T.', 'SB1', '.T.', 80,  .F.}) // MV_PAR03
	aAdd(aPergs, {1, 'Produto Até', cProdAte, '', '.T.', 'SB1', '.T.', 80,  .T.}) // MV_PAR04
	
	//Se a pergunta for confirmada, chama o preenchimento dos dados do .dot
	If ParamBox(aPergs, 'Informe os parâmetros', /*aRet*/, /*bOk*/, /*aButtons*/, /*lCentered*/, /*nPosx*/, /*nPosy*/, /*oDlgWizard*/, /*cLoad*/, .F., .F.)
		Processa({|| fGeraExcel()})
	EndIf
	
	FWRestArea(aArea)
Return

/*/{Protheus.doc} fGeraExcel
Criacao do arquivo Excel na funcao zVid0098
@author Atilio
@since 23/01/2024
@version 1.0
@type function
/*/

Static Function fGeraExcel()
	Local aArea       := FWGetArea()
	Local oPrintXlsx
	Local dData       := Date()
	Local cHora       := Time()
	Local cArquivo    := GetTempPath() + 'zVid0098' + dToS(dData) + '_' + StrTran(cHora, ':', '-') + '.rel'
	Local cQryDad     := ''
	Local nAtual      := 0
	Local nTotal      := 0
	Local aColunas    := {}
	Local oExcel
	Local cFonte      := FwPrinterFont():Arial()
	Local nTamFonte   := 12
	Local lItalico    := .F.
	Local lNegrito    := .T.
	Local lSublinhado := .F.
	Local nCpoAtual   := 0
	Local oCellHoriz  := FwXlsxCellAlignment():Horizontal()
	Local oCellVerti  := FwXlsxCellAlignment():Vertical()
	Local cHorAlinha  := ''
	Local cVerAlinha  := ''
	Local lQuebrLin   := .F.
	Local nRotation   := 0
	Local cCustForma  := ''
	Local cCampoAtu   := ''
	Local cTipo       := ''
	Local cCorFundo   := ''
	Local cCorTxtCab  := 'B02121'
	Local cCorFunPad  := 'F3E0E3'
	Local cCorPreto   := '000000'
	Local cCorBranco  := 'FFFFFF'

	//Montando consulta de dados
	cQryDad := "SELECT "		+ CRLF
	cQryDad += "    C6_NUM, "		+ CRLF
	cQryDad += "    C6_ITEM, "		+ CRLF
	cQryDad += "    C6_PRODUTO, "		+ CRLF
	cQryDad += "    C6_DESCRI, "		+ CRLF
	cQryDad += "    C6_ENTREG, "		+ CRLF
	cQryDad += "    C6_QTDVEN, "		+ CRLF
	cQryDad += "    C6_PRCVEN, "		+ CRLF
	cQryDad += "    C6_VALOR "		+ CRLF
	cQryDad += "FROM "		+ CRLF
	cQryDad += "    " + RetSQLName("SC6") + " SC6 "		+ CRLF
	cQryDad += "WHERE "		+ CRLF
	cQryDad += "    C6_FILIAL = '" + FWxFilial("SC6") + "' "		+ CRLF
	cQryDad += "    AND C6_NUM >= '" + MV_PAR01 + "' "		+ CRLF
	cQryDad += "    AND C6_NUM <= '" + MV_PAR02 + "' "		+ CRLF
	cQryDad += "    AND C6_PRODUTO >= '" + MV_PAR03 + "' "		+ CRLF
	cQryDad += "    AND C6_PRODUTO <= '" + MV_PAR04 + "' "		+ CRLF
	cQryDad += "    AND SC6.D_E_L_E_T_ = ' '"		+ CRLF
	cQryDad += "ORDER BY "		+ CRLF
	cQryDad += "    C6_NUM, "		+ CRLF
	cQryDad += "    C6_ITEM "		+ CRLF
	
	//Executando consulta e setando o total da regua
	PlsQuery(cQryDad, 'QRY_DAD')
	DbSelectArea('QRY_DAD')

	//Somente se houver dados
	If ! QRY_DAD->(EoF())

		//Definindo o tamanho da regua
		Count To nTotal
		ProcRegua(nTotal)
		QRY_DAD->(DbGoTop())

        //Vamos agora adicionar as colunas no Excel, sendo as posições:
        //  [1] Nome do Campo
        //  [2] Tipo do Campo
        //  [3] Título a ser exibido
        //  [4] Largura em pixels, sendo que o ideal é o tamanho do campo * 1.5 (se o campo for muito pequeno, considere o tamanho minimo como 10 * 1.5)
        //  [5] Alinhamento (0 = esquerda, 1 = direita, 2 = centralizado)
        //  [6] Máscara aplicada em campos numéricos
        aAdd(aColunas, {'C6_NUM',     'C', 'Pedido',      15,   0, ''})
        aAdd(aColunas, {'C6_ITEM',    'C', 'Item',        15,   0, ''})
        aAdd(aColunas, {'C6_PRODUTO', 'C', 'Produto',     22.5, 0, ''})
        aAdd(aColunas, {'C6_DESCRI',  'C', 'Descricao',   45,   0, ''})
        aAdd(aColunas, {'C6_ENTREG',  'D', 'Dt. Entrega', 15,   2, ''})
        aAdd(aColunas, {'C6_QTDVEN',  'N', 'Qtd. Venda',  15,   1, '@E 99,999,999.99'})
        aAdd(aColunas, {'C6_PRCVEN',  'N', 'Prc. Venda',  16.5, 1, '@E 99,999,999.99'})
        aAdd(aColunas, {'C6_VALOR',   'N', 'Valor Venda', 18,   1, '@E 99,999,999.99'})
	
		//Instancia a classe, e tenta criar o arquivo .rel
		oPrintXlsx := FwPrinterXlsx():New()
		If oPrintXlsx:Activate(cArquivo)

			//Adiciona uma worksheet
			oPrintXlsx:AddSheet('Vendas')

			//Depois de imprimir os textos do cabeçalho, vamos colocar a fonte como normal
			nTamFonte := 10
			lNegrito  := .F.
			oPrintXlsx:SetFont(cFonte, nTamFonte, lItalico, lNegrito, lSublinhado)
			
			//Na primeira linha do cabeçalho, vamos definir como tudo centralizado, a cor do texto verde e de fundo branca
			cHorAlinha  := oCellHoriz:Center()
			cVerAlinha  := oCellVerti:Center()
			oPrintXlsx:SetCellsFormat(cHorAlinha, cVerAlinha, lQuebrLin, nRotation, cCorTxtCab, cCorBranco, cCustForma)

			//Percorre agora as colunas e vem setando o tamanho delas e colocando o nome
			nLinExcel := 1
			For nAtual := 1 To Len(aColunas)
				oPrintXlsx:SetColumnsWidth(nAtual, nAtual, aColunas[nAtual][4])
				oPrintXlsx:SetText(nLinExcel, nAtual, aColunas[nAtual][3])
			Next

			//Define que as colunas terão opção de filtrar (da coluna 1 até a quantidade de campos)
			oPrintXlsx:ApplyAutoFilter(nLinExcel, 1, nLinExcel, Len(aColunas))
			
			//Percorrendo os dados da query
			nAtual := 0
			While !(QRY_DAD->(EoF()))
				
				//Incrementando a regua
				nAtual++
				IncProc('Adicionando registro ' + cValToChar(nAtual) + ' de ' + cValToChar(nTotal) + '...')

				//Se for ímpar, o fundo vai ser verde claro, senão vai ser branco
				If nAtual % 2 != 0
					cCorFundo := cCorFunPad
				Else
					cCorFundo := cCorBranco
				EndIf

				//Incrementa a linha no Excel
				nLinExcel++

				//Percorre as colunas
				For nCpoAtual := 1 To Len(aColunas)
					cCampoAtu := aColunas[nCpoAtual][1]
					cTipo     := aColunas[nCpoAtual][2]
					xConteud  := &('QRY_DAD->' + cCampoAtu)

					//Se for data, vai ser centralizado
					If cTipo == 'D'
						xConteud := dToC(xConteud)

					//Se for numérico, vai ser a direita
					ElseIf cTipo == 'N'
						//Se tem máscara, aplica num transform
						If ! Empty(aColunas[nCpoAtual][6])
							xConteud := Alltrim(Transform(xConteud, aColunas[nCpoAtual][6]))

						//Senão converte de numérico para texto
						Else
							xConteud := cValToChar(xConteud)
						EndIf

					//Senão, apenas tira espaços do campo
					Else
						xConteud := Alltrim(xConteud)
					EndIf

					//Se o alinhamento for a direita
					If aColunas[nCpoAtual][5] == 1
						cHorAlinha := oCellHoriz:Right()

					//Se for centralizado
					ElseIf aColunas[nCpoAtual][5] == 2
						cHorAlinha := oCellHoriz:Center()

					//Senão, será a esquerda
					Else
						cHorAlinha := oCellHoriz:Left()
					EndIf

					//Reseta a formatação
					oPrintXlsx:ResetCellsFormat()

					//Em seguida, define a formatação da coluna, sendo que o texto será preto
					oPrintXlsx:SetCellsFormat(cHorAlinha, cVerAlinha, lQuebrLin, nRotation, cCorPreto, cCorFundo, cCustForma)
					
					//Adiciona a informação na linha do excel na coluna do campo
					oPrintXlsx:SetText(nLinExcel, nCpoAtual, xConteud)
				Next
				
				QRY_DAD->(DbSkip())
			EndDo

			//Vamos finalizar o arquivo
			oPrintXlsx:ToXlsx()
			oPrintXlsx:DeActivate()

			//E agora vamos abrir ele
			cArquivo := ChgFileExt(cArquivo, '.xlsx')
			If File(cArquivo)
				oExcel := MsExcel():New()
				oExcel:WorkBooks:Open(cArquivo)
				oExcel:SetVisible(.T.)
				oExcel:Destroy()
			EndIf
		EndIf

	Else
		FWAlertError('Não foi encontrado registros com os filtros informados!', 'Falha')
	EndIf
	QRY_DAD->(DbCloseArea())
	
	FWRestArea(aArea)
Return
