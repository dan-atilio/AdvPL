//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zExpPars
Função que gera uma lista de parâmetros em HTML
@author Atilio
@since 15/07/2017
@version 1.0
@type function
/*/

User Function zExpPars()
	MsAguarde({|| fRunProc()}, "Aguarde...", "Processando Parâmetros", .T.)
Return

/*---------------------------------------------------*
 | Func: fRunProc                                    |
 | Desc: Função que percorre os parâmetros           |
 *---------------------------------------------------*/

Static Function fRunProc()
	Local aArea    := GetArea()
	Local cPasta   := GetTempPath()
	Local cArquivo := "pars_"+dToS(Date())+"_"+StrTran(Time(), ':', '-')+".html"
	Local nTotal   := 0
	Local nAtual   := 0
	Local nHdl     := 0
	
	//Abre a tabela de parâmetros
	DbSelectArea('SX6')
	SX6->(DbSetOrder(1))
	SX6->(DbGoTop())
	Count To nTotal
	
	//Cabeçalho do html
	nHdl := fCreate(cPasta+cArquivo)
	fWrite(nHdl, FwNoAccent("<html>") + CRLF)
	fWrite(nHdl, FwNoAccent("<head>") + CRLF)
	fWrite(nHdl, FwNoAccent("<title>Parâmetros Protheus</title>") + CRLF)
	fWrite(nHdl, FwNoAccent("</head>") + CRLF)
	fWrite(nHdl, FwNoAccent("<body>") + CRLF)
	fWrite(nHdl, FwNoAccent("<table>") + CRLF)
	fWrite(nHdl, FwNoAccent("<tr>") + CRLF)
	fWrite(nHdl, FwNoAccent("<td><b>Parâmetro</b></td>") + CRLF)
	fWrite(nHdl, FwNoAccent("<td><b>Tipo</b></td>") + CRLF)
	fWrite(nHdl, FwNoAccent("<td><b>Conteúdo</b></td>") + CRLF)
	fWrite(nHdl, FwNoAccent("</tr>") + CRLF)
	
	//Enquanto houver dados
	SX6->(DbGoTop())
	While ! SX6->(EoF())
		nAtual++
		MsProcTxt("Parâmetro "+Alltrim(SX6->X6_VAR)+" ("+cValToChar(nAtual)+" de "+cValToChar(nTotal)+")...")
		
		//Se não conter o _X_ (parâmetro customizado), incrementa a variável
		If ! '_X_' $ Upper(SX6->X6_VAR)
			fWrite(nHdl, FwNoAccent("<tr>") + CRLF)
			fWrite(nHdl, FwNoAccent("<td>"+Alltrim(SX6->X6_VAR)+"</td>") + CRLF)
			fWrite(nHdl, FwNoAccent("<td>"+SX6->X6_TIPO+"</td>") + CRLF)
			fWrite(nHdl, FwNoAccent("<td>"+Alltrim(Alltrim(SX6->X6_DESCRIC)+" "+Alltrim(SX6->X6_DESC1)+" "+Alltrim(SX6->X6_DESC2))+"</td>") + CRLF)
			fWrite(nHdl, FwNoAccent("</tr>") + CRLF)
		EndIf 
		SX6->(DbSkip())
	EndDo
	
	fWrite(nHdl, FwNoAccent("</table>") + CRLF)
	fWrite(nHdl, FwNoAccent("</body>") + CRLF)
	fWrite(nHdl, FwNoAccent("</html>") + CRLF)
	fClose(nHdl)
	
	//Abre o arquivo
	If MsgYesNo("Arquivo '"+cPasta+cArquivo+"' gerado. Deseja abrir?", "Atenção")
		ShellExecute("OPEN", cPasta+cArquivo, "", cPasta, 0 )
	EndIf
	RestArea(aArea)
Return