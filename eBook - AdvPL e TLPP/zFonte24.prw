/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFonte24
Exemplo de função para inserir um elemento no array
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.totvs.com/display/tec/AAdd, https://tdn.totvs.com/display/tec/AIns e https://tdn.totvs.com/display/tec/ASize
/*/

User Function zFonte24()
    Local aArea     := FWGetArea()
    Local aNomes    := {}

    //Adicionando os nomes
    aAdd(aNomes, "Daniel")
    aAdd(aNomes, "João")
    aAdd(aNomes, "Maria")
    
    //Redimensiona o Array, Aumentando uma posição, vai ficar como: ["Daniel", "João", "Maria", Nil]
    aSize(aNomes, Len(aNomes) + 1)

    //Insere o elemento na posição 2, vai ficar como: ["Daniel", Nil, "João", "Maria"]
    aIns(aNomes, 2)

    //Agora altera a posição 2
    aNomes[2] := "José"

    //Exibe agora o que está na posição 2
    FWAlertInfo("Posição 2 é " + aNomes[2], "Exemplo de aIns")

    FWRestArea(aArea)
Return
