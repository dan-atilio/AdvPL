/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/08/31/funcao-abs-para-retornar-um-valor-absoluto-de-uma-variavel-maratona-advpl-e-tl-023/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe023
Exemplo de função para demonstrar como mostrar um valor absoluto independente se o valor é negativo ou positivo
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.totvs.com/pages/releaseview.action?pageId=23888835
@obs Função Abs
    Parâmetros
        + Valor numérico
    Retorno
        + Valor numérico transformado em absoluto

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe023()
    Local aArea      := FWGetArea()
    Local nValorOrig := -10
    Local nValorNovo := 0

    //Aciona para deixar em absoluto e exibe em uma mensagem
    nValorNovo := Abs(nValorOrig)
    FWAlertInfo("nValorOrig é " + cValToChar(nValorOrig) + "; nValorNovo é " + cValToChar(nValorNovo), "Resultado")

    FWRestArea(aArea)
Return
