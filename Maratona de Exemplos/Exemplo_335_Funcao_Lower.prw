/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/04/deixando-uma-string-tudo-minuscula-com-a-lower-maratona-advpl-e-tl-335/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe335
Transforma uma string, deixando todos os caracteres minusculos
@type Function
@author Atilio
@since 12/03/2023
@see https://tdn.totvs.com/display/tec/Lower
@obs 

    Função Lower
    Parâmetros
        + cText    , Caractere   , Texto que será deixado em minúsculo
    Retorno
        + cTextNew , Caractere   , Texto já formatado tudo em minúsculo

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe335()
    Local aArea   := FWGetArea()
    Local cMsgOri := "Terminal de Informação"
    Local cMsgMin := Lower(cMsgOri)
    
    //Exibe a string original e a formatada
    FWAlertInfo("Original: " + cMsgOri + CRLF + "Minusculo: " + cMsgMin, "Teste - Lower")

    FWRestArea(aArea)
Return
