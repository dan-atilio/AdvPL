/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/10/buscando-o-texto-por-extenso-de-um-valor-numerico-atraves-da-extenso-maratona-advpl-e-tl-164/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe165
Função que retorna apenas a extensão do arquivo
@type Function
@author Atilio
@since 19/12/2022
@obs 
    Função ExtractExt
    Parâmetros
        + Nome do arquivo com a extensão
    Retorno
        + Retorna a extensão do arquivo

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe165()
    Local aArea     := FWGetArea()
    Local cArquivo  := ""
    Local cExtensao := ""

    //Descobrindo a extensão do arquivo
    cArquivo  := "C:\spool\relatorio.pdf"
    cExtensao := ExtractExt(cArquivo)

    //Exibindo uma mensagem
    FWAlertInfo("O arquivo '" + cArquivo + "' tem a extensão '" + cExtensao + "'", "Teste com ExtractExt")

    FWRestArea(aArea)
Return
