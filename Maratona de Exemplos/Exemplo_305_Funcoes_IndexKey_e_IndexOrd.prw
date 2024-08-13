/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/20/pegando-informacoes-de-indices-com-as-indexkey-e-indexord-maratona-advpl-e-tl-305/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe305
Retorna o dados de um índice do Protheus
@type Function
@author Atilio
@since 22/02/2023
@see https://tdn.totvs.com/display/tec/IndexKey e https://tdn.totvs.com/display/tec/IndexOrd
@obs 

    Função IndexKey
    Parâmetros
        + nOrdem        , Numérico   , Número do Índice do Alias sendo que a partir da letra A no configurador passa a ser 10 (então B é 11, C é 12, D é 13 e assim por diante)
    Retorno
        + cRet          , Caractere  , Conteúdo do índice com os campos

    Função IndexOrd
    Parâmetros
        Não possui parâmetros
    Retorno
        + nOrd          , Numérico   , Número do Índice do Alias sendo que a partir da letra A no configurador passa a ser 10 (então B é 11, C é 12, D é 13 e assim por diante)

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe305()
    Local aArea      := FWGetArea()
    Local cMensagem  := ""

    //Abre a tabela de produtos e posiciona num índice
    DbSelectArea("SB1")
    SB1->(DbSetOrder(5))

    //Monta a mensagem e exibe
    cMensagem := "Cadastro de Produtos" + CRLF + CRLF
    cMensagem += "O índice numérico é: " + cValToChar(SB1->(IndexOrd())) + CRLF
    cMensagem += "E a chave do índice é: " + SB1->(IndexKey(IndexOrd())) + CRLF
    FWAlertInfo(cMensagem, "Teste IndexKey e IndexOrd")

    FWRestArea(aArea)
Return
