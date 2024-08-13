/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/22/fazendo-backup-de-variaveis-internas-com-saveinter-e-restinter-maratona-advpl-e-tl-430/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe431
Exemplo para retornar o saldo do estoque de um produto de um lote específico
@type Function
@author Atilio
@since 30/03/2023
@obs 
    Função SB8Saldo
    Parâmetros
        Flag .T. ou .F. para considerar empenho
        Flag .T. ou .F. para considerar lotes vencidos
        Flag .T. ou .F. para considerar saldo a classificar
        Flag .T. ou .F. se deve calcular na segunda unidade de medida
        Alias que será considerado para buscar o lote
        Flag .T. ou .F. que indica se esta baixando empenho previsto
        Flag .T. ou .F. se é uma consulta de saldo
        Data de Referência para compor o Saldo
        Flag .T. ou .F. que indica se considera apenas o campo B8_SALDO
        Código da Ordem de Produção
    Retorno
        Retorna o Saldo encontrado no lote na SB8

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe431()
    Local aArea    := FWGetArea()
    Local lQtdPrev := .F.
    Local cQuery   := ""
    Local cCodProd := ""
    Local cLoteCtl := ""
    Local nSaldo   := 0

    //Pegando conteúdo do parâmetro
    lQtdPrev := GetMV("MV_QTDPREV") == "S"

    //Define o produto e o lote que serão buscados
    cCodProd := "A0002"
    cLoteCtl := "AUTO000001"
    
    //Criando a consulta que irá buscar os dados do Produto
    cQuery := " SELECT "
    cQuery += "     * "
    cQuery += " FROM "
    cQuery += "     " + RetSqlName('SB8') + " SB8 "
    cQuery += " WHERE "
    cQuery += "     B8_FILIAL = '" + FWxFilial('SB8') + "' "
    cQuery += "     AND B8_PRODUTO = '" + cCodProd + "' "
    cQuery += "     AND B8_LOTECTL = '" + cLoteCtl + "' "
    cQuery += "     AND SB8.D_E_L_E_T_ = ' ' "
    PLSQuery(cQuery, 'QRY_SB8')
    
    //Se houver dados da consulta
    If ! QRY_SB8->(EoF())
        
        //Percorre todas as linhas da query
        While ! QRY_SB8->(EoF())
            //Pega o saldo
            nSaldo += SB8Saldo(Nil, Nil, Nil, Nil, "QRY_SB8", lQtdPrev, .T.)
            
            QRY_SB8->(DbSkip())
        EndDo

        FWAlertInfo("O saldo encontrado foi de " + cValToChar(nSaldo), "Teste SB8Saldo")
    EndIf
    QRY_SB8->(DbCloseArea())

    FWRestArea(aArea)
Return
