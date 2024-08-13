/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/10/pausando-a-execucao-por-3-segundos-com-a-waitaminute-maratona-advpl-e-tl-529/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe529
Pausa a execução da função por 3 segundos
@type Function
@author Atilio
@since 06/04/2023
@obs 

    Função WaitAMinute
    Parâmetros
        Função não tem parâmetros
    Retorno
        Função não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe529()
    Local aArea      := FWGetArea()
    Local cInicio    := ""
    Local cTermino   := ""

    //Aciona a rotina para esperar 3 segundos e marca o tempo antes e depois
    cInicio := Time()
    WaitAMinute()
    cTermino := Time()

    //Mostra a diferença de tempo
    FWAlertInfo("Total espera: " + ElapTime(cInicio, cTermino), "Teste WaitAMinute")

    FWRestArea(aArea)
Return
