/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/08/validando-o-mes-atraves-das-validmes-e-verifmes-maratona-advpl-e-tl-524/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe525
Função que pega uma variável e ja converte para ser usada em um filtro no SQL (adicionando apóstrofos)
@type Function
@author Atilio
@since 06/04/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6814752
@obs 

    Função ValToSQL
    Parâmetros
        Recebe a variável ou expressão a ser validada
    Retorno
        Retorna a expressão já pronta para ser usada no filtro com os apóstrofos

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe525()
    Local aArea      := FWGetArea()
    Local cQuery     := ""
    Local cFilAux    := "01"
    Local dDataAux   := MonthSub(Date(), 1)

    //Monta a query
    cQuery := " SELECT " + CRLF
    cQuery += "     F2_DOC, F2_EMISSAO, F2_VALBRUT " + CRLF
    cQuery += " FROM " + CRLF
    cQuery += "     " + RetSQLName("SF2") + " SF2 " + CRLF
    cQuery += " WHERE " + CRLF
    cQuery += "     F2_FILIAL = " + ValToSQL(cFilAux) + " " + CRLF
    cQuery += "     AND F2_EMISSAO >= " + ValToSQL(dDataAux) + " " + CRLF
    cQuery += "     AND SF2.D_E_L_E_T_ = '' " + CRLF

    //Exibe o resultado
    FWAlertInfo(cQuery, "Teste ValToSQL")

    FWRestArea(aArea)
Return
