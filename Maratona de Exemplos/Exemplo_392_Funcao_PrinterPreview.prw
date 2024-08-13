/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/03/abrindo-um-relatorio-com-a-printerpreview-maratona-advpl-e-tl-392/
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} User Function zExe392
Abre um arquivo gerado pelo printer.exe antes da impressão
@type Function
@author Atilio
@since 28/03/2023
@obs 

    Função PrinterPreview
    Parâmetros
        Objeto que terá o arquivo aberto
    Retorno
        Função não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe392()
    Local aArea    := FWGetArea()
	Local cArqRelat  := ""
	Local oPrinter
	
    //Definindo o arquivo que será aberto
    cArqRelat := "\spool\matr680.prt"
    
    //Criando um objeto de impressão e setando o arquivo
    oPrinter := TMSPrinter():New()
    oPrinter:SetFile(cArqRelat,.F.)
    oPrinter:SetPortrait()
    oPrinter:SetPaperSize(9)

    //Exibe o relatório em tela
    PrinterPreview(oPrinter)
 
    FWRestArea(aArea)
Return
