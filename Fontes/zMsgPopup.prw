/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2021/09/08/exibindo-uma-notificacao-no-windows-atraves-de-um-programa-em-advpl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "TOTVS.ch"

User Function AfterLogin() 
	u_zMsgPopup()
Return nil

/*/{Protheus.doc} User Function zMsgPopup
Função que mostra um popup de aviso no Windows 10 (Windows Notification Balloon)
@type  Function
@author Atilio
@since 08/04/2021
@version version
@obs A função também pode ser adaptada para ser usada com TSystemTray - https://tdn.totvs.com/display/tec/TSystemTray
@see https://stackoverflow.com/questions/50927132/show-balloon-notifications-from-batch-file
/*/

User Function zMsgPopup()
	Local aArea := GetArea()
	Local cPastaTemp := GetTempPath()
	Local cArquiBat := "test-message.bat"
	Local cConteuBat := ""
	Local cTitulo := ""
	Local cMensagem := ""

	//Tratativa para que, se a variável não existir, iremos criar ela como public
	If Type("__lMostrou") == "U"
		Public __lMostrou := .F.
	EndIf

	//Se for o módulo financeiro (variável pública do Protheus)
	If nModulo == 6
		
		//Se a mensagem não tiver sido exibida ainda
		If ! __lMostrou

			//Primeiro passo, iremos criar um arquivo .bat dentro da pasta temporária do Windows - Conforme exemplo do StackOverFlow Acima
			If ! File(cPastaTemp + cArquiBat)
				cConteuBat := '@echo off' + CRLF
				cConteuBat += '' + CRLF
				cConteuBat += 'if "%~1"=="" call :printhelp  & exit /b 1' + CRLF
				cConteuBat += 'setlocal' + CRLF
				cConteuBat += '' + CRLF
				cConteuBat += 'if "%~2"=="" (set Icon=Information) else (set Icon=%2)' + CRLF
				cConteuBat += 'powershell -Command "[void] [System.Reflection.Assembly]::LoadWithPartialName(' + "'System.Windows.Forms'" + '); $objNotifyIcon=New-Object System.Windows.Forms.NotifyIcon; $objNotifyIcon.BalloonTipText=' + "'%~1'" + '; $objNotifyIcon.Icon=[system.drawing.systemicons]::%Icon%; $objNotifyIcon.BalloonTipTitle=' + "'%~3'" + '; $objNotifyIcon.BalloonTipIcon=' + "'None'" + '; $objNotifyIcon.Visible=$True; $objNotifyIcon.ShowBalloonTip(5000);"' + CRLF
				cConteuBat += '' + CRLF
				cConteuBat += 'endlocal' + CRLF
				cConteuBat += 'goto :eof' + CRLF
				cConteuBat += '' + CRLF
				cConteuBat += ':printhelp' + CRLF
				cConteuBat += 'echo USAGE: %~n0 Text [Icon [Title]]' + CRLF
				cConteuBat += 'echo Icon can be: Application, Asterisk, Error, Exclamation, Hand, Information, Question, Shield, Warning or WinLogo' + CRLF
				cConteuBat += 'exit /b' + CRLF

				MemoWrite(cPastaTemp + cArquiBat, cConteuBat)
			EndIf

			//Agora iremos montar a mensagem do comando, aqui estou chumbando ela, mas você pode fazer uma query SQL para montar
			cTitulo := "[Protheus] Atenção"
			cMensagem := "Seja bem vindo -" + Alltrim(UsrRetName(RetCodUsr())) + "- , lembre-se que: "
			cMensagem += "Existem 5 Títulos a Pagar vencendo hoje e "
			cMensagem += "Existem 8 Títulos a Receber vencendo hoje"

			//Por último, iremos mostrar o comando, executando o bat, e passando as variaveis montadas acima
			ShellExecute("OPEN", cArquiBat, '"' + cMensagem + '" Information "' + cTitulo + '"', cPastaTemp, 0 )

			//Altera a flag para não mostrar novamente a mensagem
			__lMostrou := .T.
		EndIf
	EndIf

	RestArea(aArea)
Return
