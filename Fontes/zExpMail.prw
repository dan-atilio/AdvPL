/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2020/05/29/funcao-para-exportar-contatos-para-locaweb-utilizando-advpl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} zExpMail
Função que gera a exportação csv de contatos para a Locaweb
@author Atilio
@since 16/01/2017
@version 1.0
@type function
/*/

User Function zExpMail()
	Local aArea        := GetArea()
	Local aPergs       := {}
	Local cMsg         := ""
	Private cDiretorio := GetTempPath() + Space(50)
	Private lVendedor  := .F.
	Private lCliente   := .F.
	Private lFornece   := .F.
	Private cEstado    := Space(2)
	Private cArqCli    := "clientes_"+dToS(Date())+"_"+StrTran(Time(), ':', '-')+".csv"
	Private cArqVen    := "vendedores_"+dToS(Date())+"_"+StrTran(Time(), ':', '-')+".csv"
	Private cArqFor    := "fornecedores_"+dToS(Date())+"_"+StrTran(Time(), ':', '-')+".csv"
	
	//Adicionando os parametros
    aAdd(aPergs, {1, "Diretorio",  cDiretorio,  "", ".T.", "", ".T.", 100,  .T.})
	aAdd(aPergs, {2, "Exportar Clientes",     1, {"1=Sim", "2=Nao"}, 40, ".T.", .F.})
    aAdd(aPergs, {2, "Exportar Vendedores",   1, {"1=Sim", "2=Nao"}, 40, ".T.", .F.})
    aAdd(aPergs, {2, "Exportar Fornecedores", 1, {"1=Sim", "2=Nao"}, 40, ".T.", .F.})
    aAdd(aPergs, {1, "Filtrar Estado",  cEstado,  "", ".T.", "12", ".T.", 60,  .F.})

	//Se foi confirmado a rotina
	If ParamBox(aPergs, "Informe os parametros")
		
		//Atualizando as variaveis
        cDiretorio := Alltrim(MV_PAR01)
        lCliente   := (Val(cValToChar(MV_PAR02)) == 1)
		lVendedor  := (Val(cValToChar(MV_PAR03)) == 1)
        lFornece   := (Val(cValToChar(MV_PAR04)) == 1)
		cEstado    := Alltrim(MV_PAR05)

        //Verifica se a última posição é uma \
		If SubStr(cDiretorio, Len(cDiretorio), 1) != '\'
			cDiretorio += '\'
		EndIf
		
		//Se o diretório existir, continua com o processamento
		If ExistDir(cDiretorio)
			If lVendedor .Or. lCliente .Or. lFornece
				//Chama o processamento para gerar os arquivos
				Processa({|| fGeraArq()}, "Gerando arquivos...")
				
				//Monta e mostra a mensagem que será exibida
				cMsg := "Arquivos gerados com sucesso!" + CRLF
				If lCliente
					cMsg += "- " + cDiretorio + cArqCli + CRLF
				EndIf
				If lVendedor
					cMsg += "- " + cDiretorio + cArqVen + CRLF
				EndIf
				If lFornece
					cMsg += "- " + cDiretorio + cArqFor + CRLF
				EndIf
				Aviso("Atenção", cMsg, {"Ok"}, 2)
				
			Else
				MsgAlert("Escolha pelo menos uma opção para geração dos arquivos!", "Atenção")
			EndIf
		Else
			MsgAlert("Diretório não existe!", "Atenção")
		EndIf
	EndIf
	
	RestArea(aArea)
Return

/*---------------------------------------------------------------------*
 | Func:  fGeraArq                                                     |
 | Autor: Daniel Atilio                                                |
 | Data:  16/01/2017                                                   |
 | Desc:  Função para geração dos arquivos csv                         |
 *---------------------------------------------------------------------*/

Static Function fGeraArq()
	Local aArea     := GetArea()
	Local cQryAux   := ""
	Local nAtual    := 0
	Local nTotal    := 0
	Local cLinha    := ""
	Local cNomeAtu  := ""
	Local cEmailAtu := ""
	Local aEmails   := {}
	Local nPosAtu   := 00
    Local oFWriter
	
	//Se for exportar os dados dos clientes
	If lCliente
		cQryAux := " SELECT " + CRLF
		cQryAux += " 	A1_NOME AS NOME, A1_EMAIL AS EMAIL " + CRLF
		cQryAux += " FROM " + CRLF
		cQryAux += " 	"+RetSQLName('SA1')+" SA1 " + CRLF
		cQryAux += " WHERE " + CRLF
		cQryAux += " 	A1_FILIAL = '"+FWxFilial('SA1')+"' " + CRLF
		cQryAux += " 	AND A1_MSBLQL != '1' " + CRLF
		If !Empty(cEstado)
			cQryAux += " 	AND A1_EST = '"+cEstado+"' " + CRLF
		EndIf
		cQryAux += " 	AND SA1.D_E_L_E_T_ = ' ' " + CRLF
        PLSQuery(cQryAux, "QRY_CLI")

        //Setando o tamanho da regua
        DbSelectArea("QRY_CLI")
		Count To nTotal
        ProcRegua(nTotal)
		nAtual := 0
		QRY_CLI->(DbGoTop())
	
		//Cria o arquivo
        oFWriter := FWFileWriter():New(cDiretorio + cArqCli, .T.)
	
		//Se houve falhas, encerra a rotina
		If ! oFWriter:Create()
            lCliente := .F.
			MsgAlert("O arquivo '"+cDirect+cArqCli+"' não pode ser criado!", "Atenção")
			
		Else
			cLinha := "Email;Nome"
			oFWriter:Write(cLinha + CRLF)
			
			//Enquanto houver clientes
			While ! QRY_CLI->(EoF())
				nAtual++
				IncProc("Processando cliente "+cValToChar(nAtual)+" de "+cValToChar(nTotal)+"...")
				
				//Pegando o nome atual
				cNomeAtu := FwNoAccent(Alltrim(QRY_CLI->NOME))
				
				//Retira outros caracteres especiais do nome
				cNomeAtu := fRetira(cNomeAtu)
				
				//Pegando o email
				cEmailAtu := FwNoAccent(Alltrim(QRY_CLI->EMAIL))
				
				//Se tiver e-Mail e nome e se o email for válido
				If !Empty(cNomeAtu) .And. !Empty(cEmailAtu) .And. fEmailVali(cEmailAtu)
					cLinha := ""
					
					//Se tiver ; no campo de e-Mail
					If ";" $ cEmailAtu
						aEmails := StrTokArr(cEmailAtu, ';')
						
						//Percorre os emails
						For nPosAtu := 1 To Len(aEmails)
							cLinha := aEmails[nPosAtu]+";"+cNomeAtu
							oFWriter:Write(cLinha + CRLF)
						Next
						
					//Senão, será apenas uma linha única
					Else
						cLinha := cEmailAtu+";"+cNomeAtu
						oFWriter:Write(cLinha + CRLF)
					EndIf
				EndIf
				
				QRY_CLI->(DbSkip())
			EndDo
			
			//Fecha o ponteiro do arquivo
			oFWriter:Close()
		Endif
		
		QRY_CLI->(DbCloseArea())
	EndIf
	
	//Se for exportar os dados dos vendedores
	If lVendedor
		cQryAux := " SELECT " + CRLF
		cQryAux += " 	A3_NOME AS NOME, A3_EMAIL AS EMAIL " + CRLF
		cQryAux += " FROM " + CRLF
		cQryAux += " 	"+RetSQLName('SA3')+" SA3 " + CRLF
		cQryAux += " WHERE " + CRLF
		cQryAux += " 	A3_FILIAL = '"+FWxFilial('SA3')+"' " + CRLF
		cQryAux += " 	AND A3_MSBLQL != '1' " + CRLF
		If !Empty(cEstado)
			cQryAux += " 	AND A3_EST = '"+cEstado+"' " + CRLF
		EndIf
		cQryAux += " 	AND SA3.D_E_L_E_T_ = ' ' " + CRLF
		PLSQuery(cQryAux, "QRY_VEN")

        //Setando o tamanho da regua
        DbSelectArea("QRY_VEN")
		Count To nTotal
        ProcRegua(nTotal)
		nAtual := 0
		QRY_VEN->(DbGoTop())
	
		//Cria o arquivo
        oFWriter := FWFileWriter():New(cDiretorio + cArqVen, .T.)
	
		//Se houve falhas, encerra a rotina
		If ! oFWriter:Create()
            lVendedor := .F.
			MsgAlert("O arquivo '"+cDirect+cArqVen+"' não pode ser criado!", "Atenção")
			
		Else
			cLinha := "Email;Nome"
			oFWriter:Write(cLinha + CRLF)
			
			//Enquanto houver clientes
			While ! QRY_VEN->(EoF())
				nAtual++
				IncProc("Processando vendedor "+cValToChar(nAtual)+" de "+cValToChar(nTotal)+"...")
				
				//Pegando o nome atual
				cNomeAtu := FwNoAccent(Alltrim(QRY_VEN->NOME))
				
				//Retira outros caracteres especiais do nome
				cNomeAtu := fRetira(cNomeAtu)
				
				//Pegando o email
				cEmailAtu := FwNoAccent(Alltrim(QRY_VEN->EMAIL))
				
				//Se tiver e-Mail e nome e se o email for válido
				If !Empty(cNomeAtu) .And. !Empty(cEmailAtu) .And. fEmailVali(cEmailAtu)
					cLinha := ""
					
					//Se tiver ; no campo de e-Mail
					If ";" $ cEmailAtu
						aEmails := StrTokArr(cEmailAtu, ';')
						
						//Percorre os emails
						For nPosAtu := 1 To Len(aEmails)
							cLinha := aEmails[nPosAtu]+";"+cNomeAtu
							oFWriter:Write(cLinha + CRLF)
						Next
						
					//Senão, será apenas uma linha única
					Else
						cLinha := cEmailAtu+";"+cNomeAtu
						oFWriter:Write(cLinha + CRLF)
					EndIf
				EndIf
				
				QRY_VEN->(DbSkip())
			EndDo
			
			//Fecha o ponteiro do arquivo
			oFWriter:Close()
		Endif
		
		QRY_VEN->(DbCloseArea())
	EndIf
	
	If lFornece
		cQryAux := " SELECT " + CRLF
		cQryAux += " 	A2_NOME AS NOME, A2_EMAIL AS EMAIL " + CRLF
		cQryAux += " FROM " + CRLF
		cQryAux += " 	"+RetSQLName('SA2')+" SA2 " + CRLF
		cQryAux += " WHERE " + CRLF
		cQryAux += " 	A2_FILIAL = '"+FWxFilial('SA2')+"' " + CRLF
		cQryAux += " 	AND A2_MSBLQL != '1' " + CRLF
		If !Empty(cEstado)
			cQryAux += " 	AND A2_EST = '"+cEstado+"' " + CRLF
		EndIf
		cQryAux += " 	AND SA2.D_E_L_E_T_ = ' ' " + CRLF
		PLSQuery(cQryAux, "QRY_FOR")

        //Setando o tamanho da regua
        DbSelectArea("QRY_FOR")
		Count To nTotal
        ProcRegua(nTotal)
		nAtual := 0
		QRY_FOR->(DbGoTop())
	
		//Cria o arquivo
        oFWriter := FWFileWriter():New(cDiretorio + cArqFor, .T.)
	
		//Se houve falhas, encerra a rotina
		If ! oFWriter:Create()
            lFornece := .F.
			MsgAlert("O arquivo '"+cDirect+cArqFor+"' não pode ser criado!", "Atenção")
			
		Else
			cLinha := "Email;Nome"
			oFWriter:Write(cLinha + CRLF)
			
			//Enquanto houver clientes
			While ! QRY_FOR->(EoF())
				nAtual++
				IncProc("Processando fornecedor "+cValToChar(nAtual)+" de "+cValToChar(nTotal)+"...")
				
				//Pegando o nome atual
				cNomeAtu := FwNoAccent(Alltrim(QRY_FOR->NOME))
				
				//Retira outros caracteres especiais do nome
				cNomeAtu := fRetira(cNomeAtu)
				
				//Pegando o email
				cEmailAtu := FwNoAccent(Alltrim(QRY_FOR->EMAIL))
				
				//Se tiver e-Mail e nome e se o email for válido
				If !Empty(cNomeAtu) .And. !Empty(cEmailAtu) .And. fEmailVali(cEmailAtu)
					cLinha := ""
					
					//Se tiver ; no campo de e-Mail
					If ";" $ cEmailAtu
						aEmails := StrTokArr(cEmailAtu, ';')
						
						//Percorre os emails
						For nPosAtu := 1 To Len(aEmails)
							cLinha := aEmails[nPosAtu]+";"+cNomeAtu
							oFWriter:Write(cLinha + CRLF)
						Next
						
					//Senão, será apenas uma linha única
					Else
						cLinha := cEmailAtu+";"+cNomeAtu
						oFWriter:Write(cLinha + CRLF)
					EndIf
				EndIf
				
				QRY_FOR->(DbSkip())
			EndDo
			
			//Fecha o ponteiro do arquivo
			oFWriter:Close()
		Endif
		
		QRY_FOR->(DbCloseArea())
	EndIf
	
	RestArea(aArea)
Return

/*---------------------------------------------------------------------*
 | Func:  fRetira                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  16/01/2017                                                   |
 | Desc:  Função que retira caracteres especiais de uma string         |
 *---------------------------------------------------------------------*/

Static Function fRetira(cOrigem)
	Local cNovo     := ""
	Default cOrigem := ""
	
	cNovo := cOrigem
	
	//Retira os caracteres especiais
	cNovo := StrTran(cNovo, "Â´", "")
	cNovo := StrTran(cNovo, "'", "")
    cNovo := StrTran(cNovo, "#", "")
    cNovo := StrTran(cNovo, "%", "")
    cNovo := StrTran(cNovo, "*", "")
    cNovo := StrTran(cNovo, "&", "E")
    cNovo := StrTran(cNovo, ">", "")
    cNovo := StrTran(cNovo, "<", "")
    cNovo := StrTran(cNovo, "!", "")
    cNovo := StrTran(cNovo, "@", "")
    cNovo := StrTran(cNovo, "$", "")
    cNovo := StrTran(cNovo, "(", "")
    cNovo := StrTran(cNovo, ")", "")
    cNovo := StrTran(cNovo, "_", "")
    cNovo := StrTran(cNovo, "=", "")
    cNovo := StrTran(cNovo, "+", "")
    cNovo := StrTran(cNovo, "{", "")
    cNovo := StrTran(cNovo, "}", "")
    cNovo := StrTran(cNovo, "[", "")
    cNovo := StrTran(cNovo, "]", "")
    cNovo := StrTran(cNovo, "/", "")
    cNovo := StrTran(cNovo, "?", "")
    cNovo := StrTran(cNovo, ".", "")
    cNovo := StrTran(cNovo, "\", "")
    cNovo := StrTran(cNovo, "|", "")
    cNovo := StrTran(cNovo, ":", "")
    cNovo := StrTran(cNovo, ";", "")
    cNovo := StrTran(cNovo, '"', '')
    cNovo := StrTran(cNovo, 'Â°', '')
    cNovo := StrTran(cNovo, 'Âª', '')
    cNovo := StrTran(cNovo, ",", "")
    cNovo := StrTran(cNovo, "-", "")
Return cNovo

/*---------------------------------------------------------------------*
 | Func:  fEmailVali                                                   |
 | Autor: Daniel Atilio                                                |
 | Data:  16/01/2017                                                   |
 | Desc:  Função que verifica se o email é válido                      |
 *---------------------------------------------------------------------*/

Static Function fEmailVali(cEmailVld)
	Local lRet := .T.
	
	If '@' $ cEmailVld
		lRet := Iif("Â´" $ cEmailVld, .F., lRet)
		lRet := Iif("'" $ cEmailVld, .F., lRet)
	    lRet := Iif("#" $ cEmailVld, .F., lRet)
	    lRet := Iif("%" $ cEmailVld, .F., lRet)
	    lRet := Iif("*" $ cEmailVld, .F., lRet)
	    lRet := Iif("&" $ cEmailVld, .F., lRet)
	    lRet := Iif(">" $ cEmailVld, .F., lRet)
	    lRet := Iif("<" $ cEmailVld, .F., lRet)
	    lRet := Iif("!" $ cEmailVld, .F., lRet)
	    lRet := Iif("$" $ cEmailVld, .F., lRet)
	    lRet := Iif("(" $ cEmailVld, .F., lRet)
	    lRet := Iif(")" $ cEmailVld, .F., lRet)
	    lRet := Iif("=" $ cEmailVld, .F., lRet)
	    lRet := Iif("+" $ cEmailVld, .F., lRet)
	    lRet := Iif("{" $ cEmailVld, .F., lRet)
	    lRet := Iif("}" $ cEmailVld, .F., lRet)
	    lRet := Iif("[" $ cEmailVld, .F., lRet)
	    lRet := Iif("]" $ cEmailVld, .F., lRet)
	    lRet := Iif("/" $ cEmailVld, .F., lRet)
	    lRet := Iif("?" $ cEmailVld, .F., lRet)
	    lRet := Iif("\" $ cEmailVld, .F., lRet)
	    lRet := Iif("|" $ cEmailVld, .F., lRet)
	    lRet := Iif(":" $ cEmailVld, .F., lRet)
	    lRet := Iif('"' $ cEmailVld, .F., lRet)
	    lRet := Iif('Â°' $ cEmailVld, .F., lRet)
	    lRet := Iif('Âª' $ cEmailVld, .F., lRet)
	    lRet := Iif("," $ cEmailVld, .F., lRet)
	Else
		lRet := .F.
	EndIf
Return lRet