/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/12/24/aplicando-a-codificacao-utf-8-com-decodeutf8-e-encodeutf8-maratona-advpl-e-tl-138/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe138
Exemplo para transformar um texto com a codificação UTF-8
@type Function
@author Atilio
@since 16/12/2022
@see https://tdn.totvs.com/display/tec/DecodeUTF8 e https://tdn.totvs.com/display/tec/EncodeUTF8
@obs 
    Função DecodeUTF8
    Parâmetros
        + cText        , Caractere    , String codificada em UTF-8 que será convertida
        + cEncoding    , Caractere    , Indica qual é o encoding do retorno
    Retorno
        + cRet         , Caractere    , Retorna a string convertida

    Função EncodeUTF8
    Parâmetros
        + cText        , Caractere    , String que será convertida para UTF-8
        + cEnconding   , Caractere    , Indica qual é o enconding original (por padrão é o cp1252)
    Retorno
        + cRet         , Caractere    , Retorna a string convertida em UTF-8

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe138()
    Local aArea       := FWGetArea()
    Local cTexto      := ""
    Local cEncode     := ""
    Local cDecode     := ""
    Local cMensagem   := ""
    
    //Monta o texto e faz a conversão
    cTexto := "A aranha arranha a rã. A rã arranha a aranha. Nem a aranha arranha a rã. Nem a rã arranha a aranha."
    cEncode := EncodeUTF8(cTexto,  "cp1252")
    cDecode := DecodeUTF8(cEncode, "cp1252")

    //Monta a mensagem que será exibida
    cMensagem := "Texto Original: '" + cTexto + "'" + CRLF + CRLF
    cMensagem += "CP1252 para UTF8: '" + cEncode + "'" + CRLF + CRLF
    cMensagem += "UTF8 para CP1252: '" + cDecode + "'"
    FWAlertInfo(cMensagem, "Exemplo EncodeUTF8 e DecodeUTF8")

    FWRestArea(aArea)
Return
