//Bibliotecas
#Include "Protheus.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} zEditTmp
Função para manipulação de registros .dbf
@author Atilio
@since 06/08/2016
@version 1.0
	@example
	u_zEditTmp()
/*/

User Function zEditTmp()
	Local aArea    := GetArea()
	Local cArqDBF  := cGetFile(	"Arquivo DBF .dbf | *.dbf ",;                      //Máscara
									"Arquivo...",;                                     //Título
									,;                                                 //Número da máscara
									,;                                                 //Diretório Inicial
									.F.,;                                              //.F. == Abrir; .T. == Salvar
									,;                                                 //Tipo
									.T.)                                               //Exibe diretório do servidor
	
	//Se o arquivo não existir
	If ! File(cArqDBF)
		MsgStop("Arquivo <b>'"+cArqDBF+"'</b> não existe!", "Atenção")
		Return
	EndIf
	
	//Processando as informações e montando a Dialog
	Processa({|| u_zEditDBF(cArqDBF) }, "Aguarde...")
	
	RestArea(aArea)
Return


/*/{Protheus.doc} zEditDBF
Função para manipular o arquivo .dbf
@type function
@author Atilio
@since 06/08/2016
@version 1.0
	@param cArqDBF, character, Caminho do arquivo .dbf
	@example
	u_zEditDBF("\system\teste.dbf")
/*/

User Function zEditDBF(cArqDBF)
	Local cDirSrv    := ""
	Local aArea      := GetArea()
	Local nTamBtn    := 50
	Private cTabTmp  := "TMP_"+RetCodUsr()
	Private nColunas := 0
	Private nLinhas  := 0
	Private aDados   := {}
	Private oDlgPvt
	Private oMsGet
	Private aHeader  := {}
	Private aCols    := {}
	Private aEdit    := {}
	Private aStrut   := {}
	Private aAux     := {}
	//Tamanho da Janela
	Private aTamanho := MsAdvSize()
	Private nJanLarg := aTamanho[5]
	Private nJanAltu := aTamanho[6]
	Private nColMeio := (nJanLarg)/4

	//Usando o dbf como tabela temporária
	dbUseArea(.T., "DBFCDXADS", cArqDBF, cTabTmp, .T., .F.)
	Count To nLinhas
	nColunas := fCount()
	aStrut   := (cTabTmp)->(DbStruct())
	(cTabTmp)->(DbGoTop())
	
	//Percorrendo a estrutura, para adicionar as colunas
	For nAtual := 1 To Len(aStrut)
		//Cabeçalho ...	Titulo							Campo					Mask		Tamanho				Dec							Valid	Usado	Tip						F3	CBOX
		aAdd(aHeader,{	Capital(aStrut[nAtual][1]),	aStrut[nAtual][1],	"",			aStrut[nAtual][3],	aStrut[nAtual][4],		".T.",	".T.",	aStrut[nAtual][2],	"",	""})
		aAdd(aEdit, aStrut[nAtual][1])
	Next
	
	//Percorrendo as linhas e adicionando no aCols
	While ! (cTabTmp)->(EoF())
		//Montando a linha atual
		aAux := Array(Len(aHeader)+1)
		For nAtual := 1 To Len(aStrut)
			aAux[nAtual] := &((cTabTmp)->(aEdit[nAtual]))
		Next
		aAux[Len(aHeader)+1] := .F.
		
		//Adiciona no aCols
		aAdd(aCols, aClone(aAux))
		
		(cTabTmp)->(DbSkip())
	EndDo
	
	//Montando a tela
	DEFINE MSDIALOG oDlgPvt TITLE "Arquivo DBF..." FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
		//Dados
		@ 003, 003  GROUP oGrpDad TO (nJanAltu/2)-033, (nJanLarg/2)-003  PROMPT "Dados: "  OF oDlgPvt PIXEL
			oMsGet := MsNewGetDados():New(	010,;          					//nTop
												006,;          					//nLeft
												(nJanAltu/2)-033,;        		//nBottom
												(nJanLarg/2)-006,;       		//nRight
												GD_INSERT+GD_DELETE+GD_UPDATE,;	//nStyle
												"AllwaysTrue()",;       			//cLinhaOk
												,;           						//cTudoOk
												"",;          					//cIniCpos
												aEdit,;          					//aAlter
												,;           						//nFreeze
												9999999,;         				//nMax
												,;           						//cFieldOK
												,;           						//cSuperDel
												,;           						//cDelOk
												oDlgPvt,;     					//oWnd
												aHeader,;        					//aHeader
												aCols)         					//aCols
			
		//Ações
		@ (nJanAltu/2)-025, 003  GROUP oGrpAco TO (nJanAltu/2)-003, (nJanLarg/2)-003  PROMPT "Ações: "  OF oDlgPvt PIXEL
			@ (nJanAltu/2)-19, (nJanLarg/2)-((nTamBtn*1)+06) BUTTON oBtnConf PROMPT "Cancelar"   SIZE nTamBtn, 013 OF oDlgPvt ACTION(oDlgPvt:End())     PIXEL
			@ (nJanAltu/2)-19, (nJanLarg/2)-((nTamBtn*2)+09) BUTTON oBtnLimp PROMPT "Salvar"     SIZE nTamBtn, 013 OF oDlgPvt ACTION(fSalvar())         PIXEL
	ACTIVATE MSDIALOG oDlgPvt CENTERED
	 
	(cTabTmp)->(DbCloseArea())
	RestArea(aArea)
Return

/*---------------------------------------------------------------------*
 | Func:  fSalvar                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  06/08/2016                                                   |
 | Desc:  Função para salvar os dados do dbf                           |
 *---------------------------------------------------------------------*/

Static Function fSalvar()
	Local aColsAux := oMsGet:aCols
	Local nAtual   := 0
	Local nAux     := 0
	
	//Percorre os dados e exclui tudo que existir
	(cTabTmp)->(DbGoTop())
	While !(cTabTmp)->(EoF())
		RecLock(cTabTmp, .F.)
			DbDelete()
		(cTabTmp)->(MsUnlock())
		
		(cTabTmp)->(DbSkip())
	EndDo
	
	//Agora percorre o aCols
	For nAtual := 1 To Len(aColsAux)
		//Se não tiver excluído, inclui o registro
		If !(aColsAux[nAtual][Len(aHeader)+1])
			RecLock(cTabTmp, .T.)
				For nAux := 1 To Len(aStrut)
					&(aStrut[nAux][1]) := aColsAux[nAtual][nAux]
				Next
			(cTabTmp)->(MsUnlock())
		EndIf
	Next
	
	oDlgPvt:End()
	MsgInfo("Gravação completa!", "Atenção")
Return