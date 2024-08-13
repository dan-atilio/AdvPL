/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/21/validando-se-uma-variavel-possui-letras-com-isalpha-maratona-advpl-e-tl-307/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} zExe307
Valida se dentro de uma string ela possui letras (.T.) ou se começa com números (.F.)
@type  Function
@author Atilio
@since 23/02/2023
@see https://tdn.totvs.com/display/tec/IsAlpha
@obs 

    Função IsAlpha
    Parâmetros
        + cString   , Caractere   , Texto a ser validado
    Retorno
        + lRet      , Lógico      , .T. se tiver letras do alfabeto ou .F. se começar com números

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe307()
	Local aArea      := FWGetArea()
    Local cTexto     := ""
    
    //Teste de somente letras
    cTexto := "Daniel"
    If IsAlpha(cTexto)
        FWAlertSuccess("O texto possui letras", "Teste 1 IsAlpha")
    EndIf

    //Teste de letras com números
    cTexto := "Daniel 123 Atilio"
    If IsAlpha(cTexto)
        FWAlertSuccess("O texto possui letras", "Teste 2 IsAlpha")
    EndIf

    //Teste começando com números
    cTexto := "3.14"
    If IsAlpha(cTexto)
        FWAlertSuccess("O texto possui letras", "Teste 3 IsAlpha")
    EndIf

    FWRestArea(aArea)
Return
