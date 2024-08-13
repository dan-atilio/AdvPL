/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/31/manipulando-numeros-sequencias-de-string-com-soma1-e-tira1-maratona-advpl-e-tl-449/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe449
Incrementa um conteúdo caractere e quando chega em 9 ele começa a usar letras, por exemplo "99"
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6814919
@obs 

    Função Soma1
    Parâmetros
        + cSoma        , Caractere   , String que será analisada
        + nPos         , Numérico    , Posição ser movimentada
        + lSomaLow     , Lógico      , Se deve usar caracteres minúsculos
        + lCompleteSUM , Lógico      , Define se irá usar todos os caracteres disponíveis antes de usar letras
    Retorno
        + cRet       , Caractere     , Retorna a string com +1 no conteúdo (conforme o tamanho do cSoma)


    Função Tira1
        + Recebe a string no formato do Soma1
    Retorno
        + Retorna a string diminuindo -1 no conteúdo

    Obs.: Se o parâmetro MV_SOMAOLD estiver como .T. do "99" ele irá virar "9A"; se tiver .F. ai do "99" ele irá virar "A0"

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe449()
    Local aArea        := FWGetArea()
    Local cValor       := "00"
    Local nAtual       := 0

    //Percorre valor de 1 a 150 e depois vê quanto que ficou o Soma1
    For nAtual := 1 To 150
        cValor := Soma1(cValor)
    Next
    FWAlertInfo("O resultado é: " + cValor, "Teste Soma1")

    //Utiliza o Tira1 para ver quanto que ficou o resultado
    cValor := Tira1(cValor)
    FWAlertInfo("O resultado é: " + cValor, "Teste Tira1")

    FWRestArea(aArea)
Return
