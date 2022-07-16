//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zVid0028
Função para criar uma pasta padrão de impressora
@type  Function
@author Atilio
@since 19/04/2022
@obs Acionar essa função dentro do P.E. AfterLogin ou ChkExec
/*/

User Function zVid0028()
    Local aArea  := FWGetArea()
    Local cPasta := "C:\spool\"

    //Se a pasta não existir, irá criar
    If ! ExistDir(cPasta)
        MakeDir(cPasta)
    EndIf

    FWRestArea(aArea)
Return
