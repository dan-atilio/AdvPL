/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFonte60
Realiza um disparo de eMail
@type  Function
@author Atilio
@since 21/02/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=463812948
@obs
    Os parâmetros que devem ser cadastrados com as informações do seu provedor são
        + MV_RELAUTH - ex.: .T.
        + MV_RELSERV - ex.: mail.seudominio.com:587
        + MV_RELACNT - ex.: contato@seudominio.com
        + MV_RELPSW  - ex.: suaSenha
        + MV_RELSSL  - ex.: .F.
        + MV_RELTLS  - ex.: .T.
/*/

User Function zFonte60()
    Local aArea      := FWGetArea()
    Local cPara      := "contato@atiliosistemas.com; "
    Local cAssunto   := ""
    Local cCorpo     := ""
    Local aAnexos    := {}
    Local lExibeHelp := .T.

    //Monta o corpo do e-Mail
    cCorpo := '<p>Olá.</p>'
    cCorpo += '<p></p>'
    cCorpo += '<p>Esse é um <strong>e-Mail de teste</strong> gerado pelo <font color="red">ERP Protheus</font>.</p>'
    cCorpo += '<p></p>'
    cCorpo += '<p>Data <em>' + dToC(Date()) + '</em> às <em>' +Time() + '</em>.</p>'
   
    //Adição de Anexos (somente arquivos dentro da protheus data)
    /*
    aAdd(aAnexos, "\pasta\arquivo1.pdf")
    aAdd(aAnexos, "\pasta\arquivo2.xlsx")
    aAdd(aAnexos, "\pasta\arquivo3.txt")
    */

    //Faz o disparo via GPEMail
    cAssunto := "Envio de Teste (GPEMail)"
    lEnvio   := GPEMail(cAssunto, cCorpo, cPara, aAnexos, lExibeHelp)

    If lEnvio
        FWAlertSuccess("Sucesso no disparo do e-Mail", "Teste GPEMail")
    Else
        FWAlertError("Falha no disparo do e-Mail", "Teste GPEMail")
    EndIf

    FWRestArea(aArea)
Return
