/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2023/05/08/seek-nao-encontra-registro-mesmo-existindo-no-sql-ti-responde-055/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zVid0055
Função para demonstrar o posicionamento de registros com DbSeek / MsSeek
@type  Function
@author Atilio
@since 29/08/2022
/*/

User Function zVid0055()
    Local aArea   := FWGetArea()
    Local cFilSB1 := FWxFilial("SB1")
    Local cDescri := "Caneta Vermelha"
    Local cCodigo := "E0002"

    DbSelectArea("SB1")
    SB1->(DbSetOrder(3)) //B1_FILIAL + B1_DESC + B1_COD

    //Primeiro teste (que não irá encontrar o registro)
    If SB1->(MsSeek(Alltrim(cFilSB1) + cDescri + cCodigo))
        FwAlertInfo("Encontrou", "Teste 1")
    Else
        FwAlertInfo("Não encontrou", "Teste 1")
    EndIf

    //Segundo teste (que irá encontrar o registro)
    If SB1->(MsSeek(cFilSB1 + AvKey(cDescri, "B1_DESC") + AvKey(cCodigo, "B1_COD")))
        FwAlertInfo("Encontrou", "Teste 2")
    Else
        FwAlertInfo("Não encontrou", "Teste 2")
    EndIf

    FWRestArea(aArea)
Return
