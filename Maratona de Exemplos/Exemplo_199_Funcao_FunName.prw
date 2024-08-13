/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/27/buscando-o-nome-da-funcao-atraves-da-funname-maratona-advpl-e-tl-199/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe199
Função que retorna o nome da função aberta no menu
@type Function
@author Atilio
@since 11/02/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6814875
@obs 
    Função FunName
    Parâmetros
        Função não tem parâmetros
    Retorno
        + cRetorno    , Caractere        , Texto com o nome da função do menu

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe199()
    Local aArea     := FWGetArea()
    Local cNomeFunc := ""

    //Busca a descrição e mostra
    cNomeFunc := FunName()
    FWAlertInfo(cNomeFunc, "Teste FunName")

    FWRestArea(aArea)
Return
