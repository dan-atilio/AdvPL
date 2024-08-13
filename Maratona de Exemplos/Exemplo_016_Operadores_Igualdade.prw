/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/08/24/operadores-e-para-comparacao-e-atribuicao-respectivamente-maratona-advpl-e-tl-016/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe016
Exemplo de como utilizar os operadores de comparação (==) e o por que de evitarmos o de atribuição (=)
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.engpro.totvs.com.br/display/tec/Operadores+Comuns
@obs Nesse artigo é explorado um pouco sobre esse conteúdo https://terminaldeinformacao.com/2020/05/01/voce-sabia-que-tem-diferenca-entre-e-em-advpl/

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe016()
    Local aArea   := FWGetArea()
    Local cVar    := "Atilio"
    
    //Demonstrando que o = é para atribuição
    cVar = "Daniel"
    FWAlertInfo("cVar é: " + cVar, "= é Atribuição!")

    //Logo ao usar em comparação, erros estranhos podem ocasionar, como:
    If "ZZZZ" = "ZZZ"
        FWAlertInfo("Caiu dentro desse IF por causa de utilizar um único igual!", "'ZZZZ' é igual 'ZZZ' ???")
    EndIf

    //Portanto, o correto é como boa prática usar := para atribuições e o == para comparações
    cVar := "Dan"
    If Upper(cVar) == "DAN"
        FWAlertInfo("Caiu no If do Exatamente Igual", "Agora sim")
    EndIf

    FWRestArea(aArea)
Return
