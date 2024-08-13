/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/09/06/funcao-ains-para-inserir-elementos-em-determinada-posicao-do-array-maratona-advpl-e-tl-029/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe029
Exemplo de função para inserir um elemento no array
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.totvs.com/display/tec/AIns
@obs Função aIns
    Parâmetros
        + Array que terá o elemento inserido
        + Posição numérica de inserção do elemento

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe029()
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
