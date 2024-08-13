/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/05/transformando-um-texto-tudo-em-maiusculo-atraves-da-upper-maratona-advpl-e-tl-519/
*/


//Bibliotecas
#Include "TOTVS.ch"

Static cVarStatic := "Ti"

/*/{Protheus.doc} User Function zExe518
Valida se uma variável ou expressão existe na memória
@type Function
@author Atilio
@since 05/04/2023
@see https://tdn.totvs.com/display/tec/Type e https://tdn.totvs.com/display/tec/ValType
@obs 

    Type
    Parâmetros
        + cExpr       , Caractere      , Indica a expressão em caractere para ser verificada
    Retorno
        + cType       , Caractere      , Retorna o tipo da expressão

    ValType
    Parâmetros
        + xParam      , Caractere      , Indica a informação que será verificada
    Retorno
        + cRet        , Caractere      , Retorna o tipo da informação

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe518()
    Local cVarLocal    := "Ti"
    Private cVarPriv   := "Ti"
    Private oFontTst   := TFont():New("Tahoma")
    Public __cVarPubl  := "Ti"
     
    FWAlertInfo(Type("cVarStatic"),     "Type - Static")                  //Retorna "U" - Indefinido
    FWAlertInfo(Type("cVarLocal"),      "Type - Local")                   //Retorna "U" - Indefinido
    FWAlertInfo(Type("cVarPriv"),       "Type - Private")                 //Retorna "C" - Caracter
    FWAlertInfo(Type("__cVarPubl"),     "Type - Public")                  //Retorna "C" - Caracter
    FWAlertInfo(Type("oFontTst:Bold"),  "Type - Atributo Ok")             //Retorna "L" - Lógico
    FWAlertInfo(Type("oFontTst:XXX"),   "Type - Atributo Inválido")       //Retorna "U" - Indefinido
     
    FWAlertInfo(ValType(cVarStatic),    "ValType - Static")               //Retorna "C" - Caracter
    FWAlertInfo(ValType(cVarLocal),     "ValType - Local")                //Retorna "C" - Caracter
    FWAlertInfo(ValType(cVarPriv),      "ValType - Private")              //Retorna "C" - Caracter
    FWAlertInfo(ValType(__cVarPubl),    "ValType - Public")               //Retorna "C" - Caracter
    FWAlertInfo(ValType(oFontTst:Bold), "ValType - Atributo Ok")          //Retorna "L" - Lógico
    FWAlertInfo(ValType(oFontTst:XXX),  "ValType - Atributo Inválido")    //Dá erro de Invalid Property e encerra o programa

    FWRestArea(aArea)
Return
