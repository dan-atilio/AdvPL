/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/31/convertendo-um-array-para-string-com-fwarraytostr-maratona-advpl-e-tl-206/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe206
Exemplo de função que converte um Array para uma String mostrando o tamanho da cada posição
@type Function
@author Atilio
@since 12/02/2023
@obs 
    Função FWArrayToStr
    Parâmetros
        + Array que será convertido para uma String
    Retorno
        + Texto com as posições do Array

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe206()
    Local aArea    := FWGetArea()
    Local aDados   := {}
    Local cResult  := ""

    //Adiciona informações no Array
    aAdd(aDados, {"Site", "Terminal de Informação"})
    aAdd(aDados, {"URL",  "https://terminaldeinformacao.com"})

    //Transforma o Array em uma String
    cResult := FWArrayToStr(aDados)

    //Mostra o resultado
    FWAlertInfo("O Resultado é " + CRLF + cResult, "Resultado do FWArrayToStr")

    FWRestArea(aArea)
Return
