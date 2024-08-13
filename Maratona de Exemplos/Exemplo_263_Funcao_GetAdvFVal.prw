/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/28/usando-as-gddeleted-gdfieldget-gdfieldpos-gdfieldput-e-getdrefresh-maratona-advpl-e-tl-262/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe263
Função que retorna vários campos de uma tabela em um Array (como um Posicione para vários campos)
@type  Function
@author Atilio
@since 21/02/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6814929
@obs 

    Função GetAdvFVal
    Parâmetros
        + cKeyAlias     , Caractere        , Alias da Tabela
        + uCpo          , Indefinido       , Define o campo (caractere) ou os campos (array) a serem retornados
        + uChave        , Indefinido       , Define a chave de pesquisa da tabela conforme o índice
        + nOrder        , Numérico         , Define o índice para pesquisar na tabela
        + uDef          , Indefinido       , Define o campo (caractere) ou os campos (array) a serem retornados caso não encontre dados com a pesquisa
    Retorno
        Retorna um campo somente (se for caractere) ou vários campos (se for array)
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe263()
    Local aArea      := FWGetArea()
    Local aCampos    := {"A1_COD", "A1_NOME", "A1_MUN"}
    Local aBusca     := {}
    Local cChavePesq := FWxFilial("SA1") + "C00001"
    Local aDefault   := {"", "", ""}

    //Realiza a busca na SA1 conforme a chave passada
    aBusca := GetAdvFVal("SA1", aCampos, cChavePesq, 1, aDefault)

    //Mostra o que foi encontrado
    FWAlertInfo("Foi encontrado a seguinte informação, [1] = " + aBusca[1] + "; [2] = " + aBusca[2] + "; [3] = " + aBusca[3], "Teste GetAdvFVal")

    FWRestArea(aArea)
Return
