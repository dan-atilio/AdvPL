/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/10/21/tratando-caracteres-de-uma-ulr-com-cbiurlencode-e-cbiurldecode-maratona-advpl-e-tl-074/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe074
Exemplo para transformação de URL tratando caracteres especiais
@type Function
@author Atilio
@since 07/12/2022
@obs 
    Função cBIURLEncode
    Parâmetros
        + URL a ser convertida
    Retorno
        + URL convertida

    Função cBIURLDecode
    Parâmetros
        + URL com caracteres já formatados
    Retorno
        + URL convertida

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe074()
    Local aArea     := FWGetArea()
    Local cOriginal := ""
    Local cConverti := ""

    //Convertendo uma URL que possua espaços
    cOriginal := "terminal de informacao"
    cConverti := cBIURLEncode(cOriginal)
    cOriginal := "https://www.google.com/search?q=" + cOriginal
    cConverti := "https://www.google.com/search?q=" + cConverti
    FWAlertInfo("A conversão de '" + cOriginal + "' deu '" + cConverti + "' ", "Exemplo cBIURLEncode")

    //Convertendo e mostrando o resultado (de hexa para string)
    cOriginal := "terminal%20de%20informacao"
    cConverti := cBIURLDecode(cOriginal)
    cOriginal := "https://www.google.com/search?q=" + cOriginal
    cConverti := "https://www.google.com/search?q=" + cConverti
    FWAlertInfo("A conversão de '" + cOriginal + "' deu '" + cConverti + "' ", "Exemplo cBIURLDecode")

    FWRestArea(aArea)
Return
