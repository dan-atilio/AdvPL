/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/09/18/transformar-array-em-string-com-arrtokstr-e-cenarr2str-maratona-advpl-e-tl-041/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe041
Exemplo de função que converte um Array para uma String
@type Function
@author Atilio
@since 29/11/2022
@obs 
    Função ArrTokStr
    Parâmetros
        + Array a ser convertido
        + Delimitador de separação
        + Número de caracteres caso deseja quebra de linha com CRLF
    Retorno
        + Texto da String convertida

    Função CenArr2Str
    Parâmetros
        + Array monodimensional a ser convertido
        + Delimitador de separação
    Retorno
        + Texto da String convertida

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe041()
    Local aArea    := FWGetArea()
    Local aDados   := {}
    Local aNomes   := {}
    Local cResult1 := ""
    Local cResult2 := ""

    //Adiciona informações no Array (multidimensional)
    aAdd(aDados, {"Site", "Terminal de Informação"})
    aAdd(aDados, {"URL",  "https://terminaldeinformacao.com"})
    cResult1 := ArrTokStr(aDados, ";")

    //Transforma o Array em uma String JSON
    aAdd(aNomes, "Daniel")
    aAdd(aNomes, "João")
    aAdd(aNomes, "Maria")
    aAdd(aNomes, "José")
    cResult2 := CenArr2Str(aNomes, ";")

    //Mostra o resultado
    FWAlertInfo("cResult1 é " + cResult1 + ", cResult2 é " + cResult2, "Resultado de conversão de Array para TXT")

    FWRestArea(aArea)
Return
