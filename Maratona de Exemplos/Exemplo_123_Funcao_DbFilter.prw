/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/12/09/pegando-o-filtro-aplicado-em-um-alias-com-dbfilter-maratona-advpl-e-tl-123/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe123
Retorna o filtro aplicado em um alias
@type Function
@author Atilio
@since 14/12/2022
@see https://tdn.totvs.com/display/tec/DBFilter
@obs 

    Função DbFilter
    Parâmetros
        Não tem parâmetros
    Retorno
        + cExp        , Caractere        , Expressão do filtro na tabela

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe123()
    Local aArea      := FWGetArea()
    Local cFiltro    := ""
    Local cFiltroBus := ""

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

    //Busca agora o filtro aplicado na tabela e exibe em tela
    cFiltroBus := SA1->(DbFilter())
    FWAlertInfo("Filtro aplicado: " + cFiltroBus, "Teste DbFilter")

    FWRestArea(aArea)
Return
