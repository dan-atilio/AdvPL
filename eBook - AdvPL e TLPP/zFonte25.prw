/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFonte25
Exemplo de função que faz a ordenação de um Array
@type Function
@author Atilio
@since 29/11/2022
@see https://tdn.totvs.com/display/tec/ASort
/*/

User Function zFonte25()
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
