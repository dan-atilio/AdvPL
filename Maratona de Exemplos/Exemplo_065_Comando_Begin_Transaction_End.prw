/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/10/12/controlando-transacoes-com-o-banco-de-dados-usando-begin-transaction-end-maratona-advpl-e-tl-065/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe065
Exemplo de como realizar gravações, mas em caso de falha seja abortado
@type Function
@author Atilio
@since 06/12/2022
@see https://tdn.totvs.com/display/public/framework/BEGIN+TRANSACTION
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe065()
    Local aArea    := FWGetArea()

    //Iniciando controle de transações
    Begin Transaction
        //Inclui um novo produto
        RecLock('SBM', .T.)
            SBM->BM_GRUPO := "TST1"
            SBM->BM_DESC  := "Teste " + Time()
        SBM->(MsUnlock())
        
        //Se a pergunta foi confirmada, cancela os lançamentos na transação
        If FWAlertYesNo("Deseja cancelar e disarmar a transação?", "Atenção")
            DisarmTransaction()
        EndIf
        
    //Finalizando controle de transações
    End Transaction

    FWRestArea(aArea)
Return
