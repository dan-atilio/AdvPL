/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/08/gerando-valores-randomicos-com-random-e-randomize-maratona-advpl-e-tl-402/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe402
Gera valores randomicos entre um minimo e um máximo
@type Function
@author Atilio
@since 28/03/2023
@see https://tdn.totvs.com/display/tec/Random e https://tdn.totvs.com/display/tec/Randomize
@obs 
    Função Random
    Parâmetros
        + nMinimo     , Numérico     , Menor valor a se considerar
        + nMaximo     , Numérico     , Maior valor a se considerar
    Retorno
        + nRet        , Numérico     , Valor gerado entre o nMinimo e nMaximo
    
    Função Randomize
    Parâmetros
        + nMinimo     , Numérico     , Menor valor a se considerar
        + nMaximo     , Numérico     , Maior valor a se considerar
    Retorno
        + nRet        , Numérico     , Valor gerado entre o nMinimo e nMaximo

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe402()
    Local aArea     := FWGetArea()
    Local nValor1   := 0
    Local nValor2   := 0

    //Gera um valor randomico
    nValor1 := Random(0, 500)
    FWAlertInfo("Valor gerado é: " + cValToChar(nValor1), "Teste Random")

    //Gera um valor randomico
    nValor2 := Randomize(0, 500)
    FWAlertInfo("Valor gerado é: " + cValToChar(nValor2), "Teste Randomize")

    FWRestArea(aArea)
Return
