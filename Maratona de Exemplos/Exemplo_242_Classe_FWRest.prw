/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/18/buscando-o-idioma-usado-atraves-da-fwretidiom-maratona-advpl-e-tl-243/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe242
Exemplo de consumo de REST usando FWRest
@type  Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/display/public/framework/FWRest
@obs 

    Exemplo original em https://terminaldeinformacao.com/2020/08/06/exemplo-de-integracao-com-viacep-usando-fwrest/
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe242()
    Local aArea         := FWGetArea()
    Local aHeader       := {}    
    Local oRestClient   := FWRest():New("https://viacep.com.br/ws")
    Local cCep          := '17054679'
 
    //Adiciona os headers que serão enviados via WS
    aAdd(aHeader,'User-Agent: Mozilla/4.0 (compatible; Protheus '+GetBuild()+')')
    aAdd(aHeader,'Content-Type: application/json; charset=utf-8')
 
    //Define a url conforme o CEP e aciona o método GET
    oRestClient:setPath("/"+cCep+"/json/")
    If oRestClient:Get(aHeader)
        
        //Exibe o resultado que veio do WS
        ShowLog(oRestClient:cResult)

    //Senão, pega os erros, e exibe em um Alert
    Else
        cLastError := oRestClient:GetLastError()
        cErrorDetail := oRestClient:GetResult()
        Alert(cErrorDetail)
    Endif  

    FWRestArea(aArea)
Return
