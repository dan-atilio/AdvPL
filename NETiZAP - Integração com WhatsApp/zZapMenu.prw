/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2021/09/27/como-fazer-um-menu-de-opcoes-com-analise-da-resposta-no-whatsapp-usando-advpl-tl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} User Function zZapMenu
Função que verifica mensagens recebidas e envia um menu de perguntas
@type  Function
@author Atilio
@since 21/08/2021
@version version
@obs O ideal é agendar a rotina via Scheduler do Protheus

    Será necessário criar uma tabela que fará controle das interações pelo Protheus, abaixo os campos e o índice
    Tabela:
        ZAA - Interações via NETiZAP - Totalmente Compartilhada
    Campos:
        Campo      | Tipo      | Tamanho              | Descrição
        ZAA_FONE   | Caractere | 15                   | Telefone
        ZAA_PRIMSG | Caractere | 20                   | Primeira Mensagem
        ZAA_ULTMSG | Caractere | 20                   | Última Mensagem
        ZAA_CLICOD | Caractere | 6 (mesmo do A1_COD)  | Código do Cliente
        ZAA_CLILOJ | Caractere | 2 (mesmo do A1_LOJA) | Loja do Cliente
        ZAA_FUNCAO | Caractere | 10                   | Função que disparou a pergunta
        ZAA_PERGUN | Caractere | 10                   | Código da Pergunta
        ZAA_PERDAT | Data      | 8                    | Data da Pergunta
        ZAA_PERHOR | Caractere | 8                    | Hora da Pergunta
    Índices:
        1. ZAA_FILIAL + ZAA_FONE
/*/

User Function zZapMenu()
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
        lContinua := MsgYesNo("Deseja executar o processamento da busca das mensagens no WhatsApp?", "Atenção")
    EndIf
    aArea := GetArea()

    //Se for continuar, irá chamar a rotina de processamento
    If lContinua
        Processa({|| fProcessar() }, "Processando...")
    EndIf

    RestArea(aArea)
Return

Static Function fProcessar()
    Local aArea      := GetArea()
    Local cLinha     := SuperGetMV("MV_X_ZAPLI", .F., "5521986855299")
    Local nPorta     := SuperGetMV("MV_X_ZAPPO", .F., 13155)
    Local cChave     := SuperGetMV("MV_X_ZAPCH", .F., "fUzanE5ncxlTAWBjMO30")
    Local cMensagens := ""
    Local oJSON      := JsonObject():New()
    Local cRet
    Local nTelAtu    := 0
    Local cTelefone  := ""
    Local cPriMsg    := ""
    Local cUltMsg    := ""
    Local cFuncao    := ""
    Local cPergun    := ""
    Local dData      := sToD("")
    Local cHora      := ""
    Local cUltPerg   := ""
    Local cUltResp   := ""
    Local cZapMsg    := ""
    Local lErro      := .F.
    Local cTelCli    := ""

    //Instancia a classe, e passa os parametros da NETiZAP
    oZap := NETiZAP():New(cLinha, cChave, nPorta)
    oZap:RequestsStart()
    cMensagens := oZap:cResponse

    //Se houver mensagens
    If ! Empty(cMensagens)
        //Transforma o JSON em um Objeto
        cRet := oJSON:FromJson(cMensagens)

        If ValType(cRet) == "U"
            aTelefones := oJSON:GetJsonObject("root")

            //Percorre os números de telefones
            If ValType(aTelefones) == "A"
                For nTelAtu := 1 To Len(aTelefones)
                    cTelefone  := aTelefones[nTelAtu]:GetJsonObject("phone")
                    cPriMsg    := aTelefones[nTelAtu]:GetJsonObject("message_datehour_first")
                    cUltMsg    := aTelefones[nTelAtu]:GetJsonObject("message_datehour_last")

                    DbSelectArea("ZAA")
                    ZAA->(DbSetOrder(1)) // ZAA_FILIAL + ZAA_FONE

                    //Se encontrou na tabela customizada (não vai fazer nada, apenas deixar o registro posicionado)
                    If ZAA->(DbSeek(FWxFilial("ZAA") + cTelefone))

                    //Senão, irá incluir um novo registro
                    Else
                        RecLock("ZAA", .T.)
                            ZAA->ZAA_FILIAL := FWxFilial("ZAA")
                            ZAA->ZAA_FONE   := cTelefone
                            ZAA->ZAA_PRIMSG := cPriMsg
                            ZAA->ZAA_ULTMSG := ""
                            ZAA->ZAA_CLICOD := ""
                            ZAA->ZAA_CLILOJ := ""
                            ZAA->ZAA_FUNCAO := ""
                            ZAA->ZAA_PERGUN := ""
                            ZAA->ZAA_PERDAT := sToD("")
                            ZAA->ZAA_PERHOR := ""
                        ZAA->(MsUnlock())
                    EndIf

                    //Se o horário de fim estiver diferente, quer dizer que veio novas mensagens
                    If ZAA->ZAA_ULTMSG != cUltMsg
                        cFuncao := ""
                        cPergun := ""
                        dData   := sToD("")
                        cHora   := ""

                        //Se não houve pergunta ainda ou se a data da última pergunta for diferente da data de hoje, perguntamos sobre o cpf da pessoa
                        If Empty(ZAA->ZAA_PERGUN) .Or. ZAA->ZAA_PERDAT != Date()
                            //Dispara a mensagem para buscar o cpf ou cnpj
                            cPergun := "CPF"
                            cZapMsg := fMensagem(cPergun)
                            aZap := u_zZapSend(Alltrim(ZAA->ZAA_FONE), cZapMsg)

                            //Se houve falha, pula o telefone
                            If ! aZap[1]
                                nTelAtu++
                                Loop
                            EndIf

                        //Senão
                        Else
                            aMensagens := aTelefones[nTelAtu]:GetJsonObject("messages")

                            //Armazena a última pergunta em uma variável
                            cUltPerg := Alltrim(ZAA->ZAA_PERGUN)

                            //Armazena a resposta em outra variável
                            cUltResp := aMensagens[Len(aMensagens)]:GetJsonObject("message")

                            //Se a pergunta foi sobre o CPF
                            If cUltPerg == "CPF"
                                //Retira caracteres especiais digitados pelo usuário
                                cUltResp := StrTran(cUltResp, ' ', '')
                                cUltResp := StrTran(cUltResp, '.', '')
                                cUltResp := StrTran(cUltResp, '/', '')
                                cUltResp := StrTran(cUltResp, '-', '')

                                DbSelectArea("SA1")
                                SA1->(DbSetOrder(3)) // A1_FILIAL + A1_CGC

                                //Busca na SA1 o CPF
                                If SA1->(DbSeek(FWxFilial('SA1') + cUltResp))
                                    cTelCli := "55" + SubStr(SA1->A1_DDD, 2) + Alltrim(SA1->A1_TEL)
                                    cTelCli := StrTran(cTelCli, "-", "")
                                    cTelCli := StrTran(cTelCli, " ", "")

                                    //Se o DDD e o telefone estiverem diferentes
                                    If cTelCli != Alltrim(ZAA->ZAA_FONE)
                                        lErro   := .T.
                                        cPergun := "CPF"
                                    Else
                                        RecLock("ZAA", .F.)
                                            ZAA->ZAA_CLICOD := SA1->A1_COD
                                            ZAA->ZAA_CLILOJ := SA1->A1_LOJA
                                        ZAA->(MsUnlock())

                                        //Dispara a mensagem com o menu
                                        lErro   := .F.
                                        cPergun := "MENU"
                                        cZapMsg := fMensagem("MENU")
                                        aZap := u_zZapSend(Alltrim(ZAA->ZAA_FONE), cZapMsg)

                                        //Se houve falha, pula o telefone
                                        If ! aZap[1]
                                            nTelAtu++
                                            Loop
                                        EndIf
                                    EndIf
                                Else
                                    lErro   := .T.
                                    cPergun := "CPF"
                                EndIf

                                //Se houve erro, manda mensagem, dizendo que não compreendeu a resposta
                                If lErro
                                    cZapMsg := fMensagem("ERRO")
                                    aZap := u_zZapSend(Alltrim(ZAA->ZAA_FONE), cZapMsg)

                                    //Se houve falha, pula o telefone
                                    If ! aZap[1]
                                        nTelAtu++
                                        Loop
                                    EndIf
                                EndIf

                            //Se a pergunta foi sobre o que ele gostaria de saber
                            Else
                                cUltResp := SubStr(cUltResp, 1, 1)
                                cPergun := ZAA->ZAA_PERGUN

                                //Se a resposta foi 1 = Consultar valor de títulos em aberto
                                If cUltResp == "1"
                                    cZapMsg := fMensagem("ABERTO") + "<br>--<br>" + fMensagem("MENU")

                                //Se a resposta foi 2 = Ver dados de compras
                                ElseIf cUltResp == "2"
                                    cZapMsg := fMensagem("RESUMO") + "<br>--<br>" + fMensagem("MENU")

                                //Se a resposta foi 3 = Para qual e-Mail esta enviando as DANFEs
                                ElseIf cUltResp == "3"
                                    cZapMsg := fMensagem("EMAIL") + "<br>--<br>" + fMensagem("MENU")

                                //Se a resposta foi 4 = Falar com atendente
                                ElseIf cUltResp == "4"
                                    cZapMsg := fMensagem("ATENDENTE") + "<br>--<br>" + fMensagem("MENU")

                                //Se a resposta foi 0 = Sair e cancelar (zera a pergunta para identificar que o usuário foi atendido)
                                ElseIf cUltResp == "0"
                                    cPergun := ""
                                    cZapMsg := fMensagem("TCHAU")

                                //Senão, diz que não compreendeu
                                Else
                                    cZapMsg := fMensagem("ERRO") + "<br><br>" + fMensagem("MENU")
                                EndIf

                                //Dispara a mensagem
                                aZap := u_zZapSend(Alltrim(ZAA->ZAA_FONE), cZapMsg)

                                //Se houve falha, pula o telefone
                                If ! aZap[1]
                                    nTelAtu++
                                    Loop
                                EndIf
                            EndIf
                        EndIf

                        //Atualiza as variáveis
                        cFuncao := "zZapMenu"
                        dData   := Date()
                        cHora   := Time()

                        //Grava a informação na tabela
                        RecLock("ZAA", .F.)
                            ZAA->ZAA_ULTMSG := cUltMsg
                            ZAA->ZAA_FUNCAO := cFuncao
                            ZAA->ZAA_PERGUN := cPergun
                            ZAA->ZAA_PERDAT := dData
                            ZAA->ZAA_PERHOR := cHora
                        ZAA->(MsUnlock())
                    EndIf
                Next
            EndIf

        EndIf
    EndIf

    RestArea(aArea)
Return

Static Function fMensagem(cPergunta)
    Local cMensagem := ""
    Local cPiscada  := "\uE405"
    Local cSorriSuor := "\uD83D\uDE05"

    //Monta a mensagem para perguntar do CPF
    If cPergunta == "CPF"
        cMensagem := "Olá.<br>"
        cMensagem += "Obrigado por entrar em contato conosco " + cPiscada + ".<br>"
        cMensagem += "Por favor, nos diga, qual é o seu <b>CPF</b> ou seu <b>CNPJ</b>?"

    //Monta a mensagem para exibir o menu principal
    ElseIf cPergunta == "MENU"
        DbSelectArea("SA1")
        SA1->(DbSetOrder(1)) // A1_FILIAL + A1_COD + A1_LOJA
        SA1->(DbSeek(FWxFilial('SA1') + ZAA->ZAA_CLICOD + ZAA->ZAA_CLILOJ))

        //Se tiver o contato, usa ele, do contrário, usa o nome reduzido
        If ! Empty(SA1->A1_CONTATO)
            cNome := Alltrim(SA1->A1_CONTATO)
        Else
            cNome := Alltrim(SA1->A1_NREDUZ)
        EndIf
        cNome := Capital(cNome)

        cMensagem := cNome + ", abaixo nossa lista de opções:<br>"
        cMensagem += "<b>1</b> - Consultar valor de títulos em aberto<br>"
        cMensagem += "<b>2</b> - Ver resumo de compras<br>"
        cMensagem += "<b>3</b> - Para qual e-Mail esta enviando as DANFEs<br>"
        cMensagem += "<b>4</b> - Falar com atendente<br><br>"
        cMensagem += "<b>0</b> - Sair e cancelar<br><br>"
        cMensagem += "Qual é sua resposta?"

    //Se a resposta foi 1 = Consultar valor de títulos em aberto
    ElseIf cPergunta == "ABERTO"
        DbSelectArea("SA1")
        SA1->(DbSetOrder(1)) // A1_FILIAL + A1_COD + A1_LOJA
        SA1->(DbSeek(FWxFilial('SA1') + ZAA->ZAA_CLICOD + ZAA->ZAA_CLILOJ))

        If SA1->A1_SALDUP == 0
            cMensagem := "Parabéns, não consta atrasos em nossa base!"
        Else
            cMensagem := "O saldo em aberto é de <b>R$ " + Alltrim(Transform(SA1->A1_SALDUP, PesqPict('SA1', 'A1_SALDUP'))) + "</b>."
        EndIf

    //Se a resposta foi 2 = Ver dados de compras
    ElseIf cPergunta == "RESUMO"
        DbSelectArea("SA1")
        SA1->(DbSetOrder(1)) // A1_FILIAL + A1_COD + A1_LOJA
        SA1->(DbSeek(FWxFilial('SA1') + ZAA->ZAA_CLICOD + ZAA->ZAA_CLILOJ))

        cMensagem := "Valor da Maior Compra: <b>"    + Alltrim(Transform(SA1->A1_MCOMPRA, PesqPict('SA1', 'A1_MCOMPRA'))) + "</b><br>"
        cMensagem += "Data da Primeira Compra: <b>"  + dToC(SA1->A1_PRICOM) + "</b><br>"
        cMensagem += "Data da Última Compra: <b>"    + dToC(SA1->A1_ULTCOM) + "</b><br>"
        cMensagem += "Quantas vezes já comprou: <b>" + Alltrim(Transform(SA1->A1_NROCOM, PesqPict('SA1', 'A1_NROCOM'))) + "</b><br>"

    //Se a resposta foi 3 = Para qual e-Mail esta enviando as DANFEs
    ElseIf cPergunta == "EMAIL"
        DbSelectArea("SA1")
        SA1->(DbSetOrder(1)) // A1_FILIAL + A1_COD + A1_LOJA
        SA1->(DbSeek(FWxFilial('SA1') + ZAA->ZAA_CLICOD + ZAA->ZAA_CLILOJ))

        If ! Empty(SA1->A1_EMAIL)
            cMensagem := "As DANFEs estão indo atualmente para o e-Mail cadastrado: <b>" + SA1->A1_EMAIL + "</b>"
        Else
            cMensagem := "Atualmente não existe nenhum e-mail cadastrado no sistema."
        EndIf

    //Se a resposta foi 4 = Falar com atendente
    ElseIf cPergunta == "ATENDENTE"
        cMensagem := "Abaixo os meios de comunicação com um atendente:<br>"
        cMensagem += "e-Mail: <b>contato@atiliosistemas.com</b><br>"
        cMensagem += "Telefone: <b>(14) 9 9738-5495</b><br>"
        cMensagem += "Site: <b>https://atiliosistemas.com/</b>"

    //Se for a opção 0, irá se despedir
    ElseIf cPergunta == "TCHAU"
        cMensagem := "Obrigado por entrar em contato conosco.<br>"
        cMensagem += "Até logo."

    //Se houve alguma falha
    ElseIf cPergunta == "ERRO"
        cMensagem := "Desculpe, mas não consegui identificar sua resposta " + cSorriSuor + ", poderia repeti-la por favor?<br>"
        cMensagem += "<i>Se possível, não use pontuação ou caracteres especiais</i>"
    EndIf

Return cMensagem
