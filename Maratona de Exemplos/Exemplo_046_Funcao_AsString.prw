/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/09/23/conversao-de-texto-inclusive-macro-com-a-funcao-asstring-maratona-advpl-e-tl-046/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe046
Exemplo de função que converte um conteúdo para texto, inclusive como código sem conversão direta
@type Function
@author Atilio
@since 29/11/2022
@obs 
    Função AsString
    Parâmetros
        + Variável que será convertido para texto
        + Indica se será uma conversão direta (.F.) ou se irá montar uma string em Macro (.T.)
    Retorno
        +  Retorna o conteúdo textual que será retornado

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe046()
    Local aArea      := FWGetArea()
    Local cNome      := "Daniel"
    Local nAltura    := 1.73
    Local dDataHoje  := Date()
    Local lGostaLer  := .T.
    Local aInfo      := {"Maria", "José", "João"}
    Local cMsgNormal := ""
    Local cMsgMacro  := ""
    
    //Monta a mensagem normal e exibe
    cMsgNormal += "cNome      : " + AsString(cNome      ) + CRLF
    cMsgNormal += "nAltura    : " + AsString(nAltura    ) + CRLF
    cMsgNormal += "dDataHoje  : " + AsString(dDataHoje  ) + CRLF
    cMsgNormal += "lGostaLer  : " + AsString(lGostaLer  ) + CRLF
    cMsgNormal += "aInfo      : " + AsString(aInfo      ) + CRLF
    FWAlertInfo(cMsgNormal, "Resultado Normal")

    //Monta a mensagem macro e exibe
    cMsgMacro += "cNome      : " + AsString(cNome      , .T.) + CRLF
    cMsgMacro += "nAltura    : " + AsString(nAltura    , .T.) + CRLF
    cMsgMacro += "dDataHoje  : " + AsString(dDataHoje  , .T.) + CRLF
    cMsgMacro += "lGostaLer  : " + AsString(lGostaLer  , .T.) + CRLF
    cMsgMacro += "aInfo      : " + AsString(aInfo      , .T.) + CRLF
    FWAlertInfo(cMsgMacro, "Resultado Macro")

    FWRestArea(aArea)
Return
