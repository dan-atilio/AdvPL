/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/12/04/manipulando-filtros-em-um-alias-com-dbclearfilter-e-dbsetfilter-maratona-advpl-e-tl-118/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe118
Realiza (ou limpa) o filtro em um alias
@type Function
@author Atilio
@since 13/12/2022
@see https://tdn.totvs.com/display/tec/DBClearFilter e https://tdn.totvs.com/display/tec/DBSetFilter
@obs 
    Função DBClearFilter
    Não possui parâmetros nem retorno

    Função DBSetFilter
    Parâmetros
        + bCond       , Bloco de Código  , Bloco de código a ser executado em AdvPL
        + cCond       , Caractere        , Condição a ser avaliada em AdvPL
    Retorno
        + Não possui retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe118()
    Local aArea      := FWGetArea()
    Local nAntes     := 0
    Local nComFiltro := 0
    Local nDepois    := 0
    Local cFiltro    := ""
    Local cMensagem  := ""

    DbSelectArea("SBM")
    SBM->(DbSetOrder(1)) // Filial + Código do Grupo

    //Conta quantos registros tem antes do filtro
    Count To nAntes
    SBM->(DbGoTop())

    //Monta o filtro que será usado, aplica e conta quantos registros ficaram
    cFiltro := "! Empty(SBM->BM_GRUPO) .And. ! Empty(SBM->BM_PROORI)"
    SBM->(DbSetFilter({|| &(cFiltro)}, cFiltro))
    Count To nComFiltro
    SBM->(DbGoTop())

    //Agora limpa o filtro e conta quantos registros ficaram
    SBM->(DbClearFilter())
    Count To nDepois
    SBM->(DbGoTop())

    //Monta a mensagem e exibe
    cMensagem := "Antes (ao abrir a tabela): " + cValToChar(nAntes) + CRLF
    cMensagem += "Com o Filtro: " + cValToChar(nComFiltro) + CRLF
    cMensagem += "Após a Limpeza do Filtro: " + cValToChar(nDepois)
    FWAlertInfo(cMensagem, "Teste DbSetFilter e DbClearFilter")

    FWRestArea(aArea)
Return
