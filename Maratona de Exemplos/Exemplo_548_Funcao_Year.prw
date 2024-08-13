/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/20/busca-um-ano-ja-formatado-como-string-atraves-da-year2str-maratona-advpl-e-tl-549/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe548
Retorna o número do ano conforme data informada
@type Function
@author Atilio
@since 07/04/2023
@see https://tdn.totvs.com/display/tec/Year
@obs 

    Função Year
    Parâmetros
        + dDate    , Data      , Data a ser validada
    Retorno
        + nYear    , Numérico  , Número do ano

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe548()
	Local aArea    := FWGetArea()
    Local dDtHoje  := Date()
    Local nAno

    //Pega o ano da data de hoje
    nAno := Year(dDtHoje)
    FWAlertInfo("O ano é " + cValToChar(nAno), "Teste - Year")

    FWRestArea(aArea)
Return
