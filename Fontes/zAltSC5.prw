//Bibliotecas
#Include "Protheus.ch"

/*------------------------------------------------------------------------------------------------------*
 | P.E.:  MA410MNU                                                                                      |
 | Autor: Daniel Atilio                                                                                 |
 | Data:  31/07/2016                                                                                    |
 | Desc:  Adição de opção no menu de ações relacionadas do Pedido de Vendas                             |
 | Links: http://tdn.totvs.com/display/public/mp/MA410MNU                                               |
 *------------------------------------------------------------------------------------------------------*/
 
User Function MA410MNU()
	Local aArea := GetArea()
	
	//Adicionando função de vincular
	aAdd(aRotina,{"* Alterar Pedido",	"U_zSC5AltPed()",	0 , 4, 0 , Nil})	
	
	RestArea(aArea)
Return

/*/{Protheus.doc} zSC5AltPed
Função teste criada para ser chamada no Ações Relacionadas do Pedido de Venda, através do P.E. MA410MNU
@type function
@author Atilio
@since 30/07/2016
@version 1.0
	@example
	u_zSC5AltPed()
/*/

User Function zSC5AltPed()
	Local aArea		:= GetArea()
	Local aAreaC5		:= SC5->(GetArea())
	Local aAreaC6		:= SC6->(GetArea())
	Local aCampos		:= {}
	Local aCampAlt	:= {}
	
	//Preenchendo os campos de alteração
	aAdd(aCampAlt, 'C5_MENNOTA')
	
	//Definindo todos os campos que serão mostrados
	aCampos := aClone(aCampAlt)
	aAdd(aCampos, 'C5_NUM')
	aAdd(aCampos, 'C5_TIPO')
	aAdd(aCampos, 'C5_CLIENTE')
	aAdd(aCampos, 'C5_LOJACLI')
	aAdd(aCampos, 'C5_CONDPAG')
	aAdd(aCampos, 'C5_EMISSAO')
	
	//Tela para alteração de pedido de venda já liberado
	u_zAltSC5(aCampos, aCampAlt)
	
	RestArea(aAreaC6)
	RestArea(aAreaC5)
	RestArea(aArea)
Return

/*/{Protheus.doc} zAltSC5
Função para alterar dados de Pedidos de Venda Liberados / Faturados
@type function
@author Atilio
@since 09/12/2015
@version 1.0
	@param aCampos, Array, Array com todos os campos que serão visualizados na SC5
	@param aCampAlt, Array, (Descrição do parâmetro)
	@example
	u_zAltSC5({"C5_NUM", "C5_MENNOTA"}, {"C5_MENNOTA"})
	@obs Como é utilizada a função Enchoice para montar a tela, os campos criados por usuários serão mostrados
	@see http://terminaldeinformacao.com
/*/

User Function zAltSC5(aCampos, aCampAlt)
	Local aArea		:= GetArea()
	Local aAreaC5		:= SC5->(GetArea())
	//Variáveis da Janela
	Local oDlgPed
	Local oGrpAco
	Local oBtnConf
	Local oBtnCanc
	Local lConfirm	:= .F.
	Local nTamBtn		:= 50
	//Tamanho da janela
	Local aTamanho	:= MsAdvSize()
	Local nJanLarg	:= aTamanho[5]
	Local nJanAltu	:= aTamanho[6]
	//Variáveis da Enchoice
	Local cAliasE		:= "SC5"
	Local nReg			:= SC5->(RecNo())
	Local aPos			:= {001, 001, (nJanAltu/2)-30, (nJanLarg/2)}
	Local nModelo		:= 1
	Local lF3			:= .T.
	Local lMemoria	:= .T.
	Local lColumn		:= .F.
	Local caTela		:= ""
	Local lNoFolder	:= .F.
	Local lProperty	:= .F.
	Local nCampAtu	:= 0
	Local bCampo		:= {|nField| Field(nField)}
	
	//Iniciando o controle de transação
	Begin Transaction
		//Cria a janela
		DEFINE MsDialog oDlgPed TITLE "Alteração de Pedido de Venda" FROM 000,000 TO nJanAltu,nJanLarg PIXEL
			//Insere os dados na memória
			RegToMemory(cAliasE, .F.)
			
			//Chama a enchoice
			Enchoice(	cAliasE,;
						nReg,;
						8,;
						/*aCRA*/,;
						/*cLetra*/,;
						/*cTexto*/,;
						aCampos,;
						aPos,;
						aCampAlt,;
						nModelo,;
						/*nColMens*/,;
						/*cMensagem*/,;
						/*cTudoOk*/,;
						oDlgPed,;
						lF3,;
						lMemoria,;
						lColumn,;
						caTela,;
						lNoFolder,;
						lProperty)
			
			//Grupo de Ações
			@ (nJanAltu/2)-27, 001 GROUP oGrpAco TO (nJanAltu/2)-3, (nJanLarg/2) PROMPT "Alteração de Pedido de Venda Liberado / Faturado: "	OF oDlgPed COLOR 0, 16777215 PIXEL
				@ (nJanAltu/2)-20, (nJanLarg/2)-((nTamBtn*1)+03) BUTTON oBtnConf PROMPT "Confirmar" SIZE nTamBtn, 013 OF oDlgPed PIXEL ACTION (lConfirm := .T., oDlgPed:End())
				@ (nJanAltu/2)-20, (nJanLarg/2)-((nTamBtn*2)+06) BUTTON oBtnCanc PROMPT "Cancelar"  SIZE nTamBtn, 013 OF oDlgPed PIXEL ACTION (lConfirm := .F., oDlgPed:End())
			
		ACTIVATE MsDialog oDlgPed CENTERED
		
		//Se a rotina for confirmada, commita a transação
		If lConfirm
			DbSelectArea(cAliasE)
			RecLock(cAliasE, .F.)
			
			//Percorrendo os campos
			For nCampAtu := 1 To FCount()
				//Se for o campo filial
				If "FILIAL" $ FieldName(nCampAtu)
				 	FieldPut(nCampAtu, FWxFilial(cAliasE))
				 
				//Senão, inputa o campo
				Else
				 	FieldPut(nCampAtu, M->&(eVal(bCampo, nCampAtu)))
				EndIf
			Next
		
			(cAliasE)->(DbCommit())
			(cAliasE)->(MsUnlock())
		
		//Senão, disarma a transação
		Else
			DisarmTransaction()
		EndIf
		
	End Transaction
	
	RestArea(aAreaC5)
	RestArea(aArea)
Return