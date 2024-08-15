/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2023/07/03/posicionar-em-coordenadas-e-clicar-via-advpl-ti-responde-063/ 
    
*/


//Bibliotecas
#Include "Totvs.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} User Function zVid0063
Exemplo de TWebEngine e TWebChannel com posicionamento do mouse
@type  Function
@author Atilio
@since 31/08/2022
/*/

User Function zVid0063()
    Local cUrl          := ""
    //Tamanho da janela
    Private aTamanho  := MsAdvSize()
	Private	nJanLarg  := aTamanho[5]
	Private	nJanAltu  := aTamanho[6]
    //Navegador Internet
    Private oWebChannel
    Private nPort
    Private oWebEngine
    Private aComandos   := {}
  
    //Defina a URL e os comandos que vão ser executados
    cUrl := "https://terminaldeinformacao.com"
    aAdd(aComandos, 'document.getElementById("wrapper").style.background = "#ffeaea"; ')
    aAdd(aComandos, 'document.getElementsByClassName("search")[1].value = "teste"; ')

    //Cria a dialog
    DEFINE DIALOG oDlg TITLE "Exemplo de navegação (aperte F4 para executar os comandos)" FROM 000,000 TO nJanAltu,nJanLarg PIXEL

        // Prepara o conector WebSocket
        oWebChannel := TWebChannel():New()
        nPort := oWebChannel::connect()

        // Cria componente
        oWebEngine := TWebEngine():New(oDlg, 0, 0, 100, 100,, nPort)
        oWebEngine:navigate(cUrl)
        oWebEngine:Align := CONTROL_ALIGN_ALLCLIENT

        //Adiciona o atalho no F4
        SetKey(VK_F4, {|| fRodaScript()})

    ACTIVATE DIALOG oDlg CENTERED
    
Return

Static Function fRodaScript()
    Local nAtual    := 0
    Local cPastaLoc := GetTempPath()
    Local cPastaSrv := "\x_temp\"
    Local cPrograma := "mouse.exe"

    //Agora exemplifica em como clicar num componente
    //  O script tem que ser baixado como .bat e após executar, ele irá gerar um .exe
    //  Download: https://github.com/npocmaka/batch.scripts/blob/master/hybrids/.net/c/mouse.bat
    //  Após isso, coloque o arquivo mouse.exe dentro da Protheus data, na pasta \x_temp\
    
    //Se o arquivo existir no servidor
    If File(cPastaSrv + cPrograma)

        //Copia do Servidor para a pasta local
        __CopyFile(cPastaSrv + cPrograma, cPastaLoc + cPrograma)

        //Posiciono o cursor do mouse no botão Pesquisar do cabeçalho do site (coluna x linha)
        WinExec(cPastaLoc + "mouse moveTo 1290x153")

        //Efetuo o clique
        WinExec(cPastaLoc + "mouse click")

        //Percorre os comandos e executa
        For nAtual := 1 To Len(aComandos)
            oWebEngine:runJavaScript(aComandos[nAtual])
        Next
    EndIf
Return
