/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/12/05/encerrando-um-alias-com-a-funcao-dbclosearea-maratona-advpl-e-tl-119/
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} User Function zExe119
Fecha um alias aberto em memória
@type Function
@author Atilio
@since 13/12/2022
@see https://tdn.totvs.com/display/tec/DBCloseArea
@obs 
    Função DbCloseArea
    Não tem parâmetros nem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe119()
    Local aArea      := FWGetArea()
    Local cQrySBM    := ""

    //Monta uma query para buscar um grupo de produto com o código 0002
    cQrySBM += " SELECT  " + CRLF
    cQrySBM += "     BM_GRUPO, BM_DESC " + CRLF
    cQrySBM += " FROM  " + CRLF
    cQrySBM += "     " + RetSQLName("SBM") + " SBM  " + CRLF
    cQrySBM += " WHERE  " + CRLF
    cQrySBM += "     BM_FILIAL = '" + FWxFilial("SBM") + "' " + CRLF
    cQrySBM += "     AND BM_GRUPO = '0002' " + CRLF
    cQrySBM += "     AND SBM.D_E_L_E_T_ = ' ' " + CRLF

    //Se o alias já tiver aberto, será fechado
    If Select("QRY_SBM") > 0
        QRY_SBM->(DbCloseArea())
    EndIf

    //Abre o alias em memória
    TCQuery cQrySBM New Alias "QRY_SBM"

    //Exibe alguma mensagem, caso haja dados
    If ! QRY_SBM->(EoF())
        FWAlertInfo("Descrição do grupo: " + QRY_SBM->BM_DESC, "Teste DbCloseArea")
    EndIf

    //Fecha o alias
    QRY_SBM->(DbCloseArea())

    FWRestArea(aArea)
Return
