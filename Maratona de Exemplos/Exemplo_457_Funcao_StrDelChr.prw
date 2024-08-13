/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/04/removendo-caracteres-de-uma-string-atraves-da-strdelchr-maratona-advpl-e-tl-457/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe457
Remove alguns caracteres de uma string
@type Function
@author Atilio
@since 31/03/2023
@obs 
    Função StrDelChr
    Parâmetros
        Recebe a string a ser analisada
        Recebe um array com os textos a serem removidos
    Retorno
        Retorna o texto formatado

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe457()
    Local aArea     := FWGetArea()
    Local cTexto    := ""
    Local aRetirar  := {}
    Local cNovo     := ""

    //Monta as informações e aciona a remoçaõ de caracteres
    cTexto    := "A aranha arranha a rã. A rã arranha a aranha. Nem a aranha arranha a rã. Nem a rã arranha a aranha."
    aRetirar  := {"a", "m", " "}
    cNovo     := StrDelChr(cTexto, aRetirar)

    //Exibe a mensagem
    FWAlertInfo(cNovo, "Teste de StrDelChr")

    FWRestArea(aArea)
Return
