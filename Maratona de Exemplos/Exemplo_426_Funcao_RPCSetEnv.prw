/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/20/abrindo-uma-regua-de-processamento-com-a-rptstatus-maratona-advpl-e-tl-427/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe426
Faz a preparação do ambiente para utilização do sistema
@type Function
@author Atilio
@since 11/03/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6814927
@obs 
    Função RPCSetEnv
    Parâmetros
        + cRpcEmp      , Caractere , Código da empresa
        + cRpcFil      , Caractere , Código da filial
        + cEnvUser     , Caractere , Login do usuário
        + cEnvPass     , Caractere , Senha do usuário
        + cEnvMod      , Caractere , Módulo de conexão (se não vier nenhum será FAT de faturamento)
        + cFunName     , Caractere , Nome da FunName (se não vier nenhuma será RPC)
        + aTables      , Array     , Array com tabelas que já serão abertas
        + lShowFinal   , Lógico    , Define se irá controlar a variável lMsFinalAuto
        + lAbend       , Lógico    , Se .T. irá exibir mensagem de erro em caso de falha ao validar a licença de uso
        + lOpenSX      , Lógico    , Se .T. pega o primeiro registro da SM0 e faz a abertura das tabelas do dicionário (quando não for passado o cRpcFil)
        + lConnect     , Lógico    , Se .T. faz a conexão com servidor AS400 / SQL Server
    Retorno
        + lRet         , Lógico    , Retorna se conseguiu preparar o ambiente com sucesso (.T.) ou não (.F.)

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe426()
    Local aArea     := FWGetArea()
    Local cAutoEmp  := "99"
    Local cAutoFil  := "01"
    Local cAutoUsu  := "daniel.atilio"
    Local cAutoSen  := "tst123"
    Local cAutoAmb  := "GPE"

    //Se o dicionário não estiver aberto, irá preparar o ambiente
    If Select("SX2") <= 0
        RPCSetEnv(cAutoEmp, cAutoFil, cAutoUsu, cAutoSen, cAutoAmb)
    EndIf

    //Busca as informações do usuário
    cCodUsr := RetCodUsr()
    cNomUsr := UsrFullName(cCodUsr)

    //Exibe uma mensagem com as informações
    FWAlertInfo("Usuário logado: " + cCodUsr + " (" + cNomUsr + ")", "Teste RetCodUsr")

    FWRestArea(aArea)
Return
