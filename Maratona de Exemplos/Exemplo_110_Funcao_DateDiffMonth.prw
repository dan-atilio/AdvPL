/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/11/26/calculando-a-diferenca-de-meses-entre-duas-datas-com-datediffmonth-maratona-advpl-e-tl-110/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe110
Retorna a diferença em meses entre duas datas
@type Function
@author Atilio
@since 12/12/2022
@obs 
    Função DateDiffMonth
    Parâmetros
        + Data inicial
        + Data final
    Retorno
        + Retorna a quantidade de meses

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe110()
    Local aArea     := FWGetArea()
    Local dDataIni  := sToD("19930712")
    Local dDataFim  := Date()
    Local nMeses    := 0

    //Busca a diferença em dias
    nMeses    := DateDiffMonth(dDataIni, dDataFim)

    //Exibe a diferença
    FWAlertInfo("A diferença é de " + cValToChar(nMeses) + " mês(es)", "Teste DateDiffMonth")

    FWRestArea(aArea)
Return
