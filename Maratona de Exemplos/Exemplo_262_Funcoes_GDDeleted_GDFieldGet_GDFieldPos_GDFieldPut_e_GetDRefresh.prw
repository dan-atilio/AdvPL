/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/28/buscando-varias-informacoes-de-uma-tabela-com-getadvfval-maratona-advpl-e-tl-263/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe262
Funções para manipular as grids e atualizar objetos na tela
@type  Function
@author Atilio
@since 21/02/2023
@obs 

    Função GDDeleted
    Parâmetros
        + Número da linha do aCols
        + aHeader para validação (caso a tela tenha mais de uma grid)
        + aCols para validação (caso a tela tenha mais de uma grid)
    Retorno
        Retorna .T. se a linha esta apagada ou .F. se não

    Função GDFieldGet
    Parâmetros
        + Nome do campo
        + Número da linha do aCols
        + Se .T. busca conteúdo na memória senão se .F. busca do aCols (padrão é .F.)
        + aHeader para validação (caso a tela tenha mais de uma grid)
        + aCols para validação (caso a tela tenha mais de uma grid)
    Retorno
        Retorna o valor do campo digitado na grid

    Função GDFieldPos
    Parâmetros
        + Nome do campo
        + aHeader para validação (caso a tela tenha mais de uma grid)
    Retorno
        Retorna o número da coluna encontrada na grid

    Função GDFieldPut
    Parâmetros
        + Nome do campo
        + Conteúdo que será atribuído ao campo
        + Número da linha do aCols
        + aHeader para validação (caso a tela tenha mais de uma grid)
        + aCols para validação (caso a tela tenha mais de uma grid)
        + Define se irá buscar o valor da memória (.T.) ou do aCols (.F.)
    Retorno
        Retorna o valor antes da atribuição

    GetDRefresh
    Função não tem parâmetros nem retorno
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe262()
    Local aArea      := FWGetArea()
    Local nLinha     := 1
    Local nPosDatEnt := GDFieldPos("C6_ENTREG")
    Local cMensagem  := ""

    //Se a pergunta for confirmada
    If FWAlertYesNo("Confirma a alteração da Data de Entrega para Hoje (coluna " + cValToChar(nPosDatEnt) + ")?", "Continua")
        //Percorre as linhas digitadas na grida
        For nLinha := 1 To Len(aCols)

            //Se a linha atual não estiver apagada
            If ! GDDeleted(nLinha)
                //A operação abaixo de buscar com GDFieldGet, é o mesmo que: aCols[nLinha][nPosDatEnt]
                cMensagem += "Era " + dToC( GDFieldGet("C6_ENTREG", nLinha) ) + CRLF

                //A operação abaixo de atualizar com GDFieldPut, é o mesmo que: aCols[nLinha][nPosDatEnt] := Date()
                GDFieldPut("C6_ENTREG", Date(), nLinha)
            EndIf
        Next

        //Se tiver mensagem, exibe em tela
        If ! Empty(cMensagem)
            ShowLog(cMensagem)
        EndIf

        //Atualiza a tela
        GetDRefresh()
    EndIf

    FWRestArea(aArea)
Return

/*/{Protheus.doc} User Function A410CONS
Ponto de Entrada para adicionar botões no Outras Ações dentro do Pedido de Venda
@type  Function
@author Atilio
@since 21/02/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6784033
/*/

User Function A410CONS()
    Local aArea   := FWGetArea()
    Local aBotoes := {}

    aAdd(aBotoes, {'DBG07', {|| u_zExe262()}, "* Atualizar Data de Entrega","* Entrega"} )

    FWRestArea(aArea)
Return aBotoes
