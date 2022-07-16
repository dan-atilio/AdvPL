//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zVldData
Função para validar a data digitada nos campos
@type  Function
@author Atilio
@since 14/03/2022
@obs Colocar u_zVldData() na validação (X3_VLDUSER) dos campos
/*/

User Function zVldData()
    Local aArea      := GetArea()
    Local dDataCampo := &(ReadVar())
    Local dDataAtu   := Date()
    Local lRet       := .T.

    //Se a diferença passar de 1 ano, mostrar mensagem de falha
    If DateDiffYear(dDataAtu, dDataCampo) >= 1
        Help(, , "Help", , "Cadastro Inválido!", 1, 0, , , , , , {"A data informada passa de 1 ano!"})
        lRet := .F.
    EndIf

    RestArea(aArea)
Return lRet
