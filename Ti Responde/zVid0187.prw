/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/09/18/validar-se-uma-grid-esta-vazia-em-um-ponto-de-entrada-em-mvc-ti-responde-0187/ 
    
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function CTBA020
Plano de Contas
@author Atilio
@since 28/06/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
     *-------------------------------------------------*
     Por se tratar de um p.e. em MVC, salve o nome do 
     arquivo diferente, por exemplo, CTBA020_pe.prw 
     *-----------------------------------------------*
     A documentacao de como fazer o p.e. esta disponivel em https://tdn.totvs.com/pages/releaseview.action?pageId=208345968 
@see http://autumncodemaker.com
/*/

User Function CTBA020()
	Local aArea := FWGetArea()
	Local aParam := PARAMIXB 
	Local xRet := .T.
	Local oObj := Nil
	Local cIdPonto := ""
	Local cIdModel := ""
    Local oModelCtb
    Local oModelCVD
	
	//Se tiver parametros
	If aParam != Nil
		
		//Pega informacoes dos parametros
		oObj := aParam[1]
		cIdPonto := aParam[2]
		cIdModel := aParam[3]
		
		//Na validacao total do formulario 
		If cIdPonto == "FORMPOS" 
			xRet := .T. 
			
            //Pega o modelo ativo
            oModelCtb := FWModelActive()

            //Pega o modelo da tabela CVD (Plano de Contas Referencial)
            oModelCVD := oModelCtb:GetModel("CVDDETAIL")

            //Se o modelo tiver vazio (não tiver nenhuma informação nele)
            If oModelCVD:IsEmpty()
                ExibeHelp("Help_CTBA020", "É obrigatório o preenchimento do Plano de Contas Referencial (tabela CVD)", "Insira pelo menos 1 linha no Plano de Contas Referencial")
                xRet := .F.
            EndIf
		EndIf
		
	EndIf
	
	FWRestArea(aArea)
Return xRet
