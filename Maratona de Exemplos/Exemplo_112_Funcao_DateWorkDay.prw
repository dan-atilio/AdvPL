/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/11/28/buscando-a-quantidade-de-dias-uteis-entre-duas-datas-com-dateworkday-maratona-advpl-e-tl-112/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe112
Retorna a quantidade de dias úteis entre duas datas
@type Function
@author Atilio
@since 13/12/2022
@obs 
    Função DateWorkDay
    Parâmetros
        + Data inicial
        + Data final
        + Se irá considerar sábados (.T.) ou não (.F.)
        + Se irá considerar domingos (.T.) ou não (.F.)
        + Se irá considerar feriados (.T.) ou não (.F.) - conforme a tabela 63 da SX5
    Retorno
        + Retorna a quantidade de dias úteis

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe112()
    Local aArea      := FWGetArea()
    Local dDataIni   := sToD("20221205")
    Local dDataFim   := sToD("20221213")
    Local nDiasUteis := 0

    //Busca quantos dias úteis há no intervalo
    nDiasUteis       := DateWorkDay(dDataIni, dDataFim)

    //Exibe a diferença
    FWAlertInfo("Existe(m) " + cValToChar(nDiasUteis) + " dia(s) útil(eis)", "Teste DateWorkDay")

    FWRestArea(aArea)
Return
