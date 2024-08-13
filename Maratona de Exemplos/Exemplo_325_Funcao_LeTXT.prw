/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/30/pegando-o-tamanho-de-uma-variavel-com-a-len-maratona-advpl-e-tl-324/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe325
Efetua a leitura de um arquivo texto
@type Function
@author Atilio
@since 11/03/2023
@obs 
    Função LeTXT
    Parâmetros
        + Nome do arquivo
        + Bloco de código que será executado a cada linha
    Retorno
        Função não tem Retorno

    Obs.: Para funcionamento correto, o ideal é que no arquivo lido, tenha uma linha vazia no final

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe325()
    Local aArea     := FWGetArea()
    Local cNomeArq  := "C:\spool\teste.txt"
    Local aConteudo := {}
    Local bBloco    := {|cArquivo, cLinha, nLinha| fAddLinha(aConteudo, cLinha)}

    //Executa a leitura do arquivo texto
    LeTXT(cNomeArq, bBloco)

    //Mostra o resultado
    FWAlertInfo("O array tem " + cValToChar(Len(aConteudo)) + " linha(s)!", "Teste LeTXT")

    FWRestArea(aArea)
Return

Static Function fAddLinha(aConteudo, cLinha)
    //Se houver conteúdo, adiciona no array
    If ! Empty(cLinha)
        aAdd(aConteudo, cLinha)
    EndIf
Return
