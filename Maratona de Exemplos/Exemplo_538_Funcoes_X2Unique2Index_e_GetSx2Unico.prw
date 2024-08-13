/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/15/atualizando-uma-tabela-atraves-da-x31updtable-maratona-advpl-e-tl-539/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe538
Busca a informação de registro único da tabela (X2_UNICO)
@type Function
@author Atilio
@since 07/04/2023
@obs 

    Função GetSX2Unico
    Parâmetros
        Recebe o alias da tabela que será analisada
    Retorno
        Retorna a chave de registro único

    Função X2Unique2Index
    Parâmetros
        Recebe o alias da tabela que será analisada
    Retorno
        Retorna a chave de registro único

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe538()
    Local aArea      := FWGetArea()
    Local cTabela    := ""
    Local cChaveUni  := ""

    //Busca a informação de chave única
    cTabela   := "SE2"
    cChaveUni := GetSX2Unico(cTabela)
    ShowLog("GetSX2Unico: Para a tabela '" + cTabela + "' a chave é '" + cChaveUni + "'")

    //Efetua a busca novamente com outra função
    cTabela   := "SE1"
    cChaveUni := X2Unique2Index(cTabela)
    ShowLog("X2Unique2Index: Para a tabela '" + cTabela + "' a chave é '" + cChaveUni + "'")

    FWRestArea(aArea)
Return
