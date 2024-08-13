/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/09/busca-nomes-dos-campos-de-uma-tabela-com-a-tablefields-maratona-advpl-e-tl-467/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe466
Função para trazer a descrição de um registro de uma tabela genérica (SX5)
@type Function
@author Atilio
@since 02/04/2023
@obs 
    Tabela
    Parâmetros
        Nome da Tabela Genérica
        Chave da Tabela Genérica
        .T. se irá exibir mensagem de erro caso não encontre ou .F. se não
    Retorno
        Descrição do registro na SX5

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe466()
    Local aArea      := FWGetArea()
    Local cTpProd    := ""
    Local cDescTp    := ""

    //Efetua a busca na tabela genérica "02" com a chave "PI"
    cTpProd := "PI"
    cDescTp := Tabela("02", cTpProd, .F.)
    FWAlertInfo("O resultado é: " + cDescTp, "Teste 1 - Tabela")

    //Efetua a busca na tabela genérica "02" com a chave "XX" (que não existe)
    cTpProd := "XX"
    cDescTp := Tabela("02", cTpProd, .T.)
    If ! Empty(cDescTp)
        FWAlertInfo("O resultado é: " + cDescTp, "Teste 2 - Tabela")
    EndIf

    FWRestArea(aArea)
Return
