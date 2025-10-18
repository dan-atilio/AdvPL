/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/10/09/implementando-a-autenticacao-em-dois-fatores-2fa-no-login-do-protheus-ti-responde-0193/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} User Function PswSize
Efetua a validação do usuário digitado
@type  Function
@author Atilio
@since 05/09/2024
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6815189
/*/

User Function PswSize()
    Local aRet      := PARAMIXB
    Local aToken    := {.F., ""}
    Local cToken    := ""
    Local cDigitado := ""

    //Se não veio via JOB / WS, mostra uma mensagem e veio do SIGAMDI
    If ! IsBlind() .And. LjIsMDI()
        //Aciona o disparo do eMail e vai gravar o conteúdo dentro de um arquivo
        aToken := StartJob("u_zV93Mail", GetEnvServer(), .T., aRet[1])
        
        //Se deu certo o disparo do eMail
        If aToken[1]

            //Faz a leitura do arquivo e armazena na variável
            cToken := MemoRead(aToken[2])

            //Apaga o arquivo para prevenir que não haja leitura manual
            FErase(aToken[2])

            //Faz um laço de repetição infinito
            While .T.
                //Solicita a digitação do Token
                cDigitado := FWInputBox("Insira o Token recebido por eMail: ")

                //Se tiver vazio, pergunta se o usuário quer tentar novamente
                If Empty(cDigitado)
                    If FWAlertYesNo("Não foi informado o Token. Você deseja tentar novamente (clique em Sim) ou quer cancelar (clique em Não)?", "Qual opção?")
                        Loop
                    Else
                        Final("Login cancelado pelo usuário")
                    EndIf
                EndIf

                //Se bater a informação digitada, encerra o laço
                If cDigitado == cToken
                    Exit

                //Senão, mostra mensagem e volta o laço
                Else
                    FWAlertWarning("Token inválido, tente novamente!", "Atenção")
                EndIf

            EndDo

        //Se não, volta pro usuário tentar novamente
        Else
            FWAlertError("Infelizmente não foi possível gerar o Token de autenticação. Contate o Administrador do Sistema!", "Falha")
            aRet := {"", ""}
        EndIf
    EndIf

Return aRet

/*/{Protheus.doc} User Function zV93Mail
Função que vai disparar o email, foi usada separadamente por causa do RPCSetEnv
@type  Function
@author Atilio
@since 05/09/2024
@param cParLogin, Caractere, Login que o usuário inseriu na tela de autenticação
@return aRetorno, Array, Retorna um Array com duas posições sendo [1] Se deu certo o disparo do eMail e [2] nome do arquivo temporário com o token
/*/

User Function zV93Mail(cParLogin)
    Local aArea
    Local aRetorno   := {.F., ""}
    Local cEmpAux    := "99"
    Local cFilAux    := "01"
    Local cUsrAux    := ""
    Local cPswAux    := ""
    Local cQryUsr    := ""
    Local cParaMail  := ""
    Local cCorpoMail := ""
    Local lOkMail    := .F.
    Local cArquivo   := ""
    Local cToken     := ""
    Local cPasta     := "\x_temp\"

    //Prepara o ambiente sem usuário mesmo, só para dispararmos eMail
    If Select("SX2") == 0
        RpcSetEnv(cEmpAux, cFilAux, cUsrAux, cPswAux)
    EndIf
    aArea := FWGetArea()

    //Busca o endereço de eMail do usuário e o código dele
    cQryUsr := " SELECT  " + CRLF
    cQryUsr += "     USR_EMAIL, " + CRLF
    cQryUsr += "     USR_NOME, " + CRLF
    cQryUsr += "     USR_ID " + CRLF
    cQryUsr += " FROM  " + CRLF
    cQryUsr += "     SYS_USR " + CRLF
    cQryUsr += " WHERE  " + CRLF
    cQryUsr += "     USR_CODIGO = '" + cParLogin +  "' " + CRLF
    cQryUsr += "     AND D_E_L_E_T_ = ' ' " + CRLF
    TCQuery cQryUsr New Alias "QRY_USR"

    //Se tiver dados
    If ! QRY_USR->(EoF())

        //Se a pasta não existir, cria
        If ! ExistDir(cPasta)
            MakeDir(cPasta)
        EndIf

        //Se tiver campo eMail preenchido
        cParaMail := Alltrim(QRY_USR->USR_EMAIL)
        If ! Empty(cParaMail)

            //Gera um Token com o Código do usuário, valor randômico da Hora e da Data, depois aplica o Embaralha, e o Encode64
            cToken := QRY_USR->USR_ID + RandByTime() + RandByDate()
            cToken := Embaralha(cToken, 0)
            cToken := Encode64(cToken)

            //Pega o próximo alias disponível e define o nome do arquivo dentro de uma pasta da Protheus Data
            cArquivo := GetNextAlias()
            cArquivo := cPasta + cArquivo + ".txt"

            //Realiza o disparo do eMail
            cCorpoMail := '<p>Olá <strong>' + QRY_USR->USR_NOME + '</strong>.</p>'
            cCorpoMail += '<p>Você tentou acessar o ERP Protheus recentemente né?</p>'
            cCorpoMail += '<p>Se sim, seu Token de acesso é: <strong>' + cToken + '</strong></p>'
            cCorpoMail += '<p>Se não, entre em contato urgentemente com o email <a href="mailto:contato@atiliosistemas.com">contato@atiliosistemas.com</a>.</p>'
            cCorpoMail += '<p>Um grande abraço.</p>'
            lOkMail    := GPEMail("Protheus - Token Temporário", cCorpoMail, cParaMail, /*aAnexos*/, /*lExibeHelp*/)

            //Se deu certo o disparo do email, define o retorno e grava num arquivo para leitura posterior
            If lOkMail
                aRetorno[1] := .T.
                aRetorno[2] := cArquivo

                //Grava o token no arquivo
                MemoWrite(cArquivo, cToken)
            EndIf
        EndIf
        
    EndIf
    QRY_USR->(DbCloseArea())

    FWRestArea(aArea)
Return aRetorno
