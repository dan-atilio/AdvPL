/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/10/27/mudando-a-extensao-do-nome-de-um-arquivo-com-a-funcao-chgfileext-maratona-advpl-e-tl-080/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe080
Exemplo de como alterar a extensão de um arquivo
@type Function
@author Atilio
@since 08/12/2022
@obs 
    Função ChgFileExt
    Parâmetros
        + Filename     , Caractere    , Nome do arquivo original
        + Extension    , Caractere    , Nova extensão do arquivo
    Retorno
        + Filename     , Caractere    , Nome que será do novo arquivo

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe080()
    Local aArea     := FWGetArea()
    Local cArqOrig  := "C:\spool\tst.txt"
    Local cNovExten := ".log"
    Local cArqNovo

    //Verificando como vai ser o novo nome do arquivo
    cArqNovo := ChgFileExt(cArqOrig, cNovExten)

    //Cria o arquivo novo com o conteúdo do antigo
    MemoWrite(cArqNovo, MemoRead(cArqOrig))

    //Exibe a mensagem
    FWAlertSuccess("Arquivo novo: " + cArqNovo, "Exemplo de ChgFileExt")

    FWRestArea(aArea)
Return
