/*
    
    Esse � um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, est� dispon�vel no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "Totvs.ch"

//Constantes
#Define STR_NOME "Terminal de Informacao"

//Vari�veis est�ticas
Static dDataHoje := Date()
Static cHoraHoje := Time()

/*/{Protheus.doc} zFonte03
Demonstrando o escopo de vari�veis
@author Atilio
@since 15/02/2020
@version 1.0
@type function
/*/

User Function zFonte03()
	Local aArea        := GetArea()
	Local cNome        := "Daniel"
	Private cSobreNome := "Atilio"
	Public __cCidade   := "Bauru"
	
	//Mostrando vari�veis
	MsgInfo(cNome + " " + cSobreNome + " esta em " + __cCidade + " no dia " + dToC(dDataHoje) + " as " + cHoraHoje, "Aten��o")
    
	//Chamando uma fun��o est�tica para demonstrar local e private
	fFuncTst()
	
	RestArea(aArea)
Return

/*/{Protheus.doc} fFuncTst
Fun��o de teste para demonstrar vari�veis locais e privadas
@author Atilio
@since 15/02/2020
@version 1.0
@type function
/*/

Static Function fFuncTst()
	Local aArea := GetArea()
	Local cNome := "..."
	
	//Mostrando o nome e sobrenome
	MsgInfo(cNome + " " + cSobreNome, "Aten��o")
	
	RestArea(aArea)
Return
