/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/09/03/funcao-adel-para-eliminar-elementos-de-um-array-maratona-advpl-e-tl-026/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe026
Exemplo de função para deletar um elemento do array
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.totvs.com/pages/releaseview.action?pageId=23889096
@obs Função aDel
    Parâmetros
        + Array que terá o elemento deletado
        + Posição numérica que será deletada do array

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe026()
    Local aArea     := FWGetArea()
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
    FWAlertInfo("Posição 2 é " + aNomes[2], "Exemplo de aDel")

    FWRestArea(aArea)
Return
