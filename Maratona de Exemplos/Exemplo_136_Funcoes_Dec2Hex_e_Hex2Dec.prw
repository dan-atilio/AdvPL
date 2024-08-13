/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/12/22/convertendo-valores-dentre-decimal-e-hexa-com-dec2hex-e-hex2dec-maratona-advpl-e-tl-136/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe136
Exemplo para conversão entre números inteiros para hexadecimal e vice versa
@type Function
@author Atilio
@since 15/12/2022
@obs 
    Função Dec2Hex
    Parâmetros
        + Valor a ser convertido
    Retorno
        + Retorna a String com valor Hexadecimal

    Função Hex2Dec
    Parâmetros
        + String em hexadecimal a ser convertida
    Retorno
        + Valor convertido

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe136()
    Local aArea   := FWGetArea()
    Local nValor  := 0
    Local cHexa   := ""

    //Convertendo e mostrando o resultado (de decimal para hexa)
    nValor := 100
    cHexa  := Dec2Hex(nValor)
    FWAlertInfo("A conversão de '" + cValToChar(nValor) + "' deu '" + cHexa + "' em hexa", "Exemplo Dec2Hex")

    //Convertendo e mostrando o resultado (de hexa para decimal)
    cHexa  := "FFF"
    nValor := Hex2Dec(cHexa)
    FWAlertInfo("A conversão de '" + cHexa + "' deu '" + cValToChar(nValor) + "' em decimal", "Exemplo Hex2Dec")

    FWRestArea(aArea)
Return
