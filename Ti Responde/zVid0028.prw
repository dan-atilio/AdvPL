/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2022/10/31/configurar-uma-pasta-de-impressoras-automaticamente-ti-responde-028/ 
    
*/


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
