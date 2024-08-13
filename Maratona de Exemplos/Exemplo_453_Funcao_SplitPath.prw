/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/02/separa-pedacos-do-nome-de-um-arquivo-com-a-splitpath-maratona-advpl-e-tl-453/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe453
Pega o caminho do arquivo e retorna pedaços dela sendo drive, pasta, nome do arquivo e extensão
@type Function
@author Atilio
@since 31/03/2023
@see https://tdn.totvs.com/display/tec/SplitPath
@obs 

    Função SplitPath
    Parâmetros
        + cArquivo    , Caractere      , Indica o nome do arquivo que será processado
        + cDrive      , Caractere      , Retorna o drive do arquivo
        + cDiretorio  , Caractere      , Retorna a pasta do arquivo
        + cNome       , Caractere      , Retorna o nome do arquivo
        + cExtensao   , Caractere      , Retorna a extensão do arquivo
    Retorno
        Função não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe453()
    Local aArea      := FWGetArea()
    Local cArquivo   := "C:\spool\arquivo.txt"
    Local cDrive     := ""
    Local cDiretorio := ""
    Local cNome      := ""
    Local cExtensao  := ""
    Local cMensagem  := ""

    //Realiza a separação do arquivo ja devolvendo extensão, pasta, etc
    SplitPath(cArquivo, @cDrive, @cDiretorio, @cNome, @cExtensao)

    //Monta a mensagem e exibe
    cMensagem := "Arquivo: "  + cArquivo + CRLF
    cMensagem += "Drive:"     + cDrive     + CRLF
    cMensagem += "Diretório:" + cDiretorio + CRLF
    cMensagem += "Nome:"      + cNome      + CRLF
    cMensagem += "Extensão:"  + cExtensao
    FWAlertInfo(cMensagem, "Teste SplitPath")

    FWRestArea(aArea)
Return
