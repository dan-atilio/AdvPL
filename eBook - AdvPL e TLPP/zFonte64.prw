/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} zFonte64
Criando registro com ExecAuto MVC (carregando o modelo e dando SetValue)
@author Atilio
@since 10/09/2024
@version 1.0
@type function
/*/

User Function zFonte64()
	Local aArea     := GetArea()
	Local lDeuCerto := .F.
	Local oModel
	Local oSA2Mod
	Local aErro     := {}

	//Pegando o modelo de dados, setando a operação de inclusão
	oModel := FWLoadModel("MATA020")
	oModel:SetOperation(3)
	oModel:Activate()

	//Pegando o model dos campos da SA2
	oSA2Mod:= oModel:getModel("SA2MASTER")
	oSA2Mod:setValue("A2_COD",       "F00005"        ) // Codigo 
	oSA2Mod:setValue("A2_LOJA",      "01"       ) // Loja
	oSA2Mod:setValue("A2_NOME",      "FORNECEDOR MVC"       ) // Nome             
	oSA2Mod:setValue("A2_NREDUZ",    "MVC"   ) // Nome reduz. 
	oSA2Mod:setValue("A2_END",       "RUA TESTE"   ) // Endereco
	oSA2Mod:setValue("A2_BAIRRO",    "TESTE"     ) // Bairro
	oSA2Mod:setValue("A2_TIPO",      "J"         ) // Tipo 
	oSA2Mod:setValue("A2_EST",       "SP"        ) // Estado
	oSA2Mod:setValue("A2_COD_MUN",   "06003"     ) // Codigo Municipio                
	oSA2Mod:setValue("A2_MUN",       "BAURU"    ) // Municipio
	oSA2Mod:setValue("A2_CGC",       "00000000000000"       ) // CNPJ/CPF            

	//Se conseguir validar as informações e realizar a gravação
	If oModel:VldData() .And. oModel:CommitData()
		lDeuCerto := .T.

	//Se não conseguir validar as informações, altera a variável para false
	Else
		lDeuCerto := .F.
	EndIf

	//Se deu certo a inclusão
	If lDeuCerto
        FWAlertSuccess("Registro incluido!", "Atenção")

    //Se não deu certo a inclusão, mostra a mensagem de erro
    Else
		//Busca o Erro do Modelo de Dados
		aErro := oModel:GetErrorMessage()

		//Monta o Texto que será mostrado na tela
		AutoGrLog("Id do formulário de origem:"  + ' [' + AllToChar(aErro[01]) + ']')
		AutoGrLog("Id do campo de origem: "      + ' [' + AllToChar(aErro[02]) + ']')
		AutoGrLog("Id do formulário de erro: "   + ' [' + AllToChar(aErro[03]) + ']')
		AutoGrLog("Id do campo de erro: "        + ' [' + AllToChar(aErro[04]) + ']')
		AutoGrLog("Id do erro: "                 + ' [' + AllToChar(aErro[05]) + ']')
		AutoGrLog("Mensagem do erro: "           + ' [' + AllToChar(aErro[06]) + ']')
		AutoGrLog("Mensagem da solução: "        + ' [' + AllToChar(aErro[07]) + ']')
		AutoGrLog("Valor atribuído: "            + ' [' + AllToChar(aErro[08]) + ']')
		AutoGrLog("Valor anterior: "             + ' [' + AllToChar(aErro[09]) + ']')

		//Mostra a mensagem de Erro
		MostraErro()
	EndIf

	//Desativa o modelo de dados
	oModel:DeActivate()

	RestArea(aArea)
Return
