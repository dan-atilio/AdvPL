/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/22/buscando-o-numero-da-thread-atraves-da-threadid-maratona-advpl-e-tl-493/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe493
Retorna o número da Thread da conexão atual
@type Function
@author Atilio
@since 04/04/2023
@see https://tdn.totvs.com/display/tec/ThreadID
@obs 

    ThreadID
    Parâmetros
        Função não tem parâmetros
    Retorno
        + nRet        , Numérico     , Retorna o número da Thread

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe493()
    Local aArea      := FWGetArea()
    Local nID        := 0

    //Busca a thread
    nID := ThreadID()

    //Mostra uma mensagem
    FWAlertInfo("A thread da conexão atual é: " + cValToChar(nID), "Teste ThreadID")

    FWRestArea(aArea)
Return
