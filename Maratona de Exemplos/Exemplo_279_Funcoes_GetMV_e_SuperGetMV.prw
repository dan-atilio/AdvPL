/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/07/buscando-o-primeiro-e-o-ultimo-elemento-de-um-array-com-getmin-e-getmax-maratona-advpl-e-tl-278/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe279
Busca conteúdo de parâmetros
@type  Function
@author Atilio
@since 21/02/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6815002 e https://tdn.totvs.com/pages/releaseview.action?pageId=24347112
@obs 
    
    Função GetMV
    Parâmetros
        + cMv_par       , Caractere     , Nome do parâmetro
        + lConsulta     , Lógico        , Se .T. e o parâmetro não existir pega o valor do xDefault
        + xDefault      , Indefinido    , Valor default do parâmetro caso não exista
    Retorno
        + xConteudo     , Indefinido    , Retorna o conteúdo do parâmetro encontrado na SX6

    Função SuperGetMV
    Parâmetros
        + Parametro     , Caractere     , Nome do parâmetro
        + lHelp         , Lógico        , Se .T. será exibido uma mensagem se o parâmetro não existir
        + cPadrao       , Indefinido    , Valor default do parâmetro caso não exista
        + Filial        , Caractere     , Código da filial onde será buscado o parâmetro
    Retorno
        Retorna o conteúdo do parâmetro encontrado na SX6

    Obs.: O SuperGetMV é mais performático do que o GetMV - https://tdn.totvs.com/display/public/framework/Desempenho+SuperGetMV+x+GetMV

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe279()
    Local aArea      := FWGetArea()
    Local cConteudo  := ""

    //Se o parâmetro existir na base, pega o conteúdo dele
    If FWSX6Util():ExistsParam("MV_X_PARAM")
        cConteudo := GetMV("MV_X_PARAM")
    EndIf

    //Pegando com SuperGetMV
    cConteudo := SuperGetMV("MV_X_PARAM", .F., "CONTEUDO DEFAULT")

    //Exibe uma mensagem
    FWAlertInfo("O conteúdo do parâmetro é: " + cConteudo, "Teste GetMV e SuperGetMV")

    FWRestArea(aArea)
Return
