/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/29/abrindo-uma-tela-para-visualizacao-de-textos-com-a-showlog-maratona-advpl-e-tl-445/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe444
Executa comandos e programas no Sistema Operacional que esta rodando o SmartClient
@type Function
@author Atilio
@since 31/03/2023
@see https://tdn.totvs.com/display/tec/ShellExecute e https://tdn.totvs.com/display/tec/WaitRun e https://tdn.totvs.com/display/tec/WinExec
@obs 

    Função ShellExecute
    Parâmetros
        + cAcao        , Caractere     , Indica o tipo de ação a ser executada (como OPEN para abrir)
        + cArquivo     , Caractere     , Indica o nome do aplicativo ou arquivo
        + cParam       , Caractere     , Indica se deve passar parâmetros de execução (para caso usar aplicativo)
        + cDirTrabalho , Caractere     , Indica a pasta que contém o cArquivo
        + nOpc         , Numérico      , Indica o tipo de abertura (normal; minimizada; maximizada; etc)
    Retorno
        + nRet       , Numérico      , Se for bem sucedida retorna um valor maior que 32

    Função WaitRun
    Parâmetros
        + cExeName   , Caractere     , Indica o aplicativo a ser executado ou arquivo a ser aberto
        + nShow      , Numérico      , Indica o tipo de abertura (normal; minimizada; maximizada; etc)
    Retorno
        + nRet       , Numérico      , Retorna 0 em caso de sucesso

    Função WinExec
    Parâmetros
        + cExec      , Caractere     , Indica o aplicativo a ser executado
    Retorno
        + cRet       , Caractere     , Retorna "0" em caso de sucesso

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe444()
	Local aArea     := FWGetArea()
    Local cExecute  := ""
    Local cArquivo  := ""
    Local cComando  := ""
    Local cPrograma := ""

    //Abrindo uma janela com novo email no Outlook via ShellExecute
    cExecute := "/c ipm.note /m  teste@empresa.com " 
    ShellExecute("OPEN", "outlook.exe", cExecute, "", 1)

    //Criando um arquivo .bat e depois execuntado via WaitRun
    cArquivo  := 'C:\spool\teste.bat'
    cComando  := 'getmac > "C:\spool\mac_address.txt"'
    MemoWrite(cArquivo, cComando)
    WaitRun(cArquivo, 2)

    //Acionando um programa do Windows para abrir via WinExec
    cPrograma := "notepad.exe"
    WinExec(cPrograma)

	FWRestArea(aArea)
Return
