/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/16/executando-procedures-com-a-tcspexec-maratona-advpl-e-tl-481/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe481
Executa uma procedure do banco de dados
@type Function
@author Atilio
@since 03/04/2023
@see https://tdn.totvs.com/display/tec/TCSPExec
@obs 

    TCSPExec
    Parâmetros
        + cStoredProcedure , Caractere     , Nome da Procedure no Banco
        + xParam           , Caractere     , Parâmetros que a procedure irá receber
    Retorno
        + aResult          , Array         , Retorna os resultados caso a Procedure retorne alguma informação

    A procedure criada no SQL Server foi:
        CREATE PROCEDURE PROC_TESTE
        AS
        UPDATE SB1990 SET B1_X_TESTE = SUBSTRING(CAST(GETDATE() AS VARCHAR), 13, 7)

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe481()
    Local aArea   := FWGetArea()

    //Somente se a pergunta for confirmada, irá executar a procedure
    If FWAlertYesNo("Deseja executar a procedure", "Continua?")
        TCSPExec("PROC_TESTE")
        FWAlertInfo("Processo finalizado", "Teste TCSPExec")
    EndIf

    FWRestArea(aArea)
Return
