/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/09/21/redimensionando-um-array-com-a-funcao-asize-maratona-advpl-e-tl-044/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe044
Exemplo de função que redimensiona o tamanho de um Array (geralmente usado junto de aDel e aIns)
@type Function
@author Atilio
@since 29/11/2022
@see https://tdn.totvs.com/display/tec/ASize
@obs 
    Função aScan
    Parâmetros
        + aDestino  , Array      , Indica o array que terá o tamanho redimensionado
        + nTamanho  , Numérico   , Indica o novo tamanho do Array

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe044()
    Local aArea      := FWGetArea()
    Local aNomes    := {}

    //Adicionando os nomes
    aAdd(aNomes, "Daniel")
    aAdd(aNomes, "João")
    aAdd(aNomes, "Maria")
    
    //Deleta o elemento da posição 2, vai ficar como: ["Daniel", "Maria", Nil]
    aDel(aNomes, 2)

    //Redimensiona o Array, diminuindo uma posição que estava como Nil
    aSize(aNomes, Len(aNomes) - 1)

    //Exibe agora o que está na posição 2
    FWAlertInfo("Tamanho do Array:" + cValToChar(Len(aNomes)), "Exemplo de aSize")

    FWRestArea(aArea)
Return
