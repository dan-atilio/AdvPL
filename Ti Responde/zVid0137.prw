/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/03/27/como-liberar-ou-bloquear-edicao-de-campos-no-cabecalho-da-classificacao-de-uma-nf-ti-responde-0137/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function MT103CWH
Ponto de Entrada que permite liberar a edição de campos no cabeçalho do Documento de Entrada
@type  Function
@author Atilio
@since 13/03/2024
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6085804
/*/

User Function MT103CWH()
    Local aArea    := FWGetArea()
    Local xRetorno := Nil
    Local cCampo   := Alltrim(ParamIXB[1])
    Local lClassif := ParamIXB[3]

    //Se é uma classificação
    If lClassif
        
        //Se for os campo de Emissão vai permitir a alteração
        If cCampo $ "F1_EMISSAO;"
            xRetorno := .T.

        //Se for o campo Espécie, vai bloquear a alteração
        ElseIf cCampo $ "F1_ESPECIE;"
            xRetorno := .F.
        EndIf

    EndIf

    FWRestArea(aArea)
Return xRetorno
