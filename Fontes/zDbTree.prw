//Bibliotecas
#include 'RwMake.ch'
#Include 'TopConn.ch'
#Include 'Ap5Mail.ch'
#Include 'Protheus.ch' 

//Constantes
#Define POS_CARGO   0001
#Define POS_RECNO   0002
#Define POS_RESPOS  0003
#Define POS_STATUS  0004
#Define POS_RECPAI  0005

//Estáticas
Static aRelacao := {}
Static nTamCarg := 6
Static nTamSubC := 3

/*/{Protheus.doc} zDbTree
Histórico de ligações de Clientes
@type function
@author Atilio
@since 09/03/2016
@version 1.0
	@example
	u_zDbTree()
@obs Ter a seguinte estrutura criada:
    Tabela: SZA
    Índices:
        1 - ZA_FILIAL + ZA_CLIENTE + ZA_LOJA + DTOS(ZA_DATA) + ZA_HORA
    Campos:
        ZA_FILIAL - Caracter - Tamanho padrão conforme empresa
        ZA_DATA - Data - Tamanho 8
        ZA_HORA - Caracter - Tamanho 8
        ZA_USER - Caracter - Tamanho 15
        ZA_MEMO - Memo - Tamanho automático
		ZA_STATUS - Caracter - Tamanho 1 - Opções P=Pendente;F=Finalizado;
		ZA_RESPOS - Caracter - Tamanho 26
/*/

User Function zDbTree()
	Local aArea := GetArea()
	Local nJanLarg := 800
	Local nJanAltu := 500
	Private lIncluir, lAlterar, lVisualizar, lExcluir
	Private oBtnInc, oBtnExc, oBtnAlt, oBtnVis, oBtnRes, oBtnFin
	Private cFilCli := FWxFilial("SA1")
	Private cCliente := SA1->A1_COD
	Private cLojaCli := SA1->A1_LOJA
	Private cNomRep := "Teste" //SA1->A1_NOME
	Private oTreePad
	Private oGetObs, cGetObs := ""
	Private lSoAberto := .F.
	
	lSoAberto := MsgYesNo("Deseja trazer somente as interações pendentes?", "Atenção")
	
	DbSelectArea("SZA")
	SZA->(DbSetOrder(1)) //ZA_FILIAL+ZA_CLIENTE+ZA_LOJA+DTOS(ZA_DATA)+ZA_HORA
	
	//Criando a janela
	DEFINE MSDIALOG oDlgRep TITLE "Contatos realizados com o Cliente" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
		
		@ 001, 001 Say "Cliente: "+cCliente+" - "+cNomRep	of oDlgRep Pixel 
		
		//Criando o DbTree
		oTreePad := dbTree():New(011,003,(nJanAltu/2)-79,(nJanLarg/2)-1,oDlgRep,{|| fAtuObs()},,.T.)
		
		//Monta os dados da Tree
		fMntTree()
		
		//Observação
		@ (nJanAltu/2)-76, 003 GROUP oGrpObs TO (nJanAltu/2)-26, (nJanLarg/2-003)-86 PROMPT "Observação: " OF oDlgRep COLOR 0, 16777215 PIXEL
			@ (nJanAltu/2)-70, 006  GET oGetObs    VAR cGetObs  SIZE (nJanLarg/2-003)-86-9, 040 OF oDlgRep MULTILINE COLORS 0, 16777215 HSCROLL PIXEL
			oGetObs:lReadOnly := .T.
			
		//Legenda
		@ (nJanAltu/2)-76, (nJanLarg/2-003)-83 GROUP oGrpLeg TO (nJanAltu/2)-26, (nJanLarg/2)-1 PROMPT "Legenda: " OF oDlgRep COLOR 0, 16777215 PIXEL
			@ (nJanAltu/2)-70, (nJanLarg/2-003)-80 BITMAP oBmpPend SIZE 012, 011 OF oDlgRep FILENAME "FOLDER5"  NOBORDER ADJUST PIXEL
			@ (nJanAltu/2)-57, (nJanLarg/2-003)-80 BITMAP oBmpFina SIZE 012, 011 OF oDlgRep FILENAME "FOLDER14" NOBORDER ADJUST PIXEL
			@ (nJanAltu/2)-67, (nJanLarg/2-003)-62 SAY oSayPend PROMPT "Pendente"       SIZE 040, 007 OF oDlgRep PIXEL
			@ (nJanAltu/2)-54, (nJanLarg/2-003)-62 SAY oSayFina PROMPT "Finalizado"     SIZE 040, 007 OF oDlgRep PIXEL
		
		@ (nJanAltu/2)-23, 3 GROUP oGrpAco TO (nJanAltu/2)-3, (nJanLarg/2)-1 PROMPT "Ações: " OF oDlgRep COLOR 0, 16777215 PIXEL
			//Cria os botões
			@ (nJanAltu/2)-17,(nJanLarg/2-003)-(0042*08) BUTTON "&Incluir"    Size 040, 012 Action fOperacao(3) Object oBtnInc
			@ (nJanAltu/2)-17,(nJanLarg/2-003)-(0042*07) BUTTON "&Alterar"    Size 040, 012 Action fOperacao(4) Object oBtnAlt
			@ (nJanAltu/2)-17,(nJanLarg/2-003)-(0042*06) BUTTON "&Visualizar" Size 040, 012 Action fOperacao(2) Object oBtnVis
			@ (nJanAltu/2)-17,(nJanLarg/2-003)-(0042*05) BUTTON "&Excluir"    Size 040, 012 Action fOperacao(5) Object oBtnExc
			@ (nJanAltu/2)-17,(nJanLarg/2-003)-(0042*04) BUTTON "&Responder"  Size 040, 012 Action fOperacao(6) Object oBtnRes
			@ (nJanAltu/2)-17,(nJanLarg/2-003)-(0042*03) BUTTON "&Finalizar"  Size 040, 012 Action fFinaliza()  Object oBtnFin
			@ (nJanAltu/2)-17,(nJanLarg/2-003)-(0042*01) BUTTON "&Sair"       Size 040, 012 Action (oDlgRep:End()) Object oBtnSai
		
		fMostBtn(lIncluir, lAlterar, lVisualizar ,lExcluir)
		
	ACTIVATE MSDIALOG oDlgRep CENTERED
	
	RestArea(aArea)
Return

Static Function fMostBtn(lI,lA,lV,lE)
                  
	oBtnInc:lVisible := lI
	oBtnAlt:lVisible := lA
	oBtnVis:lVisible := lV
	oBtnExc:lVisible := lE
	
	If !lA
		oBtnRes:lVisible := .F.
		oBtnFin:lVisible := .F.
	EndIf
	
Return

Static Function fOperacao(nOpc)
	Local aArea := GetArea()
	Private dDataLig, cHoraLig
	Private cUser, cObs, cStatus, cRespos
	Private oDlgOper
	
	//Se for inclusão ou resposta
	If nOpc == 3 .Or. nOpc == 6
		
		dDataLig		:= dDataBase
		cHoraLig		:= Time()
		cUser			:= Alltrim(cUserName)
		cObs			:= ""
		cStatus			:= "P"
		
		//Se for inclusão, apenas preenche em resposta de, em branco
		If nOpc == 3
			cRespos := ""
			
		//Senão, preenche a resposta
		ElseIf nOpc == 6
			cCargo := oTreePad:GetCargo()
			nEncont := aScan(aRelacao,{|x| x[POS_CARGO] == cCargo })
		
			cRespos := aRelacao[nEncont][POS_RESPOS]
			
			//Se tiver finalizado, não permite responder
			If aRelacao[nEncont][POS_STATUS] == 'F'
				MsgAlert("Interação já finalizada, não é possível responder!", "Atenção")
				Return
			EndIf
		EndIf
		
	//Senão, preenche as variáveis
	Else
		
		cCargo := oTreePad:GetCargo()
		nEncont := aScan(aRelacao,{|x| x[POS_CARGO] == cCargo })
		SZA->(DbGoTo(aRelacao[nEncont][POS_RECNO]))
		
		//Preenchendo os campos
		dDataLig	:= SZA->ZA_DATA
		cHoraLig	:= SZA->ZA_HORA
		cUser		:= SZA->ZA_USER
		cObs		:= SZA->ZA_MEMO
		cStatus		:= SZA->ZA_STATUS
		cRespos		:= SZA->ZA_RESPOS
	EndIf
	
	//Criando a janela
	DEFINE MSDIALOG oDlgOper TITLE "Ligação" FROM 000, 000  TO 330, 550 COLORS 0, 16777215 PIXEL
		//Labels
		@ 007, 005  SAY oSayData PROMPT "Data:"       SIZE 040, 007 OF oDlgOper PIXEL
		@ 020, 005  SAY oSayHora PROMPT "Hora:"       SIZE 040, 007 OF oDlgOper PIXEL
		@ 033, 005  SAY oSayUser PROMPT "Usuário:"    SIZE 040, 007 OF oDlgOper PIXEL
		If nOpc == 3
			@ 085, 005  SAY oSayStat PROMPT "Status:"     SIZE 040, 007 OF oDlgOper PIXEL
		EndIf
		@ 098, 005  SAY oSayObse PROMPT "Observação:" SIZE 040, 007 OF oDlgOper PIXEL
		
		//Gets e Componentes
		@ 007, 040  MSGET      oDataLig    VAR dDataLig    SIZE 040, 010 OF oDlgOper           COLORS 0, 16777215         PIXEL
		@ 020, 040  MSGET      oHoraLig    VAR cHoraLig    SIZE 040, 010 OF oDlgOper           COLORS 0, 16777215         PIXEL
		@ 033, 040  MSGET      oUser       VAR cUser       SIZE 040, 010 OF oDlgOper           COLORS 0, 16777215         PIXEL
		If nOpc == 3
			@ 085, 040  MSCOMBOBOX oStatus     VAR cStatus ITEMS StrTokArr(GetSX3Cache('ZA_STATUS', 'X3_CBOX'), ';') SIZE 060, 010 OF oDlgOper COLORS 0, 16777215 PIXEL
		EndIf
		@ 098, 040  GET        oMemoObs    VAR cObs        SIZE 230, 050 OF oDlgOper MULTILINE COLORS 0, 16777215 HSCROLL PIXEL		

		//Botões
		@ 150, 173 BUTTON oBtnConf PROMPT "Confirmar" SIZE 048, 010 OF oDlgOper ACTION( Processa( {|| fConfirm(nOpc) } , "Processando...","Aguarde...", .T. ) ) PIXEL
		@ 150, 223 BUTTON oBtnCanc PROMPT "Cancelar"  SIZE 048, 010 OF oDlgOper ACTION(oDlgOper:End())                                                  PIXEL
		
		//Se for visualização ou exclusão
		If nOpc == 2 .Or. nOpc == 5
			oDataLig:lReadOnly	:= .T.
			oHoraLig:lReadOnly	:= .T.
			oUser:lReadOnly		:= .T.
			oMemoObs:lReadOnly	:= .T.
			
		//Senão, libera os campos
		Else
			oDataLig:lReadOnly	:= .F.
			oHoraLig:lReadOnly	:= .F.
			oUser:lReadOnly		:= .F.
			oMemoObs:lReadOnly	:= .F.
			
			//Se for alteração, bloqueia campos chave
			If nOpc == 4
				oDataLig:lReadOnly	:= .T.
				oHoraLig:lReadOnly	:= .T.
				oUser:lReadOnly		:= .T.
			EndIf
		EndIf
	ACTIVATE MSDIALOG oDlgOper CENTERED
	
	RestArea(aArea)
Return

Static Function fConfirm(nOpcao)
	
	//Se for visualização
	If nOpcao == 2
		oDlgOper:End()
	
	//Se for inclusão ou resposta
	ElseIf nOpcao == 3 .Or. nOpcao == 6 
		//Data em branco
		If Empty(dDataLig)
			MsgAlert("Informe a data da ligação!", "Atenção")
			oDataLig:SetFocus()
			Return
		EndIf

		//Hora em branco
		If Empty(cHoraLig)
			MsgAlert("Informe a hora da ligação!", "Atenção")
			oHoraLig:SetFocus()
			Return
		EndIf

		//Usuário em branco
		If Empty(cUser)
			MsgAlert("Informe o usuário que manteve o contato!", "Atenção")
			oUser:SetFocus()
			Return
		EndIf

		//Observaão em branco
		If Empty(cObs)
			MsgAlert("Informe o motivo e/ou observação da ligação!", "Atenção")
			oMemoObs:SetFocus()
			Return
		EndIf

		//Se conseguir posicionar, registro já existe
		If SZA->(DbSeek(cFilCli+cCliente+dToS(dDataLig)+cHoraLig))
		   MsgAlert("Já existe ligação registrada pra esse Cliente, nessa data e hora.", "Atenção")
		   Return
		   
		Else
			RecLock("SZA", .T.)
				ZA_FILIAL	:= cFilCli
				ZA_CLIENTE	:= cCliente
				ZA_LOJA	:= cLojaCli
				ZA_DATA	:= dDataLig
				ZA_HORA	:= cHoraLig
				ZA_USER	:= cUser
				ZA_MEMO	:= cObs
				ZA_STATUS	:= cStatus
				ZA_RESPOS	:= cRespos
			SZA->(MsUnlock())
		Endif
		
		oDlgOper:End()
		
	//Se for alteração
	ElseIf nOpcao == 4
		RecLock("SZA",.F.)
			ZA_STATUS	:= cStatus
			ZA_MEMO	:= cObs
		SZA->(MsUnLock())
		
		oDlgOper:End()
	
	//Se for exclusão
	ElseIf nOpcao == 5
		cCargo := oTreePad:GetCargo()
		nEncont := 0
	
		//Se tiver cargo
		If !Empty(cCargo)
			nEncont := aScan(aRelacao,{|x| x[POS_CARGO] == cCargo })
		
			//Se conseguir encontrar o registro
			If nEncont > 0
				//Se o recno do registro for o mesmo do pai, é uma interação, não uma resposta
				If aRelacao[nEncont][POS_RECNO] == aRelacao[nEncont][POS_RECPAI]
					//Pergunta se deseja realmente prosseguir com a exclusão
					If MsgYesNo("Essa interação pode possuir resposta(s), se prosseguir elas também serão excluídas.<br>Deseja continuar?", "Atenção")
						RecLock("SZA", .F.)
							SZA->(DbDelete())
						SZA->(MsUnLock())
						
						//Seleciona todas as respostas da interação
						cQryRes := " SELECT "
						cQryRes += " 	ZA.R_E_C_N_O_ AS ZAREC "
						cQryRes += " FROM "
						cQryRes += " 	"+RetSqlName("SZA")+" ZA WITH (NOLOCK) "
						cQryRes += " WHERE "
						cQryRes += " 	ZA_FILIAL = '" + cFilCli + "'"
						cQryRes += " 	AND ZA_CLIENTE = '" + cCliente + "'"
						cQryRes += " 	AND ZA_LOJA = '" + cLojaCli + "'"
						cQryRes += " 	AND ZA_RESPOS = '" + aRelacao[nEncont][POS_RESPOS] + "' "
						cQryRes += " 	AND ZA.D_E_L_E_T_ = ' '"
						cQryRes += " ORDER BY "
						cQryRes += " 	ZA_DATA DESC, ZA_HORA DESC"
						TCQuery cQryRes New Alias "QRY_RES"
						
						//Enquanto houver registros
						While ! QRY_RES->(EoF())
							SZA->(DbGoTo(QRY_RES->ZAREC))
							
							RecLock('SZA', .F.)
								SZA->(DbDelete())
							SZA->(MsUnlock())
							
							QRY_RES->(DbSkip())
						EndDo
						
						QRY_RES->(DbCloseArea())
					EndIf
					
				Else
					//Se tiver finalizado
					If SZA->ZA_STATUS == 'F'
						If ! MsgYesNo("Essa resposta já está finalizada, deseja prosseguir com a exclusão?", "Atenção")
							Return
						EndIf
					EndIf
					
					RecLock("SZA", .F.)
						SZA->(DbDelete())
					SZA->(MsUnLock())
				EndIf
			EndIf
		EndIf
		
		oDlgOper:End()
	EndIf
	
	//Se não for visualização, chama rotinas para atualizar o acols
	If nOpcao != 2
		fMntTree()
		fMostBtn(lIncluir, lAlterar, lVisualizar, lExcluir)
	EndIf
	
Return

Static Function fMntTree()
	Local aArea := GetArea()
	Local nRaiz := 1
	Local nItem := 0
	Local cCargoAtu := ""
	Local cSubCargo := ""
	Local cFolder01 := ""
	Local cFolder02 := ""
	Local cResposta := ""
	
	DbSelectArea("SZA")
	SZA->(DbSetOrder(1)) // Filial + Cliente + Data + Hora
	SZA->(DbGoTop())
	
	//Zerando variáveis
	lIncluir    := .T.
	lAlterar    := .T.
	lVisualizar := .T.
	lExcluir    := .T.
	
	//Retirando todos os nós
	oTreePad:Reset()
	aRelacao := {}
	
	//Se conseguir posicionar na filial e Cliente
	If SZA->(DbSeek(cFilCli+cCliente))
		
		//Monta uma consulta para pegar todos os dados
		cQuery := " SELECT "
		cQuery += " 	*, ZA.R_E_C_N_O_ AS ZAREC "
		cQuery += " FROM "
		cQuery += " 	"+RetSqlName("SZA")+" ZA WITH (NOLOCK) "
		cQuery += " WHERE "
		cQuery += " 	ZA_FILIAL = '" + cFilCli + "'"
		cQuery += " 	AND ZA_CLIENTE = '" + cCliente + "'"
		cQuery += " 	AND ZA_LOJA = '" + cLojaCli + "'"
		cQuery += " 	AND ZA_RESPOS = ' ' "
		cQuery += " 	AND ZA.D_E_L_E_T_ = ' '"
		If lSoAberto
			cQuery += " 	AND ZA_STATUS != 'F' "
		EndIf
		cQuery += " ORDER BY "
		cQuery += " 	ZA_DATA DESC, ZA_HORA DESC"
		TCQuery cQuery New Alias "QSZA"
		TcSetField("QSZA","ZA_DATA","D")
		
		//Se tiver dados atualiza a observação conforme o primeiro registro
		If !QSZA->(EoF())
			SZA->(DbGoTo(QSZA->ZAREC))
			cGetObs := SZA->ZA_MEMO
			
			//Enquanto houver registros, adiciona no TREE
			While !QSZA->(EoF())
				nItem := 0
				cCargoAtu := StrZero(nRaiz, nTamCarg)
				cSubCargo := StrZero(nItem, nTamSubC)
				cResposta := FWxFilial('SZA') + QSZA->ZA_CLIENTE + QSZA->ZA_LOJA + dToS(QSZA->ZA_DATA) + QSZA->ZA_HORA
				
				//Se for pendente, a pasta será amarela
				If QSZA->ZA_STATUS == 'P'
					cFolder01 := 'FOLDER5'
					cFolder02 := 'FOLDER6'
					
				//Senão, será preta
				Else
					cFolder01 := 'FOLDER14'
					cFolder02 := 'FOLDER15'
				EndIf
				
				
				//Cria a pasta da ligação para o Cliente
				oTreePad:AddTree("Interação - Data: "+dToC(QSZA->ZA_DATA)+", Hora: "+QSZA->ZA_HORA+", Por: "+QSZA->ZA_USER+Space(50), .T., cFolder01, cFolder02, , , cCargoAtu+"."+cSubCargo)
				aAdd(aRelacao, {cCargoAtu+"."+cSubCargo, QSZA->ZAREC, cResposta, QSZA->ZA_STATUS, QSZA->ZAREC})
					
				//Seleciona todas as respostas da interação
				cQryRes := " SELECT "
				cQryRes += " 	*, ZA.R_E_C_N_O_ AS ZAREC "
				cQryRes += " FROM "
				cQryRes += " 	"+RetSqlName("SZA")+" ZA WITH (NOLOCK) "
				cQryRes += " WHERE "
				cQryRes += " 	ZA_FILIAL = '" + cFilCli + "'"
				cQryRes += " 	AND ZA_CLIENTE = '" + cCliente + "'"
				cQryRes += " 	AND ZA_LOJA = '" + cLojaCli + "'"
				cQryRes += " 	AND ZA_RESPOS = '" + cResposta + "' "
				cQryRes += " 	AND ZA.D_E_L_E_T_ = ' '"
				cQryRes += " ORDER BY "
				cQryRes += " 	ZA_DATA DESC, ZA_HORA DESC"
				TCQuery cQryRes New Alias "QRY_RES"
				TcSetField("QRY_RES","ZA_DATA","D")
				nItem++
				
				//Enquanto houver respostas
				While ! QRY_RES->(EoF())
					
					cSubCargo := StrZero(nItem, nTamSubC)
					oTreePad:AddTreeItem("Resposta - Data: "+dToC(QRY_RES->ZA_DATA)+", Hora: "+QRY_RES->ZA_HORA+", Por: "+QRY_RES->ZA_USER+Space(50), "", , cCargoAtu+"."+cSubCargo)
					aAdd(aRelacao, {cCargoAtu+"."+cSubCargo, QRY_RES->ZAREC, cResposta, QSZA->ZA_STATUS, QSZA->ZAREC})
					
					nItem++
					QRY_RES->(DbSkip())
				EndDo
				QRY_RES->(DbCloseArea())
				
				oTreePad:EndTree()
				nRaiz++
				QSZA->(DbSkip())	
			EndDo
			
			
		Else
			lIncluir := .T.
			lAlterar := .F.
			lVisualizar := .F.
			lExcluir := .F.
		EndIf
		
		QSZA->(DbCloseArea())
	Else
		lIncluir := .T.
		lAlterar := .F.
		lVisualizar := .F.
		lExcluir := .F.
	EndIf
	
	oTreePad:Refresh()
	RestArea(aArea)
Return

Static Function fFinaliza()
	Local aArea := GetArea()
	Local cCargo := oTreePad:GetCargo()
	Local nEncont := 0

	If MsgYesNo("Deseja finalizar a interação?", "Atenção")
		//Se tiver cargo
		If !Empty(cCargo)
			nEncont := aScan(aRelacao,{|x| x[POS_CARGO] == cCargo })
		
			//Se conseguir encontrar o registro
			If nEncont > 0
				//Posiciona no registro pai
				SZA->(DbGoTo(aRelacao[nEncont][POS_RECPAI]))
				
				//Esta interação já está finalizada
				If SZA->ZA_STATUS == 'F'
					MsgAlert("Essa interação já está finalizada!", "Atenção")
					
				//Senão, finaliza a interação, e das respostas
				Else
					RecLock('SZA', .F.)
						ZA_STATUS := 'F'
					SZA->(MsUnlock())
					
					//Seleciona todas as respostas da interação
					cQryRes := " SELECT "
					cQryRes += " 	ZA.R_E_C_N_O_ AS ZAREC "
					cQryRes += " FROM "
					cQryRes += " 	"+RetSqlName("SZA")+" ZA WITH (NOLOCK) "
					cQryRes += " WHERE "
					cQryRes += " 	ZA_FILIAL = '" + cFilCli + "'"
					cQryRes += " 	AND ZA_CLIENTE = '" + cCliente + "'"
					cQryRes += " 	AND ZA_LOJA = '" + cLojaCli + "'"
					cQryRes += " 	AND ZA_RESPOS = '" + aRelacao[nEncont][POS_RESPOS] + "' "
					cQryRes += " 	AND ZA.D_E_L_E_T_ = ' '"
					cQryRes += " ORDER BY "
					cQryRes += " 	ZA_DATA DESC, ZA_HORA DESC"
					TCQuery cQryRes New Alias "QRY_RES"
					
					//Enquanto houver registros
					While ! QRY_RES->(EoF())
						SZA->(DbGoTo(QRY_RES->ZAREC))
						
						RecLock('SZA', .F.)
							ZA_STATUS := 'F'
						SZA->(MsUnlock())
						
						QRY_RES->(DbSkip())
					EndDo
					
					QRY_RES->(DbCloseArea())
					
					MsgInfo("Interação Finalizada!", "Atenção")
					fMntTree()
				EndIf
			EndIf
		EndIf
	EndIf
	
	RestArea(aArea)
Return

Static Function fAtuObs()
	Local aArea := GetArea()
	Local cCargo := oTreePad:GetCargo()
	Local nEncont := 0
	
	cGetObs := ""
	
	//Se tiver cargo
	If !Empty(cCargo)
		nEncont := aScan(aRelacao,{|x| x[1] == cCargo })
	
		//Se conseguir encontrar o registro
		If nEncont > 0
			//Posiciona no registro
			SZA->(DbGoTo(aRelacao[nEncont][POS_RECNO]))
			
			cGetObs := SZA->ZA_MEMO
		EndIf
	EndIf
	
	oGetObs:Refresh()
	RestArea(aArea)
Return