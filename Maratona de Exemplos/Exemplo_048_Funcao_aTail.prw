/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/09/25/buscando-o-ultimo-elemento-de-um-array-com-a-funcao-atail-maratona-advpl-e-tl-048/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe048
Exemplo de função que retorna o último elemento de um array
@type Function
@author Atilio
@since 30/11/2022
@see https://tdn.totvs.com/display/tec/ATail
@obs 
    Função aTail
    Parâmetros
        + aArray    , Array        , Indica o Array que será avaliado
    Retorno
        + xRet      , Indefinido   , Retorna o último elemento encontrado do Array

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe048()
    Local aArea      := FWGetArea()
    Local aNomes     := {}
    Local cUltimo    := ""

    //Adiciona alguns elementos no Array
    aAdd(aNomes, "Daniel")
    aAdd(aNomes, "Atilio")
    aAdd(aNomes, "João")
    aAdd(aNomes, "Maria")
    aAdd(aNomes, "José")

    //Busca o último nome do array
    cUltimo := aTail(aNomes)
    FWAlertInfo("O último elemento do array é " + cUltimo, "Exemplo aTail")

    FWRestArea(aArea)
Return
