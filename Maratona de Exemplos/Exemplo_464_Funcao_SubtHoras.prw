/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/08/calculando-o-total-de-horas-com-a-subthoras-maratona-advpl-e-tl-464/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe464
Calcula o total de horas entre duas datas e horários
@type Function
@author Atilio
@since 02/04/2023
@obs 
    Função SubtHoras
    Parâmetros
        Data Inicial para se fazer as contas
        Hora Inicial para se fazer as contas
        Data Final para se fazer as contas
        Hora Final para se fazer as contas
        .T. se retorna a quantidade total de horas ou .F. se considera no máximo 9 horas por dia
    Retorno
        Retorna o valor numérico com a diferença em horas

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe464()
    Local aArea     := FWGetArea()
    Local dDataIni  := sToD("20230405")
    Local dDataFim  := sToD("20230406")
    Local cHoraIni  := "08:00"
    Local cHoraFim  := "17:00"
    Local nResult   := 0

    //Aciona a função para verificar o total de horas (18 horas)
    nResult := SubtHoras(dDataIni, cHoraIni, dDataFim, cHoraFim, .F.)
    FWAlertInfo("O resultado é: " + cValToChar(nResult), "Teste 1 - SubtHoras")

    //Aciona a função para verificar o total de horas (33 horas)
    nResult := SubtHoras(dDataIni, cHoraIni, dDataFim, cHoraFim, .T.)
    FWAlertInfo("O resultado é: " + cValToChar(nResult), "Teste 2 - SubtHoras")

    FWRestArea(aArea)
Return
