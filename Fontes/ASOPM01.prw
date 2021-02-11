/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2020/12/10/como-integrar-protheus-com-a-sophus/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Totvs.ch"
 
/*/{Protheus.doc} User Function ASOPM01
Função que retorna o XML de consulta no Sophus
@type  Function
@author Atilio
@since 17/10/2020
@version version
@see http://www.sophus.com.br/downloads/Sockets.rar
@obs no exemplo abaixo, se vier CNPJ irá tratar com a consulta 621, se vier CPF irá tratar com a consulta 309
/*/
 
User Function ASOPM01(cCGC)
    Local aArea      := GetArea()
    Local cSendXML   := ''
    Local cResultXML := ''
    Local cVersao    := '20090415'
    Local cCodigo    := 'Informar seu Codigo aqui'
    Local cSenhaXML  := 'Informar sua Senha aqui'
    Local cTipo      := ''
    Local cCNPJ      := ''
    Local cCPF       := ''
    Default cCGC     := ''
 
    //Somente fará as tratativas se tiver vindo CGC (CNPJ ou CPF)
    If ! Empty(cCGC)
        //Faz a tratativa se for CNPJ ou CPF
        cCGC := Alltrim(cCGC)
        cCGC := StrTran(cCGC, '-', '')
        cCGC := StrTran(cCGC, '.', '')
        cCGC := StrTran(cCGC, '/', '')
        If Len(cCGC) > 11
            cTipo := '621'
            cCNPJ := cCGC
        Else
            cTipo := '309'
            cCPF  := cCGC
        EndIf
 
        //Monta o envio do XML para a Sophus
        cSendXML := '<?xml version="1.0" encoding="UTF-8"?>'
        cSendXML += '<SPCA-XML xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="https://www.scpc.inf.br/spcn/spcaxml.xsd">'
        cSendXML += '   <VERSAO>' + cVersao + '</VERSAO>'
        cSendXML += '   <SOLICITACAO>'
        cSendXML += '           <S-CODIGO>' + cCodigo + '</S-CODIGO>'
        cSendXML += '           <S-SENHA>' + cSenhaXML + '</S-SENHA>'
        cSendXML += '           <S-CONSULTA>' + cTipo + '</S-CONSULTA>'
        If cTipo == '309'
            cSendXML += '           <S-CPF>' + cCPF + '</S-CPF>'
        ElseIf cTipo == '621'
            cSendXML += '           <S-CNPJ>' + cCNPJ + '</S-CNPJ>'
        EndIf
        cSendXML += '           <S-NOME></S-NOME>'
        cSendXML += '           <S-RAZAO-SOCIAL></S-RAZAO-SOCIAL>'
        cSendXML += '           <S-DDD-1></S-DDD-1>'
        cSendXML += '           <S-TELEFONE-1></S-TELEFONE-1>'
        cSendXML += '           <S-DDD-2></S-DDD-2>'
        cSendXML += '           <S-TELEFONE-2></S-TELEFONE-2>'
        cSendXML += '           <S-CEP></S-CEP>'
        cSendXML += '           <S-NASCIMENTO></S-NASCIMENTO>'
        cSendXML += '           <S-RG></S-RG>'
        cSendXML += '           <S-UFRG></S-UFRG>'
        cSendXML += '           <S-UF-DATA></S-UF-DATA>'
        cSendXML += '           <S-TIPO-CREDITO>XX</S-TIPO-CREDITO>'
        cSendXML += '           <S-NUMERO-RESPOSTA>0</S-NUMERO-RESPOSTA>'
        cSendXML += '   </SOLICITACAO>'
        cSendXML += '</SPCA-XML>'
 
        //Envia o XML, e se tudo der certo, armazena na variável cResultXML
        cResultXML := HttpPost('https://www.scpc.inf.br/cgi-bin/spcaxml',; // cURL
            ,; // cGetParms
            cSendXML,; // cPostParms
            ,; // nTimeOut
            ,; // aHeadStr
            )  // @cHeaderGet
    EndIf
 
    RestArea(aArea)
Return cResultXML