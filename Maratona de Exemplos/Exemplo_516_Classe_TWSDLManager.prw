/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/04/consumindo-um-webservice-soap-atraves-da-twsdlmanager-maratona-advpl-e-tl-516/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe516
Realiza a integração com um WebService SOAP através do WSDL
@type  Function
@author Atilio
@since 05/04/2023
@see https://tdn.totvs.com/display/tec/Classe+TWsdlManager
@obs 
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe516()
    Local aArea      := FWGetArea()
    Local cURL       := "http://127.0.0.1:8091/ws/ZWSCLIENTES.apw?WSDL"
    Local cOperation := "VIEWCLI"
    Local oWSDL
    Local lRet
    Local cMsgWS     := ""
    Local cResp      := ""
    Local cJsonResp  := ""

    //Monta a mensagem que será enviada
    cMsgWS := ' <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://127.0.0.1:8091/"> ' + CRLF
    cMsgWS += '    <soapenv:Header/> ' + CRLF
    cMsgWS += '    <soapenv:Body> ' + CRLF
    cMsgWS += '       <ns:VIEWCLI> ' + CRLF
    cMsgWS += '          <ns:CVIEWRECE>C0000101</ns:CVIEWRECE> ' + CRLF
    cMsgWS += '       </ns:VIEWCLI> ' + CRLF
    cMsgWS += '    </soapenv:Body> ' + CRLF
    cMsgWS += ' </soapenv:Envelope> ' + CRLF

    //Instancia em um objeto e desabilita o check de CAs em caso de http ao invés de https, referência:
    //   https://centraldeatendimento.totvs.com/hc/pt-br/articles/5151712642839-Cross-Segmento-TOTVS-Backoffice-Linha-Protheus-ADVPL-Mensagem-An-exception-occurred-ar-1-0-WsdlParser-Exception-Could-not-parse-schema-http-schemas-xmlsoap-org-wsdl-
    oWsdl          := TWSDLManager():New()
	oWsdl:nTimeout := 120
    oWsdl:bNoCheckPeerCert := .T.

    //Faz o parse do WSDL
    If oWsdl:ParseURL(cUrl)
        
        //Define a operação que será consumida do WS
        lRet := oWsdl:SetOperation(cOperation)

        //Se deu certo, envia o texto e pega a resposta
        If lRet
            oWsdl:SendSoapMsg(cMsgWs)
            cResp := oWsdl:GetParsedResponse()

            //Se houver resposta do WS
            If ! Empty(cResp)
                cJsonResp := SubStr(cResp, At("{", cResp))
                ShowLog(cJsonResp)
            EndIf
        EndIf
    EndIf

    FWRestArea(aArea)
Return
