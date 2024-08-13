/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/21/buscando-o-saldo-de-um-produto-com-a-saldosb2-maratona-advpl-e-tl-428/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe428
Exemplo para retornar o saldo do estoque de um produto
@type Function
@author Atilio
@since 29/03/2023
@obs 
    Função SaldoSB2
    Parâmetros
        Se .T. efetua o cálculo real com as reservas do estoque para encontrar a necessidade
        Se .T. indica se irá subtrair os empenhos
        Data final para considerar os empenhos da SD4
        Se .T. indica se deve considerar saldos de terceiros (B2_QTNP)
        Se .T. indica se deve considerar saldos em terceiros (B2_QNTP)
        Alias que será usada no lugar da SB2 (se for vir de uma query por exemplo)
        Quantidade de Empenho que não deve ser subtraída
        Quantidade empenhada de Projetos que não deve ser subtraída
        Se .T. indica se deve subtrair a reserva do Saldo a ser retornado
        Data limite para composição do saldo (quando MV_TPSALDO é igual a "C")
        Subtrai a quantidade prevista no saldo a ser retornado (quando MV_TPSALDO é igual a "C")
    Retorno
        Retorna o Saldo Atual encontrado na SB2

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe428()
    Local aArea    := FWGetArea()
    Local cProduto := ""
    Local cArmazem := ""
    Local nSaldo   := 0

    //Define os parâmetros que serão usados para pesquisar o saldo
    cProduto := AvKey("F0001", "B1_COD")
    cArmazem := "01"

    //Abre a tabela de produtos
    DbSelectArea("SB2")
    SB2->(DbSetOrder(1)) // B2_FILIAL + B2_COD + B2_LOCAL

    //Posiciona na tabela de saldos
    If SB2->(MsSeek(FWxFilial("SB2") + cProduto + cArmazem))

        //Busca o saldo atual
        nSaldo := SaldoSB2()
        FWAlertInfo("Saldo atual é de: " + cValToChar(nSaldo), "Teste SaldoSB2")
    EndIf

    FWRestArea(aArea)
Return
