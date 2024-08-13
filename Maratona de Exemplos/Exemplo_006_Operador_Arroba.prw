/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/08/14/operador-para-passagem-de-parametro-por-referencia-maratona-advpl-e-tl-006/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe006
Exemplo de como utilizar o operador @ (Arroba), passando uma variável por referência (similar a um ponteiro)
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.engpro.totvs.com.br/display/tec/Operadores+Especiais
@obs
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe006()
    Local aArea   := FWGetArea()
    Local cTexto1 := "Daniel"
    Local cTexto2 := "Atilio"

    //Aciona a função estática
    fTrocaTxt(cTexto1, @cTexto2)

    //Mostrando como ficaram as variáveis
    FWAlertInfo("Variáveis - cTexto1: " + cTexto1 + ", cTexto2: " + cTexto2, "Exemplo de passagem por referência")

    FWRestArea(aArea)
Return

Static Function fTrocaTxt(cVar01, cVar02)
    cVar01 := "aaa"
    cVar02 := "bbb"
Return
