/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/12/buscando-alguma-informacao-da-sx3-com-a-getsx3cache-maratona-advpl-e-tl-288/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe288
Busca um conteúdo de uma informação da SX3
@type  Function
@author Atilio
@since 21/02/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6815033
@obs 
    
    Função GetSX3Cache
    Parâmetros
        + cSX3Campo   , Caractere       , Nome do campo que será buscado
        + cCampo      , Caractere       , Nome do campo do dicionário
    Retorno
        + uValor      , Indefinido      , Retorna o conteúdo do campo

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe288()
    Local aArea      := FWGetArea()
    Local cCampo     := "A1_HRCAD"
    Local cMensagem  := ""

    //Busca as informações do campo
    cMensagem += "Inic. Padrão: " + GetSX3Cache(cCampo, "X3_RELACAO") + CRLF
    cMensagem += "Tipo: " + GetSX3Cache(cCampo, "X3_TIPO") + CRLF
    cMensagem += "Título: " + GetSX3Cache(cCampo, "X3_TITULO") + CRLF
    cMensagem += "Contexto: " + GetSX3Cache(cCampo, "X3_CONTEXT")

    //Exibe uma mensagem
    FWAlertInfo(cMensagem, "Teste GetSX3Cache")

    FWRestArea(aArea)
Return
