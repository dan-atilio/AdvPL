/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/05/validando-o-tipo-de-variaveis-com-type-e-valtype-maratona-advpl-e-tl-518/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe519
Transforma uma string, deixando todos os caracteres maiusculos
@type Function
@author Atilio
@since 05/04/2023
@see https://tdn.totvs.com/display/tec/Upper
@obs 

    Função Upper
    Parâmetros
        + cText    , Caractere   , Texto que será deixado em maiúsculo
    Retorno
        + cTextNew , Caractere   , Texto já formatado tudo em maiúsculo

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe519()
    Local aArea   := FWGetArea()
    Local cMsgOri := "Terminal de Informação"
    Local cMsgMai := Upper(cMsgOri)
    
    //Exibe a string original e a formatada
    FWAlertInfo("Original: " + cMsgOri + CRLF + "Maiusculo: " + cMsgMai, "Teste - Upper")

    FWRestArea(aArea)
Return
