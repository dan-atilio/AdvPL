/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/11/25/calculando-a-diferenca-de-dias-entre-duas-datas-com-datediffday-maratona-advpl-e-tl-109/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe109
Retorna a diferença em dias entre duas datas
@type Function
@author Atilio
@since 12/12/2022
@obs 
    Função DateDiffDay
    Parâmetros
        + Data inicial
        + Data final
    Retorno
        + Retorna a quantidade de dias

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe109()
    Local aArea     := FWGetArea()
    Local dDataIni  := sToD("19930712")
    Local dDataFim  := Date()
    Local nDias     := 0

    //Busca a diferença em dias
    nDias     := DateDiffDay(dDataIni, dDataFim)

    //Exibe a diferença
    FWAlertInfo("A diferença é de " + cValToChar(nDias) + " dia(s)", "Teste DateDiffDay")

    FWRestArea(aArea)
Return
