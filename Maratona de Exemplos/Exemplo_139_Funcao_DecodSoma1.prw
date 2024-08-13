/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/12/25/decodificando-uma-string-gerada-incremental-com-a-funcao-decodsoma1-maratona-advpl-e-tl-139/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe139
Realiza a conversão de uma string feita pelo Soma1 (sequencial entre números e caracteres) para o tipo numérico
@type Function
@author Atilio
@since 16/12/2022
@obs 
    Função DecodSoma1
    Parâmetros
        + Código da sequencia em Soma1
    Retorno
        + Valor da conversão

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe139()
    Local aArea      := FWGetArea()
    Local cSoma1     := ""
    Local nConvert   := 0

    //Faz a conversão com só 2 caracteres
    cSoma1   := "9A"
    nConvert := DecodSoma1(cSoma1)
    FWAlertInfo("A string '" + cSoma1 + "' deu o resultado de '" + cValToChar(nConvert) + "'", "Teste 1 do DecodSoma1")

    //Faz a conversão com 6 caracteres
    cSoma1   := "A147B2"
    nConvert := DecodSoma1(cSoma1)
    FWAlertInfo("A string '" + cSoma1 + "' deu o resultado de '" + cValToChar(nConvert) + "'", "Teste 2 do DecodSoma1")

    FWRestArea(aArea)
Return
