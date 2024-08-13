/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/30/buscando-a-diferenca-entre-dois-periodos-com-a-plsdifanos-maratona-advpl-e-tl-387/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe386
Transforma um array tornando linhas em colunas e colunas em linhas
@type Function
@author Atilio
@since 28/03/2023
@obs 
    Função PivotTable
    Parâmetros
        Recebe o array a ser analisado
    Retorno
        Retorna o array convertido com Pivot

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe386()
    Local aArea      := FWGetArea()
    Local aDados     := {}
    Local aDadosNov  := {}

    //Cria um array multidimensional
    aAdd(aDados, {"Daniel", 44, 40, 43})
    aAdd(aDados, {"João",   34, 30, 33})
    aAdd(aDados, {"Maria",  24, 20, 23})
    
    /*
        Agora vai acionar o PivotTable, que irá ficar dessa forma o array:
        [1] - {"Daniel", "João", "Maria"}
        [2] - {44,       34,     24}
        [3] - {40,       30,     20}
        [4] - {43,       33,     23}
    */
    aDadosNov := PivotTable(aDados)

    FWRestArea(aArea)
Return
