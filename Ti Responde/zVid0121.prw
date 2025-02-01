/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/01/30/como-trocar-um-icone-de-legenda-de-uma-rotina-do-protheus-ti-responde-0121/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} FINALEG
Ponto de Entrada na manipulação de legendas do financeiro
@type user function
@author Atilio
@since 30/01/2024
@see https://tdn.totvs.com/display/public/PROT/FINALEG+-+Manipula+legendas+financeiro
/*/

User Function FINALEG()
    Local aArea     := FWGetArea()
    Local cTabela   := ParamIXB[2]
    Local aRegras   := ParamIXB[3]
    Local aLegendas := ParamIXB[4]
    Local cProcura  := "BR_BRANCO"
    Local cSubstit  := "BPMSTSK2A"
    Local nPosicao  := 0

    //Se for o Contas a Pagar
    If cTabela == "SE2"
        //Se tiver regras
        If Len(aRegras) > 0
            //Procura pela cor Branca
            nPosicao := aScan(aRegras, {|x| Alltrim(x[2]) == cProcura})

            //Se encontrou, substitui o ícone
            If nPosicao > 0
                aRegras[nPosicao][2] := cSubstit
            EndIf
        EndIf

        //Se tiver legendas
        If Len(aLegendas) > 0
            //Procura pela cor Branca
            nPosicao := aScan(aLegendas, {|x| Alltrim(x[1]) == cProcura})

            //Se encontrou, substitui o ícone
            If nPosicao > 0
                aLegendas[nPosicao][1] := cSubstit
            EndIf

            //Aciona a tela para visualizar as legendas
            BrwLegenda(cCadastro, "Legenda", aLegendas)
        EndIf

    //Senão, se for Contas a Receber
    Else
        //Aciona a tela para visualizar as legendas
        BrwLegenda(cCadastro, "Legenda", aLegendas)
    EndIf

    FWRestArea(aArea)
Return aRegras
