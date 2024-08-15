/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2022/12/26/acionar-o-f4-do-produto-em-uma-customizacao-ti-responde-036/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zVid0036
Função para abrir a tela do "F4" do Produto
@type  Function
@author Atilio
@since 10/05/2022
/*/

User Function zVid0036(cCodProd)
    Local aArea    := FWGetArea()
    Default cCodProd := ""

    DbSelectArea('SB1')
    SB1->(DbSetOrder(1)) // B1_FILIAL + B1_COD

    //Se conseguir posicionar no produto
    If SB1->(DbSeek(FWxFilial('SB1') + cCodProd))
        MaViewSB2(SB1->B1_COD)
    EndIf

    FWRestArea(aArea)
Return
