/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} zFonte04
Demonstrando tipos de dados em AdvPL
@author Atilio
@since 15/02/2020
@version 1.0
@type function
@see https://tdn.totvs.com/display/tec/Tipos+de+Dados
/*/

User Function zFonte04()
	Local aArea := GetArea()

	//Declarando da forma antiga
	fFormaAnt()
	
	//Declarando da forma nova
	fFormaNov()
	
	RestArea(aArea)
Return

/*/{Protheus.doc} fFormaAnt
Função que demonstra a tipagem de dados da forma antiga
@author Atilio
@since 15/02/2020
@version 1.0
@type function
/*/

Static Function fFormaAnt()
	Local cNome     := ""
	Local nIdade    := 0
    Local lCurso    := .T.
	Local dDataNasc := sToD("")
    Local xVariavel := Nil
    Local oFont     := TFont():New()
    Local bBloco    := {|| }
	Local aDados    := {}
    Local jInfo     := JsonObject():New()
Return

/*/{Protheus.doc} fFormaNov
Função que demonstra a tipagem de dados da forma nova
@author Atilio
@since 15/02/2020
@version 1.0
@type function
@see https://tdn.totvs.com/display/tec/Tipagem+de+Dados
/*/

Static Function fFormaNov()
	Local cNome     := ""                 AS Character
	Local nIdade    := 0                  AS Numeric
    Local lCurso    := .T.                AS Logical
	Local dDataNasc := sToD("")           AS Date
    Local xVariavel := Nil                AS Variant
    Local oFont     := TFont():New()      AS Object
    Local bBloco    := {|| }              AS CodeBlock
    Local aDados    := {}                 AS Array
    Local jInfo     := JsonObject():New() AS Json
Return
