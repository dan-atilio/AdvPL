/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/13/interceptando-modelo-ou-view-em-mvc-com-fwmodelactive-e-fwviewactive-maratona-advpl-e-tl-233/
*/


//Bibliotecas
#Include "Totvs.ch"
#Include "FWMVCDef.ch"

/*/{Protheus.doc} User Function zExe233
Busca o Modelo ou a Visualização em memória
@type Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/display/public/framework/FWModelActive e https://tdn.totvs.com/display/public/framework/FWViewActive
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe233()
    Local aArea       := FWGetArea()
    Local oModel      := FWModelActive()
    Local oModelGrid  := oModel:GetModel("DA1DETAIL")
    Local oView       := FWViewActive()

    //Altera um campo da memória
    oModel:SetValue("DA0MASTER", "DA0_DESCRI", "Olá - " + Time())

    //Posiciona na terceira linha e atualiza a tela
    oModelGrid:GoLine(3)
    oView:Refresh()

    FWRestArea(aArea)
Return

/*/{Protheus.doc} User Function OMSA010
Ponto de Entrada na Tabela de Preços em MVC
@author Atilio
@since 09/10/2022
@version 1.0
/*/

User Function OMSA010()
	Local aArea := FWGetArea()
	Local aParam := PARAMIXB 
	Local xRet := .T.
	Local oObj := Nil
	Local cIdPonto := ""
	Local cIdModel := ""
	
	//Se tiver parametros
	If aParam != Nil
		
		//Pega informacoes dos parametros
		oObj := aParam[1]
		cIdPonto := aParam[2]
		cIdModel := aParam[3]

		//Para a inclusao de botoes na ControlBar 
		If cIdPonto == "BUTTONBAR" 
			xRet := {} 
			aAdd(xRet, {"* Atualizar Tela",        "", {|| u_zExe233()}, "Atu. Tela"})
		EndIf
		
	EndIf
	
	FWRestArea(aArea)
Return xRet
