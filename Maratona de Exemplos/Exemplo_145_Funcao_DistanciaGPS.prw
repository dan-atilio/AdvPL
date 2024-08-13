/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/12/31/calculando-a-distancia-entre-dois-pontos-atraves-da-distanciagps-maratona-advpl-e-tl-145/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe145
Função que calcula a distância (em metros) entre duas distâncias
@type Function
@author Atilio
@since 16/12/2022
@obs 
    Função DistanciaGPS
    Parâmetros
        + Latitude Inicial
        + Longitude Inicial
        + Latitude Final
        + Longitude Final
    Retorno
        + Retorna a distância

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe145()
    Local aArea      := FWGetArea()
    Local nLati1     := 0
    Local nLong1     := 0
    Local nLati2     := 0
    Local nLong2     := 0
    Local nResultado := 0

    //Latitude e Longitude inicial (Avenida Castelo Branco em Bauru-SP)
    nLati1 := -22.349679429772337
    nLong1 := -49.10019604880774

    //Latitude e Longitudo final (Avenida Duque de Caxias em Bauru-SP)
    nLati2 := -22.327814567707186
    nLong2 := -49.06405753456426

    //Busca a distância entre as latitudes e longitudes e mostra a mensagem (algo em torno de 4 KM)
    nResultado := DistanciaGPS(nLati1, nLong1, nLati2, nLong2)
    FWAlertInfo("O resultado calculado é " + cValToChar(nResultado), "Teste DistanciaGPS")

    FWRestArea(aArea)
Return
