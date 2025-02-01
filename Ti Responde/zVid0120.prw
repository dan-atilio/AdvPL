/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/01/28/gatilho-em-um-pergunte-ti-responde-0120/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zVid0120
Função criada para ser acionada na validação dos parâmetros de Data no relatório MATR120
@type  Function
@author Atilio
@since 13/03/2024
@obs Editar o X1_VALID colocando u_zVid0120() dos parâmetros 03 e 04 do grupo MTR120
/*/

User Function zVid0120()
    Local aArea       := FWGetArea()
    Local dDtEmisDe   := MV_PAR03
    Local dDtEmisAte  := MV_PAR04
    Local lContinua   := .T.

    //Atualiza os parâmetros de data de entrega conforme a emissão que foi digitada
    MV_PAR05 := MonthSum(dDtEmisDe,  2)
    MV_PAR06 := MonthSum(dDtEmisAte, 5)

    FWRestArea(aArea)
Return lContinua
