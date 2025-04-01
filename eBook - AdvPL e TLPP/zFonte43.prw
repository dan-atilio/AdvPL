/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFonte43
Trava uma tabela para atualizações de informações
@type Function
@author Atilio
@since 27/03/2023
/*/

User Function zFonte43()
    Local aArea    := FWGetArea()
    Local cCodProd := "F0001"
 
    DbSelectArea("SB1")
    SB1->(DbSetOrder(1)) // B1_FILIAL + B1_COD
 
    //Posiciona no produto
    If SB1->(MsSeek(FWxFilial("SB1") + cCodProd))
        RecLock("SB1", .F.)
            //SB1->B1_X_CAMPO := 'aaaa'
        SB1->(MsUnlock())
    EndIf
 
    FWRestArea(aArea)
Return
