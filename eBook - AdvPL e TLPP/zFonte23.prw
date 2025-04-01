/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} zFonte23
Demonstrando operadores em AdvPL
@author Atilio
@since 05/03/2020
@version 1.0
@type function
@see https://tdn.totvs.com/display/tec/Operadores+Comuns
/*/

User Function zFonte23()
	Local aArea  := GetArea()

    //Passando os 2 parâmetros
    fFuncao("daniel", "atilio")

    //Passando apenas 1 parâmetro (primeiro)
    fFuncao("daniel")

    //Passando apenas 1 parâmetro (segundo)
    fFuncao(, "atilio")

    //Sem passar nada para a função
    fFuncao()

    RestArea(aArea)
Return

/*/{Protheus.doc} fFuncao
Funcao de teste para alteracao de variaveis
@author Atilio
@since 05/03/2020
@version 1.0
@type function
/*/

Static Function fFuncao(cVar1, cVar2)
    Default cVar1 := "Teste"
    Default cVar2 := "Teste 2"

    Alert("cVar1: " + cVar1 + CRLF + "cVar2: " + cVar2)
Return
