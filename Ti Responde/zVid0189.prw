/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/09/25/criando-um-log-de-disparo-de-emails-ti-responde-0189/ 
    
*/


//Bibliotecas
#Include "Totvs.ch"
#Include "FWMVCDef.ch"

//Variveis Estaticas
Static cTitulo := "Logs de eMail"
Static cAliasMVC := "Z38"

/*/{Protheus.doc} User Function zVid0189
Logs de eMail
@author Atilio
@since 11/09/2024
@version 1.0
@type function
@obs No GitHub (https://github.com/dan-atilio/AdvPL) tem um arquivo chamado zVid0189_dicionario.rar nele vai ter
    a SX2, a SX3 e SIX caso você queira importar. Só se atente aos seguintes campos quando for importar:
    X2_ARQUIVO
    X2_TAMFIL
    X2_TAMUN
    X2_TAMEMP
    X3_TAMANHO do campo Z38_FILIAL

    Além disso, se a tabela Z38 já existir, troque a numeração para uma disponível na sua base
/*/

User Function zVid0189()
	Local aArea   := FWGetArea()
	Local oBrowse
	Private aRotina := {}

	//Definicao do menu
	aRotina := MenuDef()

	//Instanciando o browse
	oBrowse := FWMBrowse():New()
	oBrowse:SetAlias(cAliasMVC)
	oBrowse:SetDescription(cTitulo)
	oBrowse:DisableDetails()

	//Adicionando as Legendas
	oBrowse:AddLegend( "Z38->Z38_RESULT == '1'", "BLUE",   "Enviado com Sucesso" )
	oBrowse:AddLegend( "Z38->Z38_RESULT == '2'", "RED",    "Falha no Envio" )

	//Ativa a Browse
	oBrowse:Activate()

	FWRestArea(aArea)
Return Nil

/*/{Protheus.doc} MenuDef
Menu de opcoes na funcao zVid0189
@author Atilio
@since 11/09/2024
@version 1.0
@type function
/*/

Static Function MenuDef()
	Local aRotina := {}

	//Adicionando opcoes do menu
	ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.zVid0189"   OPERATION 1 ACCESS 0
	ADD OPTION aRotina TITLE "Reenviar eMail" ACTION "U_zReenvMail()" OPERATION 1 ACCESS 0

Return aRotina

/*/{Protheus.doc} ModelDef
Modelo de dados na funcao zVid0189
@author Atilio
@since 11/09/2024
@version 1.0
@type function
/*/

Static Function ModelDef()
	Local oStruct := FWFormStruct(1, cAliasMVC)
	Local oModel
	Local bPre := Nil
	Local bPos := Nil
	Local bCommit := Nil
	Local bCancel := Nil


	//Cria o modelo de dados para cadastro
	oModel := MPFormModel():New("zMailM", bPre, bPos, bCommit, bCancel)
	oModel:AddFields("Z38MASTER", /*cOwner*/, oStruct)
	oModel:SetDescription("Modelo de dados - " + cTitulo)
	oModel:GetModel("Z38MASTER"):SetDescription( "Dados de - " + cTitulo)
	oModel:SetPrimaryKey({})
Return oModel

/*/{Protheus.doc} ViewDef
Visualizacao de dados na funcao zVid0189
@author Atilio
@since 11/09/2024
@version 1.0
@type function
/*/

Static Function ViewDef()
	Local oModel := FWLoadModel("zVid0189")
	Local oStruct := FWFormStruct(2, cAliasMVC)
	Local oView

	//Cria a visualizacao do cadastro
	oView := FWFormView():New()
	oView:SetModel(oModel)
	oView:AddField("VIEW_Z38", oStruct, "Z38MASTER")
	oView:CreateHorizontalBox("TELA" , 100 )
	oView:SetOwnerView("VIEW_Z38", "TELA")

Return oView


/*/{Protheus.doc} zIncMail
Inclusão de Log de eMail
@author Atilio
@since 11/09/2024
@version 1.0
@type function
/*/

User Function zIncMail(lResult, cResulMsg, cRemetente, cAssunto, cDestinat, cMensagem, xAnexos)
	Local aArea        := FWGetArea()
	Local cCodigo      := ""
	Local cRotina      := ""
	Local cDescri      := ""
	Local dDataEnv     := sToD("")
	Local cHoraEnv     := ""
	Local cAmbiEnv     := ""
	Local cUsrEnv      := ""
	Local cUsrNome     := ""
	Local cAnexos      := ""
	Default lResult    := .F.
	Default cResulMsg  := ""
	Default cRemetente := ""
	Default cAssunto   := ""
	Default cDestinat  := ""
	Default cMensagem  := ""
	Default xAnexos    := {}

	DbSelectArea("Z38")
	Z38->(DbSetOrder(1))

	//Monta as variáveis para gravação do log
	cCodigo  := GetSXENum("Z38", "Z38_CODIGO")
	dDataEnv := Date()
	cHoraEnv := Time()
	cAmbiEnv := GetEnvServer()
	cUsrEnv  := RetCodUsr()
	cUsrNome := UsrRetName(cUsrEnv)
    If Empty(xAnexos)
        cAnexos := ""
    ElseIf ValType(xAnexos) == "C"
        cAnexos := xAnexos
    Else
	    cAnexos  := CenArr2Str(xAnexos, "|")
    EndIf

	//Monta a rotina e descrição
	fBuscaRot(@cRotina, @cDescri)

	//Se deu certo o disparo, zera o log para não confundir
	If lResult
		cResulMsg := ""
	EndIf

	//Inclui o registro
	RecLock("Z38", .T.)
		Z38->Z38_FILIAL := FWxFilial("Z38")
		Z38->Z38_CODIGO := cCodigo
		Z38->Z38_DESCRI := cDescri
		Z38->Z38_DATA   := dDataEnv
		Z38->Z38_HORA   := cHoraEnv
		Z38->Z38_ROTINA := cRotina
		Z38->Z38_AMBIEN := cAmbiEnv
		Z38->Z38_RESULT := Iif(lResult, "1", "2")
		Z38->Z38_RESMSG := cResulMsg
		Z38->Z38_USRCOD := cUsrEnv
		Z38->Z38_USRNOM := cUsrNome
		Z38->Z38_REMETE := cRemetente
		Z38->Z38_ASSUNT := cAssunto
		Z38->Z38_DESTIN := cDestinat
		Z38->Z38_MENSAG := cMensagem
		Z38->Z38_ANEXOS := cAnexos
	Z38->(MsUnlock())
	ConfirmSX8()

	FWRestArea(aArea)
Return

Static Function fBuscaRot(cRotina, cDescri)
	Local nAtu    := 0
	Local cRotAux := "XXX"

	cRotina := "XXX"
	cDescri := "Função (menu): " + FunName()

	//Enquanto houver funções, vai pegar sempre a última
	While ! (Empty(cRotAux))
		cRotAux := Upper( Alltrim(ProcName(nAtu)) )

		If ! Alltrim(cRotAux) + ";" $ "WFLAUNCHER;U_ZENVMAIL;U_ZINCMAIL;U_ENVIARANE;U_ENVEMAIL;GPEMAIL;"
			cRotina := cRotAux
		EndIf

		nAtu++
	EndDo
Return

/*/{Protheus.doc} User Function zReenvMail
Função para reenviar email
@type  Function
@author Atilio
@since 22/02/2023
/*/

User Function zReenvMail()
	Local aArea      := FWGetArea()
	Local cPara      := Alltrim(Z38->Z38_DESTIN)
	Local cAssunto   := Alltrim(Z38->Z38_ASSUNT)
	Local cCorpo     := Alltrim(Z38->Z38_MENSAG)
	Local aAnexos    := Iif(!Empty(Z38->Z38_ANEXOS), StrTokArr(Alltrim(Z38->Z38_ANEXOS), "|"), {})
	Local lMostraLog := .T.
	Local lDeuCerto  := .F.

	//Pergunta se quer reenviar
	If FWAlertYesNo("Deseja reenviar o e-Mail posicionado?", "Confirma?")
		//Confirma os destinatários
		cPara := FWInputBox("Informe os destinatários que irão receber:", cPara)

		//Aciona o disparo do e-Mail
		Processa({|| ;
			lDeuCerto := GPEMail(;
				cAssunto,;
				cCorpo,;
                cPara,;
				aAnexos,;
				lMostraLog;
			);
		}, "Disparando o e-Mail")

		//Exibe uma mensagem de sucesso ou falha
		If lDeuCerto
			FWAlertSuccess("Sucesso no envio do eMail", "Sucesso")
		Else
			FWAlertError("Falha no disparo do e-Mail", "Falha")
		EndIf
	EndIf

	FWRestArea(aArea)
Return

/*/{Protheus.doc} User Function zTstMail
Função de teste de disparo de eMail
@type  Function
@author Atilio
@since 11/09/2024
/*/

User Function zTstMail()
    Local cAssunto    := "eMail de Teste"
    Local cCorpo      := "<p>Olá, esse é um eMail de Teste</p>"
    Local cPara       := "contato@atiliosistemas.com"
    Local aAnexos     := {}
    Local lMostraErro := .F.
    Local cMsgErro    := "N"
    Local lDeuCerto   := .T.

    //Adiciona o arquivo como anexo
    aAdd(aAnexos, "\x_imagens\logo.png")

    //Dispara o email
    lDeuCerto := GPEMail(cAssunto, cCorpo, cPara, aAnexos, lMostraErro, @cMsgErro)

    //Grava o log
    u_zIncMail(lDeuCerto, cMsgErro, GetMV("MV_RELFROM"), cAssunto, cPara, cCorpo, aAnexos)
Return
