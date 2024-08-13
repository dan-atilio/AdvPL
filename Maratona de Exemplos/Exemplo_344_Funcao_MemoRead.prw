/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/09/criando-arquivos-com-a-memowrite-maratona-advpl-e-tl-345/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe344
Retorna o conteúdo de um arquivo (todas as linhas), com a limitação de 64 kb
@type Function
@author Atilio
@since 22/03/2023
@see https://tdn.totvs.com/display/tec/MemoRead
@obs 

    Função MemoRead
    Parâmetros
        + cFile       , Caractere     , Indica o nome do arquivo a ser lido
        + lChangeCase , Lógico        , Se verdadeiro o nome do arquivo será considerado tudo minúsculo
    Retorno
        + cRet        , Caractere     , Retorna o conteúdo do arquivo (com a limitação de 64 kb)

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe344()
	Local aArea := FWGetArea()
    Local cArquivo := "C:\spool\exemplo_query.sql"
    Local cConteudo := ""

    //Se o arquivo existir
    If File(cArquivo)
        //Realiza a leitura do arquivo para uma variável
        cConteudo := MemoRead(cArquivo)

        //Exibe o conteúdo lido
        ShowLog(cConteudo)
    EndIf

    FWRestArea(aArea)
Return
