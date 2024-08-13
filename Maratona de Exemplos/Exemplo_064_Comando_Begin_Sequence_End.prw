/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/10/11/tratando-execucoes-e-erros-com-begin-sequence-end-maratona-advpl-e-tl-064/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe064
Exemplo de como realizar tratativas e recuperar caso haja falhas
@type Function
@author Atilio
@since 06/12/2022
@see https://tdn.totvs.com/display/public/framework/BEGIN+SEQUENCE+...+END
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe064()
    Local aArea    := FWGetArea()
    Local cError   := ""
    Local bError   := ErrorBlock({ |oError| cError := oError:Description})
    Local nVar     := 1
    Local cVar     := "A"
    
    //Inicio a utilização da tentativa
    Begin Sequence
        nVariavel := nVar + cVar
    End Sequence
    
    //Restaurando bloco de erro do sistema
    ErrorBlock(bError)
    
    //Se houve erro, será mostrado ao usuário
    If ! Empty(cError)
        FWAlertError("Houve um erro na fórmula digitada: " + CRLF + CRLF + cError, "Teste com Begin Sequence")
    EndIf

    FWRestArea(aArea)
Return
