/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/10/executando-uma-aplicacao-no-s-o-do-servidor-com-a-waitrunsrv-maratona-advpl-e-tl-528/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe528
Executa uma aplicação no sistema operacional onde esta rodando o AppServer
@type Function
@author Atilio
@since 06/04/2023
@obs 

    Função WaitRunSrv
    Parâmetros
        Nome do aplicativo que será executado
        Determina se irá aguardar a aplicação encerrar (.T.) ou não (.F.)
        Pasta raiz do aplicativo
    Retorno
        Retorna .T. se deu certo a execução ou .F. se não

    Exemplo do comando dentro desse nosso .bat de exemplo:
        getmac > C:\spool\teste_mac_address_wait.txt

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe528()
    Local aArea      := FWGetArea()
    Local lWait      := .F.
    Local cPrograma  := ""

    //Define as variáveis que serão usadas na execução
    lWait       := .T.
    cPrograma   := "C:\spool\programa_teste.bat"
    
    //Tenta executar a aplicação e mostra uma mensagem
    If ! WaitRunSrv(cPrograma, lWait , "C:\" )
        FWAlertError("Erro na execução do aplicativo às " + Time(), "Teste WaitRunSrv")
    Else
        FWAlertSuccess("Sucesso na execução do aplicativo no servidor às " + Time(), "Teste WaitRunSrv")
    EndIf

    FWRestArea(aArea)
Return
