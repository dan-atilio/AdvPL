/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/16/mostrando-avisos-com-help-exibehelp-e-showhelpdlg-maratona-advpl-e-tl-297/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe297
Exibe uma mensagem com problema e solução (ideal para utilizar em ExecAuto e validações MVC)
@type  Function
@author Atilio
@since 22/02/2023
@see https://tdn.totvs.com/display/tec/ShowHelpDlg
@obs 
    
    Função Help
    Parâmetros
        Nome da Função
        Indica qual linha começará a leitura do help
        Título que será exibido do Help
        Busca pelo help gravado pelo nome do help
        Mensagem do Problema
        Número de Linhas do Problema
        Indica qual coluna começará a leitura do help
        Compatibilidade
        Define se irá mostrar em alguma dialog
        Altura da janela de help
        Largura da janela de help
        Define se irá gravar um log (ideal para usar na MostraErro)
        Array com as linhas da solução do Problema
    Retorno
        Não tem retorno

    Função ExibeHelp
    Parâmetros
        Título que será exibido do Help
        Mensagem do Problema
        Mensagem da Solução
    Retorno
        Não tem retorno

    Função ShowHelpDlg
    Parâmetros
        + cCabec     , Caractere     , Título que será exibido do Help
        + aProbl     , Array         , Array com a mensagem de problema
        + nLinProbl  , Numérico      , Número máximo de linhas que serão exibidas do problema
        + aSolucao   , Array         , Array com a mensagem de solução
        + nLinSoluc  , Numérico      , Número máximo de linhas que serão exibidas da solução
    Retorno
        Não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe297()
    Local aArea      := FWGetArea()
    Local cMensagem  := "Não foi encontrado parametrização para executar a rotina"
    Local cSolucao   := "Cadastre o parâmetro MV_X_PARAM"
    
    //Exibindo a mensagem com Help
    Help(, , "Help", , cMensagem, 1, 0, , , , , , {cSolucao})

    //Exibindo a mensagem com ExibeHelp
    ExibeHelp("Help", cMensagem, cSolucao)

    //Exibindo a mensagem com ShowHelpDlg
    ShowHelpDlg("Help", {cMensagem}, , {cSolucao})

    FWRestArea(aArea)
Return
