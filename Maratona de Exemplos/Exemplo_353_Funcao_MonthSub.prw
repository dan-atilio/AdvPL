/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/13/subtraindo-meses-de-uma-data-com-a-monthsub-maratona-advpl-e-tl-353/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe353
Subtrai meses em uma data
@type Function
@author Atilio
@since 26/03/2023
@obs 
    Função MonthSub
    Parâmetros
        Data a ser processada
        Número de meses a serem subtraídos
    Retorno
        Retorna a nova data com a subtração

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe353()
    Local aArea      := FWGetArea()
    Local dDataRef   := Date()
    Local nMeses     := 2
    Local dNovaData

    //Faz a subtração
    dNovaData        := MonthSub(dDataRef, nMeses)

    //Exibe a diferença
    FWAlertInfo("Após a subtração de " + cValToChar(nMeses) + " meses, a nova data é " + dToC(dNovaData), "Teste MonthSub")

    FWRestArea(aArea)
Return
