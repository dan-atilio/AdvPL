/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/10/26/criando-tabelas-com-a-funcao-checkfile-maratona-advpl-e-tl-079/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe079
Exemplo de como criar uma tabela que ainda não existe no banco de dados (também pode ser usado a ChkFile)
@type Function
@author Atilio
@since 08/12/2022
@obs 
    Função CheckFile
    Parâmetros
        + Alias da tabela
        + Nome real da tabela que ficará no banco de dados

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe079()
    Local aArea     := FWGetArea()
    Local cAlias    := ""
    Local cArquivo  := ""

    //Aciona a verificação se a tabela (padrão) não existir, será criada
    cAlias    := "SCA"
    cArquivo  := "SCA990"
    CheckFile(cAlias, cArquivo)

    //Aciona a verificação se a tabela customizada a partir de um alias padrão não existir, será criada
    cAlias    := "SB1"
    cArquivo  := "SB1TESTE"
    CheckFile(cAlias, cArquivo)

    FWRestArea(aArea)
Return
