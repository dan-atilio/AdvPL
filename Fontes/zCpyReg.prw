/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2017/05/30/funcao-para-copiar-registro-de-uma-filial-para-outra/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} zCpyReg
Função para copiar registros entre as filiais
@type function
@author Atilio
@since 02/01/2017
@version 1.0
	@example
	u_zCpyReg()
/*/

User Function zCpyReg()
	Local aArea        := GetArea()
	Local cPerg        := "X_zCpyReg"
	Private cTabelaAux := ""
	Private cChaveAux  := ""
	Private cFilAtuAux := ""
	Private cCodAtuAux := ""
	Private cFilNovAux := ""
	Private cCodNovAux := ""
	
	//Cria o grupo de pergunta
	fVldPerg(cPerg)
	
	//Se a pergunta for confirmada
	If Pergunte(cPerg, .T.)
		cTabelaAux := MV_PAR01
		cChaveAux  := MV_PAR02
		cFilAtuAux := MV_PAR03
		cCodAtuAux := MV_PAR04
		cFilNovAux := MV_PAR05
		cCodNovAux := MV_PAR06
		
		//Se tiver algum parâmetro em branco, encerra
		If 	Empty(cTabelaAux) .Or.;
			Empty(cChaveAux) .Or.;
			Empty(cCodAtuAux) .Or.;
			Empty(cCodNovAux)
			MsgAlert("Existe(m) parâmetros em branco!", "Atenção")
		EndIf
		
		Processa({|| fCopia()},'Processando')
	EndIf
	
	RestArea(aArea)
Return

/*---------------------------------------------------------------------*
 | Func:  fCopia                                                       |
 | Autor: Daniel Atilio                                                |
 | Data:  02/01/2017                                                   |
 | Desc:  Função para copiar os dados                                  |
 *---------------------------------------------------------------------*/

Static Function fCopia()
	Local aArea     := GetArea()
	Local aEstru    := {}
	Local aConteu   := {}
	Local nPosFil   := 0
	Local cCampoFil := ""
	Local cQryAux   := ""
	Local nAtual    := 0
	
	DbSelectArea(cTabelaAux)
	
	//Pega a estrutura da tabela
	aEstru := (cTabelaAux)->(DbStruct())
	
	//Encontra o campo filial
	nPosFil   := aScan(aEstru, {|x| "FILIAL" $ AllTrim(Upper(x[1]))})
	cCampoFil := aEstru[nPosFil][1]
	
	//Faz uma consulta sql trazendo o RECNO
	cQryAux := " SELECT "
	cQryAux += " 	R_E_C_N_O_ AS DADREC "
	cQryAux += " FROM "
	cQryAux += " 	"+RetSQLName(cTabelaAux)+" "
	cQryAux += " WHERE "
	cQryAux += " 	"+cCampoFil+" = '"+cFilAtuAux+"' "
	cQryAux += " 	AND "+cChaveAux+" = '"+cCodAtuAux+"' "
	cQryAux += " 	AND D_E_L_E_T_ = ' ' "
	TCQuery cQryAux New Alias "QRY_AUX"
	
	//Caso exista registro
	If ! QRY_AUX->(EoF())
		//Posiciona nesse recno
		(cTabelaAux)->(DbGoTo(QRY_AUX->DADREC))
		
		//Percorre a estrutura
		ProcRegua(Len(aEstru))
		For nAtual := 1 To Len(aEstru)
			IncProc("Adicionando valores ("+cValToChar(nAtual)+" de "+cValToChar(Len(aEstru))+")...")
			
			//Se for campo filial
			If Alltrim(aEstru[nAtual][1]) == Alltrim(cCampoFil)
				aAdd(aConteu, cFilNovAux)
				
			//Se for o campo de código
			ElseIf Alltrim(aEstru[nAtual][1]) == Alltrim(cChaveAux)
				aAdd(aConteu, cCodNovAux)
				
			//Se não, adiciona
			Else
				aAdd(aConteu, &(cTabelaAux+"->"+aEstru[nAtual][1]))
			EndIf
		Next
		
		IncProc("Criando o registro...")
		//Faz um RecLock
		RecLock(cTabelaAux, .T.)
			//Percorre a estrutura
			For nAtual := 1 To Len(aEstru)
				//Grava o novo valor
				&(aEstru[nAtual][1]) := aConteu[nAtual]
			Next
		(cTabelaAux)->(MsUnlock())
		
		MsgInfo("Cópia concluída.", "Atenção")
	EndIf
	QRY_AUX->(DbCloseArea())
	
	RestArea(aArea)
Return

/*---------------------------------------------------------------------*
 | Func:  fVldPerg                                                     |
 | Autor: Daniel Atilio                                                |
 | Data:  02/01/2016                                                   |
 | Desc:  Função para criar o grupo de perguntas                       |
 *---------------------------------------------------------------------*/

Static Function fVldPerg(cPerg)
	//(		cGrupo,	cOrdem,	cPergunt,				cPergSpa,		cPergEng,	cVar,		cTipo,	nTamanho,					nDecimal,	nPreSel,	cGSC,	cValid,	cF3,		cGrpSXG,	cPyme,	cVar01,		cDef01,	cDefSpa1,	cDefEng1,	cCnt01,	cDef02,		cDefSpa2,	cDefEng2,	cDef03,			cDefSpa3,		cDefEng3,	cDef04,	cDefSpa4,	cDefEng4,	cDef05,	cDefSpa5,	cDefEng5,	aHelpPor,	aHelpEng,	aHelpSpa,	cHelp)
	PutSx1(cPerg,		"01",		"Tabela?",				"",				"",			"mv_ch0",	"C",	03,							0,			0,			"G",	"", 		"SX2PAD",	"",			"",		"mv_par01",	"",			"",			"",			"",			"",				"",			"",			"",					"",				"",			"",			"",			"",			"",			"",			"",			{},			{},			{},			"")
	PutSx1(cPerg,		"02",		"Campo Chave?",		"",				"",			"mv_ch1",	"C",	10,							0,			0,			"G",	"", 		"",			"",			"",		"mv_par02",	"",			"",			"",			"",			"",				"",			"",			"",					"",				"",			"",			"",			"",			"",			"",			"",			{},			{},			{},			"")
	PutSx1(cPerg,		"03",		"Filial Atual?",		"",				"",			"mv_ch2",	"C",	FWSizeFilial(),			0,			0,			"G",	"", 		"SM0",		"",			"",		"mv_par03",	"",			"",			"",			"",			"",				"",			"",			"",					"",				"",			"",			"",			"",			"",			"",			"",			{},			{},			{},			"")
	PutSx1(cPerg,		"04",		"Chave Atual?",		"",				"",			"mv_ch3",	"C",	30,							0,			0,			"G",	"", 		"",			"",			"",		"mv_par04",	"",			"",			"",			"",			"",				"",			"",			"",					"",				"",			"",			"",			"",			"",			"",			"",			{},			{},			{},			"")
	PutSx1(cPerg,		"05",		"Filial Nova?",		"",				"",			"mv_ch4",	"C",	FWSizeFilial(),			0,			0,			"G",	"", 		"SM0",		"",			"",		"mv_par05",	"",			"",			"",			"",			"",				"",			"",			"",					"",				"",			"",			"",			"",			"",			"",			"",			{},			{},			{},			"")
	PutSx1(cPerg,		"06",		"Chave Nova?",		"",				"",			"mv_ch5",	"C",	30,							0,			0,			"G",	"", 		"",			"",			"",		"mv_par06",	"",			"",			"",			"",			"",				"",			"",			"",					"",				"",			"",			"",			"",			"",			"",			"",			{},			{},			{},			"")
Return