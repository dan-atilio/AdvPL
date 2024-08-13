/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/07/buscando-conteudos-de-parametros-com-getmv-e-supergetmv-maratona-advpl-e-tl-279/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe278
Retorna o primeiro ou o último elemento de um array (ordenando ele de forma crescente)
@type  Function
@author Atilio
@since 21/02/2023
@obs 

    Função GetMin
    Parâmetros
        Não tem parâmetros
    Retorno
        Retorna o primeiro elemento encontrado no Array

    Função GetMax
    Parâmetros
        Não tem parâmetros
    Retorno
        Retorna o último elemento encontrado no Array
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe278()
    Local aArea     := FWGetArea()
    Local aNomes    := {}
    Local cPrimeiro := ""
    Local cUltimo   := ""

    //Adiciona elementos no Array
    aAdd(aNomes, "João")
    aAdd(aNomes, "Maria")
    aAdd(aNomes, "Daniel")
    aAdd(aNomes, "José")

    //Busca o primeiro
    cPrimeiro := GetMin(aNomes)

    //Busca o último
    cUltimo := GetMax(aNomes)

    //Exibe uma mensagem
    FWAlertInfo("O primeiro nome é '" + cPrimeiro + "', e o último nome é '" + cUltimo + "'", "Teste GetMin e GetMax")

    FWRestArea(aArea)
Return
