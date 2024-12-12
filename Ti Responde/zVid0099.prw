/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2024/11/14/diferencas-entre-dbstruct-e-metodos-da-fwsx3util-ti-responde-0099/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zVid0099
Exemplo de comparação entre DbStruct e FWSX3Util (por causa do X3_ORDEM)
@type  Function
@author Atilio
@since 01/03/2024
/*/

User Function zVid0099()
    Local aArea     := FWGetArea()
    Local aEstruSB1 := {}
    Local aSX3daSB1 := {}
    Local cMensagem := ""

    //Abre a tabela de produtos e busca todos os campos
    DbSelectArea("SB1")
    aEstruSB1 := SB1->(DbStruct())
    aSX3daSB1 := FWSX3Util():GetAllFields("SB1", .F. /*lVirtual*/)

    //Exibe uma mensagem com a quantidade em comparação
    cMensagem := FormatStr("Com DbStruct: %n , com FWSX3Util %n", {Len(aEstruSB1), Len(aSX3daSB1)})
    FWAlertInfo(cMensagem, "Comparação")

    FWRestArea(aArea)
Return
