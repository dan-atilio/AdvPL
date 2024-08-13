/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/17/convertendo-segundos-com-as-hrstosecs-mintosecs-e-secstotime-maratona-advpl-e-tl-299/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe299
Conversão com segundos
@type  Function
@author Atilio
@since 22/02/2023
@obs 

    Função HrsToSecs
    Parâmetros
        Recebe um número de horas
    Retorno
        Retorna o número total de segundos

    Função MinToSecs
    Parâmetros
        Recebe um número de minutos
    Retorno
        Retorna o número total de segundos

    Função SecsToTime
    Parâmetros
        Recebe um número de segundos
    Retorno
        Retorna a hora, minuto e segundos no formato "hh:mm:ss"

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe299()
    Local aArea       := FWGetArea()
    Local nResultado  := 0
    Local cHoras      := ""
    
    //Busca o total de segundos conforme uma hora passada
    nResultado := HrsToSecs(10)
    FWAlertInfo("10 horas dá um total de " + cValToChar(nResultado) + " segundos!", "Exemplo HrsToSecs")

    //Busca o total de segundos conforme uma quantidade de minutos
    nResultado := MinToSecs(640)
    FWAlertInfo("640 minutos dá um total de " + cValToChar(nResultado) + " segundos!", "Exemplo MinToSecs")

    //Busca o total de horas, minutos e segundos conforme uma quantidade de segundos
    cHoras := SecsToTime(4590)
    FWAlertInfo("4590 segundos dá o total de " + cHoras + " segundos!", "Exemplo SecsToTime")

    FWRestArea(aArea)
Return
