/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} User Function zFonte39
Executa uma query e atribui um alias para ela
@type Function
@author Atilio
@since 03/04/2023
@see https://tdn.totvs.com/display/tec/Comando+TCQUERY
/*/

User Function zFonte39()
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

    //Abre o alias em memória
    TCQuery cQrySBM New Alias "QRY_SBM"

    //Exibe alguma mensagem, caso haja dados
    If ! QRY_SBM->(EoF())
        FWAlertInfo("Descrição do grupo: " + QRY_SBM->BM_DESC, "Teste TCQuery")
    EndIf

    //Fecha o alias
    QRY_SBM->(DbCloseArea())

    FWRestArea(aArea)
Return
