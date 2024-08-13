/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/25/validando-se-no-existe-em-um-xml-com-isxmlnode-maratona-advpl-e-tl-315/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe315
Valida se um nó existe dentro de uma tag em XML
@type Function
@author Atilio
@since 23/02/2023
@obs 
    Função IsXMLNode
    Parâmetros
        + oObj       , Objeto     , Nome do objeto instânciado
        + cAttName   , Caractere  , Nome da propriedade sendo pesquisada
        + lRecursive , Lógico     , Indica se a pesquisa também será feita em classes superiores
    Retorno
        + lRet       , Lógico     , Retorna .T. se encontrou a tag ou .F. se não encontrou

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe315()
    Local aArea      := FWGetArea()
    Local cXML       := ""
    Local oXML
    Local oDetalhes
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

        //Pega a "subtag" de detalhes
        oDetalhes := oXML:_detalhes

        //Realizando a procura de tag (similar a XMLChildEx)
        If IsXmlNode(oDetalhes, "_gostaDeLer")
            FWAlertInfo("A tag 'gostaDeLer' foi encontrada no objeto, sendo: " + oDetalhes:_gostaDeLer:TEXT, "Exemplo de IsXmlNode")
        EndIf

    EndIf

    FWRestArea(aArea)
Return
