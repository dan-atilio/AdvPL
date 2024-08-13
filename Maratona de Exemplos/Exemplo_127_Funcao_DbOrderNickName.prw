/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/12/13/ordenando-uma-tabela-por-um-apelido-de-indice-com-dbordernickname-maratona-advpl-e-tl-127/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe127
Ordena uma tabela conforme o apelido (nickname) passado
@type Function
@author Atilio
@since 14/12/2022
@see https://tdn.totvs.com/display/tec/DBOrderNickname
@obs 

    Função DBOrderNickname
    Parâmetros
        + cApelido     , Caractere     , Apelido que será buscado na tabela SIX para ordenar nosso alias
    Retorno
        + lRet         , Lógico        , .T. se conseguiu encontrar e ordenar ou .F. se houve alguma falha

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe127()
    Local aArea      := FWGetArea()
    Local cNickTab   := "LOTEPLS"
    Local cMensagem  := ""

    //Abre o cadastro de pedidos de compras
    DbSelectArea("SC7")
    
    //Tenta ordenar conforme o apelido
    If SC7->(DbOrderNickName(cNickTab))
        //Monta a mensagem e exibe
        cMensagem += "Foi possível ordenar pelo apelido -" + cNickTab + "-" + CRLF + CRLF
        cMensagem += "O índice numérico é: " + cValToChar(SC7->(IndexOrd())) + CRLF
        cMensagem += "E a chave do índice é: " + SC7->(IndexKey(IndexOrd())) + CRLF
        FWAlertInfo(cMensagem, "Teste DbOrderNickName")

    Else
        FWAlertError("Apelido não encontrado!", "Falha DbOrderNickName")
    EndIf

    FWRestArea(aArea)
Return
