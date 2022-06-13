//Bibliotecas
#Include "TOTVS.ch"
#Include "FWMVCDef.ch"

/*/{Protheus.doc} zVid0002
Função para "clonar" a função padrão FATA110 adicionando opções no Outras Ações
@author Atilio
@since 29/12/2021
/*/

User Function zVid0002()
    Local oBrowse     := Nil  
    Private cCadastro := "Grupos de Clientes"
    Private aRotina   := FwLoadMenuDef("FATA110")
	
	//Talvez é necessário chamar aqui o SetFunName dependendo da rotina padrão

    //Adicionar a opção no menu padrão
    ADD OPTION aRotina TITLE "* Função Teste" ACTION 'Alert("teste")'	OPERATION 8	ACCESS 0

    //Abre o browse da rotina
    oBrowse := FWMBrowse():New()
    oBrowse:SetAlias('ACY')
    oBrowse:SetDescription(cCadastro)
    oBrowse:Activate()
Return

//Busca o Model da função FATA110
Static Function ModelDef()
Return FWLoadModel('FATA110')

//Busca o View da função FATA110
Static Function ViewDef()
Return FWLoadView('FATA110')
