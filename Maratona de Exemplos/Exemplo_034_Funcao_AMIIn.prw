/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/09/11/funcao-amiin-para-validar-utilizacao-do-modulo-maratona-advpl-e-tl-034/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe034
Exemplo de função que verifica se a rotina está sendo chamada com licença de uso para o módulo de origem
@type Function
@author Atilio
@since 28/11/2022
@see https://tdn.totvs.com/pages/releaseview.action?pageId=555856401
@obs 
    Função AMIIn
    Parâmetros
        + nMd01  (Opcional), Numérico, Número do módulo a ser conferido
        + nMd02  (Opcional), Numérico, Número do módulo a ser conferido
        + nMd03  (Opcional), Numérico, Número do módulo a ser conferido
        + nMd04  (Opcional), Numérico, Número do módulo a ser conferido
        + nMd05  (Opcional), Numérico, Número do módulo a ser conferido
        + nMd06  (Opcional), Numérico, Número do módulo a ser conferido
        + nMd07  (Opcional), Numérico, Número do módulo a ser conferido
        + nMd08  (Opcional), Numérico, Número do módulo a ser conferido
        + nMd09  (Opcional), Numérico, Número do módulo a ser conferido
        + nMd10  (Opcional), Numérico, Número do módulo a ser conferido
        + nMd11  (Opcional), Numérico, Número do módulo a ser conferido
        + nMd12  (Opcional), Numérico, Número do módulo a ser conferido
        + nMd13  (Opcional), Numérico, Número do módulo a ser conferido
        + nMd14  (Opcional), Numérico, Número do módulo a ser conferido
        + nMd15  (Opcional), Numérico, Número do módulo a ser conferido
        + nMd16  (Opcional), Numérico, Número do módulo a ser conferido
        + nMd17  (Opcional), Numérico, Número do módulo a ser conferido
        + nMd18  (Opcional), Numérico, Número do módulo a ser conferido
        + nMd19  (Opcional), Numérico, Número do módulo a ser conferido
        + nMd20  (Opcional), Numérico, Número do módulo a ser conferido
        + nMd21  (Opcional), Numérico, Número do módulo a ser conferido
        + nMd22  (Opcional), Numérico, Número do módulo a ser conferido
        + nMd23  (Opcional), Numérico, Número do módulo a ser conferido
        + nMd24  (Opcional), Numérico, Número do módulo a ser conferido
        + nMd25  (Opcional), Numérico, Número do módulo a ser conferido
    Retorno
        + Se o usuário tem acesso retorna .T. do contrário retorna .F.

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe034()
    Local aArea     := FWGetArea()

    //Se tiver licença de acesso do Compras (2), Estoque Custos (4), Faturamento (5), Financeiro (6)
    If AMIIn(2, 4, 5, 6)
        FWAlertInfo("Caiu na primeira condição", "Primeiro teste")
    EndIf

    FWRestArea(aArea)
Return
