/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


/* 1 . Bibliotecas e Constantes */

//Bibliotecas
#Include "Totvs.ch"

/* 2 . Documentação da Função / Identificação */

/*/{Protheus.doc} zFonte01
Demonstrando a estrutura de um program em AdvPL
@author Atilio
@since 15/02/2020
@version 1.0
@type function
@obs A linguagem é estruturada, ou seja, um comando será executado por vez
	Além disso, ela tem limitações no nome de funções e variáveis
@see https://tdn.totvs.com/display/tec/ProtheusDOC
/*/

/* 3 . Abertura de um programa */

User Function zFonte01()
	Local aArea    := FWGetArea()
	Local dDataAtu := Date()
	Local cHoraAtu := Time()
	Local cNome    := "eBook de AdvPL e TLPP"
	
	/* 4 . Corpo do programa */
	MsgInfo("Estamos no [" + cNome + "], hoje é " + dToC(dDataAtu) + ", às " + cHoraAtu, "Atenção")
	MsgInfo("Ontem seria " + dToC(DaySub(dDataAtu, 1)), "Atenção")
	MsgInfo("Mês passado seria " + dToC(MonthSub(dDataAtu, 1)), "Atenção")
	
	/* 5 . Encerramento do programa */
	FWRestArea(aArea)
Return
