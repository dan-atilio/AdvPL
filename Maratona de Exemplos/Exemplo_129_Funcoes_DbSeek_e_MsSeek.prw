/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/12/15/posicionando-em-um-registro-com-uma-expressao-atraves-de-dbseek-e-msseek-maratona-advpl-e-tl-129/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe129
Posiciona em um registro conforme uma chave passada para pesquisar no índice
@type Function
@author Atilio
@since 14/12/2022
@see https://tdn.totvs.com/display/tec/DBSeek e https://tdn.totvs.com/pages/releaseview.action?pageId=24347003
@obs 
    Função DbSeek
    Parâmetros
        + xExp         , Caractere    , Expressão que será usada para encontrar o registro na tabela
        + lSoftSeek    , Lógico       , .T. se deve posicionar no próximo registro depois do encontrado ou .F. se posiciona exatamente no encontrado
        + lLast        , Lógico       , Compatibilidade
    Retorno
        + lRet         , Lógico       , .T. se encontrou o registro ou .F. se não encontrou

    Função MsSeek
    Parâmetros
        + xExp         , Caractere    , Expressão que será usada para encontrar o registro na tabela
        + lSoftSeek    , Lógico       , .T. se deve posicionar no próximo registro depois do encontrado ou .F. se posiciona exatamente no encontrado
        + lLast        , Lógico       , Compatibilidade
    Retorno
        + lRet         , Lógico       , .T. se encontrou o registro ou .F. se não encontrou

    O indicado é tentar usar o MsSeek por ser mais performático, conforme os artigos:
    + https://terminaldeinformacao.com/2020/07/23/voce-sabia-que-o-msseek-e-mais-performatico-que-o-dbseek-em-advpl/
    + https://tdn.totvs.com/display/framework/Desempenho+DbSeek+x+MsSeek

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe129()
    Local aArea      := FWGetArea()
    Local cBusca     := ""
    
    //Abre o cadastro de produtos
    DbSelectArea('SB1')
    SB1->(DbSetOrder(3)) //B1_FILIAL + B1_DESC + B1_COD



    //Pede pro usuário inserir uma descrição e faz a busca com DbSeek
    cBusca := FWInputBox("Insira a descrição do produto para o DbSeek:")
    If SB1->(DbSeek(FWxFilial("SB1") + AvKey(cBusca, "B1_DESC")))
        FWAlertSuccess("Produto encontrado, código " + SB1->B1_COD, "Sucesso DbSeek")
    Else
        FWAlertError("Produto não encontrado", "Falha DbSeek")
    EndIf



    //Pede pro usuário inserir uma descrição e faz a busca com MsSeek
    cBusca := FWInputBox("Insira a descrição do produto para o MsSeek:")
    If SB1->(MsSeek(FWxFilial("SB1") + AvKey(cBusca, "B1_DESC")))
        FWAlertSuccess("Produto encontrado, código " + SB1->B1_COD, "Sucesso MsSeek")
    Else
        FWAlertError("Produto não encontrado", "Falha MsSeek")
    EndIf

    FWRestArea(aArea)
Return
