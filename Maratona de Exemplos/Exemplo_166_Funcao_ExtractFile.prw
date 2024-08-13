/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/11/buscando-o-nome-do-arquivo-atraves-da-funcao-extractfile-maratona-advpl-e-tl-166/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe166
Função que retorna apenas o arquivo
@type Function
@author Atilio
@since 19/12/2022
@obs 
    Função ExtractFile
    Parâmetros
        + Nome do arquivo completo com a pasta
    Retorno
        + Retorna apenas o nome do arquivo

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe166()
    Local aArea     := FWGetArea()
    Local cArqCompl := ""
    Local cArquivo  := ""

    //Descobrindo a extensão do arquivo
    cArqCompl := "C:\spool\relatorio.pdf"
    cArquivo  := ExtractFile(cArqCompl)

    //Exibindo uma mensagem
    FWAlertInfo("O caminho completo é '" + cArqCompl + "', o arquivo é '" + cArquivo + "'", "Teste com ExtractFile")

    FWRestArea(aArea)
Return
