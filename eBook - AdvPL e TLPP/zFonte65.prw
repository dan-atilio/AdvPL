/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFonte65
Exemplo de alteração de pedido de venda através de MsExecAuto
@type  Function
@author Atilio
@since 27/08/2024
/*/

User Function zFonte65()
    Local aArea         := FWGetArea()
    Local aCabec        := {}
    Local aItens        := {}
    Local cPedido       := "000012"
    Local nNovaQtde     := 0
    Private lMsErroAuto := .F.

    DbSelectArea("SC5")
    SC5->(DbSetOrder(1)) // C5_FILIAL + C5_NUM
    DbSelectArea("SC6")
    SC6->(DbSetOrder(1)) // C6_FILIAL + C6_NUM + C6_ITEM + C6_PRODUTO
    
    //Se conseguir posicionar no pedido
    If SC5->(MsSeek(FWxFilial("SC5") + cPedido))

        //Cabeçalho do pedido de vendas
        aCabec := {;
            {"C5_NUM"     , SC5->C5_NUM       , Nil},;
            {"C5_CLIENTE" , SC5->C5_CLIENTE   , Nil},;
            {"C5_LOJACLI" , SC5->C5_LOJACLI   , Nil},;
            {"C5_MENNOTA" , "alt: " + Time()  , Nil};
        }

        //Posiciona nos itens do pedido
        SC6->(MsSeek(SC5->C5_FILIAL + SC5->C5_NUM))
        While ! SC6->(EoF()) .And. SC6->C6_FILIAL == SC5->C5_FILIAL .And. SC6->C6_NUM == SC5->C5_NUM
            //Adiciona o básico que é a posição do item
            aGets := {}
            aAdd(aGets, {"LINPOS"      , "C6_ITEM"                            , SC6->C6_ITEM} )
            aAdd(aGets, {"C6_ITEM"     , SC6->C6_ITEM	                      , Nil} )

            //Se for o Item 02, vai alterar a quantidade
            If SC6->C6_ITEM == "02"
                nNovaQtde := 5
                aAdd(aGets, {"C6_QTDVEN"   , nNovaQtde                        , Nil} )
                aAdd(aGets, {"C6_VALOR "   , nNovaQtde * SC6->C6_PRCVEN       , Nil} )

            //Se for o Item 03, vamos excluir ele
            ElseIf SC6->C6_ITEM == "03"
                aAdd(aGets, {"AUTDELETA"   , "S"                              , Nil})
            EndIf
            
            //Adicionamos os campos no array de itens
            aAdd(aItens, aClone(aGets))

            SC6->(DbSkip())
        EndDo

        //Chama a alteração
        MSExecAuto({|x, y, z| Mata410(x, y, z) }, aCabec, aItens, 4)

        //Se houve erro, mostra a mensagem
        If lMsErroAuto
            MostraErro()
        Else
            FWAlertSuccess("Pedido " + SC5->C5_NUM + " alterado com sucesso!", "Atenção")
        EndIf
    EndIf

    FWRestArea(aArea)
Return
