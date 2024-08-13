/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/24/quebrando-um-texto-em-um-array-com-separa-strtokarr-e-strtokarr2-maratona-advpl-e-tl-435/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe435
Retorna o numero da semana do mês / dia
@type Function
@author Atilio
@since 30/03/2023
@see https://tdn.totvs.com/display/tec/StrTokArr e https://tdn.totvs.com/display/tec/StrTokArr2
@obs 
    Função Separa
    Parâmetros
        Recebe a string com separadores
        Recebe o token para fazer a separação
    Retorno
        Array com os elementos separados (considerando posições vazias)

    Função StrTokArr
    Parâmetros
        + cValue     , Caractere   , Recebe a string com separadores
        + cToken     , Caractere   , Recebe o token para fazer a separação
    Retorno
        + aRet       , Array       , Array com os elementos separados conforme parâmetros informados

    Função StrTokArr2
    Parâmetros
        + cValue     , Caractere   , Recebe a string com separadores
        + cToken     , Caractere   , Recebe o token para fazer a separação
        + lEmptyStr  , Lógico      , Define se irá considerar posições vazias
    Retorno
        + aRet       , Array       , Array com os elementos separados conforme parâmetros informados

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe435()
    Local aArea     := FWGetArea()
    Local cFrase    := ""
    Local cQuebra   := ""
    Local aDadosSep := {}
    Local aDadosSt1 := {}
    Local aDadosSt2 := {}
    Local cMensagem := ""

    //Define um texto que terá separações e sua respectiva quebra
    cFrase  := "Daniel;João;Maria;;José;"
    cQuebra := ";"

    //Aciona os 3 tipos de separações
    aDadosSep := Separa(cFrase, cQuebra)
    aDadosSt1 := StrTokArr(cFrase, cQuebra)
    aDadosSt2 := StrTokArr2(cFrase, cQuebra, .T.)

    //Monta a mensagem e exibe
    cMensagem := "Separa deu [" + cValToChar(Len(aDadosSep)) + "] elemento(s)" + CRLF
    cMensagem += "StrTokArr deu [" + cValToChar(Len(aDadosSt1)) + "] elemento(s)" + CRLF
    cMensagem += "StrTokArr2 deu [" + cValToChar(Len(aDadosSt2)) + "] elemento(s)" + CRLF
    FWAlertInfo(cMensagem, "Teste de Separa, StrTokArr e StrTokArr2")

    FWRestArea(aArea)
Return
