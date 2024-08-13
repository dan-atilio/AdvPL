/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/20/buscando-o-proximo-numero-sequencial-com-a-nextnumero-maratona-advpl-e-tl-367/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe367
Retorna o próximo número disponível na tabela
@type Function
@author Atilio
@since 27/03/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6814928
@obs 

    Função NextNumero
    Parâmetros
        + cAlias      , Caractere     , Alias da Tabela
        + nOrdem      , Numérico      , Índice utilizado
        + cNomeCpo    , Caractere     , Nome do campo a ser verificado
        + lSomar      , Lógico        , .T. se irá incrementar ou .F. se não
        + cVar        , Caractere     , Valor a ser pesquisado caso o lSomar seja .F.
    Retorno
        + cNumero     , Caractere     , Retorna o número conforme os parâmetros informados

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe367()
    Local aArea     := FWGetArea()
    Local cProximo  := ""

    //Busca o próximo pedido de compra
    cProximo := NextNumero("SC7", 1, "C7_NUM", .T.)

    //Exibe em uma mensagem
    FWAlertInfo("O próximo pedido de compra é '" + cProximo + "'", "Teste NextNumero")
 
    FWRestArea(aArea)
Return
