/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/11/27/calculando-a-diferenca-de-anos-entre-duas-datas-com-datediffyear-maratona-advpl-e-tl-111/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe111
Retorna a diferença em anos entre duas datas
@type Function
@author Atilio
@since 13/12/2022
@obs 
    Função DateDiffYear
    Parâmetros
        + Data inicial
        + Data final
    Retorno
        + Retorna a quantidade de anos

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe111()
    Local aArea     := FWGetArea()
    Local dDataIni  := sToD("19930712")
    Local dDataFim  := Date()
    Local nAnos    := 0

    //Busca a diferença em dias
    nAnos    := DateDiffYear(dDataIni, dDataFim)

    //Exibe a diferença
    FWAlertInfo("A diferença é de " + cValToChar(nAnos) + " ano(s)", "Teste DateDiffYear")

    FWRestArea(aArea)
Return
