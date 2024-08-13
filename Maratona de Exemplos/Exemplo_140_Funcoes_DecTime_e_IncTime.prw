/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/12/26/subtraindo-ou-somando-horas-com-as-funcoes-dectime-e-inctime-maratona-advpl-e-tl-140/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe140
Exemplo de função para adicionar ou subtrair horas de uma variável
@type Function
@author Atilio
@since 16/12/2022
@obs 
    Função DecTime
    Parâmetros
        + Variável com a hora inicial
        + Quantidade de horas para subtrair
        + Quantidade de minutos para subtrair
        + Quantidade de segundos para subtrair
    Retorno
        + Hora com as subtrações

    Função IncTime
    Parâmetros
        + Variável com a hora inicial
        + Quantidade de horas para somar
        + Quantidade de minutos para somar
        + Quantidade de segundos para somar
    Retorno
        + Hora com as somas

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe140()
    Local aArea       := FWGetArea()
    Local cHoraIni    := Time()
    Local cHoraSoma   := ""
    Local cHoraSubt   := ""
    Local cMensagem   := ""

    //Fazendo os calculos com 3 horas, 10 minutos e 25 segundos
    cHoraSoma := IncTime(cHoraIni, 3, 10, 25)
    cHoraSubt := DecTime(cHoraIni, 3, 10, 25)

    //Monta a mensagem com o resulta e mostra
    cMensagem := "Hora inicial para as contas: " + cHoraIni + CRLF + CRLF
    cMensagem += "Hora com soma: " + cHoraSoma + CRLF + CRLF
    cMensagem += "Hora com subtração: " + cHoraSubt
    FWAlertInfo(cMensagem, "Teste DecTime e IncTime")

    FWRestArea(aArea)
Return
