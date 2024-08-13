/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/26/criando-uma-navegacao-de-passos-com-a-fwwizardcontrol-maratona-advpl-e-tl-258/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe259
Retorna o código da filial para a tabela conforme a filial logada e o tipo de compartilhamento da tabela
@type  Function
@author Atilio
@since 21/02/2023
@see https://tdn.totvs.com/display/public/framework/FWxFilial+-+Retorna+a+string e https://tdn.totvs.com/pages/releaseview.action?pageId=27675626
@obs 

    Função FWxFilial
    Parâmetros
		+ cAlias         , Caractere       , Alias da tabela
        + cEmpUDFil      , Caractere       , Indica a filial a ser considerada (cFilAnt)
        + cModoEmp       , Caractere       , Indica o modo de compartilhamento da empresa a ser validado
        + cModoUn        , Caractere       , Indica o modo de compartilhamento da unidade de negócios a ser validado
        + cModoFil       , Caractere       , Indica o modo de compartilhamento da filial a ser validado
    Retorno
        + cFilial        , Caractere       , Código da filial para a tabela informada

    Função xFilial
    Parâmetros
		+ cAlias         , Caractere       , Alias da tabela
        + cFil           , Caractere       , Indica a filial a ser considerada (cFilAnt)
    Retorno
        Código da filial para a tabela informada
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe259()
    Local aArea      := FWGetArea()
    Local cMensagem  := ""

    //Monta uma mensagem usando FWxFilial
    cMensagem := "SB1: " + FWxFilial("SB1") + CRLF
    cMensagem += "SA2: " + FWxFilial("SA2") + CRLF
    cMensagem += "SC5: " + FWxFilial("SC5") + CRLF
    cMensagem += "SC7: " + FWxFilial("SC7") + CRLF
    cMensagem += "SD1: " + FWxFilial("SD1")
    FWAlertInfo(cMensagem, "Teste FWxFilial")

    //Monta uma mensagem usando xFilial
    cMensagem := "SB1: " + xFilial("SB1") + CRLF
    cMensagem += "SA2: " + xFilial("SA2") + CRLF
    cMensagem += "SC5: " + xFilial("SC5") + CRLF
    cMensagem += "SC7: " + xFilial("SC7") + CRLF
    cMensagem += "SD1: " + xFilial("SD1")
    FWAlertInfo(cMensagem, "Teste xFilial")

    FWRestArea(aArea)
Return
