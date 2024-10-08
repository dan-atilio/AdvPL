/*
    Esse exemplo faz parte da s�rie do YouTube, Maratona de Exemplos, do canal Terminal de Informa��o, 
    caso queira ver esse exemplo rodando em v�deo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/18/ativando-a-gravacao-de-logs-do-dbaccess-com-tcsqlreplay-maratona-advpl-e-tl-484/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe484
Ativa a grava��o de logs do DBAccess direto dentro da Protheus Data
@type Function
@author Atilio
@since 03/04/2023
@see https://tdn.totvs.com/display/tec/TCSQLReplay
@obs 

    TCSQLReplay
    Par�metros
        + nOption     , Num�rico       , Op��o a ser executada (consulte o link do TDN para mais informa��es)
        + cMessage    , Caractere      , Comando a ser executado ou mensagem de retorno da execu��o
    Retorno
        + lRet        , L�gico         , Dependendo do comando retorna .T. se deu certo ou .F. se n�o

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe484()
    Local aArea     := FWGetArea()
    Local cComando  := ""

    //Verifica se no DbAccess existe o recurso para executar o TCSqlReplay
    If TCSqlReplay(1, @cComando)

        //Define o nome do arquivo de log que ser� gerado dentro da Protheus Data
        cComando := "/sqlreplay_teste.log"
        TCSqlReplay(2, @cComando)

        //Ativa o log de rotinas internas
        cComando := "1"
        TCSqlReplay(6, @cComando)

        //Altera o tamanho do log para at� 5 MB
        cComando := "5"
        TCSqlReplay(7, @cComando)

        //Verifica se esta ativo o log, se sim, executa alguns comandos no banco (como posicionar em um registro)
        cComando := ""
        If TCSqlReplay(4, @cComando)
            DbSelectArea("SB1")
            SB1->(DbSetOrder(1))
            SB1->(MsSeek(FWxFilial("SB1") + "F0001"))
        EndIf

        //Finaliza o TCSqlReplay
        TCSqlReplay(3, @cComando)
    EndIf

    FWRestArea(aArea)
Return
