/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/12/23/convertendo-informacoes-base64-com-as-funcoes-decode64-e-encode64-maratona-advpl-e-tl-137/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe137
Exemplo para transformar um conteúdo em Base64 ou des-transformar esse conteúdo
@type Function
@author Atilio
@since 15/12/2022
@see https://tdn.totvs.com/display/tec/Decode64 e https://tdn.totvs.com/display/tec/Encode64
@obs 
    Função Decode64
    Parâmetros
        + cToConvert   , Caractere    , String codificada em Base64 que será convertida
        + cFilePath    , Caractere    , Indica um arquivo para salvar o resultado
        + lChangeCase  , Lógico       , Se .T. pastas e arquivos vão ficar tudo minúsculo senão se for .F. irá manter o nome recebido
    Retorno
        + cRet         , Caractere    , Retorna a string convertida no formato original

    Função Encode64
    Parâmetros
        + cToConvert   , Caractere    , String que será convertida para Base64
        + cFilePath    , Caractere    , Indica um arquivo para salvar o resultado
        + lZip         , Lógico       , Se .T. irá compactar o conteúdo antes de transformar senão se for .F. não irá compactar nada
        + lChangeCase  , Lógico       , Se .T. pastas e arquivos vão ficar tudo minúsculo senão se for .F. irá manter o nome recebido
    Retorno
        + cRet         , Caractere    , Retorna a string convertida em Base64

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe137()
    Local aArea      := FWGetArea()
    Local cTxtNormal := "Terminal de Informação"
    Local cTxtBase64 := "RGFuaWVsIEF0aWxpbw=="
    Local cResultado := ""

    //Convertendo de string normal para base64
    cResultado := Encode64(cTxtNormal)
    FWAlertInfo("A conversão de '" + cTxtNormal + "' deu '" + cResultado + "'", "Exemplo Encode64")

    //Convertendo e mostrando o resultado (de hexa para decimal)
    cResultado := Decode64(cTxtBase64)
    FWAlertInfo("A conversão de '" + cTxtBase64 + "' deu '" + cResultado + "'", "Exemplo Decode64")

    FWRestArea(aArea)
Return
