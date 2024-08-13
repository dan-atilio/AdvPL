/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/08/pegando-parte-de-uma-string-com-substr-e-substring-maratona-advpl-e-tl-465/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe465
Calcula o total de horas entre duas datas e horários
@type Function
@author Atilio
@since 02/04/2023
@see https://tdn.totvs.com/display/tec/SubStr
@obs
    Função SubStr
    Parâmetros
        + cText      , Caractere      , String a ser verificada
        + nIndex     , Numérido       , Posição inicial a ser considerada
        + nLen       , Numérico       , Quantidade caracteres a serem considerados (opcional)
    Retorno
        + cRet       , Caractere      , Retorna parte da string conforme os parâmetros informados

    Função SubString
    Parâmetros
        String a ser verificada
        Posição inicial a ser considerada
        Quantidade caracteres a serem considerados (obrigatório)
    Retorno
        Retorna parte da string conforme os parâmetros informados

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe465()
    Local aArea     := FWGetArea()
    Local cNome     := "Daniel Atilio"
    Local cMensagem := ""

    //Utilizando SubStr
    cMensagem := "A partir da posição 8: "             + SubStr(cNome, 8)                + CRLF
    cMensagem += "Da posição 8 até o restante: "       + SubStr(cNome, 8, Len(cNome))    + CRLF
    cMensagem += "Da posição 1 pegando 3 caracteres: " + SubStr(cNome, 1, 3)             + CRLF
    cMensagem += "Da posição 8 pegando 4 caracteres: " + SubStr(cNome, 8, 4)             + CRLF
    FWAlertInfo(cMensagem, "Teste SubStr")

    //Utilizando SubString
    cMensagem := "Da posição 8 até o restante: "       + SubString(cNome, 8, Len(cNome))    + CRLF
    cMensagem += "Da posição 1 pegando 3 caracteres: " + SubString(cNome, 1, 3)             + CRLF
    cMensagem += "Da posição 8 pegando 4 caracteres: " + SubString(cNome, 8, 4)             + CRLF
    FWAlertInfo(cMensagem, "Teste SubString")

    FWRestArea(aArea)
Return
