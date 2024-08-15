/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2023/06/05/execauto-de-estorno-na-mata241-ti-responde-059/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zVid0059
Exemplo de estorno / exclusão via ExecAuto da MATA241
@type  Function
@author Atilio
@since 29/08/2022
/*/

User Function zVid0059()
    Local aArea      := FWGetArea()
    Local cDocumento := Space(TamSX3("D3_DOC")[1])
    Local aPergs     := {}

    //Adiciona a pergunta e mostra a pergunta
    aAdd(aPergs, {1, "Documento SD3", cDocumento, "", ".T.", "", ".T.", 90, .T.})
    If ParamBox(aPergs, "Informe os parâmetros", , , , , , , , , .F., .F.)
        Processa({|| fEstornar(MV_PAR01)}, "Estornando...")
    EndIf

    FWRestArea(aArea)
Return

Static Function fEstornar(cDocumento)
    Local aArea    := FWGetArea()
    Local aAreaSD3
    Local aCab     := {}
    Local aItens   := {}
    Local aItem    := {}
    Local cChave   := ""
    Private lMsErroAuto := .F.

    //Abre a tabela de movimentações, e se conseguir posicionar no documento
    DbSelectArea("SD3")
    SD3->(DbSetOrder(2)) // D3_FILIAL + D3_DOC + D3_COD
    If SD3->(MsSeek(FWxFilial('SD3') + cDocumento))
        aAreaSD3 := SD3->(FWGetArea())
        cChave   := SD3->D3_FILIAL + SD3->D3_DOC

        //Adiciona no cabeçalho as chaves da tabela
        aCab := {;
            {"D3_DOC", SD3->D3_DOC, Nil};
        }

        //Enquanto houver dados que for o mesmo documento, adiciona no array de itens
        ProcRegua(0)
        While ! SD3->(EoF()) .And. SD3->D3_FILIAL + SD3->D3_DOC == cChave
            IncProc("Adicionando produto " + Alltrim(SD3->D3_COD) + "...")

            aItem := {}
            aAdd(aItem, {"D3_COD",     SD3->D3_COD,   Nil})
            aAdd(aItem, {"D3_UM",      SD3->D3_UM,    Nil})
            aAdd(aItem, {"D3_QUANT",   SD3->D3_QUANT, Nil})
            aAdd(aItem, {"D3_LOCAL",   SD3->D3_LOCAL, Nil})
            aAdd(aItem, {"D3_ESTORNO", "S",           Nil})
            aAdd(aItens, aClone(aItem))

            SD3->(DbSkip())
        EndDo

        //Volta onde estava na SD3
        FWRestArea(aAreaSD3)

        //Aciona o ExecAuto
        MsExecAuto({|x, y, z| MATA241(x, y, z)}, aCab, aItens, 6)

        //Se houve erro, exibe
        If lMsErroAuto
            MostraErro()
        Else
            FWAlertSuccess("Documento foi estornado com sucesso!", "Atenção")
        EndIf

    Else
        FWAlertError("Documento não foi encontrado!", "Atenção")
    EndIf

    FWRestArea(aArea)
Return
