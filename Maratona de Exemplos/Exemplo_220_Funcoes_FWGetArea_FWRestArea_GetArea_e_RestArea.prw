/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/07/manipulando-dados-da-sx5-com-as-funcoes-fwgetsx5-e-fwputsx5-maratona-advpl-e-tl-221/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe220
Faz um backup da área em memória e depois volta
@type Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/display/public/framework/FwGetArea , https://tdn.totvs.com/display/public/framework/FwRestArea , https://tdn.totvs.com/pages/releaseview.action?pageId=24346925, https://tdn.totvs.com/pages/releaseview.action?pageId=24347058
@obs 

    Função FWGetArea
    Parâmetros
        Não possui parâmetros
    Retorno
        Retorna um array com as posições [1] Alias ; [2] Índice Usado ; [3] Registro posicionado

    Função FWRestArea
    Parâmetros
        + aArea         , Array       , Array com as posições igual armazenadas na FWGetArea
    Retorno
        Não tem retorno

    Função GetArea
    Parâmetros
        Não possui parâmetros
    Retorno
        Retorna um array com as posições [1] Alias ; [2] Índice Usado ; [3] Registro posicionado

    Função RestArea
    Parâmetros
        + aArea         , Array       , Array com as posições igual armazenadas na GetArea
    Retorno
        Não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe220()
    Local aArea    := FWGetArea()
    Local aAreaSB1 := SB1->(FWGetArea())
     
    //Aqui suas customizações
     
    FWRestArea(aAreaSB1)
    FWRestArea(aArea)
Return

/*/{Protheus.doc} User Function A010TOK
Ponto de entrada ao clicar no botão Ok no Cadastro de Produtos
@type  Function
@author Atilio
@since 20/02/2023
/*/

User Function A010TOK()
    Local lRet     := .T.

    //Aciona o exemplo do GetArea e RestArea
    u_zExe220()

Return lRet
