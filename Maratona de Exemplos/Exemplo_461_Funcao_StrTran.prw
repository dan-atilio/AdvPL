/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/06/substituindo-parte-de-uma-string-com-strtran-maratona-advpl-e-tl-461/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe461
Substitui parte de uma string por outra
@type Function
@author Atilio
@since 02/04/2023
@see https://tdn.totvs.com/display/tec/StrTran
@obs 
    Função StrTran
    Parâmetros
        + cString   , Caractere    , String que será analisada
        + cSearch   , Caractere    , Trecho que será pesquisado
        + cReplace  , Caractere    , Trecho que irá substituir o pesquisado
        + nStart    , Numérico     , Indica a partir de qual recorrência ocorrerá a substituição
        + nCount    , Numérico     , Indica o número de substituições a fazer
    Retorno
        + cRet      , Caractere    , A string com as partes substituidas

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe461()
    Local aArea  := FWGetArea()
    Local cTexto := "A aranha arranha a rã. A rã arranha a aranha. Nem a aranha arranha a rã. Nem a rã arranha a aranha."
    Local cNovo  := ""

    //Substitui toda letra "a" minúscula por "-o-"
    cNovo := StrTran(cTexto, "a", "-o-")
    FWAlertInfo(cNovo, "Teste 1 StrTran")

    //Substitui toda letra "a" minúscula por "-o-" somente a partir da 20ª recorrência
    cNovo := StrTran(cTexto, "a", "-o-", 20)
    FWAlertInfo(cNovo, "Teste 2 StrTran")

    FWRestArea(aArea)
Return
