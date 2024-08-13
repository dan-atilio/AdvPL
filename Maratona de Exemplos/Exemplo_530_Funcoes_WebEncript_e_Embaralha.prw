/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/11/criptografando-strings-atraves-das-webencript-e-embaralha-maratona-advpl-e-tl-530/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe530
Criptografa ou descriptografa uma string (usando criptografia web ou embaralhamento de caracteres)
@type Function
@author Atilio
@since 07/04/2023
@see https://tdn.totvs.com/display/tec/WebEncript e https://tdn.totvs.com/display/tec/Embaralha
@obs 

    Função WebEncript
    Parâmetros
        + cContent   , Caractere    , Texto a ser avaliado
        + lDecript   , Lógico       , .T. para descriptografar ou .F. para criptografar
        + lUseInJava , Lógico       , .T. quando for usado em alguma validação em Java
    Retorno
        + cRet       , Caractere    , Retorna a string conforme os parâmetros informados

    Função Embaralha
    Parâmetros
        + cTexto     , Caractere    , Texto a ser avaliado
        + nTipo      , Numérico     , 0 para embaralhar ou 1 para desembaralhar
    Retorno
        + cRet       , Caractere    , Retorna a string conforme os parâmetros informados

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe530()
    Local aArea      := FWGetArea()
    Local cWebNormal := ""
    Local cWebCript  := ""
    Local cTxtNormal := ""
    Local cTxtEmbar  := ""
    Local cMensagem  := ""

    //Define um texto normal e um já encriptado
    cWebNormal := "Daniel Atilio"
    cWebCript  := "VÉk-Ü°‘+’7™öÉk,Æ°Û"
    
    //Monta uma mensagem e exibe
    cMensagem := "O texto '" + cWebNormal + "' cripotografado é: " + WebEncript(cWebNormal, .F.) + CRLF + CRLF
    cMensagem += "Já o critografado '" + cWebCript + "' é: " + WebEncript(cWebCript, .T.)
    FWAlertInfo(cMensagem, "Teste WebEncript")


    //Define um texto normal e um já embaralhado
    cTxtNormal := "Daniel Atilio"
    cTxtEmbar  := "n mTaIaelnçr fãmdooier"

    //Monta a mensagem e exibe
    cMensagem := "O texto '" + cTxtNormal + "' embaralhado é: " + Embaralha(cTxtNormal, 0) + CRLF + CRLF
    cMensagem += "Já o embaralhado '" + cTxtEmbar + "' é: " + Embaralha(cTxtEmbar, 1)
    FWAlertInfo(cMensagem, "Teste Embaralha")


    FWRestArea(aArea)
Return
