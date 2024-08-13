/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/09/validando-se-um-gatilho-existe-e-executando-existtrigger-e-runtrigger-maratona-advpl-e-tl-162/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe163
Faz conversões entre data e hora para o formato UTC
@type Function
@author Atilio
@since 19/12/2022
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6815032
@obs 
    Função ExLocalToUTC
    Parâmetros
        + Data a ser verificada
        + Hora a ser verificada
    Retorno
        + Retorna uma string com a data e hora concatenadas

    Função ExUTCToLocal
    Parâmetros
        + String no formato de data e hora concatenadas
    Retorno
        Retorna um Array com 2 posições sendo a primeira a data e a segunda a hora

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe163()
    Local aArea     := FWGetArea()
    Local cUTC      := ""
    Local aDados
    Local dData
    Local cHora

    //Faz a conversão da data e hora local para UTC
    cUTC := ExLocalToUTC(Date(), Time())
    FWAlertInfo("O resultado é " + cUTC, "Teste com ExLocalToUTC")

    //Agora faz a conversão de UTC para Local
    aDados := ExUTCToLocal("2022-12-19T10:00:34Z")
    dData  := aDados[1]
    cHora  := aDados[2]
    FWAlertInfo("O resultado é " + dToC(dData) + " e " + cHora, "Teste com ExUTCToLocal")

    FWRestArea(aArea)
Return
