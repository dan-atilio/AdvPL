/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/12/17/definindo-um-indice-e-ordenando-um-alias-com-dbsetorder-maratona-advpl-e-tl-131/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe131
Ordena uma tabela conforme o índice
@type Function
@author Atilio
@since 15/12/2022
@see https://tdn.totvs.com/display/tec/DBSetOrder
@obs 
    Função DbSetOrder
    Parâmetros
        + nOrdem        , Numérico   , Número do Índice do Alias sendo que a partir da letra A no configurador passa a ser 10 (então B é 11, C é 12, D é 13 e assim por diante)
    Retorno
        Não possui retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe131()
    Local aArea      := FWGetArea()
    Local cMensagem  := ""

    //Usa o índice 1
    DbSelectArea("SB1")
    SB1->(DbSetOrder(1))
    
    //Monta a mensagem e exibe
    cMensagem := "Cadastro de Produtos" + CRLF + CRLF
    cMensagem += "O índice numérico é: " + cValToChar(SB1->(IndexOrd())) + CRLF
    cMensagem += "E a chave do índice é: " + SB1->(IndexKey(IndexOrd())) + CRLF
    FWAlertInfo(cMensagem, "Teste 1 DbSetOrder")





    //Agora usa o índice 5
    SB1->(DbSetOrder(5))

    //Monta a mensagem e exibe
    cMensagem := "Cadastro de Produtos" + CRLF + CRLF
    cMensagem += "O índice numérico é: " + cValToChar(SB1->(IndexOrd())) + CRLF
    cMensagem += "E a chave do índice é: " + SB1->(IndexKey(IndexOrd())) + CRLF
    FWAlertInfo(cMensagem, "Teste 2 DbSetOrder")





    //Agora usa o índice "C" (12)
    SB1->(DbSetOrder(12))

    //Monta a mensagem e exibe
    cMensagem := "Cadastro de Produtos" + CRLF + CRLF
    cMensagem += "O índice numérico é: " + cValToChar(SB1->(IndexOrd())) + CRLF
    cMensagem += "E a chave do índice é: " + SB1->(IndexKey(IndexOrd())) + CRLF
    FWAlertInfo(cMensagem, "Teste 3 DbSetOrder")

    FWRestArea(aArea)
Return
