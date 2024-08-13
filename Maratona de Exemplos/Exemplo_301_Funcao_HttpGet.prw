/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/18/conversoes-entre-horas-e-minutos-com-htom-e-mtoh-maratona-advpl-e-tl-300/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe301
Aciona uma requisição GET para uma página da internet
@type  Function
@author Atilio
@since 22/02/2023
@see https://tdn.totvs.com/display/tec/HTTPGet
@obs 

    Função HttpGet
    Parâmetros
        + cUrl       , Caractere    , Indica a URL que será feito o GET
        + cGetParms  , Caractere    , Indica os parâmetros que serão passados na requisição
        + nTimeOut   , Numérico     , Indica um número de segundos para timeout
        + aHeadStr   , Array        , Indica um array com os headers da requisição
        + cHeaderGet , Caractere    , Busca o retorno dos headers da requisição (passar por referência com @)
    Retorno
        + cRet       , Caractere    , Retorna uma string que corresponde a solicitação

    Obs.: Exemplo original em https://terminaldeinformacao.com/2020/08/06/exemplo-de-integracao-com-viacep-usando-fwrest/

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe301()
    Local aArea         := FWGetArea()
    Local cResult       := ''
    Local cCep          := '17054679'

    //Aciona a requisição via HttpGet
    cResult := HttpGet(;
        "https://viacep.com.br/ws/" + cCep + "/json/",; // cURL
        ,; // cGetParms
        ,; // nTimeOut
        ,; // aHeadStr
        ;  // cHeaderGet
    )
 
    //Exibe o resultado que veio do WS
    ShowLog(cResult)

    FWRestArea(aArea)
Return
