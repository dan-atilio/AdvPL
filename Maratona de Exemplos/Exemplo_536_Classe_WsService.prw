/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/14/buscando-o-modo-de-compartilhamento-de-uma-tabela-com-x2modacess-maratona-advpl-e-tl-537/
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "APWebSrv.ch"

/*/{Protheus.doc} WsService zWSClientes
Exemplo de WebService usando SOAP
@author Atilio
@since 07/04/2022
@version 1.0
@see https://tdn.totvs.com/display/tec/WSSERVICE
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

WsService zWSClientes Description "WebService com funcoes de clientes"
    //Atributos
    WsData   cViewRece  as String
    WsData   cViewSend  as String
    WsData   cNewRece  as String
    WsData   cNewSend  as String
 
    //Métodos
    WsMethod ViewCli       Description "Metodo para visualizar clientes"
    WsMethod NewCli        Description "Metodo para incluir clientes"
EndWsService

/*/{Protheus.doc} WsMethod ViewCli
Visualiza as informações de um cliente
@author Atilio
@since 03/06/2022
@param cViewRece, Caractere, Estrutura xml com o código do cliente ou cnpj / cpf
@obs Será retornado um XML com os dados do cadastro
/*/

WsMethod ViewCli WsReceive cViewRece WsSend cViewSend WsService zWSClientes
    Local aArea     := FWGetArea()
    Local lRet      := .T.
    Local cBusca    := Alltrim(::cViewRece)
    Local nIndice   := 0
    Local cCGC      := ""
    Local cMascCPF  := "@R 999.999.999-99"
    Local cMascCNPJ := "@R 99.999.999/9999-99"

    //Retira pontos, hífens e barras da busca (para o caso se o usuário digitou o cpf ou cnpj com esses caracteres)
    cBusca := StrTran(cBusca, ".", "")
    cBusca := StrTran(cBusca, "/", "")
    cBusca := StrTran(cBusca, "-", "")

    //Se o tamanho da busca for de 14 caracteres, é um CNPJ. Ou se for 11 caracteres, é um CPF
    If Len(cBusca) == 14 .Or. Len(cBusca) == 11
        nIndice := 3 //A1_FILIAL + A1_CGC

    //Senão, irá usar o índice padrão, por código e loja do cliente
    Else
        nIndice := 1 //A1_FILIAL + A1_COD + A1_LOJA
    EndIf

    //Tenta posicionar no cliente
    DbSelectArea("SA1")
    SA1->(DbSetOrder(nIndice))
    If SA1->(MsSeek(FWxFilial("SA1") + cBusca))
        cCGC := Alltrim(SA1->A1_CGC)

        ::cViewSend := '{' + CRLF
        ::cViewSend += ' "dados":{' + CRLF
        ::cViewSend += '  "status":"Cliente encontrado",' + CRLF
        ::cViewSend += '  "codigo":"' + SA1->A1_COD + SA1->A1_LOJA + '",' + CRLF
        If Len(cCGC) == 14
            ::cViewSend += '  "cnpj":"' + Alltrim(Transform(cCGC, cMascCNPJ)) + '",' + CRLF
        ElseIf Len(cCGC) == 11
            ::cViewSend += '  "cpf":"' + Alltrim(Transform(cCGC, cMascCPF)) + '",' + CRLF
        EndIf
        ::cViewSend += '  "nome":"'   + Alltrim(SA1->A1_NOME) + '",' + CRLF
        ::cViewSend += '  "email":"'  + Alltrim(SA1->A1_EMAIL) + '",' + CRLF
        ::cViewSend += '  "site":"'   + Alltrim(SA1->A1_HPAGE) + '"' + CRLF
        ::cViewSend += ' }' + CRLF
        ::cViewSend += '}' + CRLF

    Else
        ::cViewSend := '{' + CRLF
        ::cViewSend += ' "dados":{' + CRLF
        ::cViewSend += '  "status":"Cliente nao encontrado com a chave fornecida"' + CRLF
        ::cViewSend += ' }' + CRLF
        ::cViewSend += '}' + CRLF
    EndIf

    FWRestArea(aArea)
Return lRet

/*/{Protheus.doc} WsMethod NewCli
Cadastra um novo cliente
@author Atilio
@since 03/06/2022
@param cNewRece, Caractere, XML com os campos obrigatórios do cadastro de clientes
@obs Será retornado um XML com a informação de sucesso ou falha na inclusão
/*/
 
WsMethod NewCli WsReceive cNewRece WsSend cNewSend WsService zWSClientes
    Local aArea := FWGetArea()
    Local lRet := .T.
    Local jJsonRece
    Local cError := ""
    Local jResponse := JsonObject():New()
    Local cDirLog := '\x_logs\'
    Local nLinha
    Local aDados := {}
    Private lMsHelpAuto     := .T.
    Private lAutoErrNoFile  := .T.
    Private lMsErroAuto     := .F.

    //Recebe o texto e transforma em objeto
    jJsonRece  := JsonObject():New()
    cError := jJsonRece:FromJson(::cNewRece)

    //Se tiver algum erro no Parse, encerra a execução
    IF ! Empty(cError) .Or. Len(::cNewRece) < 20
        jResponse['errorId']  := 'NEW001'
        jResponse['error']    := 'Parse do JSON'
        jResponse['solution'] := 'Erro ao fazer o Parse do JSON'

    Else
        //Se algum dos campos estiver vazio
        If  Empty(jJsonRece:GetJsonObject('cod'))    .Or. ;
            Empty(jJsonRece:GetJsonObject('loja'))   .Or. ;
            Empty(jJsonRece:GetJsonObject('nome'))   .Or. ;
            Empty(jJsonRece:GetJsonObject('nreduz')) .Or. ;
            Empty(jJsonRece:GetJsonObject('tipo'))   .Or. ;
            Empty(jJsonRece:GetJsonObject('end'))    .Or. ;
            Empty(jJsonRece:GetJsonObject('mun'))    .Or. ;
            Empty(jJsonRece:GetJsonObject('est'))

            jResponse['errorId']  := 'NEW002'
            jResponse['error']    := 'Campo(s) obrigatorio(s)'
            jResponse['solution'] := 'Existem campos que nao foram enviados, revise a estrutura do seu JSON'

        Else
        
            //Adiciona no array
            aAdd(aDados, {'A1_COD',    jJsonRece:GetJsonObject('cod'),    Nil})
            aAdd(aDados, {'A1_LOJA',   jJsonRece:GetJsonObject('loja'),   Nil})
            aAdd(aDados, {'A1_NOME',   jJsonRece:GetJsonObject('nome'),   Nil})
            aAdd(aDados, {'A1_NREDUZ', jJsonRece:GetJsonObject('nreduz'), Nil})
            aAdd(aDados, {'A1_TIPO',   jJsonRece:GetJsonObject('tipo'),   Nil})
            aAdd(aDados, {'A1_END',    jJsonRece:GetJsonObject('end'),    Nil})
            aAdd(aDados, {'A1_MUN',    jJsonRece:GetJsonObject('mun'),    Nil})
            aAdd(aDados, {'A1_EST',    jJsonRece:GetJsonObject('est'),    Nil})

            //Chama a inclusão automática
            MsExecAuto({|x, y| CRMA980(x, y)}, aDados, 3)

            //Se houve erro, gera um arquivo de log dentro do diretório da protheus data
            If lMsErroAuto

                //Monta o texto do Error Log que será salvo
                cErrorLog   := ''
                aLogAuto    := GetAutoGrLog()
                For nLinha := 1 To Len(aLogAuto)
                    cErrorLog += aLogAuto[nLinha] + CRLF
                Next nLinha

                //Grava o arquivo de log
                cArqLog := 'zWSClientes_New_' + dToS(Date()) + '_' + StrTran(Time(), ':', '-') + '.log'
                MemoWrite(cDirLog + cArqLog, cErrorLog)

                //Define o retorno para o WebService
                jResponse['errorId']  := 'NEW003'
                jResponse['error']    := 'Erro na inclusao do registro'
                jResponse['solution'] := 'Nao foi possivel incluir o registro, foi gerado um arquivo de log em ' + cDirLog + cArqLog + ' '

            //Senão, define a mensagem de retorno
            Else
                jResponse['note']     := 'Registro incluido com sucesso'
            EndIf
        EndIf
    EndIf

    //Agora pega o json da Resposta e joga para o retorno do WS
    ::cNewSend := jResponse:toJSON()

    FWRestArea(aArea)
Return lRet
