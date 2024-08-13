/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/11/abrindo-uma-tela-para-marcacao-de-registros-com-fwmarkbrowse-maratona-advpl-e-tl-229/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe228
Exibe uma mensagem no console.log do AppServer
@type Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/display/public/framework/FWLogMsg
@obs 

    Função FWLogMsg
    Parâmetros
        + cSeverity      , Caractere  , Informe a severidade da mensagem de log. As opções possíveis são: INFO, WARN, ERROR, FATAL, DEBUG
        + cTransactionId , Caractere  , Informe o Id de identificação da transação para operações correlatas. Informe "LAST" para o sistema assumir o mesmo id anterior
        + cGroup         , Caractere  , Informe o Id do agrupador de mensagem de Log
        + cCategory      , Caractere  , Informe o Id da categoria da mensagem
        + cStep          , Caractere  , Informe o Id do passo da mensagem
        + cMsgId         , Caractere  , Informe o Id do código da mensagem
        + cMessage       , Caractere  , Informe a mensagem de log. Limitada à 10K
        + nMensure       , Numérico   , Informe a uma unidade de medida da mensagem
        + nElapseTime    , Numérico   , Informe o tempo decorrido da transação
        + aMessage       , Array      , Informe a mensagem de log em formato de Array - Ex: { {"Chave" ,"Valor"} }
    Retorno
        Função não tem retorno


    Para o correto funcionamento, ative FWLOGMSG_DEBUG=1 no environment dentro do appserver.ini


    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe228()
    Local aArea     := FWGetArea()
    Local cTexto    := "Passei pela função zExe228"

    //Exibe a mensagem no Console.log
    FWLogMsg(;
        "INFO",;    //cSeverity      - Informe a severidade da mensagem de log. As opções possíveis são: INFO, WARN, ERROR, FATAL, DEBUG
        ,;          //cTransactionId - Informe o Id de identificação da transação para operações correlatas. Informe "LAST" para o sistema assumir o mesmo id anterior
        "ZEXE228",; //cGroup         - Informe o Id do agrupador de mensagem de Log
        ,;          //cCategory      - Informe o Id da categoria da mensagem
        ,;          //cStep          - Informe o Id do passo da mensagem
        ,;          //cMsgId         - Informe o Id do código da mensagem
        cTexto,;    //cMessage       - Informe a mensagem de log. Limitada à 10K
        ,;          //nMensure       - Informe a uma unidade de medida da mensagem
        ,;          //nElapseTime    - Informe o tempo decorrido da transação
        ;           //aMessage       - Informe a mensagem de log em formato de Array - Ex: { {"Chave" ,"Valor"} }
    ) 
    
    FWRestArea(aArea)
Return
