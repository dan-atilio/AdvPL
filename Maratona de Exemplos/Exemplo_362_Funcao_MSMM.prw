/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/18/criando-grids-classicas-com-a-msnewgetdados-maratona-advpl-e-tl-363/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe362
Visualiza ou edita um campo memo do tipo antigo (tabelas SYP ou RDY)
@type Function
@author Atilio
@since 27/03/2023
@see https://tdn.totvs.com/display/public/framework/Msmm+-+Pesquisa+do+campo+MEMO+Virtual
@obs 
    Função MSMM
    Parâmetros
        + cChave      , Caractere      , Código da chave para busca
        + nTam        , Numérico       , Tamanho do campo controlado na SYP / RDY
        + nLin        , Numérico       , Linha do campo memo a ser retornada
        + cString     , Caractere      , Texto do campo memo
        + nOpc        , Numérico       , Opção a ser executada pela rotina (1 = incluir informação; 2=excluir conteúdo; 3=ler campo;)
        + nTamSize    , Numérico       , Quantidade de caracteres
        + lWrap       , Lógico         , Habilita quebra de linha
        + cAlias      , Caractere      , Alias da Tabela
        + cCpoChave   , Caractere      , Campos da Chave da Tabela na SYP
        + cRealAlias  , Caractere      , Alias da tabela MEMO (SYP / RDY)
        + lSoInclui   , Lógico         , Define se só irá realizar inclusão de informação
    Retorno
        + uRet        , Indefinido     , Se nOpc igual a 1 retorna conteudo do memo; Se igual a 2 retorna .T. ou .F. se conseguiu excluir; Se igual a 3 retorna a chave do código

    Obs.: Nesse exemplo foi usado a SB1, onde o campo REAL é o B1_CODOBS e o VIRTUAL é o B1_OBS

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe362()
    Local aArea         := FWGetArea()
    Local cCodigo       := "F0001"
    Local cObservacao   := ""
    Local nTamObserv    := TamSX3("B1_OBS")[1]
    
    //Abre o cadastro de produtos
    DbSelectArea("SB1")
    SB1->(DbSetOrder(1)) // Filial + Código

    //Posiciona em um produto
    If SB1->(MsSeek(FWxFilial("SB1") + cCodigo))

        //Busca a observação já gravada hoje
        cObservacao := MSMM(SB1->B1_CODOBS, nTamObserv)

        //Agora iremos definir algum texto qualquer, adicionando na observação
        cObservacao := Alltrim(cObservacao) + ";editado no dia " + dToC(Date()) + " as " + Time() + ";"

        //Por fim, iremos fazer a gravação desse conteúdo
        RecLock("SB1", .F.)
            MSMM(, nTamObserv, , cObservacao, 1, , , "SB1", "B1_CODOBS")
        SB1->(MsUnlock())
    EndIf

    FWRestArea(aArea)
Return
