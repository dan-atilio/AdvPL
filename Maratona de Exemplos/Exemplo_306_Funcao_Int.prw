/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/21/buscando-a-parte-inteira-de-um-numero-com-int-maratona-advpl-e-tl-306/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} zExe306
Retorna um valor numérico inteiro
@type  Function
@author Atilio
@since 23/02/2023
@see https://tdn.totvs.com/display/tec/Int
@obs 

    Função Int
    Parâmetros
        + nValue    , Numérico    , Valor que será analisado
    Retorno
        + nRet      , Numérico    , Parte inteira do valor analisado

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe306()
	Local aArea      := FWGetArea()
    Local nValorOrig := 3.14
    Local nValorInt  := 0

    //Pega a parte inteira do valor original
    nValorInt := Int(nValorOrig)

    //Exibe uma mensagem de aviso
    FWAlertInfo("A parte inteira do valor '" + cValToChar(nValorOrig) + "' é de '" + cValToChar(nValorInt) + "'", "Teste Int")

    FWRestArea(aArea)
Return
