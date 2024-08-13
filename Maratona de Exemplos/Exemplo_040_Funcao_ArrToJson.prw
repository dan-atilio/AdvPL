/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/09/17/funcao-arrtojson-para-transformar-um-array-numa-string-json-maratona-advpl-e-tl-040/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe040
Exemplo de função que converte um Array para uma String em JSON
@type Function
@author Atilio
@since 28/11/2022
@obs 
    Função ArrToJson
    Parâmetros
        + Array que será convertido para uma String em JSON
    Retorno
        + Texto da String em JSON

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe040()
    Local aArea    := FWGetArea()
    Local aDados   := {}
    Local cResult  := ""

    //Adiciona informações no Array
    aAdd(aDados, {"Site", "Terminal de Informação"})
    aAdd(aDados, {"URL",  "https://terminaldeinformacao.com"})

    //Transforma o Array em uma String JSON
    cResult := ArrToJson(aDados)

    //Mostra o resultado
    FWAlertInfo("cResult é " + cResult, "Resultado do ArrToJson")

    FWRestArea(aArea)
Return
