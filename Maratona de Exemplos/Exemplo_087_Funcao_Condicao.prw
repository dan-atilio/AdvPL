/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/11/03/buscando-valores-de-parcelas-com-condicao-de-pagamento-usando-condicao-maratona-advpl-e-tl-087/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe087
Exemplo de como função que monta as parcelas que serão geradas conforme a condição de pagamento informada
@type Function
@author Atilio
@since 09/12/2022
@see https://tdn.totvs.com.br/pages/releaseview.action?pageId=6070765
@obs 
    Função Condicao
    Parâmetros
        + nValTot    , Numérico        , Valor total que irá gerar as parcelas
        + cCond      , Caractere       , Código da condição de pagamento
        + nValIpi    , Numérico        , Valor do IPI destacado
        + dData0     , Data            , Data inicial a considerar o desdobramento
        + nValSolid  , Numérico        , Valor do ICMS solidário
        + aImpVar    , Array           , Array com a sigla e valor dos impostos para outros países
        + aE4        , Array           , Array com dados similares a SE4
        + nAcrescimo , Numérico        , Valor do acréscimo
        + nInicio3   , Numérico        , Intervalo entre duplicatas (SIGALOJA)
        + aDias3     , Array           , Dias para vencimento das duplicatas (SIGALOJA)
    Retorno
        + aVenc         , Array        , Array com os valores e vencimentos das parcelas (posição [1] será o valor e posição [2] será a data de vencimento)

    Para ver os tipos de condições de pagamento, veja em: https://centraldeatendimento.totvs.com/hc/pt-br/articles/360017468312-MP-FAT-Condi%C3%A7%C3%B5es-de-Pagamento

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe087()
    Local aArea     := FWGetArea()
    Local nValor    := 1000
    Local cCondPag  := "C02"
    Local dDataIni  := Date()
    Local aDupl     := {}
    
    //Aciona a função condição, para buscar as duplicatas com os vencimentos e valores
    aDupl := Condicao(nValor, cCondPag, , dDataIni, )
    FWAlertInfo("Existe(m) " + cValToChar(Len(aDupl)) + " parcela(s)", "Teste Condicao")

    FWRestArea(aArea)
Return
