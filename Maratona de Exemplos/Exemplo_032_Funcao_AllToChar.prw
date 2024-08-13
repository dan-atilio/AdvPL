/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/09/09/funcao-alltochar-para-converter-numeros-data-e-logico-para-caractere-maratona-advpl-e-tl-032/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe032
Exemplo de função para converter dados para Caractere usando AllToChar com possibilidade de passar uma máscara
@type Function
@author Atilio
@since 28/11/2022
@obs 
    Função AllToChar
    Parâmetros
        + Conteúdo a ser convertido que pode ser dos tipos Numérico; Lógico; Data;
        + Máscara de formatação no caso de tipo Numérico
        + Define se a data deve vir no formato YYYYMMDD (.T.) ou DD/MM/YYYY (.F.)
    Retorno
        + Conteúdo convertido

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe032()
    Local aArea     := FWGetArea()
    Local lGostaLer := .T.
    Local dDtNascim := sToD("19930712")
    Local nAltura   := 1.73
    Local cResult   := ""

    //Converte do tipo Lógico para Caractere
    cResult += "lGostaLer: "              + AllToChar(lGostaLer)            + CRLF

    //Converte do tipo Data para Caractere
    cResult += "dDtNascim (YYYYMMDD): "   + AllToChar(dDtNascim, , .T.)     + CRLF
    cResult += "dDtNascim (DD/MM/YYYY): " + AllToChar(dDtNascim, , .F.)     + CRLF

    //Converte do tipo Numérico para Caractere (e passando máscara)
    cResult += "nAltura: "                + AllToChar(nAltura)              + CRLF
    cResult += "nAltura (com máscara): "  + AllToChar(nAltura, "@E 999.99") + CRLF

    //Mostra o resultado das conversões
    FWAlertInfo(cResult, "Testes com AllToChar")

    FWRestArea(aArea)
Return
