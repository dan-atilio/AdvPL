/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/29/buscando-o-conteudo-de-um-bloco-de-codigos-com-a-getcbsource-maratona-advpl-e-tl-265/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe265
Busca o código fonte de um bloco de código (code block)
@type  Function
@author Atilio
@since 21/02/2023
@see https://tdn.totvs.com/display/tec/GetCbSource
@obs 

    Função GetCBSource
    Parâmetros
        + bBlocoDeCodigo , Bloco de Código  , Indica o bloco de código a ser verificado
    Retorno
        + cRet           , Caractere        , Retorna o código do bloco de código no formato texto
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe265()
    Local aArea      := FWGetArea()
    Local nTotal     := 0
    Local bBloco     := {|| Iif("A" $ Upper(SB1->B1_DESC), nTotal++, Nil)}
    Local cMensagem  := ""

    //Busca o conteúdo do bloco de código e exibe
    cMensagem := GetCBSource(bBloco)
    FWAlertInfo(cMensagem, "Teste GetCBSource")

    FWRestArea(aArea)
Return
