//Bibliotecas
#Include "Protheus.ch"
#Include "TopConn.ch"

//Constantes
#Define STR_PULA		Chr(13)+Chr(10)

//Variáveis estáticas
Static cDirLog := "\x_logsb6\"

/*/{Protheus.doc} zImpSB6
Função para importar saldos de poder de/em terceiros
@author Atilio
@since 28/08/2015
@version 1.0
	@example
	u_zImpSB6()
/*/

User Function zImpSB6()
	Local cMsgAux := ""
	Local aArea := GetArea()
	Local aAreaB6 := SB6->(GetArea())
	//Dimensões da janela
	Local nJanAltu := 180
	Local nJanLarg := 650
	//Objetos da tela
	Local oGrpPar
	Local oGrpAco
	Local oBtnSair
	Local oBtnImp
	Local oBtnRela
	Local oBtnArq
	Private oSayArq, oGetArq, cGetArq := Space(99)
	Private oSayTes, oGetTes, cGetTes := Space(TamSX3('F4_CODIGO')[01])
	Private oSaySer, oGetSer, cGetSer := Space(TamSX3('F2_SERIE')[01])
	Private oDlgPvt
	
	//Mostrando mensagem de atenção ao usar a rotina
	cMsgAux := "<h1>Cuidado!</h1><br>"
	cMsgAux += "Rotina para importação de Poder de/em Terceiros, será<br>"
	cMsgAux += "executado apenas a importação das NFs.<br>"
	cMsgAux += "Após a importação, rode o refaz saldos Poder Terceiro!<br>"
	MsgAlert(cMsgAux, "Atenção")
	
	//Se não existir o diretório de logs, gera
	If !ExistDir(cDirLog)
		MakeDir(cDirLog)
	EndIf
	
	//Criando a janela
	DEFINE MSDIALOG oDlgPvt TITLE "zImpSB6 - Importação Poder de/em Terceiros" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
		//Grupo Parâmetros
		@ 003, 003 	GROUP oGrpPar TO 060, (nJanLarg/2) 	PROMPT "Parâmetros: " 		OF oDlgPvt COLOR 0, 16777215 PIXEL
			//Caminho do arquivo
			@ 013, 006 SAY        oSayArq PROMPT "Arquivo:"                  SIZE 060, 007 OF oDlgPvt PIXEL
			@ 010, 070 MSGET      oGetArq VAR    cGetArq                     SIZE 240, 010 OF oDlgPvt PIXEL
			oGetArq:bHelp := {||	ShowHelpCpo(	"cGetArq",;
									{"Arquivo CSV que será importado."+STR_PULA+"Exemplo: C:\teste.csv"},2,;
									{},2)}
			@ 010, 311 BUTTON oBtnArq PROMPT "..."      SIZE 008, 011 OF oDlgPvt ACTION (fPegaArq()) PIXEL
			
			//Tipo de Importação
			@ 028, 006 SAY        oSayTes PROMPT "TES:"                      SIZE 060, 007 OF oDlgPvt PIXEL
			@ 025, 070 MSGET      oGetTes VAR    cGetTes                     SIZE 100, 010 OF oDlgPvt PIXEL F3 'SF4'
			oGetTes:bHelp := {||	ShowHelpCpo(	"cGetTes",;
									{"Tipo de TES que será processada para importação dos saldos."},2,;
									{},2)}
			
			//Simula antes de importar
			@ 043, 006 SAY        oSaySer PROMPT "Série:"                    SIZE 070, 007 OF oDlgPvt PIXEL
			@ 040, 070 MSGET      oGetSer VAR    cGetSer                     SIZE 100, 010 OF oDlgPvt PIXEL F3 '01'
			oGetSer:bHelp := {||	ShowHelpCpo(	"cGetSer",;
									{"Série que será utilizada para importação."},2,;
									{},2)}
		
		//Grupo Ações
		@ 063, 003 	GROUP oGrpAco TO (nJanAltu/2)-3, (nJanLarg/2) 	PROMPT "Ações: " 		OF oDlgPvt COLOR 0, 16777215 PIXEL
		
			//Botões
			@ 070, (nJanLarg/2)-(63*1)  BUTTON oBtnSair PROMPT "Sair"      SIZE 60, 014 OF oDlgPvt ACTION (oDlgPvt:End()) PIXEL
			@ 070, (nJanLarg/2)-(63*2)  BUTTON oBtnImp  PROMPT "Importar"  SIZE 60, 014 OF oDlgPvt ACTION (Processa({|| fImport() }, "Aguarde...")) PIXEL
			@ 070, (nJanLarg/2)-(63*3)  BUTTON oBtnRela PROMPT "Relação"   SIZE 60, 014 OF oDlgPvt ACTION (fRelacao()) PIXEL
	ACTIVATE MSDIALOG oDlgPvt CENTERED
	
	//Se confirmar a pergunta, chama a rotina de refaz poder de terceiros
	If MsgYesNo("Deseja executar a rotina de Refaz Poder de Terceiros?", "Atenção")
		Mata216()
	EndIf
	
	RestArea(aAreaB6)
	RestArea(aArea)
Return

/*---------------------------------------------------------------------*
 | Func:  fPegaArq                                                     |
 | Autor: Daniel Atilio                                                |
 | Data:  28/08/2015                                                   |
 | Desc:  Função para pegar o arquivo txt a ser importado              |
 *---------------------------------------------------------------------*/

Static Function fPegaArq()
	Local cArqAux := ""

	cArqAux := cGetFile( "Arquivo Texto *.csv* | *.csv*",;	//Máscara
							"Arquivo...",;						//Título
							,;										//Número da máscara
							,;										//Diretório Inicial
							.F.,;									//.F. == Abrir; .T. == Salvar
							GETF_LOCALHARD,;						//Diretório full. Ex.: 'C:\TOTVS\arquivo.xlsx'
							.F.)									//Não exibe diretório do servidor
								
	//Caso o arquivo não exista ou estiver em branco ou não for a extensão txt
	If Empty(cArqAux) .Or. !File(cArqAux) .Or. SubStr(cArqAux, RAt('.', cArqAux)+1, 3) != "csv"
		MsgStop("Arquivo <b>inválido</b>!", "Atenção")
		
	//Senão, define o get
	Else
		cGetArq := PadR(cArqAux,99)
		oGetArq:Refresh()
	EndIf
Return

/*---------------------------------------------------------------------*
 | Func:  fImport                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  28/08/2015                                                   |
 | Desc:  Função que realiza a importação dos dados                    |
 *---------------------------------------------------------------------*/

Static Function fImport()
	Local lMovEstoq := .F.
	Local cMsgAux := ""

	DbSelectArea('SF4')
	SF4->(DbSetOrder(1)) //F4_FILIAL+F4_CODIGO
	SF4->(DbGoTop())
	
	DbSelectArea('SX5')
	SX5->(DbSetOrder(1)) //X5_FILIAL+X5_TABELA+X5_CHAVE
	SX5->(DbGoTop())

	//Caso o arquivo não exista ou estiver em branco ou não for a extensão txt
	If Empty(cGetArq) .Or. !File(cGetArq) .Or. SubStr(cGetArq, RAt('.', cGetArq)+1, 3) != "csv"
		MsgStop("Arquivo <b>inválido</b>!", "Atenção")
		Return
	EndIf
	
	//Valida se TES existe
	If SF4->(DbSeek(FWxFilial('SF4') + cGetTes))
		//Somente irá prosseguir se for Remessa ou Devolução
		If SF4->F4_PODER3 $ 'R;D'
			lMovEstoq := (SF4->F4_ESTOQUE == 'S')
		
			//Se movimenta estoque, mostra mensagem perguntando se quer continuar
			If lMovEstoq
				cMsgAux := "Essa TES, <b>movimenta ESTOQUE</b>, certifique-se de ter saldo disponível!<br>Deseja prosseguir?"
				If !MsgYesNo(cMsgAux, "Atenção")
					Return
				EndIf
			EndIf
		
		//Senão, mostra mensagem que tes não movimenta poder de/em terceiros 
		Else
			MsgStop("TES <b>não movimenta</b> poder de/em Terceiros!", "Atenção")
			Return
		EndIf
	
	//Se não conseguir posicionar, retorna erro
	Else
		MsgStop("TES <b>não encontrada</b>!", "Atenção")
		Return
	EndIf
	
	//Valida se a Série existe
	If ! SX5->(DbSeek(FWxFilial('SX5') + '01' + cGetSer))
		MsgStop("Série <b>não encontrada</b>!", "Atenção")
		Return
	EndIf
	
	//Se for Saída
	If SF4->F4_TIPO == 'S'
		fImpSB6SF2()
		
	//Se for Entrada
	ElseIf SF4->F4_TIPO == 'E'
		fImpSB6SF1()
	EndIf
	MsgInfo("Importação concluída!", "Atenção")
Return

/*---------------------------------------------------------------------*
 | Func:  fImpSB6SF2                                                   |
 | Autor: Daniel Atilio                                                |
 | Data:  28/08/2015                                                   |
 | Desc:  Função que importa as NF de Saída, para geração da SB6       |
 *---------------------------------------------------------------------*/

Static Function fImpSB6SF2()
	Local aArea := GetArea()
	Local aAreaF2 := SF2->(GetArea())
	Local aAreaD2 := SD2->(GetArea())
	Local aAreaB6 := SB6->(GetArea())
	Local nTotalReg := 0
	Local nLinAtu := 0
	Local cErroImp := ""
	Local cBuffer := ""
	Local nLinAtu := 0
	Local aDadAux := {}
	Local aLinAux	:= {}
	Local aCabSF2 := {}
	Local aIteSD2 := {}
	Local cSerAux := cGetSer
	Local cNFAux  := ''
	Local cTipAux := 'N'
	Local nLinNF  := 0
	Local cIteAtu := StrTran(Space(TamSX3('D2_ITEM')[01]), ' ', '0')
	Local cLogAtu	:= ""
	Local cNomLog := ""
	Local nAux    := 0
	Local aLogAuto:= {}
	Local nQtdVen := 0
	Local nPrcVen := 0
	Local nValTot := 0 
	Local cCliAtu := ""
	Local cLojAtu := ""
	
	//Abrindo o arquivo
	Ft_FUse(cGetArq)
	nTotalReg := Ft_FLastRec()
	nLinAtu := 0
	ProcRegua(nTotalReg)
		
	//Indo ao topo e percorrendo os registros
	Ft_FGoTop()
	While !Ft_FEoF() .And. nLinAtu <= FT_FLastRec()
		//Pegando a linha atual
		cBuffer := Ft_FReadLn()
		nLinAtu++
		IncProc("[SIMULAÇÃO] Analisando linha "+cValToChar(nLinAtu)+" de "+cValToChar(nTotalReg)+"...")
		
		//Pegando os dados, conforme caracter delimitador
		aDadAux := StrTokArr(cBuffer, ';')
		
		//Se a primeira posição for '1' é cabeçalho
		If aDadAux[1] == '1' .And. Len(aCabSF2) == 0
			nLinNF := nLinAtu
			cCliAtu := aDadAux[3]
			cLojAtu := aDadAux[4]
			
			//Pegando a próxima nota dessa série
			cNFAux := NxtSX5Nota(cSerAux)
			
			DbSelectArea('SA1')
			SA1->(DbSetOrder(1)) //A1_FILIAL+A1_COD+A1_LOJA
			SA1->(DbSeek(FWxFilial('SA1') + cCliAtu + cLojAtu)) 
			
			//Adicionando dados no cabeçalho
			aAdd(aCabSF2,{"F2_FILIAL",	FWxFilial("SF2"),	Nil})          
			aAdd(aCabSF2,{"F2_TIPO",		cTipAux,			Nil})
			aAdd(aCabSF2,{"F2_DOC",		cNFAux,			Nil})
			aAdd(aCabSF2,{"F2_SERIE",	cSerAux,			Nil})
			aAdd(aCabSF2,{"F2_EMISSAO",	cToD(aDadAux[2]),	Nil})
			aAdd(aCabSF2,{"F2_CLIENTE",	cCliAtu,			Nil})
			aAdd(aCabSF2,{"F2_LOJA",		cLojAtu,			Nil})
			aAdd(aCabSF2,{"F2_CLIENT",	cCliAtu,			Nil})
			aAdd(aCabSF2,{"F2_LOJENT",	cLojAtu,			Nil})		
			aAdd(aCabSF2,{"F2_TIPOCLI",	SA1->A1_TIPO,		Nil})	
			aAdd(aCabSF2,{"F2_ESPECIE",	aDadAux[5],		Nil})
			
		//Senão, se a primeira posição for '2' é item
		ElseIf aDadAux[1] == '2' .And. Len(aCabSF2) != 0
			aLinAux := {}
			cIteAtu := Soma1(cIteAtu)
			nQtdVen := Val(aDadAux[3])
			nPrcVen := Val(aDadAux[4])
			nValTot := nQtdVen * nPrcVen 
			
			//Adicionando o item atual
			aAdd(aLinAux,{"D2_FILIAL",	FWxFilial("SD2"),	Nil})
			aAdd(aLinAux,{"D2_DOC",		cNFAux,			Nil})
			aAdd(aLinAux,{"D2_SERIE",	cSerAux,			Nil})
			aAdd(aLinAux,{"D2_CLIENTE",	cCliAtu,			Nil})
			aAdd(aLinAux,{"D2_LOJA",		cLojAtu,			Nil})
			aAdd(aLinAux,{"D2_ITEM",		cIteAtu,			Nil})
			aAdd(aLinAux,{"D2_COD",		aDadAux[2],		Nil})
			aAdd(aLinAux,{"D2_QUANT",	nQtdVen,			Nil})
			aAdd(aLinAux,{"D2_PRCVEN",	nPrcVen,			Nil})
			aAdd(aLinAux,{"D2_TOTAL",	nValTot,			Nil})
			aAdd(aLinAux,{"D2_X_MOTOR",	aDadAux[5],		Nil})
			aAdd(aLinAux,{"D2_TES",		cGetTes,			Nil})
			aAdd(aIteSD2, aLinAux)
			
		//Senão, se a terceira posição for '3' é o final dessa Nota, para importação dos dados
		ElseIf aDadAux[1] == '3' .And. Len(aCabSF2) != 0 .And. Len(aIteSD2) != 0
			//Iniciando transação
			Begin Transaction
				lMsErroAuto 		:= .F.
				lAutoErrNoFile	:= .T.
				lMsErroAuto		:= .F.
				l920Inclui			:= .T.
			
				//Chamando a inclusão automática
				MSExecAuto({|x, y, z| Mata920(x, y, z)}, aCabSF2, aIteSD2, 3)
			
				//Se houve erro
				If lMsErroAuto
					cLogAtu := "Houveram erros na importação da NF, na linha "+cValToChar(nLinNF)+":" + STR_PULA
					cNomLog := "linha_"+cValToChar(nLinNF)+"_"+StrTran(dToC(dDataBase), '/', '-')+"_"+StrTran(Time(), ':', '-')+".txt"
					
					//Pegando log do ExecAuto
					aLogAuto := GetAutoGRLog()
					For nAux:=1 To Len(aLogAuto)
						cLogAtu += aLogAuto[nAux] + STR_PULA
					Next
					MemoWrite(cDirLog+cNomLog, cLogAtu)
					
					cErroImp += "- Linha "+cValToChar(nLinNF)+" - log está em '"+cDirLog+cNomLog+"';"+STR_PULA
					DisarmTransaction()
				EndIf
			End Transaction
			
			//Voltando as variáveis
			nLinNF		:= 0
			cNFAux		:= ''
			cCliAtu	:= ''
			cLojAtu	:= ''
			aCabSF2	:= {}
			aIteSD2	:= {}
			cIteAtu	:= StrTran(Space(TamSX3('D2_ITEM')[01]), ' ', '0')
		EndIf
				
		Ft_FSkip()
	EndDo
		
	//Se houve erros, mostra mensagem ao usuário
	If !Empty(cErroImp)
		cErroImp := "Houve erro(s) na importação."+STR_PULA+STR_PULA+"---"+STR_PULA+"Log: "+STR_PULA+cErroImp
		Aviso('Atenção', cErroImp, {'Ok'}, 03)
	EndIf
		
	//Fechando o arquivo
	Ft_FUse()
	
	RestArea(aAreaB6)
	RestArea(aAreaD2)
	RestArea(aAreaF2)
	RestArea(aArea)
Return

/*---------------------------------------------------------------------*
 | Func:  fImpSB6SF1                                                   |
 | Autor: Daniel Atilio                                                |
 | Data:  28/08/2015                                                   |
 | Desc:  Função que importa as NF de Entrada, para geração da SB6     |
 *---------------------------------------------------------------------*/

Static Function fImpSB6SF1()
	Local aArea := GetArea()
	Local aAreaF1 := SF1->(GetArea())
	Local aAreaD1 := SD1->(GetArea())
	Local aAreaB6 := SB6->(GetArea())
	Local nTotalReg := 0
	Local nLinAtu := 0
	Local cErroImp := ""
	Local cBuffer := ""
	Local nLinAtu := 0
	Local aDadAux := {}
	Local aLinAux	:= {}
	Local aCabSF1 := {}
	Local aIteSD1 := {}
	Local cSerAux := cGetSer
	Local cNFAux  := ''
	Local cTipAux := 'N'
	Local nLinNF  := 0
	Local cIteAtu := StrTran(Space(TamSX3('D1_ITEM')[01]), ' ', '0')
	Local cLogAtu	:= ""
	Local cNomLog := ""
	Local nAux    := 0
	Local aLogAuto:= {}
	Local nQtdVen := 0
	Local nPrcVen := 0
	Local nValTot := 0 
	Local cForAtu := ""
	Local cLojAtu := ""
	Local nModBkp := 0
	
	//Abrindo o arquivo
	Ft_FUse(cGetArq)
	nTotalReg := Ft_FLastRec()
	nLinAtu := 0
	ProcRegua(nTotalReg)
		
	//Indo ao topo e percorrendo os registros
	Ft_FGoTop()
	While !Ft_FEoF() .And. nLinAtu <= FT_FLastRec()
		//Pegando a linha atual
		cBuffer := Ft_FReadLn()
		nLinAtu++
		IncProc("[SIMULAÇÃO] Analisando linha "+cValToChar(nLinAtu)+" de "+cValToChar(nTotalReg)+"...")
		
		//Pegando os dados, conforme caracter delimitador
		aDadAux := StrTokArr(cBuffer, ';')
		
		//Se a primeira posição for '1' é cabeçalho
		If aDadAux[1] == '1' .And. Len(aCabSF1) == 0
			nLinNF := nLinAtu
			cForAtu := aDadAux[3]
			cLojAtu := aDadAux[4]
			
			//Pegando a próxima nota dessa série
			cNFAux := NxtSX5Nota(cSerAux)
			
			DbSelectArea('SA2')
			SA2->(DbSetOrder(1)) //A2_FILIAL+A2_COD+A2_LOJA
			SA2->(DbSeek(FWxFilial('SA2') + cForAtu + cLojAtu)) 
			
			//Adicionando dados no cabeçalho
			aAdd(aCabSF1,{"F1_FILIAL",	FWxFilial("SF1"),	Nil})          
			aAdd(aCabSF1,{"F1_TIPO",		cTipAux,			Nil})
			aAdd(aCabSF1,{"F1_DOC",		cNFAux,			Nil})
			aAdd(aCabSF1,{"F1_SERIE",	cSerAux,			Nil})
			aAdd(aCabSF1,{"F1_EMISSAO",	cToD(aDadAux[2]),	Nil})
			aAdd(aCabSF1,{"F1_FORNECE",	cForAtu,			Nil})
			aAdd(aCabSF1,{"F1_LOJA",		cLojAtu,			Nil})
			aAdd(aCabSF1,{"F1_TIPOCLI",	SA2->A2_TIPO,		Nil})	
			aAdd(aCabSF1,{"F1_ESPECIE",	aDadAux[5],		Nil})
			aAdd(aCabSF1,{"F1_FORMUL",	'N',				Nil})
			aAdd(aCabSF1,{"F1_COND",		aDadAux[6],		Nil})
			
		//Senão, se a primeira posição for '2' é item
		ElseIf aDadAux[1] == '2' .And. Len(aCabSF1) != 0
			aLinAux := {}
			cIteAtu := Soma1(cIteAtu)
			nQtdVen := Val(aDadAux[3])
			nPrcVen := Val(aDadAux[4])
			nValTot := nQtdVen * nPrcVen 
			
			//Adicionando o item atual
			aAdd(aLinAux,{"D1_FILIAL",	FWxFilial("SD1"),	Nil})
			aAdd(aLinAux,{"D1_DOC",		cNFAux,			Nil})
			aAdd(aLinAux,{"D1_SERIE",	cSerAux,			Nil})
			aAdd(aLinAux,{"D1_FORNECE",	cForAtu,			Nil})
			aAdd(aLinAux,{"D1_LOJA",		cLojAtu,			Nil})
			aAdd(aLinAux,{"D1_ITEM",		cIteAtu,			Nil})
			aAdd(aLinAux,{"D1_COD",		aDadAux[2],		Nil})
			aAdd(aLinAux,{"D1_QUANT",	nQtdVen,			Nil})
			aAdd(aLinAux,{"D1_VUNIT",	nPrcVen,			Nil})
			aAdd(aLinAux,{"D1_TOTAL",	nValTot,			Nil})
			aAdd(aLinAux,{"D1_TES",		cGetTes,			Nil})
			aAdd(aIteSD1, aLinAux)
			
		//Senão, se a terceira posição for '3' é o final dessa Nota, para importação dos dados
		ElseIf aDadAux[1] == '3' .And. Len(aCabSF1) != 0 .And. Len(aIteSD1) != 0
			//Iniciando transação
			Begin Transaction
				lMsErroAuto 		:= .F.
				lAutoErrNoFile	:= .T.
				lMsErroAuto		:= .F.
				nModBkp			:= nModulo
				nModulo			:= 2
			
				//Chamando a inclusão automática
				MSExecAuto({|x, y, z| Mata103(x, y, z)}, aCabSF1, aIteSD1, 3)
			
				//Se houve erro
				If lMsErroAuto
					cLogAtu := "Houveram erros na importação da NF, na linha "+cValToChar(nLinNF)+":" + STR_PULA
					cNomLog := "linha_"+cValToChar(nLinNF)+"_"+StrTran(dToC(dDataBase), '/', '-')+"_"+StrTran(Time(), ':', '-')+".txt"
					
					//Pegando log do ExecAuto
					aLogAuto := GetAutoGRLog()
					For nAux:=1 To Len(aLogAuto)
						cLogAtu += aLogAuto[nAux] + STR_PULA
					Next
					MemoWrite(cDirLog+cNomLog, cLogAtu)
					
					cErroImp += "- Linha "+cValToChar(nLinNF)+" - log está em '"+cDirLog+cNomLog+"';"+STR_PULA
					DisarmTransaction()
				EndIf
				
				nModulo := nModBkp
			End Transaction
			
			//Voltando as variáveis
			nLinNF		:= 0
			cNFAux		:= ''
			cForAtu	:= ''
			cLojAtu	:= ''
			aCabSF1	:= {}
			aIteSD1	:= {}
			cIteAtu	:= StrTran(Space(TamSX3('D1_ITEM')[01]), ' ', '0')
		EndIf
				
		Ft_FSkip()
	EndDo
		
	//Se houve erros, mostra mensagem ao usuário
	If !Empty(cErroImp)
		cErroImp := "Houve erro(s) na importação."+STR_PULA+STR_PULA+"---"+STR_PULA+"Log: "+STR_PULA+cErroImp
		Aviso('Atenção', cErroImp, {'Ok'}, 03)
	EndIf
		
	//Fechando o arquivo
	Ft_FUse()
	
	RestArea(aAreaB6)
	RestArea(aAreaD1)
	RestArea(aAreaF1)
	RestArea(aArea)
Return

/*---------------------------------------------------------------------*
 | Func:  fRelacao                                                     |
 | Autor: Daniel Atilio                                                |
 | Data:  28/08/2015                                                   |
 | Desc:  Função que exporta a relação dos campos para TReport         |
 *---------------------------------------------------------------------*/

Static Function fRelacao()
	Local cMsgAux := ""
	
	//Mensagem que será impressa no TReport
	cMsgAux := 'Leiaute de importação de Saldos de/em Poder de Terceiros<br>'
	cMsgAux += ' <br>'
	cMsgAux += '   Os campos deverão ser separados com ponto e vírgula (";"), e gerados na extensão .csv.<br>'
	cMsgAux += '   Abaixo a explicação dos Saldos de/em Poder de Terceiros:<br>'
	cMsgAux += '   O controle do poder de terceiros do SIGA-ADVANCED foi concebido para controlar o envio e o recebimento de materiais que recebem algum tipo de beneficiamento.<br>'
	cMsgAux += '   Existem duas situacoes bastante claras e distintas que sao relatadas a seguir:<br>'
	cMsgAux += ' <br>'
	cMsgAux += '   Quando "EU BENEFICIO" - O processo se inicia no recebimento do material enviado por um cliente:<br>'
	cMsgAux += '     - NF de entrada com tipo "B" p/ apresentar cliente e TES com F4_PODER3 = "R" (Remessa).<br>'
	cMsgAux += '   Apos a execucao do servico de beneficiamento, o material deve ser devolvido ao cliente:<br>'
	cMsgAux += '     - NF de saida com tipo "N" p/ apresentar cliente e TES como F4_PODER3 = "D" (Devolucao).<br>'
	cMsgAux += '   Note que o servico prestado tambem deve constar desta nota, porem nao tem tratamento de poder de terceiros, simplesmente é vendido.<br>'
	cMsgAux += ' <br>'
	cMsgAux += '   Quando "EU MANDO BENEFICIAR" - O processo se inicia quando o material deve ser enviado para um fornecedor, que ira fazer o beneficiamento:<br>'
	cMsgAux += '     - NF de saida com tipo "B" p/ apresentar fornecedor e TES com F4_PODER3 = "R" (Remessa).<br>'
	cMsgAux += '   Apos a execucao do servico de beneficiamento, o material é devolvido pelo fornecedor:<br>'
	cMsgAux += '     - NF de entrada com tipo "N" p/ apresentar fornecedor e TES como F4_PODER3 = "D" (Devolucao).<br>'
	cMsgAux += '   Note que o servico prestado tambem deve constar desta nota, porem nao tem tratamento de poder de terceiros, simplesmente é comprado.<br>'
	cMsgAux += ' <br>'
	cMsgAux += '   Link: http://tdn.totvs.com/display/public/mp/Controle+de+Poder+de+Terceiros;jsessionid=8E86724A96E413F71334FBAA092EF916<br>'
	cMsgAux += ' <br>'
	cMsgAux += '+=========================================+<br>'
	cMsgAux += 'Abaixo o Layout para Saldos em Terceiros:<br>'
	cMsgAux += '   Linha de Cabeçalho:<br>'
	cMsgAux += '     - Caracter "1", indicando cabeçalho;<br>'
	cMsgAux += '     - F2_EMISSAO - Data de Emissão da NF de Saída (padrão DD/MM/YYYY);<br>'
	cMsgAux += '     - F2_CLIENTE - Código do Cliente;<br>'
	cMsgAux += '     - F2_LOJA - Loja do Cliente;<br>'
	cMsgAux += '     - F2_ESPECIE - Espécie da NF de Saída (ex.: "NF").<br>'
	cMsgAux += ' <br>'
	cMsgAux += '   Linha de Itens:<br>'
	cMsgAux += '     - Caracter "2", indicando item;<br>'
	cMsgAux += '     - D2_COD - Código do Produto;<br>'
	cMsgAux += '     - D2_QUANT - Quantidade do Produto;<br>'
	cMsgAux += '     - D2_PRCVEN - Preço do Produto;<br>'
	cMsgAux += '     - D2_X_MOTOR - Número do Motor.<br>'
	cMsgAux += ' <br>'
	cMsgAux += '   Finalização do Documento atual<br>'
	cMsgAux += '     - Caracter "3", indicando o final da NF de Saída.<br>'
	cMsgAux += ' <br>'
	cMsgAux += '   Exemplo:<br>'
	cMsgAux += '     1;28/08/2015;CL0001;01;NF<br>'
	cMsgAux += '     2;F00001;45;2.85;TST1<br>'
	cMsgAux += '     2;F00002;10;3;TST2<br>'
	cMsgAux += '     2;F00003;27;1.64;TST3<br>'
	cMsgAux += '     3;<br>'
	cMsgAux += '+=========================================+<br>'
	cMsgAux += 'Abaixo o Layout para Saldos de Terceiros:<br>'
	cMsgAux += '   Linha de Cabeçalho:<br>'
	cMsgAux += '     - Caracter "1", indicando cabeçalho;<br>'
	cMsgAux += '     - F1_EMISSAO - Data de Emissão da NF de Entrada (padrão DD/MM/YYYY);<br>'
	cMsgAux += '     - F1_FORNECE - Código do Fornecedor;<br>'
	cMsgAux += '     - F1_LOJA - Loja do Fornecedor;<br>'
	cMsgAux += '     - F1_ESPECIE - Espécie da NF de Saída (ex.: "NF");<br>'
	cMsgAux += '     - F1_COND - Condição de pagamento (ex.: "001").<br>'
	cMsgAux += ' <br>'
	cMsgAux += '   Linha de Itens:<br>'
	cMsgAux += '     - Caracter "2", indicando item;<br>'
	cMsgAux += '     - D1_COD - Código do Produto;<br>'
	cMsgAux += '     - D1_QUANT - Quantidade do Produto;<br>'
	cMsgAux += '     - D1_VUNIT - Preço do Produto.<br>'
	cMsgAux += ' <br>'
	cMsgAux += '   Finalização do Documento atual<br>'
	cMsgAux += '     - Caracter "3", indicando o final da NF de Saída.<br>'
	cMsgAux += ' <br>'
	cMsgAux += '   Exemplo:<br>'
	cMsgAux += '     1;28/08/2015;FR0001;01;NF;001<br>'
	cMsgAux += '     2;F00001;45;2.85<br>'
	cMsgAux += '     2;F00002;10;3<br>'
	cMsgAux += '     2;F00003;27;1.64<br>'
	cMsgAux += '     3;<br>'
	
	fImpRel(cMsgAux)
Return

/*-------------------------------------------------------------------------------*
 | Func:  fImpRel                                                                |
 | Autor: Daniel Atilio                                                          |
 | Data:  12/08/2015                                                             |
 | Desc:  Função que imprime a relação das variáveis                             |
 *-------------------------------------------------------------------------------*/

Static Function fImpRel(cMsgAux, aDadAux)
	Local oReport
	Private cMensagem		:= cMsgAux
	
	//Definindo as seções e gerando a impressão
	oReport := fReportDef()
	oReport:PrintDialog()
Return

/*-------------------------------------------------------------------------------*
 | Func:  fReportDef                                                             |
 | Autor: Daniel Atilio                                                          |
 | Data:  28/08/2015                                                             |
 | Desc:  Função que monta a definição do relatório                              |
 *-------------------------------------------------------------------------------*/

Static Function fReportDef()
	Local oReport
	Local oSectMsg
	Local oSectDad
	Local oFunTotDad

	//Criação do componente de impressão
	oReport := TReport():New(	"zImpSB6",;														//Nome do Relatório
									"Relação de Dados",;												//Título
									,;																	//Pergunte
									{|oReport| fRepPrint(oReport)},;								//Bloco de código que será executado na confirmação da impressão
									)																	//Descrição
	oReport:SetLandscape(.T.)   //Define a orientação de página do relatório como paisagem  ou retrato. .F.=Retrato; .T.=Paisagem
	oReport:SetTotalInLine(.F.) //Define se os totalizadores serão impressos em linha ou coluna
	If !Empty(oReport:uParam)
		Pergunte(oReport:uParam,.F.)
	EndIf
	
	//Criando a seção de mensagem
	oSectMsg := TRSection():New(	oReport,;				//Objeto TReport que a seção pertence
										"",;					//Descrição da seção
										{""})					//Tabelas utilizadas, a primeira será considerada como principal da seção
	oSectMsg:SetTotalInLine(.F.)  //Define se os totalizadores serão impressos em linha ou coluna. .F.=Coluna; .T.=Linha
	
	//Células da seção mensagem
	TRCell():New(	oSectMsg,	"XX_MENS",	"",	"",	"",	200,	/*lPixel*/,	/*{|| code-block de impressao }*/)
Return oReport

/*-------------------------------------------------------------------------------*
 | Func:  fRepPrint                                                              |
 | Autor: Daniel Atilio                                                          |
 | Data:  28/08/2015                                                             |
 | Desc:  Função que imprime o relatório                                         |
 *-------------------------------------------------------------------------------*/

Static Function fRepPrint(oReport)
	Local oMsg		:= Nil
	Local oDados 	:= Nil
	Local nAtual
	Local aAux := {}
	Local nAux := 0

	//Pegando as seções do relatório
	oMsg	:= oReport:Section(1)

	//Quebrando a mensagem
	aAux := {}
	fMemoToArr(cMensagem, @aAux, 200, '<br>')
	
	//Percorrendo e imprimindo
	oMsg:Init()
	For nAux := 1 To Len(aAux)
		oMsg:Cell("XX_MENS"):SetValue(aAux[nAux])
		oMsg:PrintLine()
	Next
	oMsg:Finish()
Return

/*-------------------------------------------------------------------------------*
 | Func:  fRepPrint                                                              |
 | Autor: Daniel Atilio                                                          |
 | Data:  28/08/2015                                                             |
 | Desc:  Função para quebrar uma string em várias linhas                        |
 *-------------------------------------------------------------------------------*/

Static Function fMemoToArr(cTexto, aTexto, nMaxCol, cCaracter)
	Local nPosAtual := 1         //Posição Atual
	Local nPosFim   := nMaxCol   //Posição Final
	Local nMaxLin   := 1         //Número de Linhas
	Local aTexto:={}
	Local aAux:={}
	Local nI := 0
	Default cCaracter := Chr(13)

	//Se o texto não tiver em branco
	If ! Empty(cTexto)
		//Quebrando o Array, conforme -Enter-
		aAux:= Separa(cTexto, '<br>')
		
		//Correndo o Array e retirando o tabulamento
		For nI:=1 TO Len(aAux)
			aAux[nI]:=StrTran(aAux[nI],Chr(10),'')
		Next
		
		//Correndo as linhas quebradas
		For nI:=1 To Len(aAux)
			//Se o tamanho de Texto, for maior que o número de colunas
			If(Len(aAux[nI]) > nMaxCol)
				//Enquanto o Tamanho for Maior
				While (Len(aAux[nI]) > nMaxCol)
					//A última posição, será o último espaço em branco
					nUltPos:=Rat(' ',SubStr(aAux[nI],1,nMaxCol))
					//Se não encontrar espaço em branco, a última posição será a coluna máxima
					If(nUltPos==0)
						nUltPos:=nMaxCol
					EndIf
					//Adicionando Parte da Sring (de 1 até a Úlima posição válida)
					aAdd(aTexto,SubStr(aAux[nI],1,nUltPos))
					//Quebrando o resto da String
					aAux[nI]:=SubStr(aAux[nI],nUltPos+1,Len(aAux[nI])-nUltPos)
				EndDo
				//Adicionando o que sobrou
				aAdd(aTexto,aAux[nI])
			Else
				//Se for menor que o Máximo de colunas, adiciona o texto
				aAdd(aTexto,aAux[nI])
			EndIf
		Next
	EndIf
	
	//Se não tiver nada para retornar, fixa como espaço em branco
	If Len(aTexto) == 0
		aTexto := {""}
	EndIf
	
	//Pegando o número máximo de Linhas
	nMaxLin:=Len(aTexto)
Return nMaxLin