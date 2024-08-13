/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/24/integracao-com-o-word-atraves-das-funcoes-ole_-maratona-advpl-e-tl-374/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe375
Abre uma tela que será fechada conforme um tempo informado
@type Function
@author Atilio
@since 28/03/2023
@obs 

    Função OmsMsgTime
    Parâmetros
        Recebe uma string com a mensagem que será exibida
        Recebe o número em segundos que a tela permanecerá aberta
    Retorno
        Função não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe375()
    Local aArea     := FWGetArea()
    Local cMensagem := ""
    Local nTempo    := 5

    //Monta uma mensagem e exibe na tela
    cMensagem := "Olá. Lembre-se de gravar todas as alterações necessárias! (essa tela será fechada em 5 segundos)"
    OmsMsgTime(cMensagem, nTempo)
 
    FWRestArea(aArea)
Return
