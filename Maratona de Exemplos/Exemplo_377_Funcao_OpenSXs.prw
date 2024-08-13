/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/25/realizando-a-troca-de-empresa-e-filial-com-a-openfile-maratona-advpl-e-tl-376/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe377
Realiza a abertura de alguma tabela do dicionário em um alias definido em uma variável
@type Function
@author Atilio
@since 28/03/2023
@obs 

    Função OpenSXs
    Parâmetros
        + Objeto que será atualizado enquanto é realizado a abertura da tabela
        + Objeto (arquivo) que será atualizado enquanto é realizado a abertura da tabela
        + Define se o processo poderá ser cancelado caso seja uma régua no objeto
        + Compatibilidade
        + Código da empresa
        + Nome do Alias que será usado
        + Nome da Tabela do dicionário
        + Objeto do tipo régua que será usado na tela
        + Define se será encerrado o processo caso não seja encontrado a tabela do dicionário
    Retorno
        Função não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe377()
    Local aArea      := FWGetArea()
    Local cEmpresa   := ""
    Local cAliasSX   := ""
    Local cFiltro    := ""
    Local cMensagem  := ""
    
    //Define a empresa que vou buscar, o nome do alias que vou usar e o filtro que será aplicado
    cEmpresa := "99"
    cAliasSX := "SX3TST"
    cFiltro  := "X3_ARQUIVO $ 'SA1;SA2;' .And. Alltrim(X3_TIPO) == 'D'"

    //Faz a abertura da tabela do dicionário no alias que foi definido
    OpenSXs(NIL, NIL, NIL, NIL, cEmpresa, cAliasSX, "SX3", NIL, .F.)

    //Aplica o filtro no alias e posiciona no topo
    (cAliasSX)->(DbSetFilter({|| &(cFiltro)}, cFiltro))
    (cAliasSX)->(DbGoTop())

    //Percorre os dados e incrementa a mensagem
    While ! (cAliasSX)->(EoF())
        cMensagem += "+ " + (cAliasSX)->X3_CAMPO + " (" + (cAliasSX)->X3_TITULO + ")" + CRLF

        (cAliasSX)->(DbSkip())
    EndDo
    (cAliasSX)->(DbCloseArea())

    //Exibe a mensagem em tela
    cMensagem := "Campos do Tipo Data que foram encontrados: " + CRLF + cMensagem
    ShowLog(cMensagem)

    FWRestArea(aArea)
Return
