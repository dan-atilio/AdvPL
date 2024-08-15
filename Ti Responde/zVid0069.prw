/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2024/08/01/como-fazer-copiar-em-mvc-ti-responde-0069/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "FWMVCDef.ch"

/*/{Protheus.doc} User Function MTA035MNU
Ponto de Entrada para adicionar funções no browse do grupo de produtos
@type  Function
@author Atilio
@since 10/11/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=800585305
/*/

User Function MTA035MNU()
	Local aArea := FWGetArea()
	
	//Adicionando opção no menu para copiar
	ADD OPTION aRotina TITLE "* Copiar" ACTION "VIEWDEF.MATA035" OPERATION 9 ACCESS 0

	FWRestArea(aArea)
Return

/*/{Protheus.doc} User Function CMA150AMNU
Ponto de Entrada para adicionar funções no browse do locais do estoque
@type  Function
@author Atilio
@since 10/11/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=268813535
/*/

User Function CMA150AMNU()
    Local aArea   := FWGetArea()
    Local aRotAux := {}
	
	//Adicionando opção no menu para copiar
	ADD OPTION aRotAux TITLE "* Copiar" ACTION "VIEWDEF.AGRA045" OPERATION 9 ACCESS 0

	FWRestArea(aArea)
Return aRotAux
