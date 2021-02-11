/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2016/11/22/funcao-migra-varias-tabelas-de-uma-base-para-outra-em-advpl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} zAppend
Função de Append em bloco de uma base para outra
@type function
@author Atilio
@since 16/08/2016
@version 1.0
	@example
	u_zAppend()
	@obs Feito conforme lógica e ajuda de Marcos Guaraná
/*/

User Function zAppend()
	Local aArea       := GetArea()
	Local   cPerg     := PadR("X_ZAPPEND", 10)
	Private cDBOrigem := ""
	Private cTabDe    := ""
	Private cTabAt    := ""
	
	//Cria as perguntas
	fValidPerg(cPerg)
	
	//Se a pergunta for confirmada (com o schema de origem, ex.: P11)
	If Pergunte(cPerg, .T.)
		cDbOrigem := MV_PAR01
		cTabDe    := MV_PAR02
		cTabAt    := MV_PAR03
		
		//Chama a rotina de cópia
		If !Empty(cDbOrigem)
			Processa({|| fAtualiza()}, "Processando...")
		EndIf
	EndIf
	
	RestArea(aArea)
Return
		
/*---------------------------------------------------------------------*
 | Func:  fAtualiza                                                    |
 | Autor: Daniel Atilio                                                |
 | Data:  16/08/2016                                                   |
 | Desc:  Função que atualiza os dados do Destino conforme a Origem    |
 *---------------------------------------------------------------------*/
		
Static Function fAtualiza()
	Local cQry    := ""
	Local cQryDad := ""
	Local nTotal  := 0
	Local nAtual  := 0
	Local nAux    := 0
	Local cBase   := cDbOrigem
	Local cAliAtu := ""
	Local cSQL    := ""
	Local cLogErr := ""
	Local nErr    := 0
	Local aEstrut := {}
	
	//Faz consulta das tabelas que tem dados
	cQry += " SELECT "
	cQry += "     esquemas.Name AS Esquema_Nome, "
	cQry += "     tabelas.NAME AS Tabela_Nome, "
	cQry += "     particoes.rows AS Numero_Linhas, "
	cQry += "     SUM(alocacao.total_pages) * 8 AS Espaco_KB_Total,  "
	cQry += "     SUM(alocacao.used_pages) * 8 AS Espaco_KB_Usado,  "
	cQry += "     (SUM(alocacao.total_pages) - SUM(alocacao.used_pages)) * 8 AS Espaco_KB_Sem_Uso " 
	cQry += " FROM "
	cQry += "     "+cBase+".sys.tables tabelas "
	cQry += "     INNER JOIN "+cBase+".sys.schemas esquemas ON ( "
	cQry += "         esquemas.schema_id = tabelas.schema_id "
	cQry += "     ) "
	cQry += "     INNER JOIN "+cBase+".sys.indexes indices ON ( "
	cQry += "         tabelas.OBJECT_ID = indices.object_id "
	cQry += "     ) "
	cQry += "     INNER JOIN "+cBase+".sys.partitions particoes ON ( "
	cQry += "         indices.object_id = particoes.OBJECT_ID  "
	cQry += "         AND indices.index_id = particoes.index_id "
	cQry += "     ) "
	cQry += "     INNER JOIN "+cBase+".sys.allocation_units alocacao ON ( "
	cQry += "         particoes.partition_id = alocacao.container_id "
	cQry += "     ) "
 
	//Filtra somentes tabelas, filtra somente as criadas por usuário
	cQry += " WHERE "
	cQry += "     tabelas.NAME NOT LIKE 'dt%' "
	cQry += "     AND tabelas.is_ms_shipped = 0 "
	cQry += "     AND indices.OBJECT_ID > 255  "
	cQry += "     AND alocacao.used_pages != 0 "
	cQry += "     AND tabelas.NAME >= '"+cTabDe+cEmpAnt+"0' "
	cQry += "     AND tabelas.NAME <= '"+cTabAt+cEmpAnt+"0' "
 
	//Agrupando pela Tabela, Esquema e Número de linhas
	cQry += " GROUP BY "
	cQry += "     tabelas.Name, esquemas.Name, particoes.Rows "
 
	//Ordenando pelo esquema, seguido pelas tabelas
	cQry += " ORDER BY "
	cQry += "     Esquema_Nome, Tabela_Nome "
	
	TCQuery cQry New Alias "QRY_ORI"
	Count To nTotal
	nAtual := 0
	ProcRegua(nTotal)
	
	Begin Transaction
		//Enquanto houver dados na query
		QRY_ORI->(DbGoTop())
		While ! QRY_ORI->(EoF())
			nAtual++
			cAliAtu := SubStr(QRY_ORI->Tabela_Nome, 1, 3)
			DbSelectArea(cAliAtu)
			aEstrut := (cAliAtu)->(DbStruct())
			IncProc("Processando "+cAliAtu+" ("+cValToChar(nAtual)+" de "+cValToChar(nTotal)+")...")
			
			//Deleta tudo que existe na tabela destino
			cSQL := "DELETE FROM "+RetSQLName(cAliAtu)+" "
			nErr := TcSqlExec(cSQL)
			
			//Se houve Erro
			If nErr != 0
				cLogErr += "- Tabela "+cAliAtu+Chr(13)+Chr(10)
				
			Else
				//Seleciona os dados da origem
				cQryDad := " SELECT "
				cQryDad += "     * "
				cQryDad += " FROM "
				cQryDad += "     "+cBase+"."+QRY_ORI->Esquema_Nome+"."+QRY_ORI->Tabela_Nome+" TAB "
				cQryDad += " WHERE "
				cQryDad += "     TAB.D_E_L_E_T_ = ' ' "
				TCQuery cQryDad New Alias "QRY_DAD"
				For nAux := 1 To Len(aEstrut)
					If aEstrut[nAux][2] == 'D'
						TCSetField("QRY_DAD", aEstrut[nAux][1], aEstrut[nAux][2])
					EndIf
				Next
				
				//Enquanto houver dados
				While !QRY_DAD->(EoF())
					//Faz reclock no destino
					RecLock(cAliAtu, .T.)
						//Percorre a SX3 do destino, e puxa os dados da origem
						For nAux := 1 To Len(aEstrut)
							If QRY_DAD->(FieldPos(aEstrut[nAux][1])) > 0 .And. (cAliAtu)->(FieldPos(aEstrut[nAux][1])) > 0
								&(aEstrut[nAux][1]) := &("QRY_DAD->"+aEstrut[nAux][1])
							EndIf
						Next
					(cAliAtu)->(MsUnlock())
					
					QRY_DAD->(DbSkip())
				EndDo
				QRY_DAD->(DbCloseArea())
			EndIf
			
			QRY_ORI->(DbSkip())
		EndDo
		QRY_ORI->(DbCloseArea())
	End Transaction
	
	//Se houve erro
	If !Empty(cLogErr)
		Aviso('Atenção', "Houveram erros nas tabelas: "+Chr(13)+Chr(10)+cLogErr, {'Ok'}, 03)
		
	Else
		MsgInfo("Processo terminado!", "Atenção")
	EndIf
Return

/*---------------------------------------------------------------------*
 | Func:  fValidPerg                                                   |
 | Autor: Daniel Atilio                                                |
 | Data:  16/08/2016                                                   |
 | Desc:  Função para criação do grupo de perguntas                    |
 *---------------------------------------------------------------------*/

Static Function fValidPerg(cPerg)
	//(		cGrupo,	cOrdem,	cPergunt,						cPergSpa,		cPergEng,	cVar,		cTipo,	nTamanho,		nDecimal,	nPreSel,	cGSC,	cValid,	cF3,	cGrpSXG,	cPyme,	cVar01,		cDef01,	cDefSpa1,	cDefEng1,	cCnt01,	cDef02,					cDefSpa2,	cDefEng2,	cDef03,						cDefSpa3,		cDefEng3,	cDef04,	cDefSpa4,	cDefEng4,	cDef05,	cDefSpa5,	cDefEng5,	aHelpPor,	aHelpEng,	aHelpSpa,	cHelp)
	PutSx1(cPerg,		"01",		"Base de Dados Origem?",		"",				"",			"mv_ch0",	"C",	060,			0,			0,			"G",	"", 		"",		"",			"",		"mv_par01",	"",			"",			"",			"",			"",							"",			"",			"",								"",				"",			"",			"",			"",			"",			"",			"",			{},			{},			{},			"")
	PutSx1(cPerg,		"02",		"Alias De?",					"",				"",			"mv_ch1",	"C",	003,			0,			0,			"G",	"", 		"",		"",			"",		"mv_par02",	"",			"",			"",			"",			"",							"",			"",			"",								"",				"",			"",			"",			"",			"",			"",			"",			{},			{},			{},			"")
	PutSx1(cPerg,		"03",		"Alias Até?",					"",				"",			"mv_ch2",	"C",	003,			0,			0,			"G",	"", 		"",		"",			"",		"mv_par03",	"",			"",			"",			"",			"",							"",			"",			"",								"",				"",			"",			"",			"",			"",			"",			"",			{},			{},			{},			"")
Return