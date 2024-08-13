/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/08/16/operadores-e-not-para-negacao-de-expressoes-maratona-advpl-e-tl-008/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe008
Exemplo de como utilizar os operadores de negação ! e .Not.
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.engpro.totvs.com.br/display/tec/Operadores+Comuns
@obs
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe008()
    Local aArea   := FWGetArea()
    Local nValorA := 0
    Local nValorB := 1

    //Se A NEGAÇÃO da condição for verdadeira
    If ! nValorA == nValorB
        FWAlertInfo("Mensagem de teste", "Primeiro If")
    EndIf

    //Se A NEGAÇÃO da condição for verdadeira
    If .Not. nValorA == nValorB
        FWAlertInfo("Mensagem de teste", "Segundo If")
    EndIf

    FWRestArea(aArea)
Return
