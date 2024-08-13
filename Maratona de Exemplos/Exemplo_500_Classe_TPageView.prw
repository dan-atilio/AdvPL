/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/26/abrindo-um-relatorio-atraves-da-tpageview-maratona-advpl-e-tl-500/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe500
Abre um relatório para visualização
@type Function
@author Atilio
@since 04/04/2023
@see https://tdn.totvs.com/display/tec/TPageView
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe500()
    Local aArea      := FWGetArea()
    Local oDlgRelat
    Local cArqRelat  := ""
    Local oPrinter
    Local oTPageView
    Local aTamanho   := MsAdvSize()
    Local nJanLarg   := aTamanho[5]
    Local nJanAltu   := aTamanho[6]
    Local lCentered  := .T.
     
    //Definindo o arquivo que será aberto
    cArqRelat := "\spool\matr680.prt"
     
    //Criando um objeto de impressão e setando o arquivo
    oPrinter := TMSPrinter():New()
    oPrinter:SetFile(cArqRelat,.F.)
    oPrinter:SetPortrait()
    oPrinter:SetPaperSize(9)
 
    //Criando a dialog
    oDlgRelat := TDialog():New(0, 0, nJanAltu, nJanLarg, "Teste de TPageView", , , , , CLR_BLACK, RGB(250, 250, 250), , , .T.)
         
        //Criando o TPageView
        oTPageView := TPageView():New(0, 0, nJanLarg, nJanAltu, oPrinter, oDlgRelat, oPrinter:nPageWidth+200, oPrinter:nPageHeight )
        oTPageView:bLClicked:= {|| Iif(oTPageView:nZoom < 200, oTPageView:nZoom += 25,)}
        oTPageView:bRClicked:= {|| Iif(oTPageView:nZoom > 25,  oTPageView:nZoom -= 25,)}
        oTPageView:Align:= CONTROL_ALIGN_ALLCLIENT
        oTPageView:nZoom := 150
 
    oDlgRelat:Activate(, , , lCentered, {|| .T.}, , )
 
    FWRestArea(aArea)
Return
