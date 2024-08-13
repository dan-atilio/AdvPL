/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/09/22/ordenando-os-elementos-de-um-array-com-a-funcao-asort-maratona-advpl-e-tl-045/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe045
Exemplo de função que faz a ordenação de um Array
@type Function
@author Atilio
@since 29/11/2022
@see https://tdn.totvs.com/display/tec/ASort
@obs 
    Função aScan
    Parâmetros
        + aVetor    , Array             , Indica o array que será ordenado
        + nInicio   , Numérico          , Indica o primeiro elemento que será colocado em ordem (caso não seja informado será desde a posição 1)
        + nCont     , Numérico          , Indica a quantidade de elementos que serão ordenados a partir do nInicio (caso não seja informado será considerado o array inteiro)
        + bOrdem    , Bloco de Código   , Bloco de código que realizará a ordenação

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe045()
    Local aArea       := FWGetArea()
    Local aDadosMono  := {}
    Local aDadosMult  := {}
    Local nPos        := 0
    Local cMsg        := ""

    //Adicionando elementos no Array
    aAdd(aDadosMono, "Daniel")
    aAdd(aDadosMono, "Atilio")
    aAdd(aDadosMono, "João")
    aAdd(aDadosMono, "Maria")
    aAdd(aDadosMono, "José")

    //Ordena o Array por Nome
    aSort(aDadosMono)

    //Percorre para compor a mensagem
    cMsg := ""
    For nPos := 1 To Len(aDadosMono)
        cMsg += "Nome: " + aDadosMono[nPos] + CRLF
    Next
    FWAlertInfo(cMsg, "Ordenação Simples")


    // ---


    //Adicionando elementos no Array (código, nome e idade)
    aAdd(aDadosMult, {"0001", "Daniel",   23})
    aAdd(aDadosMult, {"0002", "Atilio",   33})
    aAdd(aDadosMult, {"0003", "João",     43})
    aAdd(aDadosMult, {"0004", "Maria",    53})
    aAdd(aDadosMult, {"0005", "José",     63})
    
    //Ordena o Array por Nome (Array multidimensional) - Crescente usa < e Decrescente usa >
    aSort(aDadosMult, , , {|x, y| x[2] < y[2]})
    
    //Percorre para compor a mensagem
    cMsg := ""
    For nPos := 1 To Len(aDadosMult)
        cMsg += aDadosMult[nPos][2] + ", código " + aDadosMult[nPos][1] + CRLF
    Next
    FWAlertInfo(cMsg, "Ordenação Multidimensional")

    FWRestArea(aArea)
Return
