/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/17/verificando-se-um-campo-esta-marcado-como-usado-atraves-da-x3uso-maratona-advpl-e-tl-542/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe543
Converte um nó (objeto) em um array e deixa dentro da estrutura de XML
@type Function
@author Atilio
@since 07/04/2023
@see https://tdn.totvs.com/display/tec/XmlNode2Arr
@obs 
    Função XmlNode2Arr
    Parâmetros
        + oRoot      , Objeto     , Nome do objeto XML instanciado
        + cNode      , Caractere  , Nome do nó que será convertido para Array
    Retorno
        Retorna .T. se conseguiu encontrar e converter pra Array ou .F. se não

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe543()
    Local aArea      := FWGetArea()
    Local cXML       := ""
    Local oXML
    Local cAviso     := ""
    Local cErro      := ""

    //Monta o XML que será convertido em um Objeto
    cXML := '<?xml version="1.0"?>' + CRLF
    cXML += '<detalhes>' + CRLF
    cXML += '  <nome>Atilio</nome>' + CRLF
    cXML += '  <idade>29</idade>' + CRLF
    cXML += '  <gostaDeLer>sim</gostaDeLer>' + CRLF
    cXML += '  <sites>' + CRLF
    cXML += '    <site item="1">' + CRLF
    cXML += '	  <nome>Terminal de Informacao</nome>' + CRLF
    cXML += '	  <url>terminaldeinformacao.com</url>' + CRLF
    cXML += '	</site>' + CRLF
    cXML += '	<site item="2">' + CRLF
    cXML += '	  <nome>Atilio Sistemas</nome>' + CRLF
    cXML += '	  <url>atiliosistemas.com</url>' + CRLF
    cXML += '	</site>' + CRLF
    cXML += '  </sites>' + CRLF
    cXML += '</detalhes>' + CRLF

    //Transformando o XML (texto) em um objeto
    oXML := XmlParser(cXML, "_", @cAviso, @cErro)

    //Se houve alguma falha
    If ! Empty(cErro)
        FWAlertError("Houve um erro na conversão do texto para objeto: " + cErro, "Falha no 'parse' do XML")
    Else

        //Converte um nó do XML para um Array
        If XmlNode2Arr(oXML:_detalhes:_gostaDeLer, "_gostaDeLer" )
            FWAlertInfo("Conversão bem sucedida!", "Teste XmlNode2Arr")
        EndIf

    EndIf

    FWRestArea(aArea)
Return
