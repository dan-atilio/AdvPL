/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/11/12/verificando-quantas-vezes-uma-expressao-se-repete-com-a-funcao-countstr-maratona-advpl-e-tl-096/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe096
Exemplo para buscar quantas vezes uma expressão se repete
@type Function
@author Atilio
@since 11/12/2022
@obs 
    Função CountStr
    Parâmetros
        + Indica o caractere a ser buscado
        + Informa o texto completo
    Retorno
        + Retorna a quantidade de caracteres encontrados

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe096()
    Local aArea     := FWGetArea()
    Local cFrase    := "O rato roeu a roupa do Rei de roma, a rainha com raiva resolveu remendar. Num ninho de mafagafos, cinco mafagafinhos há! Quem os desmafagafizá-los, um bom desmafagafizador será."
    Local cBusca    := "ra"
    Local nTotal    := 0

    //Conta quantas repetições teve
    nTotal := CountStr(cBusca, cFrase)
    FWAlertInfo("Número de vezes que a busca se repete: " + cValToChar(nTotal), "Teste CountStr")

    FWRestArea(aArea)
Return
