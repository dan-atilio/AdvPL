/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/14/buscando-conteudos-da-sx5-com-as-funcoes-fdescsx5-e-sx5desc-maratona-advpl-e-tl-172/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe172
Função para trazer o conteúdo de campos da SX5
@type Function
@author Atilio
@since 20/12/2022
@obs 
    Função fDescSX5
    Parâmetros
        + 1 caso seja para acionar a descrição ou 2 para retornar o nome do campo da SX5 (portugues; espanhol; ingles)
    Retorno
        + Descrição do registro na SX5 (para correto funcionamento o registro deve estar posicionado na SX5)

    SX5Desc
    Parâmetros
        + Nome da Tabela Genérica
        + Chave da Tabela Genérica
    Retorno
        + Descrição do registro na SX5

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe172()
    Local aArea      := FWGetArea()
    Local cTpProd    := "PI"
    Local cDescTp    := ""
    Local cTpTitul   := "CD"
    Local cDescTitul := ""
    
    //Busca a descrição via fDescSX5
    DbSelectArea("SX5")
    SX5->(DbSetOrder(1)) // X5_FILIAL + X5_TABELA + X5_CHAVE
    If SX5->(MsSeek(FWxFilial("SX5") + "02" + cTpProd))
        cDescTp := fDescSX5(1)
        FWAlertInfo("A descrição do tipo de produto é '" + cDescTp + "'", "Teste fDescSX5")
    EndIf

    //Busca a descrição via SX5Desc
    cDescTitul := SX5Desc("05", cTpTitul)
    FWAlertInfo("A descrição do tipo de título é '" + cDescTitul + "'", "Teste com SX5Desc")

    FWRestArea(aArea)
Return
