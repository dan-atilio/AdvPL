/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/08/22/operador-menor-e-menor-igual-maratona-advpl-e-tl-014/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe014
Exemplo de como utilizar os operadores Menor e Menor/Igual (< e <=)
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.engpro.totvs.com.br/display/tec/Operadores+Comuns
@obs
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe014()
    Local aArea   := FWGetArea()
    Local nVar1   := 1
    Local nVar2   := 2

    //Somente se a variável for menor que a da direita
    If nVar1 < nVar2
        FWAlertInfo("A nVar1 é menor que a nVar2", "Primeiro teste")
    EndIf

    //Somente se a variável for menor ou igual a da direita
    If nVar1 <= nVar2
        FWAlertInfo("A nVar1 é menor ou igual a nVar2", "Segundo teste")
    EndIf

    FWRestArea(aArea)
Return
