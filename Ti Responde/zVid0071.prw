/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2024/08/08/como-bloquear-remover-uma-opcao-do-menu-via-ponto-de-entrada-ti-responde-0071/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function F750BROW
Ponto de entrada logo após montar a variável private aRotina
@type  Function
@author Atilio
@since 15/11/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6071090
/*/

User Function F750BROW()
	Local aArea     := FWGetArea()
    Local cPesqSub  := "BAIXA MANUAL"
    Local cPesqItem := "CANC BAIXA"
    Local nPosSub   := 0
    Local nPosItem  := 0
    Local aSubMenu  := {}

    //Primeiro procura pelo submenu, escrito "Baixa Manual" (foi tirado o &, pois ele pode ficar em alguns textos de atalhos)
    nPosSub := aScan(aRotina, {|x| Upper(StrTran(AllTrim(x[1]), "&", "")) == cPesqSub})

    //Se encontrou o submenu
    If nPosSub > 0
        //Pega os itens desse submenu
        aSubMenu := aRotina[nPosSub][2]

        //Agora procura pelo item escrito "Canc Baixa" igual fizemos com o submenu
        nPosItem := aScan(aSubMenu, {|x| Upper(StrTran(AllTrim(x[1]), "&", "")) == cPesqItem})

        //Se encontrou o item, iremos apagar ele do submenu e depois redimensionar diminuindo o tamanho do submenu
        If nPosItem > 0
            aDel(aSubMenu, nPosItem)
            aSize(aSubMenu, Len(aSubMenu)-1)
        EndIf
    EndIf

    FWRestArea(aArea)
Return
