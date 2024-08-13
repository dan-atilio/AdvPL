/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/06/validando-se-um-registro-ja-existe-na-mesma-tabela-com-existchav-maratona-advpl-e-tl-157/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe157
Verifica se a chave já existe na mesma tabela
@type Function
@author Atilio
@since 18/12/2022
@see https://tdn.engpro.totvs.com.br/pages/releaseview.action?pageId=24346638
@obs 
    Função ExistChav
    Parâmetros
        + Alias        , Caractere   , Nome da tabela a ser verificada
        + Expressao    , Caractere   , Conteúdo dos campos a ser verificado
        + Indice       , Numérico    , Número do índice a ser verificado
        + Help         , Lógico      , Se .T. irá exibir o help caso já encontrar o registro
    Retorno
        Retorna .F. se o registro não existir ou .T. se já existir

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe157()
    Local aArea     := FWGetArea()
    Local cCodigo   := "C00001"
    Local cLoja     := "01"

    //Verifica se já existe na tabela essa informação
    If ExistChav("SA1", cCodigo + cLoja, 1)
        FWAlertSuccess("Cliente não existe!", "Teste ExistChav")

    Else
        FWAlertError("Cliente já existe!", "Teste ExistChav")
    EndIf

    FWRestArea(aArea)
Return
