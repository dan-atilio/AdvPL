/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/04/convertendo-valores-para-o-tipo-caractere-atraves-da-funcao-str-maratona-advpl-e-tl-456/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe456
Converte valores para o tipo caractere
@type Function
@author Atilio
@since 31/03/2023
@see https://tdn.totvs.com/display/tec/Str
@obs 
    Função Str
    Parâmetros
        + nNumero       , Numérico     , Valor a ser convertido
        + nTamanho      , Numérico     , Define o tamanho que ficará a String
        + nDecimais     , Numérico     , Define o número de casas decimais após a vírgula
    Retorno
        + cRet          , Caractere    , Retorna a string conforme o valor informado

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe456()
    Local aArea     := FWGetArea()
    Local nValor    := 13.8
    Local cMensagem := ""

    //Monta a mensagem de teste
    cMensagem := "Valor:                            '" + Str(nValor)        + "'" + CRLF
    cMensagem += "Valor com tamanho 8:              '" + Str(nValor, 8)     + "'" + CRLF
    cMensagem += "Valor com tamanho 8 e 2 decimais: '" + Str(nValor, 8, 2)  + "'" + CRLF

    //Exibe a mensagem
    ShowLog(cMensagem)

    FWRestArea(aArea)
Return
