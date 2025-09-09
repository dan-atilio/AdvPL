/*
    
    Esse � um exemplo disponibilizado no Terminal de Informa��o 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/08/28/execauto-no-cadastro-de-filiais-tabela-sm0-ti-responde-0181/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "FWMVCDef.ch"

/*/{Protheus.doc} User Function zVid0181
Exemplo de ExecAuto do cadastro de Filiais (SM0 / SYS_COMPANY)
@type  Function
@author Atilio
@since 26/06/2024
@example u_zVid0181()
/*/

User Function zVid0181()
    Local aArea     := FWGetArea()
    Local oModel
    Local oModelXX8
    Local oModelSM0
    Local lDeuCerto := .F.
    Local aErro     := {}

    //Pegando o modelo de dados, setando a opera��o de inclus�o
	oModel := FWLoadModel("APCFG230")
	oModel:SetOperation(MODEL_OPERATION_INSERT)
	oModel:Activate()

    //Define os campos do cabe�alho
    oModelXX8 := oModel:GetModel("SIGAMAT_XX8")
    oModelXX8:SetValue("XX8_GRPEMP", "99"                ) //Grupo de Empresas
    oModelXX8:SetValue("XX8_CODIGO", "03"                ) //C�digo da Filial
    oModelXX8:SetValue("XX8_DESCRI", "Filial de Teste"   ) //Descri��o da FIlial

    //Define os campos das abas abaixo
    oModelSM0 := oModel:GetModel("SIGAMAT_SM0")
    oModelSM0:SetValue("M0_NOMECOM", "Filial Teste em Bauru")
    oModelSM0:SetValue("M0_TEL",     "14 91234 5678")
    oModelSM0:SetValue("M0_ENDENT",  "Rua de Teste 3-21")
    oModelSM0:SetValue("M0_BAIRENT", "Jardim de Teste")
    oModelSM0:SetValue("M0_CIDENT",  "Bauru")
    oModelSM0:SetValue("M0_ESTENT",  "SP")     

	//Se conseguir validar as informa��es e realizar o commit
	If oModel:VldData() .And. oModel:CommitData()
		lDeuCerto := .T.

	//Se n�o conseguir validar as informa��es, altera a vari�vel para false
	Else
		lDeuCerto := .F.
	EndIf

	//Se n�o deu certo a inclus�o, mostra a mensagem de erro
	If ! lDeuCerto
		//Busca o Erro do Modelo de Dados
		aErro := oModel:GetErrorMessage()

		//Monta o Texto que ser� mostrado na tela
		AutoGrLog("Id do formul�rio de origem:"  + ' [' + AllToChar(aErro[01]) + ']')
		AutoGrLog("Id do campo de origem: "      + ' [' + AllToChar(aErro[02]) + ']')
		AutoGrLog("Id do formul�rio de erro: "   + ' [' + AllToChar(aErro[03]) + ']')
		AutoGrLog("Id do campo de erro: "        + ' [' + AllToChar(aErro[04]) + ']')
		AutoGrLog("Id do erro: "                 + ' [' + AllToChar(aErro[05]) + ']')
		AutoGrLog("Mensagem do erro: "           + ' [' + AllToChar(aErro[06]) + ']')
		AutoGrLog("Mensagem da solu��o: "        + ' [' + AllToChar(aErro[07]) + ']')
		AutoGrLog("Valor atribu�do: "            + ' [' + AllToChar(aErro[08]) + ']')
		AutoGrLog("Valor anterior: "             + ' [' + AllToChar(aErro[09]) + ']')

		//Mostra a mensagem de Erro
		MostraErro()
	EndIf

	//Desativa o modelo de dados
	oModel:DeActivate()

    FWRestArea(aArea)
Return
