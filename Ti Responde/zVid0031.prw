//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zVid0031
Função que abre a tela de posição do Cliente
@type  Function
@author Atilio
@since 28/04/2022
@param cCodCli, Caractere, Código do Cliente
@param cLojCli, Caractere, Loja do Cliente
/*/

User Function zVid0031(cCodCli, cLojCli)
    Local aArea     := FWGetArea()
    Default cCodCli := ""
    Default cLojCli := ""

    DbSelectArea("SA1")
    SA1->(DbSetOrder(1)) // A1_FILIAL + A1_COD + A1_LOJA

    //Se conseguir posicionar no cliente
    If SA1->(MsSeek(FWxFilial("SA1") + cCodCli + cLojCli))
        Finc010(2)
    EndIf

    FWRestArea(aArea)
Return
