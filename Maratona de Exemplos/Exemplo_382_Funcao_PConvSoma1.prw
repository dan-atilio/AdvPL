/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/28/abrindo-uma-tela-de-parametros-com-a-pergunte-maratona-advpl-e-tl-383/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe382
Realiza a conversão de uma string feita pelo Soma1 (sequencial entre números e caracteres) para o tipo numérico (igual a DecodeSoma1)
@type Function
@author Atilio
@since 28/03/2023
@obs 
    Função PConvSoma1
    Parâmetros
        Código da sequencia em Soma1
    Retorno
        Valor da conversão

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe382()
    Local aArea      := FWGetArea()
    Local cSoma1     := ""
    Local nConvert   := 0

    //Faz a conversão com só 2 caracteres
    cSoma1   := "9A"
    nConvert := PConvSoma1(cSoma1)
    FWAlertInfo("A string '" + cSoma1 + "' deu o resultado de '" + cValToChar(nConvert) + "'", "Teste 1 do PConvSoma1")

    //Faz a conversão com 6 caracteres
    cSoma1   := "A147B2"
    nConvert := PConvSoma1(cSoma1)
    FWAlertInfo("A string '" + cSoma1 + "' deu o resultado de '" + cValToChar(nConvert) + "'", "Teste 2 do PConvSoma1")

    FWRestArea(aArea)
Return
