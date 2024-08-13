/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/19/buscando-dados-da-filial-com-a-funcao-finfo-maratona-advpl-e-tl-183/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe182
Retorna o nome de um campo de uma tabela, caso realmente exista
@type Function
@author Atilio
@since 21/12/2022
@obs 
    Função FinExtCpo
    Parâmetros
        + Tabela a ser verificada
        + Nome do campo a ser verificado
    Retorno
        + Conteúdo extraido do campo (caso o campo exista)

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe182()
    Local aArea     := FWGetArea()
    Local cDescri   := ""
    Local cCampo    := ""

    DbSelectArea("SB1")
    SB1->(DbSetOrder(1)) // B1_FILIAL + B1_COD

    //Busca o conteúdo dos campos
    cDescri := FinExtCpo("SB1", "B1_DESC"   )
    cCampo  := FinExtCpo("SB1", "B1_X_CAMPO")

    //Mostra a mensagem
    FWAlertInfo("Descricao: " + cDescri + "; Campo: " + cCampo, "Teste de FinExtCpo")

    FWRestArea(aArea)
Return
