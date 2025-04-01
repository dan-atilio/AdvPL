/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFonte62
Exemplo de inclusão de pedido de venda através de MsExecAuto
@type  Function
@author Atilio
@since 27/08/2024
/*/

User Function zFonte62()
    Local aArea         := FWGetArea()
    Local aCabec        := {}
    Local aItens        := {}
    Local nAtual        := 0
    Local cItem         := StrTran(Space(TamSX3('C6_ITEM')[01]), ' ', '0')
    Local cCodCli       := "C00002"
    Local cLojCli       := "01"
    Local cVended       := "V00001"
    Local dEmissao      := Date()
    Local cTransp       := "T00001"
    Local cCondPag      := "C01"
    Local aProdutos     := {}
    Private lMsErroAuto := .F.

    //Adiciona os produtos que vão ser depois adicionados no array de itens (código, quantidade, preço unitário e TES)
    aAdd(aProdutos, {"F0001", 1, 5.99, "501"})
    aAdd(aProdutos, {"F0004", 1, 2.99, "501"})
    aAdd(aProdutos, {"F0002", 1, 3.99, "501"})
    
    //Se a pergunta for confirmada
    If FWAlertYesNo("Deseja incluir o pedido para o cliente " + cCodCli + "?", "Continua?")

        //Cabeçalho do pedido de vendas
        aCabec := {;
            {"C5_TIPO"    , "N"       , Nil},;
            {"C5_CLIENTE" , cCodCli   , Nil},;
            {"C5_LOJACLI" , cLojCli   , Nil},;
            {"C5_VEND1"   , cVended   , Nil},;
            {"C5_EMISSAO" , dEmissao  , Nil},;
            {"C5_MOEDA"   , 1         , Nil},;
            {"C5_TXMOEDA" , 1         , Nil},;
            {"C5_TRANSP"  , cTransp   , Nil},;
            {"C5_CONDPAG" , cCondPag  , Nil};
        }

        //Percorre os produtos
        For nAtual := 1 To Len(aProdutos)
            cItem := Soma1(cItem)

            aGets := {}
            aAdd(aGets, {"C6_ITEM"     , cItem     		                             , Nil} )
            aAdd(aGets, {"C6_PRODUTO"  , aProdutos[nAtual][1]                        , Nil} )
            aAdd(aGets, {"C6_QTDVEN"   , aProdutos[nAtual][2]                        , Nil} )
            aAdd(aGets, {"C6_PRCVEN"   , aProdutos[nAtual][3]                        , Nil} )
            aAdd(aGets, {"C6_VALOR "   , aProdutos[nAtual][2] * aProdutos[nAtual][3] , Nil} )
            aAdd(aGets, {"C6_TES"      , aProdutos[nAtual][4]                        , Nil} )
            aAdd(aItens, aClone(aGets))
        Next

        //Chama a inclusão
        MSExecAuto({|x, y, z| Mata410(x, y, z) }, aCabec, aItens, 3)

        //Se houve erro, mostra a mensagem
        If lMsErroAuto
            MostraErro()
        Else
            FWAlertSuccess("Pedido " + SC5->C5_NUM + " incluído com sucesso!", "Atenção")
        EndIf
    EndIf

    FWRestArea(aArea)
Return
