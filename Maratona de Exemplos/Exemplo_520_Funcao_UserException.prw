/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/06/buscando-o-nome-do-usuario-com-usrfullname-e-usrretname-maratona-advpl-e-tl-521/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe520
Abre uma tela de error log com a pilha de chamadas
@type Function
@author Atilio
@since 05/04/2023
@see https://tdn.totvs.com/display/tec/UserException
@obs 

    Função Upper
    Parâmetros
        + cDescricao    , Caractere   , String que indica a descrição do erro forçado
    Retorno
        Função não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe520()
    Local aArea   := FWGetArea()
    Local cQuery   := ""
    
    //Monta uma query normal que conterá um erro
    cQuery := " UPDATE " + RetSQLName("SB1") + "aaa " + CRLF
    cQuery += " SET B1_X_TESTE = 'ZZ" + Time() + "'  " + CRLF
    cQuery += " WHERE B1_COD = 'F0001' " + CRLF

    //Se houve falha, mostra uma mensagem
    If TCSqlExec(cQuery) < 0
        UserException("Falha na atualizacao: " + TCSQLError())
    EndIf

    FWAlertInfo("Processo concluido!", "Teste UserException")

    FWRestArea(aArea)
Return
