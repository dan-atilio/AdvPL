/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/11/06/contando-registros-de-um-alias-com-a-funcao-contar-maratona-advpl-e-tl-090/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe090
Exemplo de função que conta os registros de uma tabela com a possibilidade de testar com uma condição
@type Function
@author Atilio
@since 09/12/2022
@obs 
    Função Contar
    Parâmetros
        + Informa o alias aberto que será feito a contagem
        + Informa a condição a ser validada (é obrigatório informar algo)
    Retorno
        + Retorna quantos registros encontrou

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe090()
    Local aArea     := FWGetArea()
    Local nTotal    := 0

    DbSelectArea("SB1")
    SB1->(DbSetOrder(1)) // Filial + Código

    //Conta todos os registros do cadastro de produtos
    nTotal := Contar("SB1", ".T.")
    FWAlertInfo("Existe(m) " + cValToChar(nTotal) + " registro(s) na tabela SB1", "Exemplo 1 - Contar")

    //Conta os registros do cadastro de produtos conforme um determinado filtro
    nTotal := Contar("SB1", "SB1->B1_TIPO == 'PA' .And. SB1->B1_UM == 'KG'")
    FWAlertInfo("Existe(m) " + cValToChar(nTotal) + " registro(s) na tabela SB1 conforme filtro passado", "Exemplo 2 - Contar")

    FWRestArea(aArea)
Return
