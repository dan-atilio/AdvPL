/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/04/buscando-o-ip-e-porta-do-appserver-com-a-getendpointip-maratona-advpl-e-tl-273/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe272
Converte um conteúdo caractere para numérico
@type  Function
@author Atilio
@since 21/02/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=24346927 e https://tdn.totvs.com/display/tec/Val
@obs 

    Função GetDToVal
    Parâmetros
        Recebe um conteúdo texto
    Retorno
        Retorna um valor numérico

    Função Val
    Parâmetros
        + cString    , Caractere   , Texto a ser convertido
    Retorno
        + nRet       , Numérico    , Valor convertido
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe272()
    Local aArea      := FWGetArea()
    Local cTexto
    Local nValor1
    Local nValor2

    //Faz a primeira conversão, de apenas números
    cTexto  := "1200.98"
    nValor1 := GetDToVal(cTexto)
    nValor2 := Val(cTexto)
    FWAlertInfo("Valor1: " + cValToChar(nValor1) + " ; Valor2: " + cValToChar(nValor2), "Teste 1 de GetDToVal e Val")

    //Faz a segunda conversão, de texto com números
    cTexto  := "dan1.98"
    nValor1 := GetDToVal(cTexto)
    nValor2 := Val(cTexto)
    FWAlertInfo("Valor1: " + cValToChar(nValor1) + " ; Valor2: " + cValToChar(nValor2), "Teste 2 de GetDToVal e Val")

    //Faz a terceira conversão, mesclando
    cTexto  := "1dan1.9a8"
    nValor1 := GetDToVal(cTexto)
    nValor2 := Val(cTexto)
    FWAlertInfo("Valor1: " + cValToChar(nValor1) + " ; Valor2: " + cValToChar(nValor2), "Teste 3 de GetDToVal e Val")

    FWRestArea(aArea)
Return
