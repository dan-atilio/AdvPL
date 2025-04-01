/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFonte40
Exemplo para percorrer as informações de uma tabela
@type Function
@author Atilio
@since 06/12/2022
@see https://tdn.totvs.com/display/tec/EOF
/*/

User Function zFonte40()
    Local aArea      := FWGetArea()
    Local nTot
    
    DbSelectArea('SB1')
    SB1->(DbSetOrder(1)) //B1_FILIAL + B1_COD

    //Posiciona no começo da tabela
    SB1->(DbGoTop())
    nTot := 0

    //Enquanto não estiver no fim da tabela
    While ! SB1->(EoF())
        nTot++
        
        SB1->(DbSkip())
    EndDo
    FWAlertInfo("Foram processados "+cValToChar(nTot)+" registros.", "Teste EoF")

    FWRestArea(aArea)
Return
