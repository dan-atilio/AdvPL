/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/26/ordenando-uma-tabela-de-forma-decrescente-com-a-orddescend-maratona-advpl-e-tl-378/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe379
Adiciona caracteres no centro, a esquerda ou a direita de uma string
@type Function
@author Atilio
@since 28/03/2023
@see https://tdn.totvs.com/display/tec/PadC e https://tdn.totvs.com/display/tec/PadL e https://tdn.totvs.com/display/tec/PadR
@obs 

    Função PadC
    Parâmetros
        + xExp           , Indefinido   , Indica o valor que terá os caracteres adicionados
        + nLen           , Numérico     , Define o tamanho que a string ficará
        + cFill          , Caractere    , Indica o caractere que será usado para preenchimento (se não for informado será o espaço)
    Retorno
        + cRet           , Caractere    , Retorna a string com o tamanho preenchido

    Função PadL
    Parâmetros
        + xExp           , Indefinido   , Indica o valor que terá os caracteres adicionados
        + nLen           , Numérico     , Define o tamanho que a string ficará
        + cFill          , Caractere    , Indica o caractere que será usado para preenchimento (se não for informado será o espaço)
    Retorno
        + cRet           , Caractere    , Retorna a string com o tamanho preenchido

    Função PadR
    Parâmetros
        + xExp           , Indefinido   , Indica o valor que terá os caracteres adicionados
        + nLen           , Numérico     , Define o tamanho que a string ficará
        + cFill          , Caractere    , Indica o caractere que será usado para preenchimento (se não for informado será o espaço)
    Retorno
        + cRet           , Caractere    , Retorna a string com o tamanho preenchido

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe379()
    Local aArea      := FWGetArea()
    Local cTexto     := ""
    Local cMensagem  := ""

    //Monta uma mensagem adicionando caracteres a direita e esquerda
    cTexto := "Daniel Atilio"
    cMensagem := "PadC: '" + PadC(cTexto, 25) + "'" + CRLF
    cMensagem += "PadL: '" + PadL(cTexto, 25) + "'" + CRLF
    cMensagem += "PadR: '" + PadR(cTexto, 25) + "'" + CRLF
    cMensagem += CRLF

    //Agora faz o exemplo, adicionando um 0 no lugar de espaço vazio
    cTexto := "55"
    cMensagem += "PadC: '" + PadC(cTexto, 6, "0") + "'" + CRLF
    cMensagem += "PadL: '" + PadL(cTexto, 6, "0") + "'" + CRLF
    cMensagem += "PadR: '" + PadR(cTexto, 6, "0") + "'" + CRLF
    cMensagem += CRLF

    //Exibe a mensagem
    ShowLog(cMensagem)

    FWRestArea(aArea)
Return
