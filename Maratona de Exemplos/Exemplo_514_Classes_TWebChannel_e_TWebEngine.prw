/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/03/abrindo-um-site-com-twebchannel-e-twebengine-maratona-advpl-e-tl-514/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe514
Cria uma navegação com a possibilidade de abrir páginas em html ou sites através de urls
@type  Function
@author Atilio
@since 05/04/2023
@see https://tdn.totvs.com/display/tec/TWebChannel e https://tdn.totvs.com/display/tec/TWebEngine
@obs 
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe514()
    Local aArea     := GetArea()
    Local cRastreio := "AA123456785BR"
    Local aPergs    := {}
  
    //Adiciona os parametros para a pergunta
    aAdd(aPergs, {1, "Rastreio",   cRastreio, "", ".T.", "", ".T.", 80, .T.})
  
    //Mostra uma pergunta com parambox para filtrar o subgrupo
    If ParamBox(aPergs, "Informe os parametros", , , , , , , , , .F., .F.)
        fMontaBusca()
    EndIf
  
    RestArea(aArea)
Return
  
Static Function fMontaBusca()
    Local cUrl          := ""
    //Tamanho da janela
    Private nJanLarg    := 800
    Private nJanAltu    := 600
    //Navegador Internet
    Private oWebChannel
    Private nPort
    Private oWebEngine
    Private aComandos   := {}
  
    //Defina a URL e os comandos que vão ser executados
    cUrl := "https://rastreamento.correios.com.br/app/index.php"
    aAdd(aComandos, 'document.getElementById("objeto").value = "' + MV_PAR01 + '"; ')

    //Cria a dialog
    DEFINE DIALOG oDlg TITLE "Pesquisa de Transportadora" FROM 000,000 TO nJanAltu,nJanLarg PIXEL

        // Prepara o conector WebSocket
        oWebChannel := TWebChannel():New()
        nPort := oWebChannel::connect()

        // Cria componente
        oWebEngine := TWebEngine():New(oDlg, 0, 0, 100, 100,, nPort)
        oWebEngine:bLoadFinished := {|self,url| fRodaScript(url) }
        oWebEngine:navigate(cUrl)
        oWebEngine:Align := CONTROL_ALIGN_ALLCLIENT

    ACTIVATE DIALOG oDlg CENTERED
    
Return
  
Static Function fRodaScript(cUrl)
    Local nAtual := 0
  
    //Percorre os comandos
    For nAtual := 1 To Len(aComandos)
        oWebEngine:runJavaScript(aComandos[nAtual])
    Next
Return
