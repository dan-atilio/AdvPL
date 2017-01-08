//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zExpTabs
Função que gera lista das tabelas do Protheus
@type function
@author Atilio
@since 18/12/2016
@version 1.0
/*/

User Function zExpTabs()
	Local aArea    := GetArea()
	Local aAreaX2  := SX2->(GetArea())
	Local aAreaX3  := SX3->(GetArea())
	Local aAreaX9  := SX9->(GetArea())
	Local aAreaIX  := SIX->(GetArea())
	Local cDirect  := GetTempPath()
	Local cArquivo := "tabelas.html"
	Local nHdl     := fCreate(cDirect+cArquivo)
	
	//Se houve falhas, encerra a rotina
	If nHdl == -1
		MsgAlert("O arquivo '"+cDirect+cArquivo+"' não pode ser criado!", "Atenção")
		Return
	Endif
	
	//Monta cabeçalho do html
	fWrite(nHdl, '<html>' + CRLF)
	fWrite(nHdl, '<head><title>Tabelas Protheus</title></head>' + CRLF)
	fWrite(nHdl, '<body>' + CRLF)
	
	//Monta as referências
	fWrite(nHdl, '<b>Refer&ecirc;ncias:</b><br>' + CRLF)
	DbSelectArea('SX2')
	SX2->(DbGoTop())
	While !SX2->(EoF())
		//Se não for tabela específica
		If SubStr(SX2->X2_CHAVE, 1, 2) != 'SZ' .And. SubStr(SX2->X2_CHAVE, 1, 2) != 'Z'
			fWrite(nHdl, '- <a href="#'+SX2->X2_CHAVE+'">'+SX2->X2_CHAVE+' ('+Alltrim(SX2->X2_NOME)+')</a><br>' + CRLF)
		EndIf
		
		SX2->(DbSkip())
	EndDo
	fWrite(nHdl, '<br>' + CRLF)
	fWrite(nHdl, '<hr>' + CRLF)
	fWrite(nHdl, '<br>' + CRLF)
	
	//Agora é montado as tabelas
	DbSelectArea('SX2')
	SX2->(DbGoTop())
	While !SX2->(EoF())
		//Se não for tabela específica
		If SubStr(SX2->X2_CHAVE, 1, 2) != 'SZ' .And. SubStr(SX2->X2_CHAVE, 1, 2) != 'Z'
			fWrite(nHdl, '<center>' + CRLF)
			fWrite(nHdl, '<font color="red"><h2 id="'+SX2->X2_CHAVE+'">'+SX2->X2_CHAVE+' - '+Alltrim(SX2->X2_NOME)+'</h2></font>' + CRLF)
			fWrite(nHdl, '<table>' + CRLF)
			
			//Campos
			DbSelectArea('SX3')
			SX3->(DbSetOrder(1))
			If SX3->(DbSeek(SX2->X2_CHAVE))
				fWrite(nHdl, '<tr>' + CRLF)
				fWrite(nHdl, '<td colspan="5" align="center"><b><i>Campos</i></b></td>' + CRLF)
				fWrite(nHdl, '</tr>' + CRLF)
				fWrite(nHdl, '<tr>' + CRLF)
				fWrite(nHdl, '<td><b>Campo</b></td>' + CRLF)
				fWrite(nHdl, '<td><b>Titulo</b></td>' + CRLF)
				fWrite(nHdl, '<td colspan="2"><b>Descri&ccedil;&atilde;o</b></td>' + CRLF)
				fWrite(nHdl, '<td><b>Tipo</b></td>' + CRLF)
				fWrite(nHdl, '</tr>' + CRLF)
			
				//Percorre os campos
				While ! SX3->(Eof()) .And. SX3->X3_ARQUIVO == SX2->X2_CHAVE
					//Se não for campo customizado
					If ! ('_X_' $ SX3->X3_CAMPO .Or. '__' $ SX3->X3_CAMPO)
						fWrite(nHdl, '<tr>' + CRLF)
						fWrite(nHdl, '<td>'+SX3->X3_CAMPO+'</td>' + CRLF)
						fWrite(nHdl, '<td>'+Alltrim(SX3->X3_TITULO)+'</td>' + CRLF)
						fWrite(nHdl, '<td colspan="2">'+Alltrim(SX3->X3_DESCRIC)+'</td>' + CRLF)
						fWrite(nHdl, '<td>'+SX3->X3_TIPO+'</td>' + CRLF)
						fWrite(nHdl, '</tr>' + CRLF)
					EndIf
					
					SX3->(DbSkip())
				EndDo
			EndIf
			
			//Relacionamentos
			DbSelectArea('SX9')
			SX9->(DbSetOrder(1))
			If SX9->(DbSeek(SX2->X2_CHAVE))
				fWrite(nHdl, '<tr>' + CRLF)
				fWrite(nHdl, '<td colspan="5" align="center"><b><i>Relacionamentos</i></b></td>' + CRLF)
				fWrite(nHdl, '</tr>' + CRLF)
				fWrite(nHdl, '<tr>' + CRLF)
				fWrite(nHdl, '<td><b>Tabela Destino</b></td>' + CRLF)
				fWrite(nHdl, '<td colspan="2"><b>Express&atilde;o Origem</b></td>' + CRLF)
				fWrite(nHdl, '<td colspan="2"><b>Express&atilde;o Destino</b></td>' + CRLF)
				fWrite(nHdl, '</tr>' + CRLF)
			
				//Percorre os campos
				While ! SX9->(Eof()) .And. SX9->X9_DOM == SX2->X2_CHAVE
					fWrite(nHdl, '<tr>' + CRLF)
					fWrite(nHdl, '<td>'+SX9->X9_CDOM+'</td>' + CRLF)
					fWrite(nHdl, '<td colspan="2">'+Alltrim(SX9->X9_EXPDOM)+'</td>' + CRLF)
					fWrite(nHdl, '<td colspan="2">'+Alltrim(SX9->X9_EXPCDOM)+'</td>' + CRLF)
					fWrite(nHdl, '</tr>' + CRLF)
					
					SX9->(DbSkip())
				EndDo
			EndIf
			
			//índices
			DbSelectArea('SIX')
			SIX->(DbSetOrder(1))
			If SIX->(DbSeek(SX2->X2_CHAVE))
				fWrite(nHdl, '<tr>' + CRLF)
				fWrite(nHdl, '<td colspan="5" align="center"><b><i>&Iacute;ndices</i></b></td>' + CRLF)
				fWrite(nHdl, '</tr>' + CRLF)
				fWrite(nHdl, '<tr>' + CRLF)
				fWrite(nHdl, '<td><b>Ordem</b></td>' + CRLF)
				fWrite(nHdl, '<td colspan="2"><b>Chave</b></td>' + CRLF)
				fWrite(nHdl, '<td><b>Descri&ccedil;&atilde;o</b></td>' + CRLF)
				fWrite(nHdl, '<td><b>NickName</b></td>' + CRLF)
				fWrite(nHdl, '</tr>' + CRLF)
			
				//Percorre os campos
				While ! SIX->(Eof()) .And. SIX->INDICE == SX2->X2_CHAVE
					fWrite(nHdl, '<tr>' + CRLF)
					fWrite(nHdl, '<td>'+SIX->ORDEM+'</td>' + CRLF)
					fWrite(nHdl, '<td colspan="2">'+Alltrim(SIX->CHAVE)+'</td>' + CRLF)
					fWrite(nHdl, '<td>'+Alltrim(SIX->DESCRICAO)+'</td>' + CRLF)
					fWrite(nHdl, '<td>'+Alltrim(SIX->NICKNAME)+'</td>' + CRLF)
					fWrite(nHdl, '</tr>' + CRLF)
					
					SIX->(DbSkip())
				EndDo
			EndIf
			
			fWrite(nHdl, '</table>' + CRLF)
			fWrite(nHdl, '</center><br>' + CRLF)
		EndIf
		
		SX2->(DbSkip())
	EndDo
	
	//Fecha ponteiro do arquivo
	fWrite(nHdl, '</html>' + CRLF)
	fClose(nHdl)
	
	//Se deseja visualizar o arquivo após a geração
	If MsgYesNo("Arquivo gerado, deseja visualizar?", "Atenção")
		ShellExecute("open", cArquivo, "", cDirect, 1)
	EndIf
	
	RestArea(aAreaIX)
	RestArea(aAreaX9)
	RestArea(aAreaX3)
	RestArea(aAreaX2)
	RestArea(aArea)
Return