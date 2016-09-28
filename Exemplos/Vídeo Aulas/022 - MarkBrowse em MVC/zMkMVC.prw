//Bibliotecas
#Include 'Protheus.ch'
#Include 'FwMVCDef.ch'

/*/{Protheus.doc} zMkMVC
MarkBrow em MVC da tabela de Artistas
@author Atilio
@since 03/09/2016
@version 1.0
@obs Criar a coluna ZZ1_OK com o tamanho 2 no Configurador e deixar como não usado
/*/

User Function zMkMVC()
	Private oMark
	
	//Criando o MarkBrow
	oMark := FWMarkBrowse():New()
	oMark:SetAlias('ZZ1')
	
	//Setando semáforo, descrição e campo de mark
	oMark:SetSemaphore(.T.)
	oMark:SetDescription('Seleção do Cadastro de Artistas')
	oMark:SetFieldMark( 'ZZ1_OK' )
	
	//Setando Legenda
	oMark:AddLegend( "ZZ1->ZZ1_COD <= '000005'", "GREEN",	"Menor ou igual a 5" )
	oMark:AddLegend( "ZZ1->ZZ1_COD >  '000005'", "RED",	"Maior que 5" )
	
	//Ativando a janela
	oMark:Activate()
Return NIL

/*---------------------------------------------------------------------*
 | Func:  MenuDef                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  03/09/2016                                                   |
 | Desc:  Criação do menu MVC                                          |
 *---------------------------------------------------------------------*/
 
Static Function MenuDef()
	Local aRotina := {}
	
	//Criação das opções
	ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.zModel1' OPERATION 2 ACCESS 0
	ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.zModel1' OPERATION 4 ACCESS 0
	ADD OPTION aRotina TITLE 'Processar'  ACTION 'u_zMarkProc'     OPERATION 2 ACCESS 0
	ADD OPTION aRotina TITLE 'Legenda'    ACTION 'u_zMod1Leg'      OPERATION 2 ACCESS 0
Return aRotina

/*---------------------------------------------------------------------*
 | Func:  ModelDef                                                     |
 | Autor: Daniel Atilio                                                |
 | Data:  03/09/2016                                                   |
 | Desc:  Criação do modelo de dados MVC                               |
 *---------------------------------------------------------------------*/
 
Static Function ModelDef()
Return FWLoadModel('zModel1')

/*---------------------------------------------------------------------*
 | Func:  ViewDef                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  03/09/2016                                                   |
 | Desc:  Criação da visão MVC                                         |
 *---------------------------------------------------------------------*/
 
Static Function ViewDef()
Return FWLoadView('zModel1')

/*/{Protheus.doc} zMarkProc
Rotina para processamento e verificação de quantos registros estão marcados
@author Atilio
@since 03/09/2016
@version 1.0
/*/

User Function zMarkProc()
	Local aArea    := GetArea()
	Local cMarca   := oMark:Mark()
	Local lInverte := oMark:IsInvert()
	Local nCt      := 0
	
	//Percorrendo os registros da ZZ1
	ZZ1->(DbGoTop())
	While !ZZ1->(EoF())
		//Caso esteja marcado, aumenta o contador
		If oMark:IsMark(cMarca)
			nCt++
			
			//Limpando a marca
			RecLock('ZZ1', .F.)
				ZZ1_OK := ''
			ZZ1->(MsUnlock())
		EndIf
		
		//Pulando registro
		ZZ1->(DbSkip())
	EndDo
	
	//Mostrando a mensagem de registros marcados
	MsgInfo('Foram marcados <b>' + cValToChar( nCt ) + ' artistas</b>.', "Atenção")
	
	//Restaurando área armazenada
	RestArea(aArea)
Return NIL