/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/11/17/buscando-todas-as-posicoes-encontradas-em-um-texto-com-a-funcao-cscan-maratona-advpl-e-tl-101/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe101
Retorna um array com todas as posições encontradas de um texto
@type Function
@author Atilio
@since 12/12/2022
@obs 
    Função cScan
    Parâmetros
        + Texto da string
        + Caractere a ser procurado
    Retorno
        + Array com as posições do caractere encontrado na string

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe101()
    Local aArea     := FWGetArea()
    Local cFrase    := "O rato roeu a roupa do Rei de roma, a rainha com raiva resolveu remendar. Num ninho de mafagafos, cinco mafagafinhos há! Quem os desmafagafizá-los, um bom desmafagafizador será."
    Local cBusca    := "a"
    Local aDados    := {}

    //Busca todas as repetições
    aDados := cScan(cFrase, cBusca)
    FWAlertInfo("Número de vezes que a busca se repete: " + cValToChar(Len(aDados)), "Teste cScan")

    FWRestArea(aArea)
Return
