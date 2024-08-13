/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/13/buscando-o-conteudo-de-uma-tag-xml-atraves-da-wsadvvalue-maratona-advpl-e-tl-534/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe534
Busca o conteúdo de uma tag em um objeto XML
@type Function
@author Atilio
@since 04/04/2023
@see https://tdn.totvs.com/display/public/framework/WSAdvValue
@obs 
    Função WSAdvValue
    Parâmetros
        + oXml        , Objeto     , Nome do objeto instanciado
        + cObjCpoInfo , Caractere  , Nome da tag a ser pesquisada
        + cType       , Caractere  , Tipo do dado no XML
        + xDefault    , Indefinido , Valor default quando não encontrar no XML
        + cNotNILMsg  , Caractere  , Mensagem de erro (caso seja obrigatório e não venha o valor)
        + lAsArray    , Lógico     , Indica se o retorno será do tipo Array
        + cAdvType    , Caractere  , Tipo do dado em AdvPL
        + cAdv2Par    , Caractere  , Variável que será preenchida com o valor em AdvPL
        + cRecNS      , Caractere  , Namespace utilizado
        + lRealLong   , Lógico     , Se .T. passará por uma tratativa no valor caso no XML seja LONG
    Retorno
        + xRet       , Indefinido , Retorna o objeto da tag dentro do XML ou um Array caso possua várias "sub-tags"

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe534()
    Local aArea      := FWGetArea()
    Local cXML       := ""
    Local oXML
    Local oDetalhes
    Local cAviso     := ""
    Local cErro      := ""
    Local oNome

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

        //Busca o valor de uma tag através da função
        oNome := WSAdvValue(oDetalhes, "_nome", "string")
        If ValType(oNome) != "U"
            FWAlertInfo("O nome é " + oNome:TEXT, "Teste WSAdvValue")
        EndIf
    EndIf

    FWRestArea(aArea)
Return
