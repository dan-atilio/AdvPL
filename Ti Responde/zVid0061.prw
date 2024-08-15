/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2023/06/19/adicionar-legenda-numa-tela-sem-pe-ti-responde-061/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function MBlkColor
Altera a cor da linha bloqueada
@type  Function
@author Atilio
@since 27/04/2022
@see http://tdn.totvs.com/display/public/mp/MBlkColor+-+Retorna+cores+a+utilizar
/*/

User Function MBlkColor()
	Local aArea     := FWGetArea()
    Local oBrowse   := Nil
    Local nColunas  := 0

    //Se a última tabela aberta for a de Fornecedor e vier da rotina MATA020
    If aArea[1] == 'SA2' .And. FWIsInCallStack("MATA020")
        //Intercepta o Browse - similar a antiga GetObjBrow()
        oBrowse := FWmBrwActive()
        
        //Se o Browse já estiver na memória
        If ValType(oBrowse) == "O"
            //Se não tiver legendas, irá adicionar
            If Len(oBrowse:aLegends) == 0
                oBrowse:AddLegend( "SA2->A2_TIPO == 'F'", "WHITE",  "Fisico" )
                oBrowse:AddLegend( "SA2->A2_TIPO == 'J'", "BLACK",  "Juridico" )
                oBrowse:AddLegend( "SA2->A2_TIPO == 'X'", "RED",   	"Outros" )

                //Pega o total de colunas, insere um elemento, e fala que será na posição 1
                nColunas := Len(oBrowse:aColumns)
                aSize(oBrowse:aColumns, nColunas + 1)
                aIns(oBrowse:aColumns, 1)

                //Copia a última posição (que é a legenda) para a primeira, e depois exclui ela do final
                oBrowse:aColumns[1] := oBrowse:aColumns[nColunas + 1]
                aDel(oBrowse:aColumns, nColunas + 1)
                aSize(oBrowse:aColumns, nColunas)
            EndIf
        EndIf
    EndIf

    FWRestArea(aArea)
Return
