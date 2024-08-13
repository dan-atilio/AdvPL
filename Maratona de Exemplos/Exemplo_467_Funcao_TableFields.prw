/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/09/buscando-informacoes-da-tabela-generica-com-a-funcao-tabela-maratona-advpl-e-tl-466/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe467
Busca o nome dos campos de uma tabela
@type Function
@author Atilio
@since 02/04/2023
@obs 
    Tabela
    Parâmetros
        Alias da Tabela
        0 se é pro retorno ser um array ou 1 se é pra ser caractere
        Texto de separação caso seja 1 (caractere)
        Bloco de código a ser avaliado para considerar o campo
    Retorno
        Retorna os campos em um array ou string conforme os parâmetros informados

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe467()
    Local aArea       := FWGetArea()
    Local aCampos     := {}
    Local cCampos     := ""
    Local cCamposPipe := ""
    Local aCamposFilt := {}

    //Efetua as buscas dos campos
    aCampos     := TableFields("SB1", 0)
    cCampos     := TableFields("SB1", 1)
    cCamposPipe := TableFields("SB1", 1, "|")
    aCamposFilt := TableFields("SB1", 0, , {|cField| "_X_" $ cField})
    FWAlertInfo("Busca dos campos com pipe: " + cCamposPipe, "Teste TableFields")

    FWRestArea(aArea)
Return
