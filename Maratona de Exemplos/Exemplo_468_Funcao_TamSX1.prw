/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/10/buscando-o-tamanho-de-um-campo-atraves-da-tamsx3-maratona-advpl-e-tl-469/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe468
Busca o tamanho e os decimais de um parâmetro na SX1
@type Function
@author Atilio
@since 02/04/2023
@obs 
    TamSX1
    Parâmetros
        Nome do Grupo de Perguntas (X1_GRUPO)
        Sequencia da pergunta (X1_ORDEM)
    Retorno
        Retorna um array com 2 posições sendo [1] o Tamanho (X1_TAMANHO) e [2] o tamanho de decimais (X1_DECIMAL)

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe468()
    Local aArea       := FWGetArea()
    Local aTamanho    := {}

    //Busca o tamanho de um parâmetro
    aTamanho := TamSX1("A311TES", "02")
    FWAlertInfo("O tamanho é '" + cValToChar(aTamanho[1]) + "', e o tamanho de decimais é '" + cValToChar(aTamanho[2]) + "'", "Teste 1 - TamSX1")

    //Busca o tamanho de um parâmetro que tenha decimais
    aTamanho := TamSX1("MTA115", "08")
    FWAlertInfo("O tamanho é '" + cValToChar(aTamanho[1]) + "', e o tamanho de decimais é '" + cValToChar(aTamanho[2]) + "'", "Teste 2 - TamSX1")

    FWRestArea(aArea)
Return
