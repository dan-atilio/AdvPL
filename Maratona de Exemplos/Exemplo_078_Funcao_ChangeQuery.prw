/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/10/25/padronizando-clausulas-sql-com-a-funcao-changequery-maratona-advpl-e-tl-078/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe078
Exemplo de como formatar uma query deixando padronizado independente do banco de dados
@type Function
@author Atilio
@since 08/12/2022
@see https://tdn.totvs.com/display/public/framework/ChangeQuery
@obs 
    Função ChangeQuery
    Parâmetros
        + cQuery        , Caractere    , Informa a query a ser analisada
    Retorno
        + cNewQuery     , Caractere    , Retorna a nova query em um padrão que rode em SQL Server ou Oracle ou Postgre


    Ao utilizar o ChangeQuery, tome cuidado que alguns comandos não serão interpretados como o:
        WITH (NOLOCK)
    Nesse artigo é exemplificado utilizando o Query Analyzer do APSDU:
        https://terminaldeinformacao.com/2020/08/27/qual-a-diferenca-entre-tcquery-e-plsquery/

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe078()
    Local aArea     := FWGetArea()
    Local cQryOrig  := ""
    Local cQryNova  := ""
    Local cMensagem := ""

    //Monta a query original
    cQryOrig := " SELECT " + CRLF
    cQryOrig += "     B1_COD, " + CRLF
    cQryOrig += "     B1_DESC, " + CRLF
    cQryOrig += "     B1_GRUPO, " + CRLF
    cQryOrig += "     ISNULL(BM_GRUPO, '') AS DESCGRUP " + CRLF
    cQryOrig += " FROM " + CRLF
    cQryOrig += "     " + RetSQLName("SB1") + " SB1 " + CRLF
    cQryOrig += "     LEFT JOIN " + RetSQLName("SBM") + " SBM ON ( " + CRLF
    cQryOrig += "         BM_FILIAL = '01' " + CRLF
    cQryOrig += "         AND BM_GRUPO = B1_GRUPO " + CRLF
    cQryOrig += "         AND SBM.D_E_L_E_T_ = ' ' " + CRLF
    cQryOrig += "     ) " + CRLF
    cQryOrig += " WHERE " + CRLF
    cQryOrig += "     B1_FILIAL = ' ' " + CRLF
    cQryOrig += "     AND SB1.D_E_L_E_T_ = ' ' " + CRLF

    //Transforma a query
    cQryNova := ChangeQuery(cQryOrig)

    //Agora exibe as duas
    cMensagem := "/* cQryOrig: */" + CRLF
    cMensagem += cQryOrig + CRLF
    cMensagem += "/* cQryNova: */" + CRLF
    cMensagem += cQryNova
    ShowLog(cMensagem)

    FWRestArea(aArea)
Return
