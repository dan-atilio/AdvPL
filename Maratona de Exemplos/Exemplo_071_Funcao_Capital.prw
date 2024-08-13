/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/10/18/deixando-a-primeira-letra-maiuscula-e-o-restante-minuscula-com-capital-maratona-advpl-e-tl-071/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe071
Exemplo para converter uma string deixando a primeira letra maiúscula e o restante minúscula
@type Function
@author Atilio
@since 07/12/2022
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6814904
@obs 
    Função Capital
    Parâmetros
        + cString        , Caractere     , String a ser convertida
    Retorno
        + cReturn        , Caractere     , String já convertida

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe071()
    Local aArea   := FWGetArea()
    Local cMsgOri := "TERMINAL DE INFORMAÇÃO"
    Local cMsgCap := Capital(cMsgOri)
    
    //Exibe a string original e a formatada
    FWAlertInfo("Original: " + cMsgOri + CRLF + "Capital: " + cMsgCap, "Teste - Capital")

    FWRestArea(aArea)
Return
