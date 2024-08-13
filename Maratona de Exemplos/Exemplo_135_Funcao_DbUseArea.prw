/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/12/21/abrindo-um-alias-ou-query-com-dbusearea-maratona-advpl-e-tl-135/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe135
Abre uma tabela ou uma query
@type Function
@author Atilio
@since 15/12/2022
@see https://tdn.totvs.com/display/tec/DBUseArea
@obs 
    Função DbUseArea
    Parâmetros
        + lNewArea       , Lógico      , .T. se será um novo alias na memória ou .F. se já irá utilizar um que já esta aberto
        + cDriver        , Caractere   , Informa o RDD de conexão
        + cFile          , Caractere   , Arquivo/Tabela/Query a ser aberta
        + cAlias         , Caractere   , Nome do alias que será atribuído
        + lShared        , Lógico      , Se .T. outras threads vão poder usar essa tabela senão se for .F. somente a thread que abriu
        + lReadOnly      , Lógico      , Se .T. é apenas para leitura de dados e não aceitará locks senão se for .F. permitirá manipulação de dados
    Retorno
        Não possui retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe135()
    Local aArea      := FWGetArea()
    Local cQrySBM    := ""

    //Monta uma query para buscar um grupo de produto com o código 0002
    cQrySBM := " SELECT  " + CRLF
    cQrySBM += "     BM_GRUPO, BM_DESC " + CRLF
    cQrySBM += " FROM  " + CRLF
    cQrySBM += "     " + RetSQLName("SBM") + " SBM  " + CRLF
    cQrySBM += " WHERE  " + CRLF
    cQrySBM += "     BM_FILIAL = '" + FWxFilial("SBM") + "' " + CRLF
    cQrySBM += "     AND BM_GRUPO = '0002' " + CRLF
    cQrySBM += "     AND SBM.D_E_L_E_T_ = ' ' " + CRLF

    //Abre um novo alias conforme a query passada
    DbUseArea(.T., "TOPCONN", TCGenQry( , , cQrySBM), "QRY_TST", .F., .T.)

    //Caso haja dados, exibe uma mensagem
    If ! QRY_TST->(EoF())
        FWAlertInfo("Descrição do grupo: " + QRY_TST->BM_DESC, "Teste DbUseArea")
    EndIf
    QRY_TST->(DbCloseArea())

    FWRestArea(aArea)
Return
