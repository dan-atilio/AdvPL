/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/24/buscando-o-numero-da-semana-com-a-semanadia-maratona-advpl-e-tl-434/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe434
Retorna o numero da semana do mês / dia
@type Function
@author Atilio
@since 30/03/2023
@obs 
    Função SemanaDia
    Parâmetros
        Data de Referência para verificação
        .F. se irá retornar como texto por extenso ou .T. se irá retornar o número da semana e do dia
    Retorno
        Array com as inforamções conforme os parâmetros passados

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe434()
    Local aArea    := FWGetArea()
    Local dDataRef := Date()
    Local aDados   := {}

    //Busca se é a primeira, segunda, terceira, etc dia da semana do mês
    aDados := SemanaDia(dDataRef, .F.)
    FWAlertInfo(aDados[1], "Teste SemanaDia com .F.")

    //Busca o número da semana e o número do dia atual
    aDados := SemanaDia(dDataRef, .T.)
    FWAlertInfo("Semana: " + cValToChar(aDados[1]) + " ; Dia da Semana: " + cValToChar(aDados[2]), "Teste SemanaDia com .T.")

    FWRestArea(aArea)
Return
