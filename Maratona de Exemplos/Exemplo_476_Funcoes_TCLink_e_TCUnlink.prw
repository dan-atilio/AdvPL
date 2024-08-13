/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/14/conectando-em-outra-base-de-dados-com-tclink-e-tcunlink-maratona-advpl-e-tl-476/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe476
Realiza uma conexão com outra base de dados, configurada no DbAccess
@type Function
@author Atilio
@since 03/04/2023
@see https://tdn.totvs.com/display/tec/TCLink e https://tdn.totvs.com/display/tec/TCUnlink
@obs 

    TCLink
    Parâmetros
        + cConn       , Caractere      , Indica o nome da conexão usada no DbAccess
        + cServerAddr , Caractere      , Indica o IP do servidor do banco de dados
        + nPort       , Numérico       , Indica o número da porta de conexão com o DbAccess
    Retorno
        + nHwnd       , Numérico       , Retorna um número de handle que será o identificador da conexão

    TCUnlink
    Parâmetros
        + nHandle     , Numérico       , Indica o número do handle que será desconectado
        + lVerbose    , Lógico         , Se .T. irá mensagens de warning no console.log
    Retorno
        + lRet        , Lógico         , Retorna .T. se a conexão foi encerrada com sucesso ou .F. se não

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe476()
    Local aArea := FWGetArea()
    Local cBcoDados:= "MSSQL/TESTE"      //Conexão no DbAccess com a outra base de Dados
    Local cServer  := "127.0.0.1"        //Servidor que está configurado o DbAccess
    Local nPorta   := 7890               //Porta da conexão do DbAccess
    Local nHandle  := 0                  //Ponteiro que armazenará a conexão
    Local cQuery   := ""
    
    //Conecta com Banco
    nHandle  := TcLink(cBcoDados, cServer, nPorta)
    
    //Se houve algum erro na conexão
    If nHandle < 0
        MsgInfo("Não foi possível conectar! Erro: " + cValToChar(nHandle), "Atenção")
        
    //Senão, insere um registro em uma tabela (você pode fazer outras operações como SELECT, UPDATE, etc)
    Else 
        cQuery += " INSERT INTO TABELA_XYZ " + CRLF
        cQuery += " (NOME, URL_SITE, PROFISSAO)  " + CRLF
        cQuery += " VALUES ('Teste automático', 'terminaldeinformacao.com', 'observação teste " + Time() + "') " + CRLF

        //Se houve falha, mostra uma mensagem
        If TCSqlExec(cQuery) < 0
            FWAlertInfo("Falha: " + TCSQLError(), "Teste TCLink e TCUnlink")
        Else
            FWAlertSuccess("Registro incluido com sucesso", "Teste TCLink e TCUnlink")
        EndIf
    Endif
    
    //Desconecta
    TCUnlink(nHandle)

    FWRestArea(aArea)
Return
