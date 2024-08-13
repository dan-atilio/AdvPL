/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/13/buscando-a-pasta-temporaria-do-s-o-com-a-gettemppath-maratona-advpl-e-tl-291/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe290
Retorna o telefone separado em DDI, DDD e Telefone
@type  Function
@author Atilio
@since 21/02/2023
@obs 
    
    Função GetTel
    Parâmetros
        Recebe o telefone no formato caractere
    Retorno
        Retorna um array com 3 posições sendo DDi, DDD e Fone

    Função FisGetTel
    Parâmetros
        Recebe o telefone no formato caractere
    Retorno
        Retorna um array com 3 posições sendo DDi, DDD e Fone

    Função NFEGetTel
    Parâmetros
        Recebe o telefone no formato caractere
    Retorno
        Retorna um array com 3 posições sendo DDi, DDD e Fone

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe290()
    Local aArea      := FWGetArea()
    Local cMensagem  := ""
    Local aTelefone  := {}
    Local cTelefone  := "+55 14 999998888"

    //Busca as informações do campo
    aTelefone := GetTel(cTelefone)
    cMensagem := "DDI: "  + cValToChar(aTelefone[1]) + CRLF
    cMensagem += "DDD: "  + cValToChar(aTelefone[2]) + CRLF
    cMensagem += "Fone: " + cValToChar(aTelefone[3]) 

    //Exibe uma mensagem
    FWAlertInfo(cMensagem, "Teste GetTel")

    //Busca as informações do campo
    aTelefone := FisGetTel(cTelefone)
    cMensagem := "DDI: "  + cValToChar(aTelefone[1]) + CRLF
    cMensagem += "DDD: "  + cValToChar(aTelefone[2]) + CRLF
    cMensagem += "Fone: " + cValToChar(aTelefone[3]) 

    //Exibe uma mensagem
    FWAlertInfo(cMensagem, "Teste FisGetTel")

    //Busca as informações do campo
    aTelefone := NFEGetTel(cTelefone)
    cMensagem := "DDI: "  + aTelefone[1] + CRLF
    cMensagem += "DDD: "  + aTelefone[2] + CRLF
    cMensagem += "Fone: " + aTelefone[3] 

    //Exibe uma mensagem
    FWAlertInfo(cMensagem, "Teste NFEGetTel")

    FWRestArea(aArea)
Return
