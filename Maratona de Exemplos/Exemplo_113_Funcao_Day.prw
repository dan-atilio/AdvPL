/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/11/29/buscando-o-numero-do-dia-de-uma-data-com-a-funcao-day-maratona-advpl-e-tl-113/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe113
Retorna o dia atual conforme a data informada
@type Function
@author Atilio
@since 13/12/2022
@see https://tdn.totvs.com/display/tec/Day
@obs 
    Função Day
    Parâmetros
        + dData         , Data         , Data que será analisada
    Retorno
        + nDia          , Numérico     , Retorna o número do dia de 1 a 31 conforme a data passada

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe113()
    Local aArea      := FWGetArea()
    Local dDataRef   := sToD("20221203")
    Local nDiaHoje   := 0

    //Busca o dia atual conforme a data
    nDiaHoje         := Day(dDataRef)

    //Exibe a diferença
    FWAlertInfo("Hoje é " + cValToChar(nDiaHoje), "Teste Day")

    FWRestArea(aArea)
Return
