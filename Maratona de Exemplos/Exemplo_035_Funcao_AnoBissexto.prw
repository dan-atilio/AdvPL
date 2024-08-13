/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/09/12/funcao-anobissexto-para-validar-se-um-ano-e-bissexto-maratona-advpl-e-tl-035/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe035
Exemplo de função que verifica se o ano passado é bissexto (366 dias) ou é um ano comum (365 dias)
@type Function
@author Atilio
@since 28/11/2022
@obs 
    Função AnoBissexto
    Parâmetros
        + Número do ano que deseja validar
    Retorno
        + Retorna .T. se é um ano bissexto ou .F. se não for

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe035()
    Local aArea     := FWGetArea()

    //Verifica se o ano de 2020 é bissexto
    If AnoBissexto(2020)
        FWAlertInfo("O ano de '2020' é bissexto, portanto tem 366 dias", "Teste 1")
    EndIf

    //Verifica se o ano de 2022 NÃO é bissexto
    If ! AnoBissexto(2022)
        FWAlertInfo("O ano de '2022' não é bissexto, portanto tem 365 dias", "Teste 2")
    EndIf

    FWRestArea(aArea)
Return
