/*
    
    Esse � um exemplo disponibilizado no Terminal de Informa��o 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/08/12/criando-um-campo-editavel-apenas-por-usuarios-de-um-determinado-grupo-ti-responde-0176/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zVid0176
Fun��o para que s� permita editar campos caso o usu�rio esteja num determinado grupo
@type  Function
@author Atilio
@since 03/07/2024
@example u_zVid0176()
@obs Deve ser colocado no X3_WHEN (modo de edi��o) da seguinte forma:
    Iif(ExistBlock("zVid0176"), u_zVid0176(), .F.)
/*/

User Function zVid0176()
    Local aArea       := FWGetArea()
    Local cGrpsPodem  := SuperGetMV("MV_X_GRTST", .F., "000001;000004;")
    Local cCodUsr     := RetCodUsr()
    Local aGrpsUsr    := FWSFUsrGrps(cCodUsr) //a FWSFUsrGrps � uma forma mais nova de usar a antiga UsrRetGrp
    Local lPodeEdit   := .F.
    Local nGrpAtu     := 0

    //Percorre os grupos
    For nGrpAtu := 1 To Len(aGrpsUsr)
    
        //Se for o grupo atual, estiver nos grupos que podem editar, altera a flag e encerra o la�o
        If aGrpsUsr[nGrpAtu] $ cGrpsPodem
            lPodeEdit := .T.
            Exit
        EndIf

    Next

    FWRestArea(aArea)
Return lPodeEdit
