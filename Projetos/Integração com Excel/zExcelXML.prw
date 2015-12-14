//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zExcelXML
Classe para manipular e gerar arquivos XML do Excel
@author Atilio
@since 28/05/2015
@version 1.0
	@example
	//... Começo do Exemplo ...
	oExcelXml := zExcelXML():New(.F.)									//Instância o Objeto
	oExcelXml:SetOrigem("\xmls\teste_sb1.xml")						//Indica o caminho do arquivo Origem (que será aberto e clonado)
	oExcelXml:SetDestino(GetTempPath()+"yTst02.xml")					//Indica o caminho do arquivo Destino (que será gerado)
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
	oExcelXml:Destroy(.F.)												//Destrói os atributos do objeto
	oExcelXml:ShowMessage("")											//Testa demonstração de mensagem em branco
	//... Fim do Exemplo ...
	@see http://terminaldeinformacao.com/advpl/
/*/

Class zExcelXML
	//Atributos
	Data cArqOrig
	Data cArqDest
	Data aExpre
	Data aTabelas
	Data aAreas
	Data aConOrig
	Data aConDest
	Data cArqCopy
	Data lShowMsg

	//Métodos
	Method New() CONSTRUCTOR
	Method SetOrigem()
	Method SetDestino()
	Method AddExpression()
	Method AddTabExcel()
	Method MountFile()
	Method CopyTo()
	Method View()
	Method ViewSO()
	Method Destroy()
	Method ShowMessage()
	Method RestAreaExcel()
EndClass

/*/{Protheus.doc} New
Construtor da classe zExcelXML
@author Atilio
@since 28/05/2015
@version 1.0
	@param lShowAlerts, Lógico, Define se será mostrado alertas ou não nas chamadas dos métodos
	@example
	oExcelXml := zExcelXML:New(.T.)
/*/

Method New(lShowAlerts) Class zExcelXML
	Default lShowAlerts := .F.

	//Definindo os atributos
	::cArqOrig	:= ""
	::cArqDest	:= ""
	::aTabelas	:= {}
	::aAreas	:= {}
	::aExpre	:= {}
	::aConOrig	:= {}
	::aConDest	:= {}
	::cArqCopy	:= ""
	::lShowMsg	:= lShowAlerts
Return Self

/*/{Protheus.doc} SetOrigem
Define o arquivo xml de origem que será lido
@author Atilio
@since 28/05/2015
@version 1.0
	@param cOrigem, Caracter, Arquivo origem a ser lido
	@return lRet, Retorna se foi possível setar o arquivo de Origem
	@example
	oExcelXml:SetOrigem("\xmls\teste_1.xml")
/*/

Method SetOrigem(cOrigem) Class zExcelXML
	Local lRet			:= .T.
	Local cMensagem	:= ""
	
	//Se não for arquivo XML
	If SubStr(cOrigem, Len(Alltrim(cOrigem))-3, Len(Alltrim(cOrigem))) != ".xml"
		lRet := .F.
		cMensagem :=	"[zExcelXML][004] Arquivo de ORIGEM com extensão inválida! "+;
						"Verificar! - SetOrigem('"+cOrigem+"') - "+dToC(dDataBase)+" "+Time()
		
	//Se o arquivo de origem existir, atualiza atributo
	ElseIf File(cOrigem)
		//Se no xml, encontrar a definição que é XML de Planilhas do Excel, arquivo OK
		If '<?mso-application progid="Excel.Sheet"?>' $ MemoRead(cOrigem)
			::cArqOrig	:= cOrigem
			
		//Senão, retorna erro
		Else
			lRet := .F.
			cMensagem :=	"[zExcelXML][002] Arquivo de ORIGEM inválido! "+;
							"Verificar! - SetOrigem('"+cOrigem+"') - "+dToC(dDataBase)+" "+Time()
		EndIf
	
	//Senão, retorna erro
	Else
		lRet := .F.
		cMensagem :=	"[zExcelXML][001] Arquivo de ORIGEM não foi encontrado! "+;
						"Verificar! - SetOrigem('"+cOrigem+"') - "+dToC(dDataBase)+" "+Time()
	EndIf
	
	//Mostrando mensagem caso tenha
	Self:ShowMessage(cMensagem)
Return lRet

/*/{Protheus.doc} SetDestino
Define o arquivo xml de destino que será gerado
@author Atilio
@since 23/06/2015
@version 1.0
	@param cDestino, Caracter, Arquivo que será gerado
	@param lSobrepoe, Lógico, Define se o arquivo será sobreposto (se já existir)
	@return lRet, Retorna se foi possível setar o arquivo de Destino
	@example
	oExcelXml:SetDestino("C:\Teste\teste.xml")
/*/

Method SetDestino(cDestino, lSobrepoe) Class zExcelXML
	Local lRet			:= .T.
	Local cMensagem	:= ""
	Default lSobrepoe	:= .T.
	
	//Se não for arquivo XML
	If SubStr(cDestino, Len(Alltrim(cDestino))-3, Len(Alltrim(cDestino))) != ".xml"
		lRet := .F.
		cMensagem :=	"[zExcelXML][005] Arquivo de DESTINO com extensão inválida! "+;
						"Verificar! - SetDestino('"+cDestino+"') - "+dToC(dDataBase)+" "+Time()
						
	//Se não tiver em branco
	ElseIf !Empty(cDestino)
		::cArqDest	:= cDestino
		
		//Se o arquivo de Destino existir, atualiza atributo
		If File(cDestino)
			cMensagem :=	"[zExcelXML][003] Arquivo de Destino já existe! "+;
							"Verificar! - SetDestino('"+cDestino+"') - "+dToC(dDataBase)+" "+Time()
			
			//Se for para sobrepor, exclui o arquivo destino
			If lSobrepoe
				FErase(cDestino)
			EndIf
		EndIf
	EndIf
	
	//Mostrando mensagem caso tenha
	Self:ShowMessage(cMensagem)
Return lRet

/*/{Protheus.doc} AddExpression
Adiciona uma expressão para ser substituída dentro do arquivo
@author Atilio
@since 29/07/2015
@version 1.0
	@param cExpressao, Caracter, Expressão que será buscada dentro do arquivo xml
	@param xConteudo, Variável, Conteúdo que irá substituir a expressão encontrada
	@example
	oExcelXML:AddExpression("#SB1-B1_COD", "Ok ok...")
/*/

Method AddExpression(cExpressao, xConteudo) Class zExcelXML
	Local cMensagem	:= ""
	
	//Se tiver expressão
	If !Empty(cExpressao) .And. !("TABELA" $ cExpressao)
		aAdd(::aExpre, {cExpressao, xConteudo})
	
	//Senão
	Else
		cMensagem :=	"[zExcelXML][013] Expressão em branco ou inválida não pode ser adicionada! "+;
						"Verificar! - AddExpression() - "+dToC(dDataBase)+" "+Time()+"... cExpressao: "+cExpressao+";"
	EndIf
	
	//Mostrando mensagem caso tenha
	Self:ShowMessage(cMensagem)
Return Nil

/*/{Protheus.doc} AddTabExcel
Adiciona tabela que será substituída no arquivo xml
@author Atilio
@since 29/07/2015
@version 1.0
	@param cNomeTab, Caracter, Nome da Tabela que será procurada no arquivo xml
	@param cAliasTab, Caracter, Alias do Protheus que irá substituir os dados da tabela
	@example
	oExcelXML:AddTabExcel("#TABELA_SC6", "SC6")
/*/

Method AddTabExcel(cNomeTab, cAliasTab) Class zExcelXML
	Local cMensagem	:= ""
	
	//Se tiver expressão
	If !Empty(cNomeTab) .And. !((cAliasTab)->(EoF()))
		aAdd(::aTabelas, {cNomeTab, cAliasTab})
		aAdd(::aAreas,  {cAliasTab, GetArea(cAliasTab)})
	
	//Senão
	Else
		cMensagem :=	"[zExcelXML][014] Tabela em branco não pode ser adicionada! "+;
						"Verificar! - AddTabExcel() - "+dToC(dDataBase)+" "+Time()
	EndIf
	
	//Mostrando mensagem caso tenha
	Self:ShowMessage(cMensagem)
Return Nil

/*/{Protheus.doc} MountFile
Método que monta o arquivo para geração e gera uma cópia se tiver
@author Atilio
@since 29/07/2015
@version 1.0
	@example
	oExcelXML:MountFile()
/*/

Method MountFile() Class zExcelXML
	Local aArea		:= GetArea()
	Local nAtual		:= 0
	Local cContAux	:= ""
	Local nExpre		:= 0
	Local nTabel		:= 0
	Local nHdl			:= 0
	Local cMensagem	:= ""
	Local lPula		:= .F.
	Local aAux			:= {}
	Local nLinExpand	:= 0
	
	//Abre o arquivo para uso
	Ft_FUse(::cArqOrig)
	
	//Indo ao topo e percorrendo os registros para gerar os dados originais
	Ft_FGoTop()
	While !Ft_FEoF()
		aAdd(::aConOrig, Ft_FReadLn())
		Ft_FSkip()
	EndDo
	Ft_FUse()
	
	//Agora será gerado o conteúdo destino (substituindo as expressões)
	For nAtual := 1 To Len(::aConOrig)
		cContAux := ::aConOrig[nAtual]
		lPula := Iif(Chr(13)+Chr(10) $ cContAux, .T., .F.)
		
		//Procurando expressões e substituindo
		For nExpre := 1 To Len(::aExpre)
			//Se encontrou a expressão, substitui a expressão pelo conteúdo
			If ::aExpre[nExpre][1] $ cContAux
				cTipoCamp1 := ValType(::aExpre[nExpre][2])
				
				//Se for Data
				If cTipoCamp1 == 'D'
					::aExpre[nExpre][2] := dToC(xConteud)
				
				//Senão se for numérico
				ElseIf cTipoCamp1 == 'N'
					cContAux := StrTran(cContAux, 'Type="String"', 'Type="Number"')
					
					//Se a máscara tiver em branco
					If Empty(cMaskAux)
						::aExpre[nExpre][2] := cValToChar(::aExpre[nExpre][2])
						
					//Senão, transforma o campo
					Else
						::aExpre[nExpre][2] := Alltrim(Transform(::aExpre[nExpre][2], cMaskAux))
					EndIf
					
				//Senão se for caracter
				ElseIf cTipoCamp1 == 'C'
					//Se tiver máscara
					If !Empty(cMaskAux)
						::aExpre[nExpre][2] := Alltrim(Transform(::aExpre[nExpre][2], cMaskAux))
					EndIf
				
				//Senão
				Else
					::aExpre[nExpre][2] := cValToChar(::aExpre[nExpre][2])
				EndIf
				
				cContAux := StrTran(cContAux, ::aExpre[nExpre][1], ::aExpre[nExpre][2])
			EndIf
		Next
		
		//Pegando a linha que define a quantidade de linhas da tabela
		If "expandedrowcount" $ Lower(cContAux)
			nLinExpand := nAtual
		EndIf
		
		//Pegando linha ativa e deixando como 1
		If "activerow" $ Lower(cContAux)
			cTagAux := SubStr(cContAux, At('<ActiveRow>', cContAux), Len(cContAux))
			cTagAux := SubStr(cContAux, 1, At('</ActiveRow>', cContAux)-1)
			cContAux := StrTran(cContAux, cTagAux, "<ActiveRow>1")
		EndIf
		
		//Pegando coluna ativa e deixando como 1
		If "activecol" $ Lower(cContAux)
			cTagAux := SubStr(cContAux, At('<ActiveCol>', cContAux), Len(cContAux))
			cTagAux := SubStr(cContAux, 1, At('</ActiveCol>', cContAux)-1)
			cContAux := StrTran(cContAux, cTagAux, "<ActiveCol>1")
		EndIf

		//Adicionando no array de destino
		aAdd(aAux, cContAux + Iif(lPula, "", Chr(13)+Chr(10)))
	Next
	
	//Agora será gerado o conteúdo destino (substituindo as tabelas / queries)
	lTabEnc := .F.
	cNomTab := ""
	cAliTab := ""
	cCampoNov := ""
	nPosIni := 0
	nPosCam := 0
	nPosAux := 0
	nPosFin := 0
	aTabAux := {}
	nAMais  := 0
	For nAtual := 1 To Len(aAux)
		//Procurando expressões e substituindo
		For nTabel := 1 To Len(::aTabelas)
			If ::aTabelas[nTabel][1] $ aAux[nAtual] .And. !lTabEnc
				lTabEnc := .T.
				cNomTab := ::aTabelas[nTabel][1]
				cAliTab := ::aTabelas[nTabel][2]
				nPosIni := nAtual
				nPosCam := 0
				nPosFin := 0
			EndIf
			
			//Encontrando o primeiro campo
			If "%"+cAliTab+"-" $ aAux[nAtual] .And. nPosCam == 0 .And. cAliTab == ::aTabelas[nTabel][2]
				aTabAux := {}
			
				//Procurando a seção ROW para identificar a linha inicial
				For nPosCam := nAtual To 1 Step -1
					If "<ROW" $ Upper(aAux[nPosCam])
						Exit
					EndIf
				Next
				
				//Procurando o fim da seção ROW para copiar as linhas que serão copiadas
				For nPosAux := nPosCam To Len(aAux)
					aAdd(aTabAux, aAux[nPosAux])
					If "</ROW>" $ Upper(aAux[nPosAux])
						Exit
					EndIf
				Next
				
			EndIf
			
			//Procurando o final da tabela
			If cNomTab+"_FIM" $ aAux[nAtual] .And. cAliTab == ::aTabelas[nTabel][2]
				lTabEnc := .F.
				nPosFin := nAtual
				nAtual  := nPosIni
			EndIf
		Next
		
		//Se tiver final, acontecerá o processamento
		If nPosFin != 0 .And. nPosCam != 0 .And. nPosCam < nPosFin
			//Substitui o início da tabela
			aAux[nPosIni] := StrTran(aAux[nPosIni], cNomTab, "")
			lFirst := .T.
			nContAux := 1
			
			//Enquanto a tabela tiver registros
			While ! (cAliTab)->(EoF())
				//Adicionando nova linha
				If !lFirst
					For nTst := 0 To Len(aTabAux)-1
						aSize(aAux, Len(aAux)+1)
						aIns(aAux, nPosCam+nTst)
						aAux[nPosCam+nTst] := aTabAux[nTst+1]
					Next
					nAMais++
					nPosFin += Len(aTabAux)
					nContAux++
				EndIf
			
				For nPosAux := nPosCam To nPosCam+Len(aTabAux)
					//Se tiver campo
					If "%"+cAliTab+"-" $ aAux[nPosAux]
						//Verificando se veio de query ou temporária
						lCampoQuery := .F.
						If "QRY" $ cAliTab .Or. "SQL" $ cAliTab .Or. "TMP" $ cAliTab .Or. Len(cAliTab) >= 4 
							lCampoQuery := .T.
						EndIf
						
						//Pegando dados do campo
						cCampoNov := SubStr(aAux[nPosAux], At("%", aAux[nPosAux])+1, Len(aAux[nPosAux]))
						cCampoNov := SubStr(cCampoNov, 1, RAt("%", cCampoNov)-1)
						cCampoNov := StrTran(cCampoNov, cAliTab+"-", "")
						cMaskAux  := Iif(lCampoQuery, fMascara(cCampoNov), PesqPict(cAliTab, cCampoNov))
						xConteud  := &(cAliTab+"->"+cCampoNov+"")
						cTipoCamp := &("ValType("+cAliTab+"->"+cCampoNov+")")
						
						//Se for Data
						If cTipoCamp == 'D'
							xConteud := dToC(xConteud)
						
						//Senão se for numérico
						ElseIf cTipoCamp == 'N'
							aAux[nPosAux] := StrTran(aAux[nPosAux], 'Type="String"', 'Type="Number"')
							
							//Se a máscara tiver em branco
							If Empty(cMaskAux)
								xConteud := cValToChar(xConteud)
								
							//Senão, transforma o campo
							Else
								xConteud := Alltrim(Transform(xConteud, cMaskAux))
							EndIf
							
						//Senão se for caracter
						ElseIf cTipoCamp == 'C'
							//Se tiver máscara
							If !Empty(cMaskAux)
								xConteud := Alltrim(Transform(xConteud, cMaskAux))
							EndIf
						
						//Senão
						Else
							xConteud := cValToChar(xConteud)
						EndIf
						
						aAux[nPosAux] := StrTran(aAux[nPosAux], "%"+cAliTab+"-"+cCampoNov+"%", xConteud)
					EndIf
				Next
				nPosCam := nPosCam+Len(aTabAux)
			
				lFirst := .F.
				(cAliTab)->(DbSkip())
			EndDo
			
			//Substitui o final da tabela
			aAux[nPosFin] := StrTran(aAux[nPosFin], cNomTab+"_FIM", "")
			
			//Somente sairá do laço, após encontrar o <row>
			nAtual := nPosFin + 1
			While ! ("</ROW>" $ Upper(aAux[nAtual]))
				nAtual++
			EndDo
			
			//Agora percorre as linhas abaixo e altera o conteúdo dos índices
			For nAltLin := nAtual To Len(aAux)
				//Se encontrar linha de índice
				If "row ss:index=" $ Lower(aAux[nAltLin])
					cIndexExc := SubStr(Lower(aAux[nAltLin]), At('row ss:index=', Lower(aAux[nAltLin])), Len(aAux[nAltLin]))
					cIndexExc := StrTran(cIndexExc, 'row ss:index="', 'row ss:index=')
					cIndexExc := SubStr(cIndexExc, 1, At('"', cIndexExc)-1)
					nOrigInd := Val(SubStr(cIndexExc, At('=', cIndexExc)+1, Len(cIndexExc)))
					aAux[nAltLin] := StrTran(aAux[nAltLin], 'Row ss:Index="'+cValToChar(nOrigInd)+'"', 'Row ss:Index="'+cValToChar(nOrigInd+nAMais)+'"')
				EndIf
			Next
			
			//Zerando dados da tabela
			lTabEnc := .F.
			cNomTab := ""
			cAliTab := ""
			nPosIni := 0
			nPosCam := 0
			nPosFin := 0
		EndIf
	Next
	
	//Se tiver linha de expandido, atualiza para não houver falha na geração do Excel
	If nLinExpand > 0
		cExpand := SubStr(aAux[nLinExpand], At('ExpandedRowCount', aAux[nLinExpand]), Len(aAux[nLinExpand]))
		cExpand := StrTran(cExpand, 'ExpandedRowCount="', 'ExpandedRowCount=')
		cExpand := SubStr(cExpand, 1, At('"', cExpand)-1)
		nOrigem := Val(SubStr(cExpand, At('=', cExpand)+1, Len(cExpand)))
		aAux[nLinExpand] := StrTran(aAux[nLinExpand], 'ExpandedRowCount="'+cValToChar(nOrigem)+'"', 'ExpandedRowCount="'+cValToChar(nOrigem+nAMais)+'"')
	EndIf
	
	//Clonando o conteúdo
	::aConDest := aClone(aAux)
	
	//Gerando agora o arquivo destino
	FErase(::cArqDest)
	nHdl := FCreate(::cArqDest)
	
	//Gerando o conteúdo
	For nAtual := 1 To Len(::aConDest)
		fWrite(nHdl, ::aConDest[nAtual])
	Next
	FClose(nHdl)
	
	//Se tiver que gerar cópia
	If !Empty(::cArqCopy)
		__CopyFile(::cArqDest, ::cArqCopy)
	EndIf
	
	//Mostrando mensagem
	cMensagem :=	"[zExcelXML][015] Processamento finalizado! "+;
					"Verificar! - MountFile() - "+dToC(dDataBase)+" "+Time()
	Self:ShowMessage(cMensagem)
	
	RestArea(aArea)
Return Nil

/*/{Protheus.doc} CopyTo
Define o nome do arquivo de cópia que será gerado no MountFile
@author Atilio
@since 23/06/2015
@version 1.0
	@example oExcelXml:CopyTo("C:\testes\novo.xml")
/*/

Method CopyTo(cCopia) Class zExcelXML
	Local cMensagem	:= ""
	Local nRet			:= 0
	Default cCopia	:= ""
	
	//Se tiver em branco a cópia
	If Empty(cCopia)
		cMensagem :=	"[zExcelXML][011] Caminho do arquivo em cópia está em branco! "+;
						"Verificar! - View() - "+dToC(dDataBase)+" "+Time()
	Else
		::cArqCopy := cCopia
	EndIf
	
	//Mostrando mensagem caso tenha
	Self:ShowMessage(cMensagem)
Return Nil

/*/{Protheus.doc} View
Abre o arquivo XML utilizando a classe padrão do Protheus
@author Atilio
@since 23/06/2015
@version 1.0
	@example oExcelXml:View()
/*/

Method View() Class zExcelXML
	Local cMensagem	:= ""
	Local nRet			:= 0
	Local cArquivo	:= ::cArqDest
	Local oExcelApp
	
	//Somente se tiver registro
	If Len(::aConDest) > 0
		//Abrindo o excel e abrindo o arquivo xml
		oExcelApp := MsExcel():New() 			//Abre uma nova conexão com Excel
		oExcelApp:WorkBooks:Open(cArquivo) 	//Abre uma planilha
		oExcelApp:SetVisible(.T.) 				//Visualiza a planilha
		oExcelApp:Destroy()						//Encerra o processo do gerenciador de tarefas
		
	//Senão, mostra mensagem de erro
	Else
		cMensagem :=	"[zExcelXML][010] Arquivo não pode ser aberto, utilize o método MountFile() para montar os dados! "+;
						"Verificar! - View() - "+dToC(dDataBase)+" "+Time()
	EndIf
	
	//Mostrando mensagem caso tenha
	Self:ShowMessage(cMensagem)
Return Nil


/*/{Protheus.doc} ViewSO
Abre o arquivo XML conforme preferências do Sistema Operacional
@author Atilio
@since 23/06/2015
@version 1.0
	@example oExcelXml:ViewSO()
/*/

Method ViewSO() Class zExcelXML
	Local cMensagem	:= ""
	Local nRet			:= 0
	Local cAbsoluto	:= ::cArqDest
	Local cDiretorio	:= SubStr(cAbsoluto, 1, RAt("\",cAbsoluto))
	Local cArquivo	:= SubStr(cAbsoluto, RAt("\",cAbsoluto)+1, Len(cAbsoluto))
	
	//Somente se tiver registro
	If Len(::aConDest) > 0
		//Tentando abrir o objeto
		nRet := ShellExecute("open", cArquivo, "", cDiretorio, 1)
		
		//Se houver algum erro
		If nRet <= 32
			cMensagem :=	"[zExcelXML][008] Arquivo não pode ser aberto! "+;
							"Verificar! - ViewSO() - "+dToC(dDataBase)+" "+Time()
		EndIf 
		
	//Senão, mostra mensagem de erro
	Else
		cMensagem :=	"[zExcelXML][009] Arquivo não pode ser aberto, utilize o método MountFile() para montar os dados! "+;
						"Verificar! - ViewSO() - "+dToC(dDataBase)+" "+Time()
	EndIf
	
	//Mostrando mensagem caso tenha
	Self:ShowMessage(cMensagem)
Return Nil

/*/{Protheus.doc} Destroy
Método que zera os atributos do objeto instanciando, caso ele seja reutilizado no fonte
@author Atilio
@since 23/06/2015
@version 1.0
	@param lShowAlerts, Lógico, Define se será mostrado alertas ou não nas chamadas dos métodos
	@example oExcelXml:Destroy()
/*/

Method Destroy(lShowAlerts) Class zExcelXML
	Local cMensagem := "[zExcelXML][999] Objeto Destruído com sucesso!"
	Default lShowAlerts := .F.

	//Restaurando as areas
	Self:RestAreaExcel()

	//Definindo os atributos
	::cArqOrig	:= ""
	::cArqDest	:= ""
	::aTabelas	:= {}
	::aAreas	:= {}
	::aExpre	:= {}
	::aConOrig	:= {}
	::aConDest	:= {}
	::cArqCopy	:= ""
	::lShowMsg	:= lShowAlerts

	//Mostrando mensagem caso tenha
	Self:ShowMessage(cMensagem)
Return Nil

/*/{Protheus.doc} ShowMessage
Mensagem que será mostrada
@author Atilio
@since 28/05/2015
@version 1.0
	@param cMensagem, Caracter, Mensagem que será mostrada ao usuário ou no console.log
/*/

Method ShowMessage(cMensagem) Class zExcelXML
	Default cMensagem := ''

	//Se tiver mensagem de erro
	If !Empty(cMensagem)
	
		//Se mostra mensagem na tela
		If ::lShowMsg
			Aviso('Atenção', cMensagem, {'OK'}, 03)
			
		//Senão apenas mostra mensagem no console.log
		Else
			ConOut(cMensagem)
		EndIf
	Endif
Return Nil

/*/{Protheus.doc} RestAreaExcel
Método que restaura as áreas armazenadas das tabelas utilizadas pela classe
@author Atilio
@since 01/08/2015
@version 1.0
/*/

Method RestAreaExcel() Class zExcelXML
	Local nAux := 0
	Local aArea := GetArea()
	
	//Percorrendo as áreas guardadas
	For nAux := 1 To Len(::aAreas)
		RestArea(::aAreas[nAux][2])
	Next
	
	RestArea(aArea)
Return Nil

/*---------------------------------------------------------------------*
 | Func:  fMascara                                                     |
 | Autor: Daniel Atilio                                                |
 | Data:  31/07/2015                                                   |
 | Desc:  Função que verifica se existe máscara para determinado campo |
 *---------------------------------------------------------------------*/

Static Function fMascara(cCampo)
	Local cMask := ""
	Local cTab := SubStr(cCampo, 1, At('_', cCampo)-1)//AliasCpo(cCampo)
	
	//Se tiver tabela
	If !Empty(cTab) .And. Len(cTab) == 3
		cMask := PesqPict(cTab, cCampo)
	EndIf
Return cMask