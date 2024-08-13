/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/10/buscando-a-extensao-do-arquivo-com-a-funcao-extractext-maratona-advpl-e-tl-165/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe164
Retorna um valor numérico em texto extenso
@type Function
@author Atilio
@since 19/12/2022
@see https://tdn.totvs.com/pages/releaseview.action?pageId=604534431
@obs 
    Função Extenso
    Parâmetros
        + nNumToExt    , Numérico    , Valor numérico
        + lQuantid     , Lógico      , Determina se será valor monetário (.F.) ou quantidade (.T.)
        + nMoeda       , Numérico    , Define qual texto será usado conforme MV_MOEDA*
        + cPrefixo     , Caractere   , Prefixo alternativo
        + cIdioma      , Caractere   , Qual idioma será a tradução (1=Portugues; 2=Espanhol; 3=Ingles)
        + lCent        , Lógico      , Especifica se deve retornar os centavos (.T.) ou não (.F.)
        + lFrac        , Lógico      , Especifica se os centavos devem retornar em modo fracionado (somente em inglês)
        + lUsaCon      , Lógico      , Especifica se será usado "y" ou "con" (somente em espanhol)
        + cPosMoed     , Caractere   , Especifica a posição da descrição da moeda (1= antes do texto; 2= entre valores e centavos; 3=no final do texto)
    Retorno
        + cExt         , Caractere   , Retorna o valor em texto extenso

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe164()
    Local aArea     := FWGetArea()
    Local nValor    := 2.87
    Local cValor    := ""
    Local cMensagem := ""

    //Montando uma mensagem com as opções
    cMensagem := Extenso(nValor)                                                                + CRLF
    cMensagem += Capital(Extenso(nValor))                                                       + CRLF
    cMensagem += Capital(Extenso(nValor, /*lQuantid*/, /*nMoeda*/, /*cPrefixo*/, "2"))          + CRLF
    cMensagem += Capital(Extenso(nValor, /*lQuantid*/, /*nMoeda*/, /*cPrefixo*/, "3"))          + CRLF
    FWAlertInfo(cMensagem, "Teste 1 com Extenso")

    //Armazenando o resultado em uma variável
    nValor := 10.79
    cValor := Extenso(nValor)
    FWAlertInfo("O valor é de " + cValToChar(nValor) + " (" + cValor + ")", "Teste 2 com Extenso")

    FWRestArea(aArea)
Return
