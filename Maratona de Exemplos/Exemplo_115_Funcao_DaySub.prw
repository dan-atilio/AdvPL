/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/12/01/subtraindo-dias-de-uma-data-com-daysub-maratona-advpl-e-tl-115/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe115
Subtrai dias em uma data
@type Function
@author Atilio
@since 13/12/2022
@obs 
    Função DaySub
    Parâmetros
        + Data que será processada
        + Número de dias a serem subtraídos
    Retorno
        + Retorna a nova data com a subtração

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe115()
    Local aArea      := FWGetArea()
    Local dDataRef   := Date()
    Local nDias      := 15
    Local dNovaData

    //Faz a subtração dos dias
    dNovaData        := DaySub(dDataRef, nDias)

    //Exibe a diferença
    FWAlertInfo("Após a subtração de " + cValToChar(nDias) + " dia(s), a nova data é " + dToC(dNovaData), "Teste DaySub")

    FWRestArea(aArea)
Return
