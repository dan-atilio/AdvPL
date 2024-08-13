/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/12/03/alterando-o-nome-de-um-alias-com-a-funcao-dbchangealias-maratona-advpl-e-tl-117/
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} User Function zExe117
Altera o nome de um alias aberto
@type Function
@author Atilio
@since 13/12/2022
@see https://tdn.totvs.com/display/tec/DBChangeAlias
@obs 
    Função DbChangeAlias
    Parâmetros
        + cOldAlias       , Caractere  , Nome do Alias antigo
        + cNewAlias       , Caractere  , Nome do novo Alias
    Retorno
        + lRet            , Lógico     , .T. em caso de sucesso ou .F. em caso de falha

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe117()
    Local aArea      := FWGetArea()
    Local cQrySBM    := ""
    Local cAlias1    := "QRY_SBM"
    Local cAlias2    := "TST_SBM"

    //Monta uma query para buscar um grupo de produto com o código 0002
    cQrySBM += " SELECT  " + CRLF
    cQrySBM += "     BM_GRUPO, BM_DESC " + CRLF
    cQrySBM += " FROM  " + CRLF
    cQrySBM += "     " + RetSQLName("SBM") + " SBM  " + CRLF
    cQrySBM += " WHERE  " + CRLF
    cQrySBM += "     BM_FILIAL = '" + FWxFilial("SBM") + "' " + CRLF
    cQrySBM += "     AND BM_GRUPO = '0002' " + CRLF
    cQrySBM += "     AND SBM.D_E_L_E_T_ = ' ' " + CRLF
    TCQuery cQrySBM New Alias (cAlias1)

    //Se conseguiu mudar de alias
    If DbChangeAlias(cAlias1, cAlias2)

        //Exibe uma mensagem apontando para o alias 2
        FWAlertSuccess("O alias foi alterado, segue um campo: " + Alltrim((cAlias2)->BM_DESC), "Sucesso no DbChangeAlias")

        (cAlias2)->(DbCloseArea())
    Else

        FWAlertError("Não foi possível alterar o alias", "Falha DbChangeAlias")
        (cAlias1)->(DbCloseArea())
    EndIf

    FWRestArea(aArea)
Return
