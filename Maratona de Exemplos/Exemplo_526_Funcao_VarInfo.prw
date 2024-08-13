/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/09/extraindo-informacoes-de-uma-variavel-atraves-da-varinfo-maratona-advpl-e-tl-526/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe526
Função que pega dados de uma variável e transforma de forma legível em caractere
@type Function
@author Atilio
@since 06/04/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6814752
@obs 

    Função VarInfo
    Parâmetros
        Recebe o nome da expressão que irá ser usada
        Recebe a variável que será extraída as informações
        Recebe qual o espaçamento deve ser adicionado a cada -tab-
        Recebe se será em HTML (.T.) ou TXT (.F.)
        Recebe se deve exibir uma mensagem no console.log com o conteúdo extraído
    Retorno
        Retorna a informação extraída da variável (ideal para arrays ou objetos)

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe526()
    Local aArea      := FWGetArea()
    Local aPessoa    := {}

    //Adiciona um array com vários elementos
    aAdd(aPessoa, {"Daniel", sToD("19930712"), "Bauru"})
    aAdd(aPessoa, {"Joao",   sToD("19910131"), "Agudos"})
    aAdd(aPessoa, {"Maria",  sToD("19921231"), "Piratininga"})

    //Cria um arquivo HTML com os dados do Array
    MemoWrite("C:\spool\seu_arquivo.html", VarInfo("aPessoa", aPessoa))

    //Cria um arquivo TXT com os dados do Array
    MemoWrite("C:\spool\seu_arquivo.txt", VarInfo("aPessoa", aPessoa, , .F.))

    FWRestArea(aArea)
Return
