/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/11/15/copiando-arquivos-entre-servidor-e-estacao-usando-cpys2t-e-cpyt2s-maratona-advpl-e-tl-099/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe099
Realiza a cópia de arquivo entre servidor (Protheus Data) e terminal (Smartclient)
@type Function
@author Atilio
@since 11/12/2022
@see https://tdn.totvs.com/display/tec/CpyS2T e https://tdn.totvs.com/display/tec/CpyT2S
@obs 
    Função CpyS2T
    Parâmetros
        + cFile         , Caractere    , Nome do arquivo na Protheus Data
        + cFolder       , Caractere    , Indica a pasta destino na estação
        + lCompress     , Lógico       , Se .T. o arquivo será compactado antes de fazer a cópia
        + lChangeCase   , Lógico       , Se .T. o nome do arquivo será convertido tudo para minúsculo
    Retorno
        + lRet          , Lógico       , .T. se a cópia foi executada com sucesso ou .F. se não

    Função CpyT2S
    Parâmetros
        + cFile         , Caractere    , Nome do arquivo na estação
        + cFolder       , Caractere    , Indica a pasta destino na Protheus Data
        + lCompress     , Lógico       , Se .T. o arquivo será compactado antes de fazer a cópia
        + lChangeCase   , Lógico       , Se .T. o nome do arquivo será convertido tudo para minúsculo
    Retorno
        + lRet          , Lógico       , .T. se a cópia foi executada com sucesso ou .F. se não

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe099()
    Local aArea     := FWGetArea()
    Local cOrigem   := ""
    Local cDestino  := ""

    //Realiza a cópia do servidor para a estação
    cOrigem   := "\x_logs\log_auto.txt"
    cDestino  := "C:\spool\"
    CpyS2T(cOrigem, cDestino)

    //Realiza a cópia da estação para o servidor
    cOrigem   := "C:\spool\tst.txt"
    cDestino  := "\x_logs\"
    CpyT2S(cOrigem, cDestino)

    FWRestArea(aArea)
Return
