/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/01/somando-informacoes-de-uma-tabela-atraves-da-somar-maratona-advpl-e-tl-451/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe451
Realiza a soma de informações de uma tabela
@type Function
@author Atilio
@since 31/03/2023
@obs 

    Função Somar
    Parâmetros
        + Alias da Tabela
        + Condição que será avaliada para efetuar a soma
        + Campo ou expressão que será somado para retornar
    Retorno
        + Retorna a soma conforme condição e campo (ou expressão)

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe451()
    Local aArea     := FWGetArea()
    Local cTabela   := ""
    Local cCondicao := ""
    Local cCampo    := ""
    Local nTotal    := 0

    //Define a tabela, condição e o campo a ser somado
    cTabela   := "SB2"
    cCondicao := "SB2->B2_LOCAL == '01' .And. Left(SB2->B2_COD, 1) == 'F'"
    cCampo    := "SB2->B2_QATU"
    nTotal    := Somar(cTabela, cCondicao, cCampo)

    //Mostra uma mensagem com o resultado
    FWAlertInfo("O resultado é " + cValToChar(nTotal), "Teste Somar")

    FWRestArea(aArea)
Return
