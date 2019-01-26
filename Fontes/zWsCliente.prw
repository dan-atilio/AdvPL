//Bibliotecas
#Include "Protheus.ch"
#Include "APWebSrv.ch"
#Include "TBIConn.ch"
#Include "TBICode.ch"
#Include "TopConn.ch"
#Include "aarray.ch"
#Include "json.ch"
#Include "shash.ch"

/*
	Links de acesso
	Interno - http://192.168.XXX.XXX:8091/ws/
	Externo - http://177.87.XXX.XXX:8091/ws/
	
	WSDL Interno - http://192.168.XXX.XXX:8091/ws/zWsCliente.apw?WSDL
	WSDL Externo - http://177.87.XXX.XXX:8091/ws/zWsCliente.apw?WSDL
*/

WsService zWsCliente Description "WebService com funcoes de teste"
	//Atributos
	WsData   cTstRece  as String
	WsData   cTstSend  as String
	WsData   cFiltRece as String
	WsData   cFiltSend as String

	//Métodos
	WsMethod TstServ       Description "Metodo para testar se servico esta em funcionamento"
	WsMethod RetListCli    Description "Metodo para retornar uma lista de clientes filtrando informacoes"
EndWsService

/*
	Método TstServ
	Metodo para testar se servico esta em funcionamento
*/

WsMethod TstServ WsReceive cTstRece WsSend cTstSend WsService zWsCliente
	::cTstSend := "It's Works - Date " + dToC(Date()) + ", Time "+Time()
Return .T.


/*
	Método RetListCli
	Metodo para retornar uma lista de clientes filtrando informacoes
	
	Exemplo do JSON que será recebido
	{
		"Dados": {
			"Vendedor": "000000",
			"Estado": "SP",
			"Cidado": "Bauru"
    	},
    	"Token" : "aaaa"
	}
	
	Exemplo de JSON que será enviado de volta (se tudo estiver certo)
	{
		"Clientes": {
			"000001" : {
				"Codigo":"XXXXXX",
				"RazaoSocial":"Beluga Corp",
				"NomeFantasia":"Beluga",
				"CGC":"00.000.000/0000-00"
			},
			"000002" : {
				"Codigo":"YYYYYY",
				"RazaoSocial":"Beluga 2 Corp",
				"NomeFantasia":"Beluga 2",
				"CGC":"00.000.000/0000-00"
			},
			...
    	}
	}
*/

WsMethod RetListCli WsReceive cFiltRece WsSend cFiltSend WsService zWsCliente
	//Retorno do Método RetListCli (.T. se está tudo certo ou .F. se houve falha)
	Local lRet       := .T.
	
	//Variável de Token pegando da tabela SX6
	Local cTokWs     := Alltrim(GetMV('MV_X_TOKEN'))
	
	//Parâmetros recebidos pelo JSON (variável cFiltRece)
	Local cParVend   := ""
	Local cParEst    := ""
	Local cParMun    := ""
	Local cParToken  := ""
	
	//Consulta SQL para filtragem dos dados e variáveis usadas
	Local cQryCli    := ""
	Local nAtual     := 0
	Local cCGC       := ""
	
	//Variáveis usadas para transformar o JSON em Objeto
	Private oJSON    := Nil
	Private oDados   := Nil
	
	
	//Deserializando o JSON (transformando a "string" em "objeto")
	If (FWJsonDeserialize(::cFiltRece, @oJSON))
	
		//Separando o objeto de dados, e o Token
		oDados     := oJSON:Dados
		cParToken  := Iif(Type("oJSON:Token") != "U", oJSON:Token, "")
		
		//Se o Token recebido for o mesmo do parâmetro, prossegue
		If cParToken == cTokWs
			
			//Pegando os 3 filtros possíveis vindo dentro de "Dados"
			cParVend   := Upper(Alltrim(Iif(Type("oDados:Vendedor") != "U", oDados:Vendedor, "")))
			cParEst    := Upper(Alltrim(Iif(Type("oDados:Estado")   != "U", oDados:Estado,   "")))
			cParMun    := Upper(Alltrim(Iif(Type("oDados:Cidade")   != "U", oDados:Cidade,   "")))
			
			//Se os 3 parâmetros estiverem em branco, retorna erro, só pode prosseguir se pelo menos 1 estiver preenchido
			If Empty(cParVend) .And. Empty(cParEst) .And. Empty(cParMun)
				SetSoapFault('Erro', 'Os 3 parametros estao em branco, preencha pelo menos 1!')
				lRet := .F.
				
			Else
			
				//Selecionando os clientes conforme o filtro
				cQryCli := " SELECT "                                                  + CRLF
				cQryCli += "     A1_COD, "                                             + CRLF
				cQryCli += "     A1_NOME, "                                            + CRLF
				cQryCli += "     A1_NREDUZ, "                                          + CRLF
				cQryCli += "     A1_CGC "                                              + CRLF
				cQryCli += " FROM "                                                    + CRLF
				cQryCli += "     " + RetSQLName('SA1') + " SA1 "                       + CRLF
				cQryCli += " WHERE "                                                   + CRLF
				cQryCli += "     A1_FILIAL = '" + FWxFilial('SA1') + "' "              + CRLF
				If ! Empty(cParVend)
					cQryCli += "     AND UPPER(A1_VEND) LIKE '%" + cParVend + "%' "    + CRLF
				EndIf
				If ! Empty(cParEst)
					cQryCli += "     AND UPPER(A1_EST)  LIKE '%" + cParEst  + "%' "    + CRLF
				EndIf
				If ! Empty(cParMun)
					cQryCli += "     AND UPPER(A1_MUN)  LIKE '%" + cParMun  + "%' "    + CRLF
				EndIf
				cQryCli += "     AND SA1.D_E_L_E_T_ = ' ' "                            + CRLF
				TCQuery cQryCli New Alias "QRY_CLI"
				
				//Se existirem dados da consulta
				If ! QRY_CLI->(EoF())	
				
					//Começa a montar o JSON de retorno
					::cFiltSend += ' { '                  + CRLF
					::cFiltSend += '  "Clientes" : { '    + CRLF
					
					//Enquanto houver clientes
					While ! QRY_CLI->(EoF())
						//Incrementa o contador
						nAtual++
						
						//Transformando o CNPJ ou CPF para visualização
						cCGC := Alltrim(QRY_CLI->A1_CGC)
						If Len(Alltrim(SA2->A2_CGC)) > 11
							cCGC := Alltrim(Transform(cCGC, "@R 99.999.999/9999-99"))
						Else
							cCGC := Alltrim(Transform(cCGC, "@R 999.999.999-99"))
						EndIf
						
						//Monta o cliente atual
						::cFiltSend +=           '   "' + StrZero(nAtual, 6) + '": { '                           + CRLF
						::cFiltSend +=           '     "Codigo":"'       + QRY_CLI->A1_COD             + '", '   + CRLF
						::cFiltSend +=           '     "RazaoSocial":"'  + Alltrim(QRY_CLI->A1_NOME)   + '", '   + CRLF
						::cFiltSend +=           '     "NomeFantasia":"' + Alltrim(QRY_CLI->A1_NREDUZ) + '", '   + CRLF
						::cFiltSend +=           '     "CGC":"'          + cCGC                        + '"'     + CRLF
						::cFiltSend +=           '   }'
						
						//Pula para o próximo cliente
						QRY_CLI->(DbSkip())
						
						//Se não for o último cliente, acrescenta a vírgula
						If ! QRY_CLI->(EoF())
							::cFiltSend += ','
						EndIf
						::cFiltSend += CRLF
					EndDo
					::cFiltSend += '  } '     + CRLF
					::cFiltSend += ' }'       + CRLF
					
				//Se não existirem clientes, retorna mensagem de falha
				Else
					SetSoapFault('Erro', 'Nao existem clientes nesse filtro usado!')
					lRet := .F.
				EndIf
				QRY_CLI->(DbCloseArea())
			EndIf
			
		//Caso seja um token inválido
		Else
			SetSoapFault('Erro', 'Token invalido!')
			lRet := .F.
		EndIf
		
	//Se houve erro ao deserializar o JSON
	Else
		SetSoapFault('Erro', 'JSON nao deserializado!')
		lRet := .F.
	EndIf

Return lRet