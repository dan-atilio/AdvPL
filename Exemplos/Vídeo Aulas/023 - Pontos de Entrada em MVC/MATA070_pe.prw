/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2017/01/16/vd-advpl-023/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"
#Include "FWMVCDef.ch"

/*---------------------------------------------------------------------------------------------------------------------------*
 | P.E.:  MATA070                                                                                                            |
 | Autor: Daniel Atilio                                                                                                      |
 | Data:  23/10/2016                                                                                                         |
 | Desc:  Ponto de entrada MVC no cadastro de Bancos                                                                         |
 | Obs.:  Ao criar um P.E. em MVC com o mesmo nome do ModelDef, deixe o nome do prw com outro nome, por exemplo,             |
 |        MATAXXX_pe.prw                                                                                                     |
 | Ref.:  http://tdn.totvs.com/display/public/mp/Pontos+de+Entrada+para+fontes+Advpl+desenvolvidos+utilizando+o+conceito+MVC |
 *---------------------------------------------------------------------------------------------------------------------------*/


User Function MATA070()
	Local aParam     := PARAMIXB
	Local xRet       := .T.
	Local oObj       := Nil
	Local cIdPonto   := ''
	Local cIdModel   := ''
	Local nOper      := 0
	Local cCampo     := ''
	Local cTipo      := ''

	//Se tiver parâmetros
	If aParam <> NIL
		ConOut("> "+aParam[2])
		
		//Pega informações dos parâmetros
		oObj     := aParam[1]
		cIdPonto := aParam[2]
		cIdModel := aParam[3]
		
		//Valida a abertura da tela
		If cIdPonto == "MODELVLDACTIVE"
			nOper := oObj:nOperation
			
			//Se for inclusão, define o ini padrão
			If nOper == 3
				oStrucSA6 := oObj:GetModel( 'MATA070_SA6' ):GetStruct()
				oStrucSA6:SetProperty( 'A6_CONTATO', MODEL_FIELD_INIT, FwBuildFeature( STRUCT_FEATURE_INIPAD, "'AAA'" ) )
			
			//Se for Exclusão, não permite abrir a tela
			ElseIf nOper == 5
				xRet := .F.
			EndIf
		
		//Pré configurações do Modelo de Dados
		ElseIf cIdPonto == "MODELPRE"
			xRet := .T.
		
		//Pré configurações do Formulário de Dados
		ElseIf cIdPonto == "FORMPRE"
			nOper  := oObj:GetModel(cIdPonto):nOperation
			cTipo  := aParam[4]
			cCampo := aParam[5]
			
			//Se for Alteração
			If nOper == 4
				//Não permite alteração dos campos chave
				If cTipo == "CANSETVALUE" 
					If Alltrim(cCampo) $ ("A6_COD.A6_AGENCIA.A6_NUMCON")
						xRet := .F.
					EndIf
					
					oModelPad  := FWModelActive()
					oModelPad:SetValue('MATA070_SA6', 'A6_CONTATO', "BBB")
				EndIf
			EndIf
		
		//Adição de opções no Ações Relacionadas dentro da tela
		ElseIf cIdPonto == 'BUTTONBAR'
			xRet := {}
			aAdd(xRet, {"* Titulo 1", "", {|| Alert("Botão 1")}, "Tooltip 1"})
			aAdd(xRet, {"* Titulo 2", "", {|| Alert("Botão 2")}, "Tooltip 2"})
			aAdd(xRet, {"* Titulo 3", "", {|| Alert("Botão 3")}, "Tooltip 3"})
		
		//Pós configurações do Formulário
		ElseIf cIdPonto == 'FORMPOS'
			xRet := .T.
		
		//Validação ao clicar no Botão Confirmar
		ElseIf cIdPonto == 'MODELPOS'
			//Se o campo de contato estiver em branco, não permite prosseguir
			If Empty(M->A6_CONTATO)
				Aviso('Atenção', 'Por favor, informe um Contato!', {'OK'}, 03)
				xRet := .F.
			EndIf
		
		//Pré validações do Commit
		ElseIf cIdPonto == 'FORMCOMMITTTSPRE'
		
		//Pós validações do Commit
		ElseIf cIdPonto == 'FORMCOMMITTTSPOS'
			
		//Commit das operações (antes da gravação)
		ElseIf cIdPonto == 'MODELCOMMITTTS'
			
		//Commit das operações (após a gravação)
		ElseIf cIdPonto == 'MODELCOMMITNTTS'
			nOper := oObj:nOperation
			
			//Se for inclusão, mostra mensagem de sucesso
			If nOper == 3
				Aviso('Atenção', 'Banco criado com sucesso!', {'OK'}, 03)
			EndIf
		EndIf
	EndIf
Return xRet