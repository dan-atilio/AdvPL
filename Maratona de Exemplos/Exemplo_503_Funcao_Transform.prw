/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/27/criando-paineis-com-a-tpanel-maratona-advpl-e-tl-502/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe503
Transforma uma expressão utilizando uma Picture (Máscara)
@type Function
@author Atilio
@since 04/04/2023
@see https://tdn.totvs.com/display/tec/Transform
@obs 

    Transform
    Parâmetros
        + xExp         , Indefinido    , Expressão a ser formatada
        + cSayPicture  , Caractere     , Define a máscara de formatação que será aplicada na transformação
    Retorno
        + Ret          , Caractere     , Retorna a expressão transformada conforme a picture fornecida

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe503()
    Local aArea      := FWGetArea()
    Local nValor     := 57485.3477
    Local cCEP       := "17000111"
    Local cTelefone  := "14988887777"
    Local cCPF       := "11122233344"
    Local cRG        := "998887776"
    Local cCNPJ      := "99888777000166"
    Local cNome      := "Daniel Atilio"
    Local cMensagem  := ""

    //Monta a mensagem transformando os valores
    cMensagem += "Valor com 2 casas: " + Alltrim(Transform(nValor,    "@E 999,999,999.99"    )) + CRLF
    cMensagem += "Valor com 4 casas: " + Alltrim(Transform(nValor,    "@E 999,999,999.9999"  )) + CRLF
    cMensagem += "CEP:               " + Alltrim(Transform(cCEP,      "@R 99999-999"         )) + CRLF
    cMensagem += "Telefone:          " + Alltrim(Transform(cTelefone, "@R (99) 9 9999-9999"  )) + CRLF
    cMensagem += "CPF:               " + Alltrim(Transform(cCPF,      "@R 999.999.999-99"    )) + CRLF
    cMensagem += "RG:                " + Alltrim(Transform(cRG,       "@R 99.999.999-X"      )) + CRLF
    cMensagem += "CNPJ:              " + Alltrim(Transform(cCNPJ,     "@R 99.999.999/9999-99")) + CRLF
    cMensagem += "Tudo Maiúsculo:    " + Alltrim(Transform(cNome,     "@!"                   )) + CRLF
    ShowLog(cMensagem)

    FWRestArea(aArea)
Return
