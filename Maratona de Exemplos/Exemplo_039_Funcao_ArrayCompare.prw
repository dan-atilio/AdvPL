/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/09/16/funcao-arraycompare-para-realizar-a-comparacao-entre-dois-arrays-maratona-advpl-e-tl-039/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe039
Exemplo de função que verifica onde tem diferenças em um array
@type Function
@author Atilio
@since 28/11/2022
@obs 
    Função ArrayCompare
    Parâmetros
        + Array de comparação
        + Array que será comparado
        + Posição da diferença encontrada
    Retorno
        + .F. se houver diferenças e .T. se for igual

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe039()
    Local aArea     := FWGetArea()
    Local aDados1   := {}
    Local aDados2   := {}
    Local nPosDif   := 0

    //Adiciona 3 informações no Array
    aAdd(aDados1, "Daniel Atilio")
    aAdd(aDados1, "Terminal de Informação")
    aAdd(aDados1, "Atilio Sistemas")

    //Adiciona 3 informações no segundo Array
    aAdd(aDados2, "Daniel Atilio")
    aAdd(aDados2, "Terminal de  Informação")
    aAdd(aDados2, "Atilio Sistemas")

    //Faz a comparação das variáveis
    If ArrayCompare(aDados1, aDados2, @nPosDif)
        FWAlertInfo("Os Arrays são iguais", "Sucesso")
    Else
        FWAlertInfo("Foi encontrada uma diferença no Array, na posição: " + cValToChar(nPosDif), "Diferença encontrada")
    EndIf

    FWRestArea(aArea)
Return
