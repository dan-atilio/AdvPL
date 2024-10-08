/*
    Esse exemplo faz parte da s�rie do YouTube, Maratona de Exemplos, do canal Terminal de Informa��o, 
    caso queira ver esse exemplo rodando em v�deo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/20/abrindo-uma-regua-de-processamento-com-a-rptstatus-maratona-advpl-e-tl-427/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe426
Faz a prepara��o do ambiente para utiliza��o do sistema
@type Function
@author Atilio
@since 11/03/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6814927
@obs 
    Fun��o RPCSetEnv
    Par�metros
        + cRpcEmp      , Caractere , C�digo da empresa
        + cRpcFil      , Caractere , C�digo da filial
        + cEnvUser     , Caractere , Login do usu�rio
        + cEnvPass     , Caractere , Senha do usu�rio
        + cEnvMod      , Caractere , M�dulo de conex�o (se n�o vier nenhum ser� FAT de faturamento)
        + cFunName     , Caractere , Nome da FunName (se n�o vier nenhuma ser� RPC)
        + aTables      , Array     , Array com tabelas que j� ser�o abertas
        + lShowFinal   , L�gico    , Define se ir� controlar a vari�vel lMsFinalAuto
        + lAbend       , L�gico    , Se .T. ir� exibir mensagem de erro em caso de falha ao validar a licen�a de uso
        + lOpenSX      , L�gico    , Se .T. pega o primeiro registro da SM0 e faz a abertura das tabelas do dicion�rio (quando n�o for passado o cRpcFil)
        + lConnect     , L�gico    , Se .T. faz a conex�o com servidor AS400 / SQL Server
    Retorno
        + lRet         , L�gico    , Retorna se conseguiu preparar o ambiente com sucesso (.T.) ou n�o (.F.)

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe426()
    Local aArea     := FWGetArea()
    Local cAutoEmp  := "99"
    Local cAutoFil  := "01"
    Local cAutoUsu  := "daniel.atilio"
    Local cAutoSen  := "tst123"
    Local cAutoAmb  := "GPE"

    //Se o dicion�rio n�o estiver aberto, ir� preparar o ambiente
    If Select("SX2") <= 0
        RPCSetEnv(cAutoEmp, cAutoFil, cAutoUsu, cAutoSen, cAutoAmb)
    EndIf

    //Busca as informa��es do usu�rio
    cCodUsr := RetCodUsr()
    cNomUsr := UsrFullName(cCodUsr)

    //Exibe uma mensagem com as informa��es
    FWAlertInfo("Usu�rio logado: " + cCodUsr + " (" + cNomUsr + ")", "Teste RetCodUsr")

    FWRestArea(aArea)
Return
