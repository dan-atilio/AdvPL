/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/30/transformando-as-linhas-em-colunas-em-um-array-com-pivottable-maratona-advpl-e-tl-386/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe387
Calcula a diferença em meses ou anos de dois períodos
@type Function
@author Atilio
@since 28/03/2023
@obs 
    Função PivotTable
    Parâmetros
        Ano inicial para cálculo
        Mês inicial para cálculo
        Ano final para cálculo
        Mês final para cálculo
        Tipo do retorno (M = em meses; A = em anos;)
    Retorno
        Retorna o número da diferença encontrada

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe387()
    Local aArea      := FWGetArea()
    Local cAnoIni    := "1993"
    Local cMesIni    := "07"
    Local cAnoFim    := "2023"
    Local cMesFim    := "03"
    Local nDifer     := 0

    //Busca a diferença em anos entre duas datas
    nDifer := PLSDifAnos(cAnoIni, cMesIni, cAnoFim, cMesFim, "A")
    FWAlertInfo("A diferença em anos é de " + cValToChar(nDifer), "Teste 1 PLSDifAnos")

    //Busca a diferença em meses entre duas datas
    nDifer := PLSDifAnos(cAnoIni, cMesIni, cAnoFim, cMesFim, "M")
    FWAlertInfo("A diferença em meses é de " + cValToChar(nDifer), "Teste 2 PLSDifAnos")

    FWRestArea(aArea)
Return
