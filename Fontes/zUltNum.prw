//Bibliotecas
#Include "Protheus.ch"
#Include "TopConn.ch"
 
/*/{Protheus.doc} zUltNum
Função que retorna o ultimo campo código
@type function
@author Atilio
@since 01/11/2017
@version 1.0
    @param cTab, Caracter, Tabela que será consultada
    @param cCampo, Caracter, Campo utilizado de código
    @param [lSoma1], Lógico, Define se além de trazer o último, já irá somar 1 no valor
    @example
    u_zUltNum("SC5", "C5_X_CAMPO", .T.)
/*/
 
User Function zUltNum(cTab, cCampo, lSoma1)
    Local aArea       := GetArea()
    Local cCodFull    := ""
    Local cCodAux     := ""
    Local cQuery      := ""
    Local nTamCampo   := 0
    Default lSoma1    := .T.
     
    //Definindo o código atual
    nTamCampo := TamSX3(cCampo)[01]
    cCodAux   := StrTran(cCodAux, ' ', '0')
     
    //Faço a consulta para pegar as informações
    cQuery := " SELECT "
    cQuery += "   ISNULL(MAX("+cCampo+"), '"+cCodAux+"') AS MAXIMO "
    cQuery += " FROM "
    cQuery += "   "+RetSQLName(cTab)+" TAB "
    cQuery := ChangeQuery(cQuery)
    TCQuery cQuery New Alias "QRY_TAB"
     
    //Se não tiver em branco
    If !Empty(QRY_TAB->MAXIMO)
        cCodAux := QRY_TAB->MAXIMO
    EndIf
     
    //Se for para atualizar, soma 1 na variável
    If lSoma1
        cCodAux := Soma1(cCodAux)
    EndIf
     
    //Definindo o código de retorno
    cCodFull := cCodAux
     
    QRY_TAB->(DbCloseArea())
    RestArea(aArea)
Return cCodFull