/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/13/buscando-o-mes-de-uma-data-no-formato-mm-com-a-month2str-maratona-advpl-e-tl-352/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe352
Retorna o mês conforme data informada no formato "MM"
@type Function
@author Atilio
@since 26/03/2023
@obs 

    Função Month
    Parâmetros
        Data a ser verificada
    Retorno
        Número do mês no formato "MM"

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe352()
	Local aArea    := FWGetArea()
    Local dDtHoje  := Date()
    Local cMes

    //Pega o mês da data de hoje
    cMes := Month2Str(dDtHoje)
    FWAlertInfo("O mês é " + cMes, "Teste - Month2Str")

    FWRestArea(aArea)
Return
