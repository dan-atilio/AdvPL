/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/07/removendo-parte-de-um-texto-com-a-stuff-maratona-advpl-e-tl-463/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe463
Remove parte do texto com a possiblidade de substituição
@type Function
@author Atilio
@since 02/04/2023
@see https://tdn.totvs.com/display/tec/Stuff
@obs 
    Função Stuff
    Parâmetros
        + cString       , Caractere    , Valor a ser analisado
        + nInicio       , Numérico     , Posição inicial que será verificada
        + nElimina      , Numérico     , Quantidade de caracteres que serão removidos a partir da posição inicial
        + cInsere       , Numérico     , Texto que será inserido no trecho removido
    Retorno
        + cRet          , Caractere    , Retorna a string conforme os parâmetros informados

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe463()
    Local aArea     := FWGetArea()
    Local cTexto    := "Gostava de jogar Sonic e Street Fighter."
    Local cNovo     := ""

    //Faz remoção de parte do texto e mostra o resultado
    cNovo := Stuff(cTexto, 18, 8, "")
    FWAlertInfo(cNovo, "Teste 1 de Stuff")

    //Faz a substituição de parte do texto por outro texto e mostra o resultado
    cNovo := Stuff(cTexto, 18, 5, "Mortal Kombat")
    FWAlertInfo(cNovo, "Teste 2 de Stuff")

    FWRestArea(aArea)
Return
