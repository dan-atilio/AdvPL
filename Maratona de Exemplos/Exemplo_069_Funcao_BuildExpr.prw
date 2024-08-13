/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/10/16/montando-filtros-de-tabela-em-tela-com-buildexpr-maratona-advpl-e-tl-069/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe069
Exemplo para filtrar tabelas através e uma tela de filtro
@type Function
@author Atilio
@since 06/12/2022
@see https://tdn.totvs.com/display/public/framework/BuildExpr
@obs 
    Função BuildExpr
    Parâmetros
        + cAlias            , Caractere         , Alias da Tabela
        + oWnd              , Objeto            , Objeto que chamou a função
        + cFilter           , Caractere         , String já contendo o filtro
        + lTopFilter        , Lógico            , Utiliza expressão SQL (.T.) ou AdvPL (.F.)
        + bOk               , Bloco de Código   , Bloco de código executado ao clicar no botão Confirmar
        + oDlg              , Objeto            , Dialog onde será apresentado o construtor de filtros
        + aUsado            , Array             , Array com os campos que poderão ser usados nos filtros
        + cDesc             , Caractere         , Título da Janela
        + nRow              , Numérico          , Posição da linha inicial para exibir a tela de filtro
        + nCol              , Numérico          , Posição da coluna inicial para exibir a tela de filtro
        + aCampo            , Array             , Array com os campos que serão apresentados
        + lVisibleTopFilter , Lógico            , Verifica expressão do filtro como TopConnect
        + lExpBtn           , Lógico            , Permite habilitar ou desabilitar o botão Expressão
        + cTopFilter        , Caractere         , Expressão do filtro do TopConnect
    Retorno
        + cRet              , Caractere         , Expressão do filtro

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe069()
    Local aArea   := FWGetArea()
    Local cFiltro := ""

    //Mostrando a tela de filtro
    DbSelectArea('SA1')
    cFiltro := BuildExpr('SA1')
    
    //Se tiver filtro, usa o DbSetFilter para filtrar a tabela
    If ! Empty(cFiltro)
        SA1->(DbSetFilter({|| &(cFiltro)}, cFiltro))
        
    //Senão, limpa qualquer filtragem
    Else
        SA1->(DbClearFilter())
    Endif

    FWRestArea(aArea)
Return
