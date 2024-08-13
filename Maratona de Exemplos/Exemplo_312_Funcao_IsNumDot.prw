/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/24/validando-se-na-string-possui-apenas-numero-e-ponto-com-isnumdot-maratona-advpl-e-tl-312/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} zExe312
Valida se uma string possui apenas número e ponto
@type  Function
@author Atilio
@since 23/02/2023
@obs 

    Função IsNumDot
    Parâmetros
        Recebe o número a ser validado (no formato Caractere)
    Retorno
        Retorna .T. se a string tiver apenas número ou "." se não retorna .F.

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe312()
	Local aArea      := FWGetArea()
    Local cTexto     := ""
    
    //Teste de somente letras
    cTexto := "3.14"
    If IsNumDot(cTexto)
        FWAlertSuccess("O texto possui apenas números ou pontos", "Teste 1 IsNumDot")
    EndIf

    //Teste de letras com números
    cTexto := "3.a14"
    If IsNumDot(cTexto)
        FWAlertSuccess("O texto possui apenas números ou pontos", "Teste 2 IsNumDot")
    EndIf

    //Teste começando com números
    cTexto := "314"
    If IsNumDot(cTexto)
        FWAlertSuccess("O texto possui apenas números ou pontos", "Teste 3 IsNumDot")
    EndIf

    FWRestArea(aArea)
Return
