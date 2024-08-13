/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/23/formatando-um-texto-com-formatstr-maratona-advpl-e-tl-191/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe190
Cria um texto com separações (como por ponto e virgula) deixando no formato para usar em queries SQL
@type Function
@author Atilio
@since 21/12/2022
@obs 
    Função FormatIn
    Parâmetros
        + String original com as separações (seja ponto virgula; pipe; virgula; etc)
        + Define qual será o caractere separador
        + Define se irá pular mais caracteres após o separador
        + Usado exclusivamente com queries do MV_CARTEIR
    Retorno
        + Retorna o texto formatado

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe190()
    Local aArea     := FWGetArea()
    Local cTipos    := ""
    Local cTextoIn  := ""
    Local cQryAux   := ""

    //Definindo os tipos que serão filtrados com ponto e vírgula
    cTipos   := "MP;PI;PA;MO"

    //Quebrando o texto, conforme o ponto e vírgula
    cTextoIn := FormatIn(cTipos, ";")

    //Montando a query, juntando com o texto já formatado
    cQryAux := " SELECT " + CRLF
    cQryAux += "     B1_COD, " + CRLF
    cQryAux += "     B1_DESC " + CRLF
    cQryAux += " FROM " + CRLF
    cQryAux += "     " + RetSQLName('SB1') + " SB1 " + CRLF
    cQryAux += " WHERE " + CRLF
    cQryAux += "     B1_FILIAL = '" + FWxFilial('SB1') + "' " + CRLF
    cQryAux += "     AND SB1.D_E_L_E_T_ = ' ' " + CRLF
    cQryAux += "     AND B1_TIPO IN " + cTextoIn + " " + CRLF
    FWAlertInfo(cQryAux, "Teste de FormatIn")

    FWRestArea(aArea)
Return
