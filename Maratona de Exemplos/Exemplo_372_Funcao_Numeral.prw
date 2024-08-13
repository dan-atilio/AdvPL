/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/23/buscando-o-texto-numeral-de-um-valor-com-a-funcao-numeral-maratona-advpl-e-tl-372/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe372
Retorna o nome numeral de um valor (até 100)
@type Function
@author Atilio
@since 28/03/2023
@obs 

    Função Numeral
    Parâmetros
        Recebe o valor numérico (inteiro)
    Retorno
        Retorna o nome numeral desse valor (ex.: primeiro; segundo; terceiro; quarto; etc...)

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe372()
    Local aArea     := FWGetArea()
    Local nValor    := 0
    Local cTexto    := ""

    //Define o valor e busca o numeral dele
    nValor  := 5
    cTexto  := Numeral(nValor)
    FWAlertInfo("O valor '" + cValToChar(nValor) + "' é o numeral '" + cTexto + "'", "Teste 1 Numeral")

    //Define o valor e busca o numeral dele
    nValor  := 83
    cTexto  := Numeral(nValor)
    FWAlertInfo("O valor '" + cValToChar(nValor) + "' é o numeral '" + cTexto + "'", "Teste 2 Numeral")
 
    FWRestArea(aArea)
Return
