/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/09/20/buscando-um-elemento-do-array-com-a-funcao-ascan-maratona-advpl-e-tl-043/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe043
Exemplo de função que busca um elementro dentro de um Array
@type Function
@author Atilio
@since 29/11/2022
@see https://tdn.totvs.com/display/tec/AScan
@obs 
    Função aScan
    Parâmetros
        + aDest     , Caractere  , Indica o array onde será efetuado a busca
        + xExpr     , Indefinido , Indica a expressão que irá ser buscada no array (geralmente um bloco de código)
        + nStart    , Numérico   , Indica a posição inicial da busca (se não for informado nada será considerao 1)
        + nCount    , Numérico   , Indica quantas posições serão buscadas a partir do nStart (se não for informado, será considerado o array inteiro)
    Retorno
        + nRet      , Numérico   , Posição encontrada no Array

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe043()
    Local aArea      := FWGetArea()
    Local aDadosMono  := {}
    Local aDadosMult  := {}
    Local nPos    := 0

    //Adicionando elementos no Array
    aAdd(aDadosMono, "Daniel")
    aAdd(aDadosMono, "Atilio")
    aAdd(aDadosMono, "José")
    aAdd(aDadosMono, "Maria")
    aAdd(aDadosMono, "João")
    
    //Procurando pelo nome Atilio
    nPos := aScan(aDadosMono, {|x| AllTrim(Upper(x)) == "ATILIO"})
    If nPos > 0
        FWAlertInfo("Atilio encontrado, na posição " + cValToChar(nPos) + ".", "Teste 1")
    Else
        FWAlertInfo("Atilio não foi encontrado!", "Teste 1")
    EndIf

    //Adicionando elementos no Array (código, nome e idade)
    aAdd(aDadosMult, {"0001", "Daniel",   23})
    aAdd(aDadosMult, {"0002", "Atilio",   33})
    aAdd(aDadosMult, {"0003", "José",     43})
    aAdd(aDadosMult, {"0004", "Maria",    53})
    aAdd(aDadosMult, {"0005", "João",     63})

    //Procurando pelo nome Hudson
    nPos := aScan(aDadosMult, {|x| AllTrim(Upper(x[2])) == "MARIA"})
    If nPos > 0
        FWAlertInfo("Maria encontrada, na linha " + cValToChar(nPos) + ".", "Teste 2")
    Else
        FWAlertInfo("Maria não foi encontrado!", "Teste 2")
    EndIf

    FWRestArea(aArea)
Return
