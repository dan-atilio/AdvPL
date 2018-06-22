//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zIsMVC
Função que verifica se a função executada atualmente é em MVC
@author Atilio
@since 14/04/2018
@version 1.0
@type function
@obs Essa função, apenas pega e verifica se existe um modelo de dados ativo aberto, caso exista, ela mostra uma tela com observações
	Inicializar ele em um ponto de entrada, por exemplo, no ChkExec ou AfterLogin:

	...
	User Function AfterLogin()
		SetKey(K_SH_F7,  { || u_zIsMVC() })     //Shift + F7
	Return
	...
/*/

User Function zIsMVC()
	Local lMVC        := .F.
	Local oModelPad   := FWModelActive()
	Local cOperacao   := ""
	Local oBtnL001
	Local oBtnL002
	Local oBtnL003
	Local oBtnL004
	Local oBtnL005
	Local cError      := ""
	Local bError      := ErrorBlock({ |oError| cError := oError:Description})
	Private cPontoEnt := ""
	Private cVarInfo  := ""
	Private oDlgPvt
	Private oFolderPvt
	Private oEditCod
	Private oEditMod
	//Tamanho da janela
	Private	nJanLarg  := 600
	Private	nJanAltu  := 420
	//Fontes
	Private	cFontUti  := "Arial"
	Private	oFontSub  := TFont():New(cFontUti,,-20)
	Private	oFontSubN := TFont():New(cFontUti,,-20,,.T.)
	
	//Se for diferente de nulo, realmente a tela é em MVC
	If oModelPad != Nil
		lMVC := .T.
		
		//Definindo a operação
		cOperacao := cValToChar(oModelPad:nOperation)
		If oModelPad:nOperation == 3
			cOperacao += " - Inclusão"
		ElseIf oModelPad:nOperation == 4
			cOperacao += " - Alteração"
		ElseIf oModelPad:nOperation == 5
			cOperacao += " - Exclusão"
		EndIf
		
		//Pegando o texto do ponto de entrada
		cPontoEnt := fPontoEnt(Alltrim(oModelPad:cID))
		
		//Inicio a utilização da tentativa
		Begin Sequence
			cVarInfo  := VarInfo("Modelo", ClassDataArr(oModelPad, .T.), , .T., )
		End Sequence
		
		//Restaurando bloco de erro do sistema
		ErrorBlock(bError)
		
		//Se houve erro, será mostrado ao usuário
		If Empty(cVarInfo)
			cVarInfo  := "Houve um erro ao gerar o VarInfo!<br>Verifique o tamanho da String, se necessário, aumente o tamanho na MaxStringSize - <b>http://tdn.totvs.com/pages/viewpage.action?pageId=161349793</b><br>"
			cVarInfo  += "Pode ser ainda, que existam muitos componentes recursivos na tela, e a função VarInfo não conseguiu interpretar."
		EndIf
		
		//Criando a janela
		DEFINE MSDIALOG oDlgPvt TITLE "zIsMVC" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
			//Labels gerais
			@ 004, 003 SAY "zIsMVC - Consulta de objeto em MVC" SIZE 200, 030 FONT oFontSubN  OF oDlgPvt COLORS RGB(031,073,125) PIXEL
			@ 014, 003 SAY "https://terminaldeinformacao.com"   SIZE 200, 030 FONT oFontSub   OF oDlgPvt COLORS RGB(031,073,125) PIXEL
			
			//Abas
			@ 027, 003 FOLDER oFolderPvt SIZE (nJanLarg/2)-03, (nJanAltu/2)-030 OF oDlgPvt ITEMS ;
				"Geral",;
				"Ponto de Entrada",;
				"Modelo de Dados" COLORS 0, 14215660 PIXEL
			
			//Aba Geral
			@ 003, 006 SAY "ID: " + oModelPad:cID                                                     SIZE 200, 030 FONT oFontSub   OF oFolderPvt:aDialogs[1] COLORS RGB(031,073,125) PIXEL
			@ 013, 006 SAY "Descrição: " + oModelPad:cDescription                                     SIZE 200, 030 FONT oFontSub   OF oFolderPvt:aDialogs[1]                         PIXEL
			@ 023, 006 SAY "Operação: " + cOperacao                                                   SIZE 200, 030 FONT oFontSub   OF oFolderPvt:aDialogs[1]                         PIXEL
			
			@ 043, 006 SAY "Links Interessantes: "                                                    SIZE 200, 030 FONT oFontSub   OF oFolderPvt:aDialogs[1] COLORS RGB(031,073,125) PIXEL
			@ 056, 006 BUTTON oBtnL001  PROMPT "Vídeo Aula - Conceitos de MVC em AdvPL"               SIZE 285, 016 FONT oFontSub   OF oFolderPvt:aDialogs[1] ACTION (fLink(1))       PIXEL
			@ 076, 006 BUTTON oBtnL002  PROMPT "TDN - Lista de Fontes em MVC"                         SIZE 285, 016 FONT oFontSub   OF oFolderPvt:aDialogs[1] ACTION (fLink(2))       PIXEL
			@ 096, 006 BUTTON oBtnL003  PROMPT "TDN - Ponto de Entrada no Padrão MVC"                 SIZE 285, 016 FONT oFontSub   OF oFolderPvt:aDialogs[1] ACTION (fLink(3))       PIXEL
			@ 116, 006 BUTTON oBtnL004  PROMPT "Vídeo Aula - Como criar um ponto de entrada em MVC"   SIZE 285, 016 FONT oFontSub   OF oFolderPvt:aDialogs[1] ACTION (fLink(4))       PIXEL
			@ 136, 006 BUTTON oBtnL005  PROMPT "Vídeo Aula - Como criar ExecAuto em MVC"              SIZE 285, 016 FONT oFontSub   OF oFolderPvt:aDialogs[1] ACTION (fLink(5))       PIXEL
			
			//Aba Ponto de Entrada
			oEditCod := tSimpleEditor():New(0, 0, oFolderPvt:aDialogs[2], 295, 160)
		    oEditCod:Load(cPontoEnt)
		    
		    //Aba do Modelo de Dados
			oEditMod := tSimpleEditor():New(0, 0, oFolderPvt:aDialogs[3], 295, 160)
		    oEditMod:Load(cVarInfo)
			
		//Mostrando a janela
		ACTIVATE MSDIALOG oDlgPvt CENTERED
		
	Else
		MsgAlert("Não há indícios dessa tela ser em MVC (utilize dentro de uma tela de Inclusão/Alteração/Exclusão)!", "Atenção")
	EndIf
	
Return lMVC

Static Function fLink(nBotao)
	Local cLink := ""
	
	//Vídeo Aula - Conceitos de MVC em AdvPL
	If nBotao == 1
		cLink := "https://terminaldeinformacao.com/2016/04/24/vd-advpl-017/"
	
	//Lista de Fontes em MVC
	ElseIf nBotao == 2
		cLink := "http://tdn.totvs.com/display/public/PROT/Fontes+em+MVC"
	
	//Ponto de Entrada no Padrão MVC
	ElseIf nBotao == 3
		cLink := "http://tdn.totvs.com/pages/releaseview.action?pageId=208345968"
	
	//Vídeo Aula - Como criar um ponto de entrada em MVC
	ElseIf nBotao == 4
		cLink := "https://terminaldeinformacao.com/2017/01/16/vd-advpl-023/"
	
	//Vídeo Aula - Como criar ExecAuto em MVC
	ElseIf nBotao == 5
		cLink := "https://terminaldeinformacao.com/2017/01/23/vd-advpl-024/"
	EndIf
	
	//Abrindo o link
	ShellExecute("Open", cLink, "", "", 1)
Return

Static Function fPontoEnt(cID)
	Local cPonto      := ""
	Local cQuebra     := "<br>"
	Local cTab        := Replicate("&nbsp;", 4)
	Local cAbreComent := '<font color="green">'
	Local cFechComent := '</font>'
	Local cAbreString := '<font color="red">'
	Local cFechString := '</font>'
	
	//Cria o fonte do ponto de Entrada
	cPonto := '<font face="consolas" size="4">'
	cPonto += cAbreComent + '//Bibliotecas' + cFechComent + cQuebra
	cPonto += '#Include "Protheus.ch" ' + cQuebra
	cPonto += ' ' + cQuebra
	cPonto += cAbreComent
	cPonto += '/*/{Protheus.doc} ' + cID + cQuebra
	cPonto += 'Exemplo de Ponto de Entrada em MVC ' + cQuebra
	cPonto += '<b>@author</b> zIsMVC ' + cQuebra
	cPonto += '<b>@since</b> ' + dToC(Date()) + cQuebra
	cPonto += '<b>@version</b> 1.0 ' + cQuebra
	cPonto += '<b>@type</b> function ' + cQuebra
	cPonto += '<b>@obs</b> Deixar o nome do prw como: ' + cID + '_pe.prw ' + cQuebra
	cPonto += '/*/ ' + cQuebra
	cPonto += cFechComent
	cPonto += ' ' + cQuebra
	cPonto += 'User Function ' + cID + '() ' + cQuebra
	cPonto += cTab + 'Local aParam := PARAMIXB ' + cQuebra
	cPonto += cTab + 'Local xRet := .T. ' + cQuebra
	cPonto += cTab + 'Local oObj := Nil ' + cQuebra
	cPonto += cTab + 'Local cIdPonto := ' + cAbreString + '""' + cFechString + ' ' + cQuebra
	cPonto += cTab + 'Local cIdModel := ' + cAbreString + '""' + cFechString + ' ' + cQuebra
	cPonto += cTab + 'Local nOper := 0 ' + cQuebra
	cPonto += cTab + 'Local cCampo := ' + cAbreString + '""' + cFechString + ' ' + cQuebra
	cPonto += cTab + 'Local cTipo := ' + cAbreString + '""' + cFechString + ' ' + cQuebra
	cPonto += cTab + ' ' + cQuebra
	cPonto += cTab + cAbreComent + '//Se tiver parâmetros' + cFechComent + cQuebra
	cPonto += cTab + 'If aParam != Nil ' + cQuebra
	cPonto += cTab + cTab + 'ConOut("> "+aParam[2]) ' + cQuebra
	cPonto += cTab + cTab + ' ' + cQuebra
	cPonto += cTab + cTab + cAbreComent + '//Pega informações dos parâmetros' + cFechComent + cQuebra
	cPonto += cTab + cTab + 'oObj := aParam[1] ' + cQuebra
	cPonto += cTab + cTab + 'cIdPonto := aParam[2] ' + cQuebra
	cPonto += cTab + cTab + 'cIdModel := aParam[3] ' + cQuebra
	cPonto += cTab + cTab + ' ' + cQuebra
	cPonto += cTab + cTab + cAbreComent + '//Valida a abertura da tela' + cFechComent + cQuebra
	cPonto += cTab + cTab + 'If cIdPonto == ' + cAbreString + '"MODELVLDACTIVE"' + cFechString + ' ' + cQuebra
	cPonto += cTab + cTab + cTab + 'xRet := .T. ' + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//nOper := oObj:nOperation' + cFechComent + cQuebra
	cPonto += cTab + cTab + cTab + ' ' + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//Se for Exclusão, não permite abrir a tela' + cFechComent + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//If nOper == 5' + cFechComent + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//' + cTab + 'xRet := .F.' + cFechComent + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//EndIf' + cFechComent + cQuebra
	cPonto += cTab + cTab + cTab + ' ' + cQuebra
	cPonto += cTab + cTab + cAbreComent + '//Pré configurações do Modelo de Dados' + cFechComent + cQuebra
	cPonto += cTab + cTab + 'ElseIf cIdPonto == ' + cAbreString + '"MODELPRE"' + cFechString + ' ' + cQuebra
	cPonto += cTab + cTab + cTab + 'xRet := .T. ' + cQuebra
	cPonto += cTab + cTab + cTab + ' ' + cQuebra
	cPonto += cTab + cTab + cAbreComent + '//Pré configurações do Formulário de Dados' + cFechComent + cQuebra
	cPonto += cTab + cTab + 'ElseIf cIdPonto == ' + cAbreString + '"FORMPRE"' + cFechString + ' ' + cQuebra
	cPonto += cTab + cTab + cTab + 'xRet := .T. ' + cQuebra
	cPonto += cTab + cTab + cTab + ' ' + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//nOper  := oObj:GetModel(cIdPonto):nOperation' + cFechComent + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//cTipo  := aParam[4]' + cFechComent + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//cCampo := aParam[5]' + cFechComent + cQuebra
	cPonto += cTab + cTab + cTab + ' ' + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//Se for Alteração' + cFechComent + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//If nOper == 4' + cFechComent + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//Não permite alteração dos campos' + cFechComent + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//' + cTab + 'If cTipo == "CANSETVALUE" .And. Alltrim(cCampo) $ ("CAMPO1;CAMPO2;CAMPO3")' + cFechComent + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//' + cTab + cTab + 'xRet := .F.' + cFechComent + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//' + cTab + 'EndIf' + cFechComent + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//EndIf' + cFechComent + cQuebra
	cPonto += cTab + cTab + cTab + '' + cQuebra
	cPonto += cTab + cTab + cAbreComent + '//Adição de opções no Ações Relacionadas dentro da tela' + cFechComent + cQuebra
	cPonto += cTab + cTab + 'ElseIf cIdPonto == ' + cAbreString + '"BUTTONBAR"' + cFechString + ' ' + cQuebra
	cPonto += cTab + cTab + cTab + 'xRet := {}' + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//aAdd(xRet, {"* Titulo 1", "", {|| Alert("Botão 1")}, "Tooltip 1"})' + cFechComent + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//aAdd(xRet, {"* Titulo 2", "", {|| Alert("Botão 2")}, "Tooltip 2"})' + cFechComent + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//aAdd(xRet, {"* Titulo 3", "", {|| Alert("Botão 3")}, "Tooltip 3"})' + cFechComent + cQuebra
	cPonto += cTab + cTab + cTab + cQuebra
	cPonto += cTab + cTab + cAbreComent + '//Pós configurações do Formulário' + cFechComent + cQuebra
	cPonto += cTab + cTab + 'ElseIf cIdPonto == ' + cAbreString + '"FORMPOS"' + cFechString + ' ' + cQuebra
	cPonto += cTab + cTab + cTab + 'xRet := .T. ' + cQuebra
	cPonto += cTab + cTab + cTab + ' ' + cQuebra
	cPonto += cTab + cTab + cAbreComent + '//Validação ao clicar no Botão Confirmar' + cFechComent + cQuebra
	cPonto += cTab + cTab + 'ElseIf cIdPonto == ' + cAbreString + '"MODELPOS"' + cFechString + ' ' + cQuebra
	cPonto += cTab + cTab + cTab + 'xRet := .T. ' + cQuebra
	cPonto += cTab + cTab + cTab + ' ' + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//Se o campo de contato estiver em branco, não permite prosseguir' + cFechComent + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//If Empty(M->CAMPO1)' + cFechComent + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//' + cTab + 'Aviso("Atenção", "Por favor, informe o Campo!", {"OK"}, 03)' + cFechComent + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//' + cTab + 'xRet := .F.' + cFechComent + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//EndIf' + cFechComent + cQuebra
	cPonto += cTab + cTab + cTab + ' ' + cQuebra
	cPonto += cTab + cTab + cAbreComent + '//Pré validações do Commit' + cFechComent + cQuebra
	cPonto += cTab + cTab + 'ElseIf cIdPonto == ' + cAbreString + '"FORMCOMMITTTSPRE"' + cFechString + ' ' + cQuebra
	cPonto += cTab + cTab + cTab + ' ' + cQuebra
	cPonto += cTab + cTab + cAbreComent + '//Pós validações do Commit' + cFechComent + cQuebra
	cPonto += cTab + cTab + 'ElseIf cIdPonto == ' + cAbreString + '"FORMCOMMITTTSPOS"' + cFechString + ' ' + cQuebra
	cPonto += cTab + cTab + cTab + ' ' + cQuebra
	cPonto += cTab + cTab + cAbreComent + '//Commit das operações (antes da gravação)' + cFechComent + cQuebra
	cPonto += cTab + cTab + 'ElseIf cIdPonto == ' + cAbreString + '"MODELCOMMITTTS"' + cFechString + ' ' + cQuebra
	cPonto += cTab + cTab + cTab + ' ' + cQuebra
	cPonto += cTab + cTab + cAbreComent + '//Commit das operações (após a gravação)' + cFechComent + cQuebra
	cPonto += cTab + cTab + 'ElseIf cIdPonto == ' + cAbreString + '"MODELCOMMITNTTS"' + cFechString + ' ' + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//nOper := oObj:nOperation' + cFechComent + cQuebra
	cPonto += cTab + cTab + cTab + ' ' + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//Se for inclusão, mostra mensagem de sucesso' + cFechComent + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//If nOper == 3' + cFechComent + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//' + cTab + 'Aviso("Atenção", "Registro incluido com sucesso!", {"OK"}, 03)' + cFechComent + cQuebra
	cPonto += cTab + cTab + cTab + cAbreComent + '//EndIf' + cFechComent + cQuebra
	cPonto += cTab + cTab + 'EndIf ' + cQuebra
	cPonto += cTab + 'EndIf ' + cQuebra
	cPonto += 'Return xRet'
	cPonto += '</font>'
	
	//Palavras reservadas deixando em negrito
	cPonto := StrTran(cPonto, "ElseIf",        "<b>ElseIf</b>")
	cPonto := StrTran(cPonto, "EndIf",         "<b>EndIf</b>")
	cPonto := StrTran(cPonto, "If",            "<b>If</b>")
	cPonto := StrTran(cPonto, "Return",        "<b>Return</b>")
	cPonto := StrTran(cPonto, ":=",            "<b>:=</b>")
	cPonto := StrTran(cPonto, "!=",            "<b>!=</b>")
	cPonto := StrTran(cPonto, "==",            "<b>==</b>")
	cPonto := StrTran(cPonto, "Local",         "<b>Local</b>")
	cPonto := StrTran(cPonto, "User Function", "<b>User Function</b>")
	cPonto := StrTran(cPonto, "#Include",      "<b>#Include</b>")
	
Return cPonto