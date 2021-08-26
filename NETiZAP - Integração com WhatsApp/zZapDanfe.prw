/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2021/09/20/enviando-arquivos-pelo-whatsapp-usando-advpl-tl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} User Function MT410INC
Ponto de Entrada na inclusão do pedido de venda
@type  Function
@author Atilio
@since 12/08/2021
@see https://tdn.totvs.com/display/public/PROT/MT410INC
/*/

User Function MT410INC()
    Local aArea    := GetArea()
    Local aAreaSA1 := SA1->(GetArea())
    Local cNome
    Local cDDD
    Local cTelefone
    Local cMensagem
    Local aZap
    Local cSacola  := "\uD83D\uDECD"
    Local cSorriso := "\uE056"
    Local cOculos  := "\uD83D\uDE0E"

    //Posiciona no cliente
    DbSelectArea('SA1')
    SA1->(DbSetOrder(1)) // Filial + Código + Loja
    If SA1->(DbSeek(FWxFilial('SA1') + SC5->C5_CLIENTE + SC5->C5_LOJACLI))
        //Se tiver o contato, usa ele, do contrário, usa o nome reduzido
        If ! Empty(SA1->A1_CONTATO)
            cNome := Alltrim(SA1->A1_CONTATO)
        Else
            cNome := Alltrim(SA1->A1_NREDUZ)
        EndIf
        cNome := Capital(cNome)

        //Pega o DDD, e se o usuário ter digitado 3 caracteres, retira o primeiro, por exemplo, 014 -> 14
        cDDD := Alltrim(SA1->A1_DDD)
        If Len(cDDD) == 3
            cDDD := SubStr(cDDD, 2)
        EndIf

        //Pega o Telefone e retira os espaços
        cTelefone := Alltrim(SA1->A1_TEL)

        //Se tiver DDD e Telefone
        If ! Empty(cDDD) .And. ! Empty(cTelefone)

            //Monta a mensagem que será enviada ao cliente
            cMensagem := 'Olá <b>' + cNome + '</b> ' + cOculos + '<br>' + CRLF
            cMensagem += '<br>' + CRLF
            cMensagem += 'Recebemos o seu pedido, e iremos preparar o mais rápido possível a separação e expedição dele ' + cSacola + '<br>' + CRLF
            cMensagem += '<br>' + CRLF
            cMensagem += 'Em breve, iremos lhe enviar mais informações ' + cSorriso

            //Faz o envio da mensagem
            aZap := u_zZapSend("55" + cDDD + cTelefone, cMensagem)

            //Se houve falha, mostra a mensagem de erro
            If ! aZap[1]
                MsgStop(aZap[2], "Falha no envio")
            EndIf
        EndIf
    EndIf

    RestArea(aAreaSA1)
    RestArea(aArea)
Return

/*/{Protheus.doc} User Function M460FIM
Ponto de Entrada na geração da nota fiscal de saída
@type  Function
@author Atilio
@since 12/08/2021
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6784180
/*/

User Function M460FIM()
    Local aArea      := GetArea()
    Local aAreaSA1   := SA1->(GetArea())
    Local cAceno     := "\uE41E"
    Local cFolha     := "\uD83D\uDCC4"

    //Posiciona no cliente
    DbSelectArea('SA1')
    SA1->(DbSetOrder(1)) // Filial + Código + Loja
    If SA1->(DbSeek(FWxFilial('SA1') + SF2->F2_CLIENTE + SF2->F2_LOJA))
        //Se tiver o contato, usa ele, do contrário, usa o nome reduzido
        If ! Empty(SA1->A1_CONTATO)
            cNome := Alltrim(SA1->A1_CONTATO)
        Else
            cNome := Alltrim(SA1->A1_NREDUZ)
        EndIf
        cNome := Capital(cNome)

        //Pega o DDD, e se o usuário ter digitado 3 caracteres, retira o primeiro, por exemplo, 014 -> 14
        cDDD := Alltrim(SA1->A1_DDD)
        If Len(cDDD) == 3
            cDDD := SubStr(cDDD, 2)
        EndIf

        //Pega o Telefone e retira os espaços
        cTelefone := Alltrim(SA1->A1_TEL)

        //Se tiver DDD e Telefone
        If ! Empty(cDDD) .And. ! Empty(cTelefone)

            //Monta a mensagem que será enviada ao cliente
            cMensagem := '<b>' + cNome + '</b>, ' + cAceno + '<br>' + CRLF
            cMensagem += '<br>' + CRLF
            cMensagem += 'Seu pedido já está quase concluido, se precisar tirar alguma dúvida conosco, o código de referência é <b>' + Alltrim(SF2->F2_DOC) + '-' + Alltrim(SF2->F2_SERIE) + '</b><br>' + CRLF
            cMensagem += '<br>' + CRLF
            cMensagem += 'Em breve, iremos lhe enviar a DANFE ' + cFolha

            //Faz o envio da mensagem
            aZap := u_zZapSend("55" + cDDD + cTelefone, cMensagem)

            //Se houve falha, mostra a mensagem de erro
            If ! aZap[1]
                MsgStop(aZap[2], "Falha no envio")
            EndIf
        EndIf
    EndIf

    RestArea(aAreaSA1)
    RestArea(aArea)
Return

/*/{Protheus.doc} User Function zZapDanfe
Função que processa as danfes que precisam ser enviadas aos clientes
@type  Function
@author Atilio
@since 12/08/2021
@version version
@obs O ideal é agendar a rotina via Scheduler do Protheus
    É necessário baixar o fonte zGerDanfe, disponível em https://terminaldeinformacao.com/2019/03/02/funcao-para-gerar-danfe-e-xml-de-uma-nota-em-uma-pasta-via-advpl/
/*/

User Function zZapDanfe()
    Local aArea
    Local cUser     := "Administrador"
    Local cPass     := MemoRead("\x_temp\teste.txt") //Aqui você pode adaptar para a sua lógica, mas evite deixar senhas chumbadas no código fonte
    Local cEmpAux   := "99"
    Local cFilAux   := "01"
    Local lContinua := .F.
    Private lJobPvt := .F.

    //Se não tiver ambiente aberto, é job
    If Select("SX2") == 0
        //Reseta o ambiente e abre ele novamente
        RpcClearEnv()
        RpcSetEnv(cEmpAux, cFilAux, cUser, cPass, "FAT")
        lJobPvt := .T.
        lContinua := .T.
    Else
        lContinua := MsgYesNo("Deseja executar o processamento das DANFEs para WhatsApp?", "Atenção")
    EndIf
    aArea := GetArea()

    //Se for continuar, irá chamar a rotina de processamento
    If lContinua
        Processa({|| fGerar() }, "Processando...")
    EndIf

    RestArea(aArea)
Return

Static Function fGerar()
    Local aArea     := GetArea()
    Local cPasta    := "\x_danfe\"
    Local cArqDanfe := ""
    Local cFilBkp   := cFilAnt
    Local cQryDoc   := ""
    Local nAtual    := 0
    Local nTotal    := 0
    Local cBraco    := "\uE14C"
    Local cFolha    := "\uD83D\uDCC4"
    Local cPiscada  := "\uE405"

    //Se a pasta não existir, cria
    If ! ExistDir(cPasta)
        MakeDir(cPasta)
    EndIf

    //Monta a consulta das NFs, que tenham chave de acesso, que não foram enviadas, e
    //   foi colocado uma data de corte para não processar NFs antigas
    cQryDoc := " SELECT " + CRLF
    cQryDoc += " 	F2_FILIAL, " + CRLF
    cQryDoc += " 	F2_DOC, " + CRLF
    cQryDoc += " 	F2_SERIE, " + CRLF
    cQryDoc += " 	F2_CLIENTE, " + CRLF
    cQryDoc += " 	F2_LOJA, " + CRLF
    cQryDoc += " 	SF2.R_E_C_N_O_ AS SF2REC " + CRLF
    cQryDoc += " FROM " + CRLF
    cQryDoc += " 	" + RetSQLName("SF2") + " SF2 " + CRLF
    cQryDoc += " WHERE " + CRLF
    cQryDoc += " 	F2_CHVNFE != '' " + CRLF
    cQryDoc += " 	AND F2_X_ZAPDA = '' " + CRLF
    cQryDoc += " 	AND F2_EMISSAO >= '20210801' " + CRLF
    cQryDoc += " 	AND SF2.D_E_L_E_T_ = '' " + CRLF
    TCQuery cQryDoc New Alias "QRY_DOC"

    //Define o tamanho da régua
    Count To nTotal
    ProcRegua(nTotal)
    QRY_DOC->(DbGoTop())

    //Enquanto houver notas
    While ! QRY_DOC->(EoF())
        //Incrementa a régua
        nAtual++
        IncProc("Analisando NF " + cValToChar(nAtual) + " de " + cValToChar(nTotal) + "...")

        //Se a filial for diferente, troca a empresa na memória
        If cFilAnt != QRY_DOC->F2_FILIAL
            cFilAnt := QRY_DOC->F2_FILIAL
            cNumEmp := Alltrim(cEmpAnt) + AllTrim(cFilAnt)
            OpenFile(cNumEmp)
        EndIf

        //Define o nome do arquivo da danfe
        cArqDanfe := "danfe_" + Alltrim(QRY_DOC->F2_FILIAL) + Alltrim(QRY_DOC->F2_DOC) + Alltrim(QRY_DOC->F2_SERIE)

        //Se o arquivo existir, faz a exclusão dele
        If File(cPasta + cArqDanfe + ".pdf")
            FErase(cPasta + cArqDanfe + ".pdf")
        EndIf

        //Chama a geração da danfe
        u_zGerDanfe(cParNotFis, cParSerie, cPasta, cArqDanfe)
        
        //Se o arquivo existir, irá fazer o disparo da mensagem
        If File(cPasta + cArqDanfe + ".pdf")
            //Posiciona na NF
            DbSelectArea('SF2')
            SF2->(DbGoTo(QRY_DOC->SF2REC))

            //Posiciona no cliente
            DbSelectArea('SA1')
            SA1->(DbSetOrder(1)) // Filial + Código + Loja
            If SA1->(DbSeek(FWxFilial('SA1') + SF2->F2_CLIENTE + SF2->F2_LOJA))
                //Se tiver o contato, usa ele, do contrário, usa o nome reduzido
                If ! Empty(SA1->A1_CONTATO)
                    cNome := Alltrim(SA1->A1_CONTATO)
                Else
                    cNome := Alltrim(SA1->A1_NREDUZ)
                EndIf
                cNome := Capital(cNome)

                //Pega o DDD, e se o usuário ter digitado 3 caracteres, retira o primeiro, por exemplo, 014 -> 14
                cDDD := Alltrim(SA1->A1_DDD)
                If Len(cDDD) == 3
                    cDDD := SubStr(cDDD, 2)
                EndIf

                //Pega o Telefone e retira os espaços
                cTelefone := Alltrim(SA1->A1_TEL)

                //Se tiver DDD e Telefone
                If ! Empty(cDDD) .And. ! Empty(cTelefone)

                    //Monta a mensagem que será enviada ao cliente
                    cMensagem := '<b>' + cNome + '</b>, ' + cBraco + '<br>' + CRLF
                    cMensagem += '<br>' + CRLF
                    cMensagem += 'A Nota Fiscal já foi emitida, segue o PDF ' + cFolha + '<br>' + CRLF
                    cMensagem += '<br>' + CRLF
                    cMensagem += 'Obrigado por comprar conosco, do que precisar conte conosco ' + cPiscada

                    //Faz o envio da mensagem
                    aZap := u_zZapSend("55" + cDDD + cTelefone, cMensagem, cPasta + cArqDanfe + ".pdf")

                    //Se houve falha, grava apenas a mensagem de erro
                    If ! aZap[1]
                        RecLock("SF2", .F.)
                            SF2->F2_X_ZAPOB := aZap[2]
                        SF2->(MsUnlock())

                    //Senão, se foi com sucesso, grava a data e hora também
                    Else
                        RecLock("SF2", .F.)
                            SF2->F2_X_ZAPDA := Date()
                            SF2->F2_X_ZAPHO := Time()
                            SF2->F2_X_ZAPOB := aZap[2]
                        SF2->(MsUnlock())
                    EndIf
                EndIf
            EndIf
        EndIf

        QRY_DOC->(DbSkip())
    EndDo
    QRY_DOC->(DbCloseArea())

    //Volta para a filial que estava
    If cFilAnt != cFilBkp
        cFilAnt := cFilBkp
        cNumEmp := Alltrim(cEmpAnt) + AllTrim(cFilAnt)
        OpenFile(cNumEmp)
    EndIf

    RestArea(aArea)
Return
