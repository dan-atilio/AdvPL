/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/08/15/operador-para-pegar-resto-de-divisao-maratona-advpl-e-tl-007/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe007
Exemplo de como utilizar o operador % (Percentual) para pegar o resto de uma divisão
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.engpro.totvs.com.br/display/tec/Operadores+Comuns
@obs
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe007()
    Local aArea   := FWGetArea()
    Local nResto1 := 10 % 3
    Local nResto2 := 9 % 3
    Local nValor  := 41

    //Mostra os resultados
    FWAlertInfo("nResto1: " + cValToChar(nResto1) + ", nResto2: " + cValToChar(nResto2), "Restos de divisões")

    //Realiza o teste, se o resto da divisão por 2 for 0
    If nValor % 2 == 0
        FWAlertInfo("O valor é -PAR-", "Resultado")
    Else
        FWAlertInfo("O valor é -ÍMPAR-", "Resultado")
    EndIf

    FWRestArea(aArea)
Return
