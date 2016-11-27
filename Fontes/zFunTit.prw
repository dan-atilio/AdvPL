//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zFunTit
Função que retorna o título da rotina em Execução
@type function
@author Atilio
@since 26/11/2016
@version 1.0
@return cTitle, Título da Rotina atual
	@example
	MsgInfo("Estou na rotina <b>'"+u_zFunTit()+"'</b>", "Atenção")
/*/

User Function zFunTit()
	Local aArea := GetArea()
	Local cTitle := ""
	
	//Se estiver instanciado no Objeto
	If Type("oApp:oMainWnd:cTitle") == "C"
		cTitle := oApp:oMainWnd:cTitle
		
		//Se tiver um colchetes, pega o texto até a posição inicial do colchete
		If '[' $ cTitle
			cTitle := SubStr(cTitle, 1, At('[', cTitle)-1)
		EndIf
		
		cTitle := Alltrim(cTitle)
	EndIf
	
	RestArea(aArea)
Return cTitle