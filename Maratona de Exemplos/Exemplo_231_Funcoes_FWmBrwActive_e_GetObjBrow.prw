/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/12/interceptando-o-browse-com-fwmbrwactive-e-getobjbrow-maratona-advpl-e-tl-231/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe231
Intercepta o browse aberto em memória
@type Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/display/public/framework/FWmBrwActive
@obs 

    Função FWmBrwActive
    Parâmetros
        Função não tem parâmetros
    Retorno
        Retorna o objeto do browse (FWmBrowse)

    Função GetObjBrow
    Parâmetros
        Função não tem parâmetros
    Retorno
        Retorna o objeto do browse (mBrowse)

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe231()
    Local aArea     := FWGetArea()
    Local oBrowse   := Nil
    Local nColunas  := 0

    //Se a última tabela aberta for a de Fornecedor e vier da rotina MATA020
    If aArea[1] == 'SA2' .And. FWIsInCallStack("MATA020")
        //Intercepta o Browse - similar a antiga GetObjBrow()
        //oBrowseAnt := GetObjBrow()
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

/*/{Protheus.doc} User Function MBlkColor
Altera a cor da linha bloqueada
@type  Function
@author Atilio
@since 20/02/2023
@see http://tdn.totvs.com/display/public/mp/MBlkColor+-+Retorna+cores+a+utilizar
/*/

User Function MBlkColor()
    u_zExe231()
Return
