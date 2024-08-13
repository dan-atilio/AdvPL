/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/10/19/conversao-entre-decimal-e-hexa-com-as-funcoes-cbiint2hex-e-nbihex2int-maratona-advpl-e-tl-072/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe072
Exemplo para conversão entre números inteiros para hexadecimal e vice versa
@type Function
@author Atilio
@since 07/12/2022
@obs 
    Função cBIInt2Hex
    Parâmetros
        + Valor a ser convertido
        + Número de casas a esquerda caso seja preenchido com 0
    Retorno
        + Retorna a String com valor Hexadecimal

    Função nBIHex2Int
    Parâmetros
        + String em hexadecimal a ser convertida
    Retorno
        + Valor convertido

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe072()
    Local aArea   := FWGetArea()
    Local nValor  := 0
    Local cHexa   := ""

    //Convertendo e mostrando o resultado (de decimal para hexa)
    nValor := 100
    cHexa  := cBIInt2Hex(nValor)
    FWAlertInfo("A conversão de '" + cValToChar(nValor) + "' deu '" + cHexa + "' em hexa", "Exemplo cBIInt2Hex")

    //Convertendo e mostrando o resultado (de hexa para decimal)
    cHexa  := "FFF"
    nValor := nBIHex2Int(cHexa)
    FWAlertInfo("A conversão de '" + cHexa + "' deu '" + cValToChar(nValor) + "' em decimal", "Exemplo nBIHex2Int")

    FWRestArea(aArea)
Return
