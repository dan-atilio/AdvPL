/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2024/12/24/como-atualizar-o-mv_spedurl-da-base-de-teste-automaticamente-via-codigo-fonte-ti-responde-0110/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function AfterLogin
P.E. Acionado logo após fazer login no sistema
@type  Function
@author Atilio
@since 02/02/2024
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6815186
/*/

User Function AfterLogin()
    Local aArea := FWGetArea()

    //Aciona a verificação da URL do TSS
    u_zVid0110()

    FWRestArea(aArea)
Return

/*/{Protheus.doc} zVid0110
Atualiza o parâmetro MV_SPEDURL se estiver na base de testes
@type user function
@author Atilio
@since 02/02/2024
/*/

User Function zVid0110()
    Local aArea      := FWGetArea()
    Local cIniFile   := GetAdv97()
    Local cStrError  := "ERROR"
    Local cNomeBase  := ""
    Local cSpedURL   := ""
    Local cParametro := "MV_SPEDURL"
    Local cConteudo  := ""

    //Busca o nome da base na seção "DbAccess"
    cNomeBase := GetPvProfString("DbAccess", "Alias", cStrError, cIniFile)

    //Se não encontrou ou deu erro, ai vamos buscar novamente mas agora ao invés de "DbAccess" vamos usar a seção "TopConnect"
    If Empty(cNomeBase) .Or. cNomeBase == cStrError
        cNomeBase := GetPvProfString("TopConnect", "Alias", cStrError, cIniFile)
        cPasso    := "2"
    EndIf

    //Se não encontrou ou deu erro, ai vamos buscar novamente mas agora ao invés de "TopConnect" vamos usar a seção "TotvsDBAccess"
    If Empty(cNomeBase) .Or. cNomeBase == cStrError
        cNomeBase := GetPvProfString("TotvsDBAccess", "Alias", cStrError, cIniFile)
        cPasso    := "3"
    EndIf

    //Se mesmo assim não encontrou, vamos buscar direto do ambiente
    If Empty(cNomeBase) .Or. cNomeBase == cStrError
        cNomeBase := GetSrvProfString("DBAlias", cStrError)
        cPasso    := "4"
    EndIf

    //Se for a base de Homologação / Testes
    If cNomeBase == "BASE_TST"
        //Define qual é a URL do TSS de Testes
        cSpedURL := "http://192.168.x.x:8280"

        //Busca a URL atual
        cConteudo := GetMV(cParametro)

        //Se o conteúdo do parâmetro for diferente do esperado
        If ! cConteudo == cSpedUrl
            PutMV(cParametro, cSpedUrl)
            FWAlertInfo("Parâmetro <strong>" + cParametro + "</strong>, teve o conteúdo atualizado para <strong>" + cSpedURL + "</strong>", "Base " + cNomeBase)
        EndIf
    EndIf

    FWRestArea(aArea)
Return
