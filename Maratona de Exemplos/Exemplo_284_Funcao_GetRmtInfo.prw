/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/10/buscando-a-versao-do-rpo-com-a-getrporelease-maratona-advpl-e-tl-285/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe284
Buscando informações do remote
@type  Function
@author Atilio
@since 21/02/2023
@see https://tdn.totvs.com/display/tec/GetRmtInfo
@obs 
    
    Função GetRmtInfo
    Parâmetros
        Não tem parâmetros
    Retorno
        + aRet        , Array       , Retorna um array com detalhes do computador e SmartClient

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe284()
    Local aArea      := FWGetArea()
    Local aInfo      := {}
    Local cMensagem  := ""

    //Busca as informações da máquina
    aInfo := GetRmtInfo()

    //Monta a mensagem e exibe
    cMensagem += "Nome Computador:  " + aInfo[01] + CRLF
    cMensagem += "S.O.:             " + aInfo[02] + CRLF
    cMensagem += "Inf. Adicional:   " + aInfo[03] + CRLF
    cMensagem += "Mem. Fisica:      " + aInfo[04] + CRLF
    cMensagem += "Nr.Processadores: " + aInfo[05] + CRLF
    cMensagem += "MHz Processador:  " + aInfo[06] + CRLF
    cMensagem += "Descr. Process.:  " + aInfo[07] + CRLF
    cMensagem += "Linguagem:        " + aInfo[08] + CRLF
    cMensagem += "Navegador:        " + aInfo[09] + CRLF
    cMensagem += "Android ou iOS:   " + aInfo[10] + CRLF
    cMensagem += "Arquitetura:      " + aInfo[11] + CRLF
    cMensagem += "Estát. ou Dinam:  " + aInfo[12] + CRLF
    cMensagem += "Pasta do execut:  " + aInfo[13]
    ShowLog(cMensagem)

    FWRestArea(aArea)
Return
