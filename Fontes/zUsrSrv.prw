/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2020/06/05/script-para-validar-usuarios-locais-nos-servidores-utilizando-advpl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Totvs.ch"

Static nPosCod  := 1
Static nPosIP   := 2
Static nPosDNS  := 3
Static nPosDesc := 4
Static nPosDif  := 5
Static nPosOld  := 6
Static nPosNew  := 7

/*/{Protheus.doc} User Function zUsrSrv
Script para verificar usuarios locais nos servers
@type  Function
@author Atilio
@since 08/04/2020
@version version
@obs Essa funcao nao pode ser agendada no Scheduler por causa do PowerShell
    Ela deve ser executada via .bat (conteudo abaixo), agendada em uma maquina local (testada com Windows 10)

    C:\TOTVS\Producao\smartclient.exe -m -q -c=tcp -e=ambiente_desenv -p=u_zUsrSrv
/*/

User Function zUsrSrv()
    Local aArea := GetArea()
    Local cPsw	   := "Sua Senha"
    Private aServers := {}
    Private cDirSpool := "C:\spool\"

    //Se não estiver preparado, prepara o ambiente
	If Select("SX2") == 0  
   	 	RPCSetEnv("01", "01", "Admin", cPsw, "", "", {})
	EndIf

    //Se nao existir a pasta para o procedimento, cria ela
    If ! ExistDir(cDirSpool)
        MakeDir(cDirSpool)
    EndIf

    //Diretorio interno do spool
    cDirSpool += "zUsrSrv\"
    If ! ExistDir(cDirSpool)
        MakeDir(cDirSpool)
    EndIf

    //Monta os arrays
    fMontaSrv()

    //Faz as execucoes
    fExecCmd()

    //Faz as comparacoes
    fCompara()

    RestArea(aArea)
Return

Static Function fMontaSrv()
    //Adiciona os servidores e ips das maquinas que terao analise
    aAdd(aServers, {"111", "192.168.70.111", "srv01.dominio.org",    "DBAccess e License",         .F., "", ""})
    aAdd(aServers, {"112", "192.168.70.112", "srv02.dominio.org",    "Protheus e Protheus Data",   .F., "", ""})
    aAdd(aServers, {"113", "192.168.70.113", "srv03.dominio.org",    "Banco de Dados",             .F., "", ""})
Return

Static Function fExecCmd()
    Local nAtual := 1
    Local cCommand := ""
    Local cExecCmd := ""
    Local cDirTmp  := GetTempPath()
    Local cArqBat  := "servers_local_users.bat"
    Local cNewFile := ""
    Local cOldFile := ""
    
    //Montando a base do comando
    cCommand := 'powershell -Command "Get-WmiObject -ComputerName \"%zUsrSrv_DNS%\" -Class Win32_UserAccount -Filter '
    cCommand += '\"LocalAccount=' + "'True'\" + '" | Select PSComputername, Name, Status, Disabled, AccountType, Lockout, PasswordRequired, PasswordChangeable, SID '
    cCommand += '| Export-csv \"%zUsrSrv_FILE%\" -NoTypeInformation '// + CRLF + 'pause'

    //Percorre os servidores
    For nAtual := 1 To Len(aServers)
        cArqBat  := "servers_local_" + aServers[nAtual][nPosCod] + ".bat"

        //Exclui o arquivo novo
        cNewFile := cDirSpool + aServers[nAtual][nPosCod] + "_new.csv"
        FErase(cNewFile)

        //Cria .bat com comando
        cExecCmd := cCommand
        cExecCmd := StrTran(cExecCmd, "%zUsrSrv_DNS%",  aServers[nAtual][nPosIP])
        cExecCmd := StrTran(cExecCmd, "%zUsrSrv_FILE%", cNewFile)
        MemoWrite(cDirTmp + cArqBat, cExecCmd)

        //Executa o comando
        ShellExecute("Open", cArqBat, "", cDirTmp, 0 )
        Sleep(10000)

        //Pega o conteudo dele e coloca no array
        aServers[nAtual][nPosNew] := MemoRead(cNewFile)

        //Se o arquivo original nao existir, cria uma copia dele conforme o arquivo novo
        cOldFile := cDirSpool + aServers[nAtual][nPosCod] + "_old.csv"
        If ! File(cOldFile)
            MemoWrite(cOldFile, aServers[nAtual][nPosNew])
        EndIf
        aServers[nAtual][nPosOld] := MemoRead(cOldFile)

        //Compara os dois conteudos
        If aServers[nAtual][nPosNew] != aServers[nAtual][nPosOld]
            aServers[nAtual][nPosDif] := .T.
        EndIf
    Next
Return

Static Function fCompara()
    Local cCorpo := ""
    Local cVazio := ""
    Local nAtual := 0
    Local aConteudo := {}
    Local nPosUsr := 0
    Local cNomeUsr := ""
    Local cMensagem := ""
    Local cPara := u_zRetMail("zUsrSrv")

    //Percorrendo os servers
    For nAtual := 1 To Len(aServers)
        //Se houver diferencas
        If aServers[nAtual][nPosDif]
            cCorpo += "<h3>Servidor - " + aServers[nAtual][nPosIP] + " (" + aServers[nAtual][nPosDesc] + ")</h3>"

            //Percorre linhas do novo arquivo
            aConteudo := StrTokArr(aServers[nAtual][nPosNew], CRLF)
            cCorpo += "<ul>"
            For nPosUsr := 1 To Len(aConteudo)
                //Se nao for a linha de cabecalho
                If (aConteudo[nPosUsr] != '"PSComputerName","Name","Status","Disabled","AccountType","Lockout","PasswordRequired","PasswordChangeable","SID"')
                    cNomeUsr := aConteudo[nPosUsr]
                    cNomeUsr := SubStr(cNomeUsr, At(',', cNomeUsr) + 1, Len(cNomeUsr))
                    cNomeUsr := SubStr(cNomeUsr, 1,                      At(',', cNomeUsr) - 1)
                    cNomeUsr := StrTran(cNomeUsr, '"', '')

                    //Se o usuario estiver no antigo, saira normal, senao saira em negrito
                    If aConteudo[nPosUsr] $ aServers[nAtual][nPosOld]
                        cCorpo += "<li>" + cNomeUsr + "</li>"
                    Else
                        cCorpo += "<li><strong>" + cNomeUsr + "</strong></li>"
                    EndIf
                EndIf
            Next
            cCorpo += "</ul>"
            cCorpo += "<br>"
        EndIf

        //Se tiver vazio o conteudo
        If Empty(aServers[nAtual][nPosNew])
            cVazio += "<li>" + aServers[nAtual][nPosIP] + " (" + aServers[nAtual][nPosDNS] + " / " + aServers[nAtual][nPosDesc] + ")</li>"
        EndIf
    Next

    //Se tiver corpo do e-Mail
    If ! Empty(cCorpo) .Or. ! Empty(cVazio)
        cMensagem := "<p>Ola.</p><br>"
        If ! Empty(cCorpo)
            cMensagem += "<hr>"
            cMensagem += "<p>Os seguintes servidores tiveram alteracao recente nos usuarios locais, confira com urgencia!</p><br><br>"
            cMensagem += cCorpo + "<br>"
        EndIf

        //Se tiver arquivos vazios
        If ! Empty(cVazio)
            cMensagem += "<hr>"
            cMensagem += "<p>Nos seguintes servidores, nao foi possivel buscar os usuarios locais:</p><br>"
            cMensagem += "<ul>"
            cMensagem += cVazio
            cMensagem += "</ul>"
        EndIf

        //MemoWrite("C:\Users\daniel.atilio\Desktop\arquivo_tst.html", cMensagem)

        //Disparando o e-Mail
        u_EnviarEmail(	cPara,;                                    //Destinatário do e-Mail
                        "[dominio] - Usuarios Locais nos Servidores ",;   //Assunto
                        cMensagem,;                                    //Corpo do e-Mail
                        "",;                          //Arquivo anexo
                        ,;                                         //Grava log
                        ,;                                         //Deu certo disparo de e-Mail?
                        .F.)                                       //Novo tipo de envio?
    EndIf
Return