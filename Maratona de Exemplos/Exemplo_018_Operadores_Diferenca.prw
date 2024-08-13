/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/08/26/operadores-de-diferenca-maratona-advpl-e-tl-018/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe016
Exemplo de como utilizar os operadores de diferença (<> ou # ou !=)
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.engpro.totvs.com.br/display/tec/Operadores+Comuns
@obs
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe018()
    Local aArea   := FWGetArea()
    Local cVar1   := "Daniel"
    Local cVar2   := "Atilio"

    //Usando o sinal de menor/maior
    If cVar1 <> cVar2
        FWAlertInfo("Variáveis são diferentes", "Primeiro If")
    EndIf

    //Usando sustenido
    If cVar1 # cVar2
        FWAlertInfo("Variáveis são diferentes", "Segundo If")
    EndIf

    //Usando o diferente igual
    If cVar1 != cVar2
        FWAlertInfo("Variáveis são diferentes", "Terceiro If")
    EndIf

    //Usando a NEGAÇÃO DE EXATAMENTE igual
    If ! cVar1 == cVar2
        FWAlertInfo("Variáveis são diferentes", "Quarto If")
    EndIf

    FWRestArea(aArea)
Return
