/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/12/pegando-informacoes-basicas-de-um-campo-atraves-da-getsx3info-maratona-advpl-e-tl-289/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe289
Busca um conteúdo de uma informação da SX3
@type  Function
@author Atilio
@since 21/02/2023
@obs 
    
    Função GetSX3Info
    Parâmetros
        Recebe o nome do campo
    Retorno
        Retorna um array com informações do campo

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe289()
    Local aArea      := FWGetArea()
    Local cCampo     := "A1_HRCAD"
    Local cMensagem  := ""
    Local aDados     := {}

    //Busca as informações do campo
    aDados := GetSX3Info(cCampo)
    cMensagem += "Título: "  + aDados[1] + CRLF
    cMensagem += "Tipo: "    + aDados[2] + CRLF
    cMensagem += "Tamanho: " + cValToChar(aDados[3]) + CRLF
    cMensagem += "Decimal: " + cValToChar(aDados[4]) 

    //Exibe uma mensagem
    FWAlertInfo(cMensagem, "Teste GetSX3Info")

    FWRestArea(aArea)
Return
