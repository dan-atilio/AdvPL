/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2020/12/22/como-integrar-protheus-com-jotforms/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Totvs.ch"
 
/*/{Protheus.doc} zJotTst
Exemplo de GET em uma integração com JotForms
@author Atilio
@since 01/11/2020
@version 1.0
@type function
@obs No exemplo abaixo é usado o /user/forms com Get, mas é possÃ­vel usar Set e outros métodos conforme documentação disponÃ­vel - https://api.jotform.com/docs/#user-forms
/*/
 
User Function zJotTst()
    Local aArea := GetArea()
    Local cURL := "api.jotform.com"
    Local aHeaderStr   := {}
    Local oRestClient  := FwRest():New(cUrl)
    Local cAPIKey := "Seu Token de Acesso"
    Local oJSON
    Local cDtIni := "2020-11-01"
    Local cResult
 
    //Se o token tiver preenchido
    If !Empty(cAPIKey)
        //No cabeçalho define o Token usado
        aAdd(aHeaderStr, 'APIKEY: ' + cAPIKey)
 
        //Iremos definir a integração como /user/forms e iremos filtrar criaçÃµes a partir da data 01/11/2020
        oRestClient:SetPath('/user/forms?filter={%22created_at:gt%22:%22' + cDtIni + '%2000:00:00%22}%20')
         
        //Chama o método Get do FWRest, armazena o resultado em uma variável
        If oRestClient:Get( aHeaderStr )
            cResult := oRestClient:GetResult()
 
            //Se o JSON for deserializado, significa que deu certo, e aÃ­ basta pegar os atributos dentro do oJSON e fazer as tratativas
            If (FWJsonDeserialize(cResult, @oJSON))
                Alert('Json foi deserializado')
            EndIf
             
        //Senão, pega os erros, e se quiser exibir, basta adicionar um Alert
        Else
            cLastError := oRestClient:GetLastError()
            cErrorDetail := oRestClient:GetResult()
        EndIf
    EndIf
 
    RestArea(aArea)
Return