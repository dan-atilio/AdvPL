/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/18/convertendo-um-arquivo-para-array-com-filetoarr-maratona-advpl-e-tl-180/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe180
Faz a leitura de um arquivo para um Array
@type Function
@author Atilio
@since 20/12/2022
@obs 
    Função FileToArr
    Parâmetros
        + Nome do arquivo completo com a pasta (pode ser local ou dentro da Protheus Data)
    Retorno
        + Array com o conteúdo do arquivo sendo cada posição 1 linha do arquivo

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe180()
    Local aArea     := FWGetArea()
    Local cArqCompl := "C:\spool\log_auto.txt"
    Local aConteudo := {}

    //Busca o conteúdo do arquivo na máquina
    aConteudo := FileToArr(cArqCompl)
    FWAlertInfo("Foi encontrado " + cValToChar(Len(aConteudo)) + " linha(s) de conteúdo", "Teste com FileToArr")

    FWRestArea(aArea)
Return
