/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2024/10/01/filtrar-um-browse-atraves-de-atalho-via-advpl/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function MT120BRW
Ponto de entrada para adicionar outras opções no menu do Pedido de Compras
@type  Function
@author Atilio
@since 26/01/2024
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6085467
/*/

User Function MT120BRW()
    Local aArea := FWGetArea()

    //Adiciona atalho para filtrar o browse
    SetKey(VK_F7, {|| u_zVid0086()})

    FWRestArea(aArea)
Return

/*/{Protheus.doc} zVid0086
Função para abrir uma tela de filtro para escolher o fornecedor
@type user function
@author Atilio
@since 26/01/2024
/*/

User Function zVid0086()
    Local lOk     := .F.
    Local cQry    := ""
    Local cFiltro := "1 == 1" 
    Local oBrowse

    //Somente se não tiver dentro da tela de pedido
    If ! FWIsInCallStack("A120Pedido")

        //Monta a busca de fornecedores que não estão bloqueados
        cQry += " SELECT " + CRLF
        cQry += "     A2_COD, " + CRLF
        cQry += "     A2_NOME, " + CRLF
        cQry += "     A2_NREDUZ, " + CRLF
        cQry += "     A2_CGC " + CRLF
        cQry += " FROM " + CRLF
        cQry += "     " + RetSQLName("SA2") + " SA2 " + CRLF
        cQry += " WHERE " + CRLF
        cQry += "     A2_FILIAL = '" + FWxFilial("SA2") + "' " + CRLF
        cQry += "     AND A2_MSBLQL != '1' " + CRLF
        cQry += "     AND SA2.D_E_L_E_T_ = ' ' " + CRLF

        //Chama a tela, pesquisando fornecedores
        lOk := u_zConsSQL(cQry, "A2_COD", "", "A2_COD")

        //Se a tela foi confirmada
        If lOk
            //Se tem fornecedor escolhido, filtra o browse
            If ! Empty(__cRetorno)
                cFiltro := " C7_FORNECE == '" + __cRetorno + "' "
            EndIf
        EndIf

    EndIf

    //Atualizando a grid do browse
    oBrowse := GetObjBrow()
    oBrowse:CleanFilter()
    oBrowse:SetFilterDefault(cFiltro)
    oBrowse:Refresh()
Return
