/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/11/30/buscando-o-numero-do-dia-no-formato-dd-com-a-day2str-maratona-advpl-e-tl-114/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe114
Retorna o dia atual conforme a data informada no formato "DD"
@type Function
@author Atilio
@since 13/12/2022
@obs 
    Função Day2Str
    Parâmetros
        + Conteúdo que será analisado podendo ser: Data (ex: 05/12/2022); Numérico (ex: 5); Caractere (ex: "5")
    Retorno
        + Retorna uma string com o dia no formato "DD"

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe114()
    Local aArea      := FWGetArea()
    Local dDataRef   := sToD("20221203")
    Local cDiaHoje   := ""

    //Busca o dia atual conforme a data
    cDiaHoje         := Day2Str(dDataRef)

    //Exibe a diferença
    FWAlertInfo("Hoje é " + cDiaHoje, "Teste Day2Str")

    FWRestArea(aArea)
Return
