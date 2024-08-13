/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/12/gerando-uma-tabela-em-html-com-a-montatabelahtml-maratona-advpl-e-tl-350/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe351
Retorna o número do mês conforme data informada
@type Function
@author Atilio
@since 26/03/2023
@see https://tdn.totvs.com/display/tec/Month
@obs 

    Função Month
    Parâmetros
        + dData    , Data      , Data a ser validada
    Retorno
        + nRet     , Numérico  , Número do mês

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe351()
	Local aArea    := FWGetArea()
    Local dDtHoje  := Date()
    Local nMes

    //Pega o mês da data de hoje
    nMes := Month(dDtHoje)
    FWAlertInfo("O mês é " + cValToChar(nMes), "Teste - Month")

    FWRestArea(aArea)
Return
