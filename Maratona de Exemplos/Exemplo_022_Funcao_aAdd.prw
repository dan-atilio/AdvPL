/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/08/30/funcao-aadd-para-adicionar-elementos-em-um-array-maratona-advpl-e-tl-022/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe022
Exemplo de função para adicionar elementos em um array
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.totvs.com/display/tec/AAdd
@obs Função aAdd
    Parâmetros
        + aDest  - Array      - Identifica o array que terá elemenos adicionados
        + xExpr  - Indefinido - Identifica o elemento, podendo ser Caractere, Data, Numérico, Array, etc

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe022()
    Local aArea     := FWGetArea()
    Local aObserv   := {}
    Local aPessoa   := {}

    //Adicionando apenas conteúdos textuais
    aAdd(aObserv, "Terminal de Informação")
    aAdd(aObserv, "Se inscreva no Canal")

    //Adiciona um array com vários elementos
    aAdd(aPessoa, {"Daniel", sToD("19930712"), "Bauru"})
    aAdd(aPessoa, {"Joao",   sToD("19910131"), "Agudos"})
    aAdd(aPessoa, {"Maria",  sToD("19921231"), "Piratininga"})

    //Exibe o total de elementos
    FWAlertInfo("aObserv tem " + cValToChar(Len(aObserv)) + ", e aPessoa tem " + cValToChar(Len(aPessoa)), "Exemplo de aAdd")

    FWRestArea(aArea)
Return
