/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/04/24/como-criar-uma-fwmbrowse-com-uma-dimensao-menor-ti-responde-0145/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "FWMVCDef.ch"

/*/{Protheus.doc} User Function MTA035MNU
Ponto de Entrada para adicionar funções no browse do grupo de produtos
@type  Function
@author Atilio
@since 12/04/2024
@see https://tdn.totvs.com/pages/releaseview.action?pageId=800585305
/*/

User Function MTA035MNU()
	Local aArea := FWGetArea()
	
	//Adicionando opção no menu do grupo de produtos
	ADD OPTION aRotina TITLE "* Produtos do Grupo" ACTION "u_zVid0145()" OPERATION 1 ACCESS 0

	FWRestArea(aArea)
Return

//Variveis Estaticas
Static cTitulo     := "Produtos do Grupo"
Static cAliasMVC   := "SB1"
Static lEmExecucao := .F.
Static cFiltro     := ""

/*/{Protheus.doc} User Function zVid0145
Browse de Produtos do Grupo
@author Atilio
@since 12/04/2024
@version 1.0
@type function
/*/

User Function zVid0145()
	Local aArea   := FWGetArea()
    Local cFunBkp := FunName()
    Local aTamanho := MsAdvSize()
    Local nJanLarg := aTamanho[5] - 200
    Local nJanAltu := aTamanho[6] - 200
    Local oDlgProdut
	Private aRotina := {}
    Private oBrowse

    SetFunName("MATA010")

    //Tratativa para impedir que seja aberta a mesma janela por cima da original do browse
	If ! lEmExecucao
        lEmExecucao := .T.
        oDlgProdut := TDialog():New(0, 0, nJanAltu, nJanLarg, cTitulo, , , , , CLR_BLACK, RGB(250, 250, 250), , , .T.)

            //Monta o Filtro conforme o registro posicionado, e trazendo somente o último
            cFiltro := "SB1->B1_GRUPO == '" + SBM->BM_GRUPO + "'"

            //Definicao do menu
            aRotina := MenuDef()

            //Instanciando o browse
            oBrowse := FWMBrowse():New()
            oBrowse:SetAlias(cAliasMVC)
            oBrowse:SetDescription(cTitulo)
            oBrowse:DisableDetails()
            oBrowse:DisableReport()
            oBrowse:SetFilterDefault(cFiltro)

            //Ativa a Browse
            oBrowse:Activate(oDlgProdut)

        oDlgProdut:Activate(, , , .T., {|| .T.}, , {|| } )
        lEmExecucao := .F.
    EndIf

    SetFunName(cFunBkp)
	FWRestArea(aArea)
Return Nil

/*/{Protheus.doc} MenuDef
Menu de opcoes
@author Atilio
@since 12/04/2024
@version 1.0
@type function
/*/

Static Function MenuDef()
	Local aRotina := {}

	//Adicionando opcoes do menu
	ADD OPTION aRotina TITLE "Visualizar Produto" ACTION "VIEWDEF.MATA010" OPERATION 1 ACCESS 0

Return aRotina

