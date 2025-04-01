/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "Totvs.ch"
#Include "FWMVCDef.ch"

/*/{Protheus.doc} User Function OMSA010
P.E. Tabela de Preço
@author Atilio
@since 20/08/2023
@version 1.0
@type function
@see https://tdn.totvs.com/pages/releaseview.action?pageId=208345968
/*/

User Function OMSA010()
	Local aArea := FWGetArea()
	Local aParam := PARAMIXB 
	Local xRet := .T.
	Local oObj := Nil
	Local cIdPonto := ""
	Local cIdModel := ""
    Local nOper := 0
	Local oModel
	Local oModelDA0
	Local oModelDA1
	Local oModelStruct
	Local aBkpRows := {}
	Local dDataAte := sToD("")
	Local cAtivo := ""
	Local dDataHoj := sToD("")
	Local nLinha := 0
	Local cCorpo := ""
	Local cAssunto := ""
	Local cPara := ""
	
	//Se tiver parametros
	If aParam != Nil
		
		//Pega informacoes dos parametros
		oObj := aParam[1]
		cIdPonto := aParam[2]
		cIdModel := aParam[3]
		
		//Na validação do modelo 
		If cIdPonto == "MODELVLDACTIVE" 
			nOper := oObj:nOperation

			//Se for Exclusão, não permite abrir a tela
			If nOper == 5
				ExibeHelp("Help_OMSA010_MODELVLDACTIVE", "Não é permitido excluir tabelas de preço", "Contate o Administrador")
				xRet := .F.
			EndIf
			
		//Antes da alteracao de qualquer campo do modelo 
		ElseIf cIdPonto == "MODELPRE" 
			xRet := .T. 

			//Se for alteração, desativa o campo data inicial
			nOper := oObj:nOperation
			If nOper == 4

				//Pega a view em memória
				oModel := FWModelActive()
				If ValType(oModel) == "O"
					oModelStruct := oModel:GetModel('DA0MASTER'):GetStruct()
					oModelStruct:SetProperty("DA0_DATDE", MODEL_FIELD_WHEN, FWBuildFeature(STRUCT_FEATURE_WHEN, '.F.'))
				EndIf
			EndIf
			
		//Na validacao total do formulario 
		ElseIf cIdPonto == "FORMPOS" 
			xRet := .T. 

			//Pega os campos de data até e ativo
			oModel := FWModelActive()
			dDataAte := oModel:GetValue("DA0MASTER", "DA0_DATATE")
			cAtivo   := oModel:GetValue("DA0MASTER", "DA0_ATIVO")
			dDataHoj := Date()

			//Se a data até for menor que o dia atual
			If ! Empty(dDataAte) .And. dDataAte <= dDataHoj

				//Se o registro ainda esta ativo, avisa o usuário
				If cAtivo == "1"
					ExibeHelp("Help_OMSA010_FORMPOS", "Essa tabela esta expirada, mas o campo de Tabela Ativa esta como Sim", "Altere o campo Tabela Ativa para Não!")
					xRet := .F.
				EndIf

			EndIf
			
		//Na validacao total da linha do formulario FWFORMGRID 
		ElseIf cIdPonto == "FORMLINEPOS" 
			xRet := .T. 

			//Pega os models
			oModel    := FWModelActive()
			oModelDA1 := oModel:GetModel("DA1DETAIL")

			//Se o tipo de operação for estadual, mas o campo preço máximo estiver vazio
			If oModelDA1:GetValue("DA1_TPOPER") == "1" .And. oModelDA1:GetValue("DA1_PRCMAX") == 0
				ExibeHelp("Help_OMSA010_FORMLINEPOS", "Para operação estadual, o preço máximo é obrigatório", "Informe o campo Preço Máximo")
				xRet := .F.
			EndIf
			
		//Apos a gravacao total do modelo e fora da transacao 
		ElseIf cIdPonto == "MODELCOMMITNTTS" 

			//Se for inclusão
			nOper := oObj:nOperation
			If nOper == 3

				//Pega os models
				oModel    := FWModelActive()
				oModelDA0 := oModel:GetModel("DA0MASTER")
				oModelDA1 := oModel:GetModel("DA1DETAIL")
				aBkpRows  := FWSaveRows()

				//Dispara uma mensagem de eMail
				cCorpo := '<p>Olá.</p>'
				cCorpo += '<p>Foi incluido uma nova tabela de preço no sistema:</p>'
				cCorpo += '<p><b>Tabela:</b> '     + oModelDA0:GetValue("DA0_CODTAB") + '</p>'
				cCorpo += '<p><b>Descrição:</b> '  + oModelDA0:GetValue("DA0_DESCRI") + '</p>'
				cCorpo += '<center>'
				cCorpo += '<table>'
				cCorpo += '<tr>'
				cCorpo += '<td><b>Produto</b></td>'
				cCorpo += '<td><b>Descrição</b></td>'
				cCorpo += '<td><b>Preço</b></td>'
				cCorpo += '</tr>'
				//Percorrendo a grid com os itens
				For nLinha := 1 To oModelDA1:Length()

					//Posicionando na linha atual
					oModelDA1:GoLine(nLinha)
					cCorpo += '<tr>'
					cCorpo += '<td>' + oModelDA1:GetValue("DA1_CODPRO") + '</td>'
					cCorpo += '<td>' + Posicione('SB1', 1, FWxFilial('SB1') + oModelDA1:GetValue("DA1_CODPRO") , 'B1_DESC') + '</td>'
					cCorpo += '<td>' + Transform(oModelDA1:GetValue("DA1_PRCVEN"), "@E 999,999.99") + '</td>'
					cCorpo += '</tr>'
				Next
				cCorpo += '</table>'
				cCorpo += '</center>'
				cCorpo += '<p>Mensagem disparada na data <em>' + dToC(Date()) + '</em> às <em>' +Time() + '</em>.</p>'

				//Realiza o disparo do eMail
				cAssunto := "Tabela #" + oModelDA0:GetValue("DA0_CODTAB")
				cPara    := "contato@atiliosistemas.com"
				GPEMail(cAssunto, cCorpo, cPara, /*aAnexos*/, /*lExibeHelp*/)
				FWRestRows(aBkpRows)
			EndIf
			
		//No cancelamento do botao 
		ElseIf cIdPonto == "MODELCANCEL" 
			xRet := .T. 

            //Se for inclusão ou alteração, desativa atalhos
            nOper := oObj:nOperation
			If nOper == 3 .Or. nOper == 4
				fDesAtalho()
			EndIf
			
		//Para a inclusao de botoes na ControlBar 
		ElseIf cIdPonto == "BUTTONBAR" 
			xRet := {} 
            
            //Adiciona botões no Outras Ações
			aAdd(xRet, {"* Atualizar Descrição", "", {|| u_zFonte59()}, ""})

            //Se for inclusão ou alteração, ativa atalhos
			nOper := oObj:nOperation
			If nOper == 3 .Or. nOper == 4
				fAtiAtalho()
			EndIf
			
		EndIf
		
	EndIf
	
	FWRestArea(aArea)
Return xRet

/*/{Protheus.doc} User Function zFonte59
Função de teste para atualizar um campo
@type  Function
@author Atilio
@since 20/08/2023
/*/

User Function zFonte59()
    Local aArea     := FWGetArea()
    Local aPergs    := {}
    Local oModelPad := FWModelActive()
	Local oView     := FWViewActive()
    Local cDescri   := oModelPad:GetValue("DA0MASTER", "DA0_DESCRI")
    
    //Adicionando os parametros que serão digitados
    aAdd(aPergs, {1, "Descrição",  cDescri,  "",     "NaoVazio()", "", ".T.", 80,  .T.})
    
    If ParamBox(aPergs, "Informe os parâmetros", , , , , , , , , .F., .F.)
        //Atualiza o valor
        cDescri := MV_PAR01
        oModelPad:SetValue("DA0MASTER", "DA0_DESCRI", cDescri)
		oView:Refresh()
    EndIf

    FWRestArea(aArea)
Return

//Desativa atalhos
Static Function fDesAtalho()
    SetKey(VK_F7, Nil)
	SetKey(VK_F8, Nil)
Return

//Ativa atalhos
Static Function fAtiAtalho()
    SetKey(VK_F7, {|| FWAlertInfo("Olá, essa é uma mensagem de teste!", "Atenção")  })
	SetKey(VK_F8, {|| u_zFonte59()  })
Return
