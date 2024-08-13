/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/11/24/calculando-dias-e-meses-com-a-funcao-datecomp-maratona-advpl-e-tl-108/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe108
Calcula dias ou meses entre duas datas
@type Function
@author Atilio
@since 12/12/2022
@obs 
    Função DateComp
    Parâmetros
        + Data inicial
        + Data final
        + Define se quer saber a diferença entre: DD ou MM
    Retorno
        + Retorna a quantidade de dias; meses ou anos

    A função até tem parametrização para receber anos (com YY), mas o cálculo sempre retorna
    incorreto, então evitem usar para anos, usem apenas para dias ou meses

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe108()
    Local aArea     := FWGetArea()
    Local dDataIni  := sToD("19930712")
    Local dDataFim  := Date()
    Local nDias     := 0
    Local nMeses    := 0
    Local cMensagem := ""

    //Busca a diferença em dias e meses
    nDias     := DateComp(dDataIni, dDataFim, "DD")
    nMeses    := DateComp(dDataIni, dDataFim, "MM")

    //Monta a mensagem e a exibe
    cMensagem := "Abaixo diferença entre as duas datas" + CRLF + CRLF
    cMensagem += "Dias: "  + cValToChar(nDias)  + " ou " + CRLF
    cMensagem += "Meses: " + cValToChar(nMeses) + CRLF
    FWAlertInfo(cMensagem, "Teste DateComp")

    FWRestArea(aArea)
Return
