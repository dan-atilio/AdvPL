/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/12/07/apagando-ou-voltando-registros-com-dbdelete-e-dbrecall-maratona-advpl-e-tl-121/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe121
Exclui um registro da tabela ou faz a recuperação dele
@type Function
@author Atilio
@since 14/12/2022
@see https://tdn.totvs.com/display/tec/DBDelete e https://tdn.totvs.com/display/tec/DBRecall
@obs 
    Função DbDelete
    Não possui parâmetros nem retorno

    Função DbRecall
    Não possui parâmetros nem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe121()
    Local aArea      := FWGetArea()
    Local cCodClient := "C00003"

    DbSelectArea('SA1')
    SA1->(DbSetOrder(1)) //A1_FILIAL + A1_COD + A1_LOJA
    SA1->(DbGoTop())

    //Iniciando o controle de transações
    Begin Transaction

        //Se conseguir posicionar no cliente, apaga o registro
        If SA1->( MsSeek(FWxFilial('SA1') + cCodClient))
            RecLock('SA1', .F.)
                DbDelete()
            SA1->(MsUnlock())
        EndIf
        
        //Pergunta se deseja voltar
        If FWAlertYesNo("Você deseja realmente apagar o registro (sim), ou deseja cancelar a exclusão (não)?", "Continua (DbDelete/DbRecall)?")
            SA1->(DbCommit())

        Else
            SA1->(DbRecall())
        EndIf
    End Transaction

    FWRestArea(aArea)
Return
