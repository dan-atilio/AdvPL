/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/11/07/convertendo-cor-com-a-funcao-convrgb-maratona-advpl-e-tl-091/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe091
Exemplo para converter uma cor para o padrão RGB (separado em Red, Green e Blue)
@type Function
@author Atilio
@since 11/12/2022
@obs 
    Função ConvRGB
    Parâmetros
        + Informa o número da cor no formato AdvPL
    Retorno
        + Array com as posições 1 = Vermelho; 2 = Verde; 3 = Azul

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe091()
    Local aArea     := FWGetArea()
    Local nCorAdvPL := 0
    Local aCorRGB   := {}
    Local cMensagem := ""

    //Abre a tela para seleção de cores e depois converte para um array com separação
    nCorAdvPL := ColorTriangle()
    aCorRGB   := ConvRGB(nCorAdvPL)

    //Agora mostra a conversão
    cMensagem := "Para a cor em AdvPL = " + cValToChar(nCorAdvPL) + CRLF + CRLF
    cMensagem += "É necessário: " + CRLF
    cMensagem += "Red = " + cValToChar(aCorRGB[1]) + CRLF
    cMensagem += "Green = " + cValToChar(aCorRGB[2]) + CRLF
    cMensagem += "Blue = " + cValToChar(aCorRGB[3])
    FWAlertSuccess(cMensagem, "Teste ConvRGB")

    FWRestArea(aArea)
Return
