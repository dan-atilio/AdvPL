/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/11/18/convertendo-texto-para-data-com-as-funcoes-ctod-e-stod-maratona-advpl-e-tl-102/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe102
Exemplo de como converter conteúdos em string para o tipo Data
@type Function
@author Atilio
@since 12/12/2022
@see https://tdn.totvs.com/display/tec/CToD e https://tdn.totvs.com/display/tec/SToD
@obs 
    Função CToD
    Parâmetros
        + cData         , Caractere    , Texto com a data no formato "DD/MM/YYYY" ou "DD/MM/YY"
    Retorno
        + dRet          , Array        , Retorna a data convertida

    Função SToD
    Parâmetros
        + cData         , Caractere    , Texto com a data no formato "YYYYMMDD"
    Retorno
        + dRet          , Array        , Retorna a data convertida

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe102()
    Local aArea     := FWGetArea()
    Local dData1
    Local dData2
    Local dData3

    //Monta as variáveis do tipo Data
    dData1 := CToD("12/07/1993")
    dData2 := SToD("19930712")
    dData3 := SToD("")

    //Exibe uma mensagem
    FWAlertInfo("Datas convertidas", "Teste CToD e SToD")

    FWRestArea(aArea)
Return
