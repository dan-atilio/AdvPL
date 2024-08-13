/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/22/buscando-informacoes-do-markbrowse-com-thisinv-e-thismark-maratona-advpl-e-tl-492/
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} User Function zExe492
Busca informações do MarkBrowse aberto (se esta invertido e qual é a marcação)
@type Function
@author Atilio
@since 04/04/2023
@obs 

    ThisInv
    Parâmetros
        Função não tem parâmetros
    Retorno
        Retorna se o MarkBrow esta invertido (.T.) ou não (.F.)

    ThisMark
    Parâmetros
        Função não tem parâmetros
    Retorno
        Retorna a string usada na marcação da coluna do MarkBrow

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe492()
    Local aArea      := FWGetArea()
    Local cSQL       := ""
    Local cMensagem  := ""
    Local cMascQtd   := PesqPict("SC9", "C9_QTDLIB")
    Local lContinua  := .T.
    Local cMarca     := ThisMark() 
    Local lInverte   := ThisInv()  
    
    //Criando a consulta
    cSQL += " SELECT " + CRLF
    cSQL += "  C9_PEDIDO AS PEDIDO, " + CRLF
    cSQL += "  C9_PRODUTO AS PRODUTO, " + CRLF
    cSQL += "  B1_DESC AS DESCRI, " + CRLF
    cSQL += "  C9_QTDLIB AS QUANTID, " + CRLF
    cSQL += "  B2_QATU AS SALDO " + CRLF
    cSQL += " FROM "+RetSQLName("SC9")+" SC9 " + CRLF
    cSQL += "   INNER JOIN "+RetSQLName("SC5")+" SC5 ON (" + CRLF
    cSQL += "       SC5.D_E_L_E_T_='' " + CRLF
    cSQL += "       AND C5_FILIAL = C9_FILIAL " + CRLF
    cSQL += "       AND C5_NUM = C9_PEDIDO " + CRLF
    cSQL += "   ) " + CRLF
    cSQL += "   INNER JOIN "+RetSQLName("SB1")+" SB1 ON ( " + CRLF
    cSQL += "		B1_FILIAL = '' " + CRLF
    cSQL += "		AND B1_COD = C9_PRODUTO " + CRLF
    cSQL += "		AND SB1.D_E_L_E_T_ = ' ' " + CRLF
    cSQL += "   ) " + CRLF
    cSQL += "   INNER JOIN "+RetSQLName("SB2")+" SB2 ON ( " + CRLF
    cSQL += "		B2_FILIAL = C9_FILIAL " + CRLF
    cSQL += "		AND B2_COD = C9_PRODUTO " + CRLF
    cSQL += "		AND B2_LOCAL = C9_LOCAL " + CRLF
    cSQL += "		AND SB2.D_E_L_E_T_ = ' ' " + CRLF
    cSQL += "   ) " + CRLF
    cSQL += "   INNER JOIN "+RetSQLName("SC6")+" SC6 ON ( " + CRLF
    cSQL += "		C6_FILIAL = C9_FILIAL " + CRLF
    cSQL += "		AND C6_NUM = C9_PEDIDO " + CRLF
    cSQL += "		AND C6_PRODUTO = C9_PRODUTO " + CRLF
    cSQL += "		AND C6_ITEM = C9_ITEM " + CRLF
    cSQL += "		AND SC6.D_E_L_E_T_ = ' ' " + CRLF
    cSQL += "   ) " + CRLF
    cSQL += "   INNER JOIN "+RetSQLName("SF4")+" SF4 ON ( " + CRLF
    cSQL += "		F4_FILIAL = '" + FWxFilial("SF4") + "' " + CRLF
    cSQL += "		AND F4_CODIGO = C6_TES " + CRLF
    cSQL += "		AND F4_ESTOQUE = 'S' " + CRLF
    cSQL += "		AND SF4.D_E_L_E_T_ = ' ' " + CRLF
    cSQL += "   ) " + CRLF
    cSQL += " WHERE SC9.D_E_L_E_T_ = ' ' " + CRLF
    cSQL += "  AND C9_FILIAL='"+FWxFilial("SC9")+"' " + CRLF
    cSQL += "  AND C9_OK"+Iif(lInverte, "<>", "=")+ "'"+cMarca+"' " + CRLF
    cSQL += "  AND C9_CLIENTE >= '" + MV_PAR07 + "' AND C9_CLIENTE <= '" + MV_PAR08 + "' " + CRLF
    cSQL += "  AND C9_LOJA >= '" + MV_PAR09 + "' AND C9_LOJA <= '" + MV_PAR10 + "' " + CRLF
    cSQL += "  AND C9_DATALIB >= '" + dToS(MV_PAR11) + "' AND C9_DATALIB <= '" + dToS(MV_PAR12) + "' " + CRLF
    cSQL += "  AND C9_PEDIDO >= '" + MV_PAR05 + "' AND C9_PEDIDO <= '" + MV_PAR06 + "' " + CRLF
    cSQL += "  AND C9_BLEST = '' AND C9_BLCRED = ''" + CRLF
    TCQuery cSQL New Alias "QRY_SC9"

    //Percorrendo os dados e incrementando a mensagem
    While ! QRY_SC9->(Eof())
            cMensagem += "* "
            cMensagem += "Pedido '" + QRY_SC9->PEDIDO + "', "
            cMensagem += "Produto '" + QRY_SC9->PRODUTO + "' (" + Left(QRY_SC9->DESCRI, 15) + "), "
            cMensagem += "Vendeu '" + Transform(QRY_SC9->QUANTID, cMascQtd) + "', tem saldo de '" + Transform(QRY_SC9->SALDO, cMascQtd) + "'"
            cMensagem += CRLF

        QRY_SC9->(DbSkip())
    EndDo
    QRY_SC9->(DbCloseArea())

    //Se existir mensagem, será exibida
    If ! Empty(cMensagem)
        cMensagem := "Produtos marcados: " + CRLF + CRLF + cMensagem
        ShowLog(cMensagem)
    EndIf

    FWRestArea(aArea)
Return lContinua
