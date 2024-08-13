/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/04/expandindo-e-visualizando-um-xml-atraves-da-txmlviewer-maratona-advpl-e-tl-517/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe517
Realiza a abertura de um XML para ser navegável em uma Dialog
@type  Function
@author Atilio
@since 05/04/2023
@see https://tdn.totvs.com/display/tec/TXMLViewer
@obs 
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe517()
    Local aArea         := FWGetArea()
    Local nCorFundo     := RGB(238, 238, 238)
    Local nJanAltura    := 500
    Local nJanLargur    := 500
    Local cJanTitulo    := 'Exemplo TXMLViewer'
    Local cArquiXML     := 'C:\spool\teste.xml'
    Local lDimPixels    := .T. 
    Local lCentraliz    := .T. 
    Local oXMLView
    Private oDialogPvt

    //Cria a dialog
    oDialogPvt := TDialog():New(0, 0, nJanAltura, nJanLargur, cJanTitulo, , , , , , nCorFundo, , , lDimPixels)

        //Cria o visualizador do XML
        nObjLinha := 3
        nObjColun := 3
        nObjLargu := (nJanLargur / 2) - 3
        nObjAltur := (nJanAltura / 2) - 6
        oXMLView := TXMLViewer():New(nObjLinha, nObjColun, oDialogPvt, cArquiXML, nObjLargu, nObjAltur, lDimPixels)
        oXMLView:SetXML(cArquiXML)
    
    //Ativa e exibe a janela
    oDialogPvt:Activate(, , , lCentraliz)
    
    FWRestArea(aArea)
Return
