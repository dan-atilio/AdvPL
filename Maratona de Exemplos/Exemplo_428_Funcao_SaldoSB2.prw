/*
    Esse exemplo faz parte da s�rie do YouTube, Maratona de Exemplos, do canal Terminal de Informa��o, 
    caso queira ver esse exemplo rodando em v�deo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/21/buscando-o-saldo-de-um-produto-com-a-saldosb2-maratona-advpl-e-tl-428/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe428
Exemplo para retornar o saldo do estoque de um produto
@type Function
@author Atilio
@since 29/03/2023
@obs 
    Fun��o SaldoSB2
    Par�metros
        Se .T. efetua o c�lculo real com as reservas do estoque para encontrar a necessidade
        Se .T. indica se ir� subtrair os empenhos
        Data final para considerar os empenhos da SD4
        Se .T. indica se deve considerar saldos de terceiros (B2_QTNP)
        Se .T. indica se deve considerar saldos em terceiros (B2_QNTP)
        Alias que ser� usada no lugar da SB2 (se for vir de uma query por exemplo)
        Quantidade de Empenho que n�o deve ser subtra�da
        Quantidade empenhada de Projetos que n�o deve ser subtra�da
        Se .T. indica se deve subtrair a reserva do Saldo a ser retornado
        Data limite para composi��o do saldo (quando MV_TPSALDO � igual a "C")
        Subtrai a quantidade prevista no saldo a ser retornado (quando MV_TPSALDO � igual a "C")
    Retorno
        Retorna o Saldo Atual encontrado na SB2

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe428()
    Local aArea    := FWGetArea()
    Local cProduto := ""
    Local cArmazem := ""
    Local nSaldo   := 0

    //Define os par�metros que ser�o usados para pesquisar o saldo
    cProduto := AvKey("F0001", "B1_COD")
    cArmazem := "01"

    //Abre a tabela de produtos
    DbSelectArea("SB2")
    SB2->(DbSetOrder(1)) // B2_FILIAL + B2_COD + B2_LOCAL

    //Posiciona na tabela de saldos
    If SB2->(MsSeek(FWxFilial("SB2") + cProduto + cArmazem))

        //Busca o saldo atual
        nSaldo := SaldoSB2()
        FWAlertInfo("Saldo atual � de: " + cValToChar(nSaldo), "Teste SaldoSB2")
    EndIf

    FWRestArea(aArea)
Return
