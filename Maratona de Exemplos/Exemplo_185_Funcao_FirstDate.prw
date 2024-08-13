/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/20/invertendo-uma-string-com-a-funcao-finvstring-maratona-advpl-e-tl-184/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe185
Busca o primeiro dia do mês conforme a data passada
@type Function
@author Atilio
@since 21/12/2022
@obs 
    Função FirstDate
    Parâmetros
        Data de Referência
    Retorno
        Retorna o primeiro dia do mês

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe185()
    Local aArea     := FWGetArea()
    Local dData     := sToD("20221215")
    Local dPriDia

    //Busca o primeiro dia
    dPriDia := FirstDate(dData)

    //Mostra o resultado
    FWAlertInfo("Na data '" + dToC(dData) + "' o primeiro dia do mês é '" + dToC(dPriDia) + "'", "Teste FirstDate")

    FWRestArea(aArea)
Return
