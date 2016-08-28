//Bibliotecas
#Include "Protheus.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} zTstXML
Função que testa a Criação e Leitura de um arquivo XML
@type function
@author Atilio
@since 17/08/2016
@version 1.0
	@example
	u_zTstXML()
/*/

User Function zTstXML()
	Local aArea      := GetArea()
	Private cDirect  := GetTempPath()
	Private cArquivo := "teste.xml"
	
	//Criação do arquivo XML
	fCriaXML()
	
	//Leitura do arquivo XML
	fLeXML()
	
	RestArea(aArea)
Return

/*---------------------------------------------------------------------*
 | Func:  fCriaXML                                                     |
 | Autor: Daniel Atilio                                                |
 | Data:  17/08/2016                                                   |
 | Desc:  Função que cria o arquivo XML                                |
 *---------------------------------------------------------------------*/
		
Static Function fCriaXML()
	Local nHdl  := 0
	Local aArea := GetArea()
	Local cQry  := ""
	Local nAtu  := 1
	
	//Cria o arquivo
	nHdl := fCreate(cDirect+cArquivo)
		
	//Se houve erro na criação
	If nHdl == -1
		MsgStop("Não foi possível gerar o arquivo!")
	
	Else
		//Monta a query de produtos (pega até o recno 50)
		cQry := " SELECT "
		cQry += "    B1_COD, B1_DESC "
		cQry += " FROM "
		cQry += "    "+RetSQLName('SB1')+" SB1 "
		cQry += " WHERE "
		cQry += "    B1_FILIAL = '"+FWxFilial('SB1')+"' "
		cQry += "    AND R_E_C_N_O_ <= 50 "
		cQry += "    AND SB1.D_E_L_E_T_ = ' ' "
		TCQuery cQry New Alias "QRY_SB1"
		
		//Monta o XML
		fWrite(nHdl, "<?xml version='1.0' encoding='UTF-8' ?>"+Chr(13)+Chr(10))
		fWrite(nHdl, "<dados>"+Chr(13)+Chr(10))
		fWrite(nHdl, "<data>"+dToC(dDataBase)+"</data>"+Chr(13)+Chr(10))
		fWrite(nHdl, "<hora>"+Time()+"</hora>"+Chr(13)+Chr(10))
		fWrite(nHdl, "<produtos>"+Chr(13)+Chr(10))
		While !QRY_SB1->(EoF())
			fWrite(nHdl, '  <produto id="'+cValToChar(nAtu)+'">'+Chr(13)+Chr(10))
			fWrite(nHdl, "    <codigo>"+QRY_SB1->B1_COD+"</codigo>"+Chr(13)+Chr(10))
			fWrite(nHdl, "	<descricao>"+QRY_SB1->B1_DESC+"</descricao>"+Chr(13)+Chr(10))
			fWrite(nHdl, "  </produto>"+Chr(13)+Chr(10))
			
			nAtu++
			QRY_SB1->(DbSkip())
		EndDo
		QRY_SB1->(DbCloseArea())
		fWrite(nHdl, "</produtos>"+Chr(13)+Chr(10))
		fWrite(nHdl, "</dados>"+Chr(13)+Chr(10))
		
		//Finalizando o Handle
		fClose(nHdl)
		
		//Abrindo o arquivo
		ShellExecute("OPEN", cArquivo, "", cDirect, 0 )
	EndIf
	
	RestArea(aArea)
Return

/*---------------------------------------------------------------------*
 | Func:  fLeXML                                                       |
 | Autor: Daniel Atilio                                                |
 | Data:  17/08/2016                                                   |
 | Desc:  Função que faz a leitura do arquivo XML                      |
 *---------------------------------------------------------------------*/
		
Static Function fLeXML()
	Local oLido    := Nil
	Local oProds   := Nil
	Local nAtual   := 0
	Local cReplace := "_"
	Local cErros   := ""
	Local cAvisos  := ""
	Local cMsg     := ""
	
	//Se o arquivo existir
	If File(cDirect+cArquivo)
		//Lendo o arquivo com XMLParser (lê a string), caso queira ler o arquivo direto, utilize o XMLParserFile (o arquivo deve estar dentro da system)
		oLido := XmlParser(MemoRead(cDirect+cArquivo), cReplace, @cErros, @cAvisos)
		
		//Se tiver erros, mostra ao usuário
		If !Empty(cErros)
			Aviso('Atenção', "Erros: "+cErros, {'Ok'}, 03)
		EndIf
		
		//Se tiver avisos, mostra ao usuário
		If !Empty(cAvisos)
			Aviso('Atenção', "Avisos: "+cAvisos, {'Ok'}, 03)
		EndIf
		
		//Montando a Mensagem, data e hora
		cMsg := "Data: "+oLido:_Dados:_Data:Text + Chr(13)+Chr(10)
		cMsg := "Hora: "+oLido:_Dados:_Hora:Text + Chr(13)+Chr(10)
		
		//Percorrendo os produtos
		oProds := oLido:_Dados:_Produtos:_Produto
		For nAtual := 1 To Len(oProds)
			cMsg += "ID: "+oProds[nAtual]:_ID:Text+", "
			cMsg += "ID: "+oProds[nAtual]:_Codigo:Text+", "
			cMsg += "ID: "+oProds[nAtual]:_Descricao:Text
			cMsg += Chr(13)+Chr(10)
		Next
		
		//Mostrando a mensagem do xml lido
		Aviso('Atenção', cMsg, {'Ok'}, 03)
	EndIf
Return