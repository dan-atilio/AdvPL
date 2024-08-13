/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/05/convertendo-variaveis-com-string_to_qqtipo-e-qqtipo_to_string-maratona-advpl-e-tl-459/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe459
Realiza a conversão de valores com strings
@type Function
@author Atilio
@since 31/03/2023
@obs 
    Função QQTipo_To_String
    Parâmetros
        Valor a ser convertido
        Tipo da conversão
    Retorno
        Retorna a string convertida

    Função String_To_QQTipo
    Parâmetros
        String a ser convertido
        Tipo da conversão
    Retorno
        Retorna o valor

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe459()
    Local aArea     := FWGetArea()
    Local dData     := Date()
    Local nValor    := 13.8
    Local lLogico   := .T.
    Local cMensagem := ""

    //Monta a mensagem de teste
    cMensagem += "Data: "     + QQTipo_To_String(dData,   "D")    + CRLF
    cMensagem += "Numérico: " + QQTipo_To_String(nValor,  "N")   + CRLF
    cMensagem += "Lógico: "   + QQTipo_To_String(lLogico, "L")
    FWAlertInfo(cMensagem, "Teste de QQTipo_To_String")

    //Pega informações de String e converte
    nValor  := String_To_QQTipo("15.34",      "N")
    dData   := String_To_QQTipo("10/03/2023", "D")
    lLogico := String_To_QQTipo(".F.",        "L")
    cMensagem := "nValor: " + cValToChar(nValor) + " . dData: " + cValToChar(dData) + " . lLogico: " + cValToChar(lLogico)
    FWAlertInfo(cMensagem, "Teste de String_To_QQTipo")

    FWRestArea(aArea)
Return
