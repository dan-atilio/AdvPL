/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/07/restaurando-a-memoria-com-fwgetarea-fwrestarea-getarea-e-restarea-maratona-advpl-e-tl-220/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe221
Efetua a busca ou a criação / atualização de conteúdos de uma tabela genérica (SX5)
@type Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/display/public/framework/FWGetSX5 e https://tdn.totvs.com/pages/releaseview.action?pageId=286016719
@obs 

    Função FWGetSX5
    Parâmetros
        + cTable        , Caractere   , Código da tabela genérica (X5_TABELA)
        + cKey          , Caractere   , Código da chave de pesquisa X5_CHAVE
        + cIdiom        , Caractere   , Idioma de pesquisa sendo possível: pt-br; pt-pt; en; es e ru 
    Retorno
        + xRetorno      , Array       , Array com as posições [1] Filial ; [2] Tabela ; [3] Chave ; [4] Descrição

    Função FWPutSX5
    Parâmetros
        + cFlavour      , Caractere   , Código do Flavour
        + cTable        , Caractere   , Código da tabela genérica (X5_TABELA)
        + cChave        , Caractere   , Código da chave (X5_CHAVE)
        + cTextoPor     , Caractere   , Texto com conteúdo em português (X5_DESCRI)
        + cTextoEng     , Caractere   , Texto com conteúdo em inglês (X5_DESCENT)
        + cTextoEsp     , Caractere   , Texto com conteúdo em espanhol (X5_DESCSPA)
        + cTextoAlt     , Caractere   , Texto do idioma alternativo
    Retorno
        + Retorna .T. se conseguiu criar / alterar ou .F. se não

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe221()
    Local aArea     := FWGetArea()
    Local aEstados
    Local aSaoPaulo
    Local cTabela   := ""
    Local cChave    := ""
    Local cConteudo := ""

    //Busca a informação de todos os estados
    aEstados := FWGetSX5("12")
    FWAlertInfo("Foi encontrado " + cValToChar(Len(aEstados)) + " estados", "Teste 1 FWGetSX5")

    //Busca somente de 1 estado
    aSaoPaulo := FWGetSX5("12", "SP")

    //Se houver dados
    If Len(aSaoPaulo) > 0
        FWAlertInfo("A descrição do estado é '" + aSaoPaulo[1][4] + "'", "Teste 2 FWGetSX5")
    EndIf

    //Faz a gravação de um conteúdo existente na SX5
    cTabela   := "01"
    cChave    := "B"
    cConteudo := StrTran(Time(), ":", "")
    FwPutSX5(, cTabela, cChave, cConteudo, cConteudo, cConteudo)

    //Cria um novo registro na SX5 caso não exista
    cTabela   := "01"
    cChave    := "DAN"
    cConteudo := "000000001"
    FwPutSX5(, cTabela, cChave, cConteudo, cConteudo, cConteudo)

    FWRestArea(aArea)
Return
