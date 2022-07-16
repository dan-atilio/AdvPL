//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zVid0029
Função de exemplo, pegando uma string (json) e transformando em objeto
@type  Function
@author Atilio
@since 21/04/2022
/*/

User Function zVid0029()
    Local aArea  := FWGetArea()
    Local cTexto := '{"nome":"daniel", "empresa":"atilio sistemas", "site":"https://atiliosistemas.com", "contatos":[{"email":"contato@atiliosistemas.com"}, {"email":"suporte@terminaldeinformacao.com"}]}'
    Local oJson
    Local cErro  := ''
    Local cNome  := ''
    Local cSite  := ''

    //Pega o texto e transforma em objeto
    oJson := JsonObject():New()
    cErro := oJson:FromJson(cTexto)

    //Se houve erro
    If ! Empty(cErro)
        FWAlertError("Falha ao converter texto para Objeto JSON: " + CRLF + cErro, "Conversão JSON")

    //Senão, manipula o JSON
    Else
        If ! Empty(oJson:GetJsonObject('nome'))
            cNome := oJson:GetJsonObject('nome')
        EndIf

        If ! Empty(oJson:GetJsonObject('site'))
            cSite := oJson:GetJsonObject('site')
        EndIf

        FWAlertSuccess("Nome: " + cNome + CRLF + "Site: " + cSite, "Sucesso na conversão JSON")
    EndIf

    FWRestArea(aArea)
Return
