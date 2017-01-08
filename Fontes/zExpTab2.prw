//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zExpTab2
Função que gera lista das tabelas do Protheus
@type function
@author Atilio
@since 18/12/2016
@version 1.0
/*/

User Function zExpTab2()
	Local aArea    := GetArea()
	Local aAreaX2  := SX2->(GetArea())
	Local aAreaX3  := SX3->(GetArea())
	Local aAreaX9  := SX9->(GetArea())
	Local aAreaIX  := SIX->(GetArea())
	Local cDirect  := GetTempPath()
	Local cArquivo := "tabelas.html"
	Local nHdl
	
	//Monta cabeçalho do html
	fErase("C:\Users\Atilio\Desktop\tab2\referencias.html")
	nHdl := fCreate("C:\Users\Atilio\Desktop\tab2\referencias.html")
	fWrite(nHdl, FwNoAccent('<html>') + CRLF)
	fWrite(nHdl, FwNoAccent('<head>') + CRLF)
	fWrite(nHdl, FwNoAccent('	<meta charset="utf-8">') + CRLF)
	fWrite(nHdl, FwNoAccent('	<link rel="stylesheet" type="text/css" href="./estilo.css">') + CRLF)
	fWrite(nHdl, FwNoAccent('</head>') + CRLF)
	fWrite(nHdl, FwNoAccent('<body class="referencia">') + CRLF)
	fWrite(nHdl, FwNoAccent('	<ul>') + CRLF)
	
	//Monta as referências
	fWrite(nHdl, FwNoAccent('<b>Refer&ecirc;ncias:</b><br>') + CRLF)
	DbSelectArea('SX2')
	SX2->(DbGoTop())
	While !SX2->(EoF())
		//Se não for tabela específica
		If SubStr(SX2->X2_CHAVE, 1, 2) != 'SZ' .And. SubStr(SX2->X2_CHAVE, 1, 2) != 'Z'
			fWrite(nHdl, FwNoAccent('		<li><a href="./tabelas/'+Lower(SX2->X2_CHAVE)+'.html" target="main">'+SX2->X2_CHAVE+' - '+Alltrim(SX2->X2_NOME)+'</a></li>') + CRLF)
		EndIf
		
		SX2->(DbSkip())
	EndDo
	//Fecha ponteiro do arquivo
	fWrite(nHdl, FwNoAccent('	</ul>') + CRLF)
	fWrite(nHdl, FwNoAccent('</body>') + CRLF)
	fWrite(nHdl, FwNoAccent('</html>') + CRLF)
	fClose(nHdl)
	Return
	
	//Agora é montado as tabelas
	DbSelectArea('SX2')
	SX2->(DbGoTop())
	While !SX2->(EoF())
		//Se não for tabela específica
		If SubStr(SX2->X2_CHAVE, 1, 2) != 'SZ' .And. SubStr(SX2->X2_CHAVE, 1, 2) != 'Z'
			fErase("C:\Users\Atilio\Desktop\tab2\tabelas\"+SX2->X2_CHAVE+".html")
			nHdl := fCreate("C:\Users\Atilio\Desktop\tab2\tabelas\"+SX2->X2_CHAVE+".html")
			
			fWrite(nHdl, FwNoAccent('<html>') + CRLF)
			fWrite(nHdl, FwNoAccent('<head>') + CRLF)
			fWrite(nHdl, FwNoAccent('	<meta charset="utf-8">') + CRLF)
			fWrite(nHdl, FwNoAccent('	<link rel="stylesheet" type="text/css" href="./../estilo.css">') + CRLF)
			fWrite(nHdl, FwNoAccent('</head>') + CRLF)
			fWrite(nHdl, FwNoAccent('<body class="tabelas">') + CRLF)
			fWrite(nHdl, FwNoAccent('<center>') + CRLF)
			fWrite(nHdl, FwNoAccent('<h2>'+SX2->X2_CHAVE+' - '+Alltrim(SX2->X2_NOME)+'</h2><br><br>') + CRLF)
			fWrite(nHdl, FwNoAccent('<table class="tabProtheus">') + CRLF)
			
			//Campos
			DbSelectArea('SX3')
			SX3->(DbSetOrder(1))
			If SX3->(DbSeek(SX2->X2_CHAVE))
				fWrite(nHdl, FwNoAccent('<tr>') + CRLF)
				fWrite(nHdl, FwNoAccent('	<td colspan="5" class="separaTab">Campos</td>') + CRLF)
				fWrite(nHdl, FwNoAccent('</tr>') + CRLF)
				fWrite(nHdl, FwNoAccent('<tr>') + CRLF)
				fWrite(nHdl, FwNoAccent('	<td><b>Campo</b></td>') + CRLF)
				fWrite(nHdl, FwNoAccent('	<td><b>Titulo</b></td>') + CRLF)
				fWrite(nHdl, FwNoAccent('	<td colspan="2"><b>Descri&ccedil;&atilde;o</b></td>') + CRLF)
				fWrite(nHdl, FwNoAccent('	<td><b>Tipo</b></td>') + CRLF)
				fWrite(nHdl, FwNoAccent('</tr>') + CRLF)
			
				//Percorre os campos
				While ! SX3->(Eof()) .And. SX3->X3_ARQUIVO == SX2->X2_CHAVE
					//Se não for campo customizado
					If ! ('_X_' $ SX3->X3_CAMPO .Or. '__' $ SX3->X3_CAMPO)
						fWrite(nHdl, FwNoAccent('<tr>') + CRLF)
						fWrite(nHdl, FwNoAccent('	<td>'+SX3->X3_CAMPO+'</td>') + CRLF)
						fWrite(nHdl, FwNoAccent('	<td>'+Alltrim(SX3->X3_TITULO)+'</td>') + CRLF)
						fWrite(nHdl, FwNoAccent('	<td colspan="2">'+Alltrim(SX3->X3_DESCRIC)+'</td>') + CRLF)
						fWrite(nHdl, FwNoAccent('	<td>'+SX3->X3_TIPO+'</td>') + CRLF)
						fWrite(nHdl, FwNoAccent('</tr>') + CRLF)
					EndIf
					
					SX3->(DbSkip())
				EndDo
			EndIf
			
			//Relacionamentos
			DbSelectArea('SX9')
			SX9->(DbSetOrder(1))
			If SX9->(DbSeek(SX2->X2_CHAVE))
				fWrite(nHdl, FwNoAccent('<tr>') + CRLF)
				fWrite(nHdl, FwNoAccent('	<td colspan="5" class="separaTab">Relacionamentos</td>') + CRLF)
				fWrite(nHdl, FwNoAccent('</tr>') + CRLF)
				fWrite(nHdl, FwNoAccent('<tr>') + CRLF)
				fWrite(nHdl, FwNoAccent('	<td><b>Tabela Destino</b></td>') + CRLF)
				fWrite(nHdl, FwNoAccent('	<td colspan="2"><b>Express&atilde;o Origem</b></td>') + CRLF)
				fWrite(nHdl, FwNoAccent('	<td colspan="2"><b>Express&atilde;o Destino</b></td>') + CRLF)
				fWrite(nHdl, FwNoAccent('</tr>') + CRLF)
			
				//Percorre os campos
				While ! SX9->(Eof()) .And. SX9->X9_DOM == SX2->X2_CHAVE
					fWrite(nHdl, FwNoAccent('<tr>') + CRLF)
					fWrite(nHdl, FwNoAccent('	<td>'+SX9->X9_CDOM+'</td>') + CRLF)
					fWrite(nHdl, FwNoAccent('	<td colspan="2">'+Alltrim(SX9->X9_EXPDOM)+'</td>') + CRLF)
					fWrite(nHdl, FwNoAccent('	<td colspan="2">'+Alltrim(SX9->X9_EXPCDOM)+'</td>') + CRLF)
					fWrite(nHdl, FwNoAccent('</tr>') + CRLF)
					
					SX9->(DbSkip())
				EndDo
			EndIf
			
			//índices
			DbSelectArea('SIX')
			SIX->(DbSetOrder(1))
			If SIX->(DbSeek(SX2->X2_CHAVE))
				fWrite(nHdl, FwNoAccent('<tr>') + CRLF)
				fWrite(nHdl, FwNoAccent('	<td colspan="5" class="separaTab">&Iacute;ndices</td>') + CRLF)
				fWrite(nHdl, FwNoAccent('</tr>') + CRLF)
				fWrite(nHdl, FwNoAccent('<tr>') + CRLF)
				fWrite(nHdl, FwNoAccent('	<td><b>Ordem</b></td>') + CRLF)
				fWrite(nHdl, FwNoAccent('	<td colspan="2"><b>Chave</b></td>') + CRLF)
				fWrite(nHdl, FwNoAccent('	<td><b>Descri&ccedil;&atilde;o</b></td>') + CRLF)
				fWrite(nHdl, FwNoAccent('	<td><b>NickName</b></td>') + CRLF)
				fWrite(nHdl, FwNoAccent('</tr>') + CRLF)
			
				//Percorre os campos
				While ! SIX->(Eof()) .And. SIX->INDICE == SX2->X2_CHAVE
					fWrite(nHdl, FwNoAccent('<tr>') + CRLF)
					fWrite(nHdl, FwNoAccent('	<td>'+SIX->ORDEM+'</td>') + CRLF)
					fWrite(nHdl, FwNoAccent('	<td colspan="2">'+Alltrim(SIX->CHAVE)+'</td>') + CRLF)
					fWrite(nHdl, FwNoAccent('	<td>'+Alltrim(SIX->DESCRICAO)+'</td>') + CRLF)
					fWrite(nHdl, FwNoAccent('	<td>'+Alltrim(SIX->NICKNAME)+'</td>') + CRLF)
					fWrite(nHdl, FwNoAccent('</tr>') + CRLF)
					
					SIX->(DbSkip())
				EndDo
			EndIf
			
			fWrite(nHdl, FwNoAccent('</table>') + CRLF)
			fWrite(nHdl, FwNoAccent('</center><br>') + CRLF)
			fWrite(nHdl, FwNoAccent('</body>') + CRLF)
			fWrite(nHdl, FwNoAccent('</html>') + CRLF)
			fClose(nHdl)
		EndIf
		
		SX2->(DbSkip())
	EndDo
	
	MsgInfo("Processo terminado.")
	
	RestArea(aAreaIX)
	RestArea(aAreaX9)
	RestArea(aAreaX3)
	RestArea(aAreaX2)
	RestArea(aArea)
Return