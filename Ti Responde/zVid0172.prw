/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/07/29/solicitar-um-motivo-na-exclusao-de-nf-de-saida-atraves-do-p-e-sf2520e-ti-responde-0172/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function SF2520E
Ponto de entrada na Exclusão do Documento de Saída
@type  Function
@author Atilio
@since 17/06/2024
@see https://centraldeatendimento.totvs.com/hc/pt-br/articles/360018257391-Cross-Segmento-Backoffice-Linha-Protheus-ADVPL-Ponto-de-entrada-SF2520E
@obs O campo F2_X_MTCAN pode ser criado como Caractere tamanho 100
/*/

User Function SF2520E()
    Local aArea      := FWGetArea()
    Local aAreaSF2   := SF2->(FWGetArea())
    Local aPergs     := {}
    Local cMotivCan  := Space(100)
    Local aBackupPar := {}
    Local lGravou    := .F.
    
    //Faz backup dos parâmetros
    aBackupPar := NgSalvaMvPa()

    //Adiciona os parâmetros
    aAdd(aPergs, {1, "Motivo Cancelamento",  cMotivCan,  "", ".T.", "", ".T.", 100,  .T.})

    //Enquanto não gravou
    While ! lGravou
    
        //Exibe a pergunta
        If ParamBox(aPergs, "Informe os parâmetros", /*aRet*/, /*bOk*/, /*aButtons*/, /*lCentered*/, /*nPosx*/, /*nPosy*/, /*oDlgWizard*/, /*cLoad*/, .F., .F.)
            
            //Atualiza o motivo de cancelamento
            RecLock("SF2", .F.)
                SF2->F2_X_MTCAN := MV_PAR01
            SF2->(MsUnlock())

            lGravou := .T.
        EndIf
    EndDo

    //Volta backup dos parâmetros
    NgRetAuMVPa(aBackupPar)
    
    FWRestArea(aAreaSF2)
    FWRestArea(aArea)
Return      


