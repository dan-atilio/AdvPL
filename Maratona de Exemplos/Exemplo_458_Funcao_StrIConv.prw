/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/05/convertendo-uma-string-de-uma-codificacao-para-outra-com-a-striconv-maratona-advpl-e-tl-458/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe458
Converte uma string de uma codificação para outra
@type Function
@author Atilio
@since 31/03/2023
@see https://tdn.totvs.com/display/tec/STRICONV
@obs 
    Função StrIConv
    Parâmetros
        + cText        , Caractere    , Texto a ser analisado
        + fromCodePage , Caractere    , Codificação de origem
        + toCodePage   , Caractere    , Codificação de destino
    Retorno
        + cRet         , Caractere    , Retorna o texto formatado

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe458()
    Local aArea     := FWGetArea()
    Local cTexto    := ""
    Local cNovo     := ""

    //Monta as informações e aciona a remoçaõ de caracteres
    cTexto    := "A aranha arranha a rã. A rã arranha a aranha. Nem a aranha arranha a rã. Nem a rã arranha a aranha."
    cNovo     := StrIConv(cTexto, "CP1252", "UTF-8")

    //Exibe a mensagem
    FWAlertInfo(cNovo, "Teste de StrIConv")

    FWRestArea(aArea)
Return
