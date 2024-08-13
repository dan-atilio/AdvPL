/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/17/exibindo-tela-com-temporizador-e-as-opcoes-sim-e-nao-com-msgyesnotimer-maratona-advpl-e-tl-361/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe361
Abre uma tela com as opções sim e não, com um temporizador
@type Function
@author Atilio
@since 27/03/2023
@obs 
    Função MsgYesNoTimer
    Parâmetros
        + Mensagem a ser exibida
        + Título da janela
        + Tempo em milissegundos
        + Opção padrão de retorno (1=Sim; 2=Não) em caso da tela fechar sozinha
    Retorno
        + Retorna .T. se foi Sim ou .F. se Não

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe361()
    Local aArea         := FWGetArea()
    
    //Se a pergunta for confirmada, ou passar o tempo (ultimo parametro igual a 1)
    If MsgYesNoTimer("Você deseja continuar? (tela irá fechar em 5 segundos)", "Atenção!", 5000, 1)
        FWAlertSuccess("Foi clicado no sim ou acabou o tempo!", "Teste")
    EndIf

    FWRestArea(aArea)
Return
