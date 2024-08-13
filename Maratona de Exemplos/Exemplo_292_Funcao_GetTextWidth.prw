/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/14/buscando-as-threads-abertas-com-a-getuserinfoarray-maratona-advpl-e-tl-293/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe292
Retorna a largura em pixels de um texto conforme uma fonte
@type  Function
@author Atilio
@since 21/02/2023
@obs 
    
    Função GetTextWidth
    Parâmetros
        + Fonte instanciada pela classe TFont
        + Texto a ser avaliado
    Retorno
        Retorna a largura em pixels

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe292()
    Local aArea       := FWGetArea()
    Local cFontNome   := 'Tahoma'
    Local oFontPadrao := TFont():New(cFontNome, , -12)
    Local cTexto      := "Ola mundo 123"
    Local nLargura    := 0

    //Busca a largura em pixels do texto
    nLargura := GetTextWidth(oFontPadrao, cTexto)
    FWAlertInfo("A largura é: " + cValToChar(nLargura), "Teste GetTextWidth")

    FWRestArea(aArea)
Return
