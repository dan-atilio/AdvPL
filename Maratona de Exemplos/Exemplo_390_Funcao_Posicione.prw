/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/02/buscando-a-informacao-de-uma-tabela-com-a-posicione-maratona-advpl-e-tl-390/
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} User Function zExe390
Busca o conteúdo de um campo de uma tabela
@type Function
@author Atilio
@since 28/03/2023
@see https://tdn.totvs.com/display/public/framework/Posicione+-+Posiciona+tabela+em+registro
@obs 

    Função Posicione
    Parâmetros
        + cAlias     , Caractere      , Alias da Tabela
        + nOrdem     , Numérico       , Índice da Tabela usado na busca
        + cSeek      , Caractere      , Expressão da busca conforme o índice
        + cField     , Caractere      , Campo a ser buscado
        + cNickName  , Caractere      , Apelido do índice caso queira usar no lugar do nOrdem
    Retorno
        + cReturn    , Caractere      , Conteúdo do campo buscado

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe390()
    Local aArea    := FWGetArea()
    Local aPergs   := {}
    Local cCliente := Space(TamSX3('A1_COD')[1])
    Local cLoja    := Space(TamSX3('A1_LOJA')[1])

    //Adiciona os parâmetros que serão mostrados no ParamBox
    aAdd(aPergs, {01, "Cliente",   cCliente, "", "ExistCPO('SA1')", "SA1", ".T.", 80,  .T.})
    aAdd(aPergs, {01, "Loja",      cLoja,    "", ".T.", "",    ".T.", 80,  .T.})
 
    //Se a pergunta for confirmada, busca o nome do cliente
    If ParamBox(aPergs, "Informe os parâmetros", , , , , , , , , .F., .F.)
        cNomeCli := Posicione('SA1', 1, FWxFilial('SA1') + MV_PAR01 + MV_PAR02, "A1_NOME")
 
        FWAlertInfo("O nome do cliente é " + cNomeCli, "Teste Posicione")
    EndIf
 
    FWRestArea(aArea)
Return
