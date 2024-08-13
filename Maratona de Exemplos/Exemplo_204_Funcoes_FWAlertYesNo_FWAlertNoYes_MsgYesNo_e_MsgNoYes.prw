/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/30/mostrando-perguntas-com-fwalertyesno-fwalertnoyes-msgyesno-e-msgnoyes-maratona-advpl-e-tl-204/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe204
Função que exibe uma mensagem em tela com uma pergunta com as opções "sim" e "não"
@type Function
@author Atilio
@since 12/02/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=24347000 e https://tdn.totvs.com/display/tec/MsgNoYes
@obs 
    Função MsgYesNo
    Parâmetros
        + cTexto      , Caractere        , Texto da mensagem
        + cTitulo     , Caractere        , Título da janela da mensagem
    Retorno
        + lRet        , Lógico           , .T. se foi clicado em 'Sim' e .F. se não foi

    Função FWAlertYesNo
    Parâmetros
        + Texto da mensagem
        + Título da janela da mensagem
    Retorno
        + .T. se foi clicado em 'Sim' e .F. se não foi

    Função MsgNoYes
    Parâmetros
        + cTexto      , Caractere        , Texto da mensagem
        + cTitulo     , Caractere        , Título da janela da mensagem
    Retorno
        + lRet        , Lógico           , .T. se foi clicado em 'Sim' e .F. se não foi

    Função FWAlertNoYes
    Parâmetros
        + Texto da mensagem
        + Título da janela da mensagem
    Retorno
        + .T. se foi clicado em 'Sim' e .F. se não foi

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe204()
    Local aArea     := FWGetArea()
    Local cMensagem := ""

    //Monta uma mensagem e pergunta para o usuário
    cMensagem := "Você realmente deseja prosseguir com a <strong>exclusão das informações</strong> da tabela?"
    If FWAlertYesNo(cMensagem, "Continuar (FWAlertYesNo)?")
        Alert("Teste 1 - Usuário clicou no -Sim-")
    Else
        Alert("Teste 1 - Usuário não clicou no -Sim-")
    EndIf



    If MsgYesNo(cMensagem, "Continuar (MsgYesNo)?")
        Alert("Teste 2 - Usuário clicou no -Sim-")
    Else
        Alert("Teste 2 - Usuário não clicou no -Sim-")
    EndIf



    If FWAlertNoYes(cMensagem, "Continuar (FWAlertNoYes)?")
        Alert("Teste 3 - Usuário clicou no -Sim-")
    Else
        Alert("Teste 3 - Usuário não clicou no -Sim-")
    EndIf



    If MsgNoYes(cMensagem, "Continuar (MsgNoYes)?")
        Alert("Teste 4 - Usuário clicou no -Sim-")
    Else
        Alert("Teste 4 - Usuário não clicou no -Sim-")
    EndIf



    FWRestArea(aArea)
Return
