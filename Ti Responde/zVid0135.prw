/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/03/20/como-fazer-chover-no-protheus-ti-responde-0135/ 
    
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function ChkExec
Ponto de Entrada acionado ao clicar em alguma opção no menu
@type  Function
@author Atilio
@since 08/03/2024
@see https://tdn.totvs.com/display/public/framework/CHKEXEC+-+Dispara+ponto+de+entrada
/*/

User Function ChkExec()
    Local lContinua := .T.
	Local dDataHoje := Date()
	Local nDiaSeman := Dow(dDataHoje)
	Local cArqJaFoi := ""

    //Se for terça feira ou sábado
    If nDiaSeman == 3 .Or. nDiaSeman == 7

		//Define um nome de arquivo que ficará na temporária do S.O.
		cArqJafoi := GetTempPath() + dToS(dDataHoje) + ".txt" // exempllo: %temp%/20240308.txt

		//Se o arquivo não existe ainda
		If ! File(cArqJaFoi)

			//Cria o arquivo, para que na próxima vez que o usuário abrir alguma rotina, não abrir novamente a tela
			MemoWrite(cArqJaFoi, "Chove chuva...")
    
			//Aciona a função da chuva
			u_zVid0135()
		EndIf
    EndIf

Return lContinua

/*/{Protheus.doc} User Function zVid0135
Chove chuva...
@author Daniel Atilio
@since 08/03/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function zVid0135()
	Local aArea := FWGetArea()
	
	//Aciona a montagem da tela
	Processa({|| fMontaTela()})
	
	FWRestArea(aArea)
Return

/*/{Protheus.doc} fMontaTela
Montagem da tela
@author Daniel Atilio
@since 08/03/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fMontaTela()
	Local aArea       := FWGetArea()
	Local oDlgWeb
	Local cHtmlMusic := '&#127926;'
	Local cJanTitulo := cHtmlMusic + cHtmlMusic + ' <strong>Chove chuva</strong>, chove sem parar ' + cHtmlMusic + cHtmlMusic
	//Tamanho da janela
	Local aTamanho := FwGetDialogSize()
	Local nJanLarg := aTamanho[4] / 2
	Local nJanAltu := aTamanho[3] / 2
	//Blocos de código dos botões
	Local bBlocoFech  := {|| oDlgWeb:DeActivate()}
	//Variáveis dos objetos de navegação de páginas
	Local cHtmlText   := ''
	Local nPort       := 0
	Local oPanelHtml
	Private oWebChannel
	Private oWebEngine

	//Cria o HTML base
	cHtmlText := fMontaHtml()

	//Instancia a classe, criando uma janela
	oDlgWeb := FWDialogModal():New()
	oDlgWeb:SetTitle(cJanTitulo)
	oDlgWeb:SetSize(nJanAltu, nJanLarg)
	oDlgWeb:EnableFormBar(.T.)
	oDlgWeb:CreateDialog()
	oDlgWeb:CreateFormBar()
	oDlgWeb:AddButton('Fechar', bBlocoFech, 'Fechar', , .T., .F., .T., )

	//Busca o painel principal da dialog
	oPanelHtml := oDlgWeb:GetPanelMain()
	
	//Prepara o conector WebSocket
	oWebChannel := TWebChannel():New()
	nPort := oWebChannel::connect()

	//Cria componente
	oWebEngine := TWebEngine():New(oPanelHtml, 0, 0, 100, 100, , nPort)
	oWebEngine:SetHtml(cHtmlText)
	oWebEngine:Align := CONTROL_ALIGN_ALLCLIENT

	//Abre a janela
	oDlgWeb:Activate()

	FWRestArea(aArea)
Return

/*/{Protheus.doc} fMontaHtml
Montagem do HTML que será exibido
@author Daniel Atilio
@since 08/03/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fMontaHtml()
	Local aArea := FWGetArea()
	Local cHtml := ''

	cHtml := '<html>' + CRLF
	cHtml += '<head>' + CRLF
	cHtml += '	<title>Gerado pelo Autumn Code Maker</title>' + CRLF
	cHtml += '	<meta charset="UTF-8">' + CRLF
	cHtml += '	<style>' + CRLF
	cHtml += '	  ' + CRLF
	cHtml += '	</style>' + CRLF
	cHtml += '	<script>' + CRLF
	cHtml += '	  ' + CRLF
	cHtml += '	</script>' + CRLF
	cHtml += '</head>' + CRLF
	cHtml += '<body>' + CRLF
	cHtml += '	<iframe width="100%" height="100%" src="https://www.youtube.com/embed/QyqTU5TGi3g?autoplay=1&mute=1" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>' + CRLF
	cHtml += '</body>' + CRLF
	cHtml += '</html>' + CRLF
	
	FWRestArea(aArea)
Return cHtml
