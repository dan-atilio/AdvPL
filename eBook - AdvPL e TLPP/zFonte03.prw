/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "Totvs.ch"

//Constantes
#Define STR_NOME "Terminal de Informacao"

//Variáveis estáticas
Static dDataHoje := Date()
Static cHoraHoje := Time()

/*/{Protheus.doc} zFonte03
Demonstrando o escopo de variáveis
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
	
	//Mostrando variáveis
	MsgInfo(cNome + " " + cSobreNome + " esta em " + __cCidade + " no dia " + dToC(dDataHoje) + " as " + cHoraHoje, "Atenção")
    
	//Chamando uma função estática para demonstrar local e private
	fFuncTst()
	
	RestArea(aArea)
Return

/*/{Protheus.doc} fFuncTst
Função de teste para demonstrar variáveis locais e privadas
@author Atilio
@since 15/02/2020
@version 1.0
@type function
/*/

Static Function fFuncTst()
	Local aArea := GetArea()
	Local cNome := "..."
	
	//Mostrando o nome e sobrenome
	MsgInfo(cNome + " " + cSobreNome, "Atenção")
	
	RestArea(aArea)
Return
