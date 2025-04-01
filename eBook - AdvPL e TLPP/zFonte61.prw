/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFonte61
Exemplo de inclusão de produto através de MsExecAuto
@type  Function
@author Atilio
@since 20/08/2024
/*/

User Function zFonte61()
    Local aArea     := FWGetArea()
    Local aDados    := {}
    Local aPergs    := {}
    Local cCodProd  := Space(TamSX3("B1_COD")[01])
    Local cDesProd  := Space(TamSX3("B1_DESC")[01])
    Local cTipProd  := Space(TamSX3("B1_TIPO")[01])
    Local cUniProd  := Space(TamSX3("B1_UM")[01])
    Local cArmProd  := Space(TamSX3("B1_LOCPAD")[01])
    Local cGrpProd  := Space(TamSX3("B1_GRUPO")[01])
    Private lMsErroAuto := .F.
    
    //Adiciona os parâmetros para exibir no ParamBox
    aAdd(aPergs, {1, "Produto",   cCodProd,  "", ".T.", "",    ".T.", 070,  .T.})
    aAdd(aPergs, {1, "Descrição", cDesProd,  "", ".T.", "",    ".T.", 100,  .T.})
    aAdd(aPergs, {1, "Tipo",      cTipProd,  "", ".T.", "02",  ".T.", 040,  .T.})
    aAdd(aPergs, {1, "U.M.",      cUniProd,  "", ".T.", "SAH", ".T.", 040,  .T.})
    aAdd(aPergs, {1, "Armazém",   cArmProd,  "", ".T.", "NNR", ".T.", 040,  .T.})
    aAdd(aPergs, {1, "Grupo",     cGrpProd,  "", ".T.", "SBM", ".T.", 060,  .T.})

    //Se a pergunta for confirmada
    If ParamBox(aPergs, "Informe os parâmetros", /*aRet*/, /*bOk*/, /*aButtons*/, /*lCentered*/, /*nPosx*/, /*nPosy*/, /*oDlgWizard*/, /*cLoad*/, .F., .F.)

        //Adiciona os campos
        aAdd(aDados, {"B1_COD",    MV_PAR01, Nil})
        aAdd(aDados, {"B1_DESC",   MV_PAR02, Nil})
        aAdd(aDados, {"B1_TIPO",   MV_PAR03, Nil})
        aAdd(aDados, {"B1_UM",     MV_PAR04, Nil})
        aAdd(aDados, {"B1_LOCPAD", MV_PAR05, Nil})
        aAdd(aDados, {"B1_GRUPO",  MV_PAR06, Nil})

        //Chama a inclusão
        MsExecAuto({|x, y| MATA010(x, y)}, aDados, 3)

        //Se houve erro, mostra a mensagem
        If lMsErroAuto
            MostraErro()
        Else
            FWAlertSuccess("Produto " + SB1->B1_COD + " incluído com sucesso!", "Atenção")
        EndIf
    EndIf

    FWRestArea(aArea)
Return
