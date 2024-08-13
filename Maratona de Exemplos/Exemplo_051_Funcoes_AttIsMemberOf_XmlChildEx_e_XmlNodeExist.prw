/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/09/28/validando-se-no-xml-existe-com-attismemberof-xmlchildex-e-xmlnodeexist-maratona-advpl-e-tl-051/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe051
Exemplo de função que identifica se um atributo existe em um objeto (AttIsMemberOf) ou uma tag existe dentro do XML (XMLChildEx)
@type Function
@author Atilio
@since 05/12/2022
@see https://tdn.totvs.com/display/tec/AttlsMemberOf e https://tdn.totvs.com/display/tec/XmlChildEx
@obs 
    Função AttIsMemberOf
    Parâmetros
        + oObj       , Objeto     , Nome do objeto instânciado
        + cAttName   , Caractere  , Nome da propriedade sendo pesquisada
        + lRecursive , Lógico     , Indica se a pesquisa também será feita em classes superiores
    Retorno
        + lRet       , Lógico     , Retorna .T. se encontrou a tag ou .F. se não encontrou

    Função XMLChildEx
    Parâmetros
        + oParent    , Objeto     , Ojeto instânciado
        + cProcura   , Caractere  , Nome da propriedade sendo pesquisada (tudo em maiúsculo)
    Retorno
        + xRet       , Indefinido , Retorna o objeto da tag dentro do XML ou um Array caso possua várias "sub-tags"

    Função XmlNodeExist
    Parâmetros
        Objeto instânciado
        Nome da propriedade sendo pesquisada
    Retorno
        Retorna .T. se encontrou a tag ou .F. se não

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe051()
    Local aArea      := FWGetArea()
    Local cXML       := ""
    Local oXML
    Local oDetalhes
    Local cAviso     := ""
    Local cErro      := ""
    Local xResult

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

        //Realizando a procura de um atributo com AttIsMemberOf
        If AttIsMemberOf(oDetalhes, "_idade")
            FWAlertInfo("O atributo 'idade' foi encontrado no objeto, sendo: " + oDetalhes:_idade:TEXT, "Exemplo de AttIsMemberOf")
        EndIf

        

        //Realizando a procura de tag com XMLChildEx (você precisa mandar o nome da tag tudo em maiúsculo)
        xResult := XMLChildEx(oDetalhes, "_GOSTADELER")
        If ValType(xResult) != "U"
            FWAlertInfo("A tag 'gostaDeLer' foi encontrada no objeto, sendo: " + xResult:TEXT, "Exemplo de XMLChildEx")
        EndIf



        //Verificando se a tag existe, independente se escreve tudo minúsculo ou maiúsculo
        If XmlNodeExist(oDetalhes, "_GostaDeLer")
            FWAlertInfo("A tag 'gostaDeLer' foi encontrada no objeto, sendo: " + oDetalhes:_gostaDeLer:TEXT, "Exemplo de XmlNodeExist")
        EndIf
    EndIf

    FWRestArea(aArea)
Return
