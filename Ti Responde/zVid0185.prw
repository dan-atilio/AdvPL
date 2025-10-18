/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/09/11/alterar-fornecedor-de-um-pedido-de-compras-ti-responde-0185/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} User Function MT120BRW
Adiciona os botões na tela de pedido de compras
@type  Function
@author Atilio
@since 18/09/2024
@version version
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6085467
/*/

User Function MT120BRW()
    Local aArea := FWGetArea()

    //Adiciona os botões na tela de documento de entrada
	aAdd(aRotina, {'* Alterar Fornecedor', 'u_zVid0185()', 0, 2})

    FWRestArea(aArea)
Return

/*/{Protheus.doc} User Function zVid0185
Função que altera o fornecedor de um pedido de compras
@type  Function
@author Atilio
@since 18/09/2024
/*/

User Function zVid0185()
    Processa({|| fAnalisa()})
Return

Static Function fAnalisa()
	Local aArea      := FWGetArea()
	Local cUsrsCompr := SuperGetMV("MV_X_USRCO", .F., "000000;000109;000080;") //Usuários que podem alterar o fornecedor do Pedido de Compras
	Local cUsrAtu    := RetCodUsr()
	Local lContinua  := .T.
	Local aPergs     := {}
	Local cForneced  := Space(TamSX3('A2_COD')[01])
	Local cLoja      := Space(TamSX3('A2_LOJA')[01])
	Local cQryPedido := ""
	Local cFilPedido := SC7->C7_FILIAL
	Local cNumPedido := SC7->C7_NUM
    Local aCabC7     := {}
    Local aItensC7   := {}
    Local aGets      := {}
    Local cItem      := StrTran(Space(TamSX3('C7_ITEM')[01]), ' ', '0')
    Private lMsErroAuto := .F.

	//Se o usuário não estiver no parâmetro
	If ! cUsrAtu $ cUsrsCompr
		FWAlertError("Usuário sem acesso para alterar o Fornecedor do Pedido de Compras!", "Atenção")
	Else
		//Monta a query do pedido
		cQryPedido := " SELECT " + CRLF
		cQryPedido += "     COUNT(C7_ITEM) AS TOT_ITENS, " + CRLF
		cQryPedido += "     SUM(IIF(C7_QUJE = 0 AND C7_QTDACLA = 0 AND C7_CONTRA = '', 1, 0)) AS TOT_ABERT, " + CRLF
		cQryPedido += "     SUM(IIF(C7_NUMSC + C7_ITEMSC != '', 1, 0)) AS TOT_SOLIC, " + CRLF
		cQryPedido += "     (SELECT COUNT(D1_DOC) FROM " + RetSQLName("SD1") + " SD1 WHERE D1_FILIAL = C7_FILIAL AND D1_FORNECE = C7_FORNECE AND D1_LOJA = C7_LOJA AND SD1.D_E_L_E_T_ = ' ' AND D1_PEDIDO = C7_NUM) AS TOT_DOCENT " + CRLF
		cQryPedido += " FROM  " + CRLF
		cQryPedido += "     " + RetSQLName("SC7") + " SC7 " + CRLF
		cQryPedido += " WHERE " + CRLF
		cQryPedido += "     C7_FILIAL = '" + cFilPedido + "' " + CRLF
		cQryPedido += "     AND C7_NUM = '" + cNumPedido + "' " + CRLF
		cQryPedido += "     AND SC7.D_E_L_E_T_ = ' ' " + CRLF
		cQryPedido += " GROUP BY " + CRLF
		cQryPedido += "     C7_FILIAL, C7_FORNECE, C7_LOJA, C7_NUM " + CRLF
		TCQuery cQryPedido New Alias "QRY_PEDID"

		//Se houver dados da query
		If ! QRY_PEDID->(EoF())

			//1ª validação - se o pedido esta em aberto (C7_QUJE == 0 .And. C7_QTDACLA == 0 .And. Empty(C7_CONTRA))
			If QRY_PEDID->TOT_ABERT != 0 .And. QRY_PEDID->TOT_ABERT == QRY_PEDID->TOT_ITENS
				lContinua := .T.
			Else
				lContinua := .F.
				FWAlertError("Esse pedido já foi encerrado (parcialmente / totalmente), ele não pode ser alterado!", "Pedido Encerrado")
			EndIf

			//2ª validação - se não tem solicitação de compras (C7_NUMSC + C7_ITEMSC)
			If lContinua
				If QRY_PEDID->TOT_SOLIC == 0
					lContinua := .T.
				Else
					lContinua := .F.
					FWAlertError("Existe uma solicitação de compra vinculada a esse pedido, ele não pode ser alterado!", "Solicitação de Compra")
				EndIf
			EndIf

			//3ª validação - se não tem documento de entrada (D1_PEDIDO + D1_ITEMPC)
			If lContinua
				If QRY_PEDID->TOT_DOCENT == 0
					lContinua := .T.
				Else
					lContinua := .F.
					FWAlertError("Existe um documento de entrada vinculado a esse pedido, ele não pode ser alterado!", "Documento de Entrada")
				EndIf
			EndIf

			//Somente se todas as validações estiverem ok
			If lContinua
				aAdd(aPergs, {1, "Novo Fornecedor",  cForneced,  "@!", ".T.", "SA2", ".T.", 80,  .T.})
				aAdd(aPergs, {1, "Loja",             cLoja,      "@!", ".T.", "",    ".T.", 40,  .T.})

				//Se a pergunta for confirmada
				If ParamBox(aPergs, "Informe os parâmetros", , , , , , , , , .F., .F.)
					cForneced := MV_PAR01
					cLoja     := MV_PAR02

                    //Ativa o controle de transações
					Begin Transaction
                        cQryPedido := " SELECT " + CRLF
                        cQryPedido += "     C7_FILIAL, C7_COND, C7_MOEDA, C7_CONTATO, C7_FILENT, C7_TIPO, C7_TXMOEDA, " + CRLF
                        cQryPedido += "     C7_ITEM, C7_PRODUTO, C7_QUANT, C7_PRECO, C7_TOTAL " + CRLF
                        cQryPedido += " FROM  " + CRLF
                        cQryPedido += "     " + RetSQLName("SC7") + " SC7 " + CRLF
                        cQryPedido += " WHERE " + CRLF
                        cQryPedido += "     C7_FILIAL = '" + cFilPedido + "' " + CRLF
                        cQryPedido += "     AND C7_NUM = '" + cNumPedido + "' " + CRLF
                        cQryPedido += "     AND SC7.D_E_L_E_T_ = ' ' " + CRLF
                        cQryPedido += " ORDER BY " + CRLF
                        cQryPedido += "     C7_ITEM " + CRLF
                        TCQuery cQryPedido New Alias "QRY_PED"

                        //Se houver dados
                        If ! QRY_PED->(EoF())
                            //Cabeçalho do pedido de compras
                            aCabC7 := {;
                                {"C7_FILIAL"  , QRY_PED->C7_FILIAL	   , Nil},;
                                {"C7_FORNECE" , cForneced              , Nil},;
                                {"C7_LOJA"    , cLoja                  , Nil},;
                                {"C7_COND"    , QRY_PED->C7_COND       , Nil},;
                                {"C7_EMISSAO" , Date()                 , Nil},;
                                {'C7_MOEDA'	  , QRY_PED->C7_MOEDA	   , Nil},;
                                {"C7_CONTATO" , QRY_PED->C7_CONTATO    , Nil},;
                                {"C7_FILENT"  , QRY_PED->C7_FILENT	   , Nil},;
                                {"C7_TIPO"    , QRY_PED->C7_TIPO       , Nil},;
                                {'C7_TXMOEDA' , QRY_PED->C7_TXMOEDA    , Nil};
                            }

                            //Enquanto houver produtos a serem processados
                            While ! QRY_PED->(EoF())
                                cItem := Soma1(cItem)

                                aGets := {}
                                aAdd(aGets, {"C7_ITEM"    , cItem     		      , Nil} )
                                aAdd(aGets, {"C7_PRODUTO" , QRY_PED->C7_PRODUTO   , Nil} )
                                aAdd(aGets, {"C7_QUANT"   , QRY_PED->C7_QUANT     , Nil} )
                                aAdd(aGets, {"C7_PRECO"   , QRY_PED->C7_PRECO     , Nil} )
                                aAdd(aGets, {"C7_TOTAL"   , QRY_PED->C7_TOTAL     , Nil} )
                                aAdd(aItensC7, aClone(aGets))

                                QRY_PED->(DbSkip())
                            EndDo

                        EndIf
                        QRY_PED->(DbCloseArea())

                        //Se conseguiu eliminar o resíduo do pedido original
                        If fElimina(cNumPedido)

                            //Chama a inclusão
                            MSExecAuto({|v, w, x, y, z| Mata120(v, w, x, y, z) }, 1, aCabC7, aItensC7, 3, .F.)

                            //Se houve erro, mostra a mensagem, e aborta o restante das operações
                            If lMsErroAuto
                                MostraErro()
                                DisarmTransaction()
                            Else
                                FWAlertSuccess("Pedido " + SC7->C7_NUM + " criado com sucesso baseado no " + cNumPedido, "Atenção")
                            EndIf
                        EndIf
                    End Transaction
				EndIf
			EndIf
		EndIf
		QRY_PEDID->(DbCloseArea())
	EndIf

	FWRestArea(aArea)
Return

Static Function fElimina(cNumPedido)
    Local aArea     := FWGetArea()
    Local cPerg     := "MTA235"
    Local lDeuCerto := .T.
    Private lMsErroAuto := .F.

    //Define os parâmetros
    SetMVValue(cPerg, "MV_PAR01", 100)                                 //Percentual máximo
    SetMVValue(cPerg, "MV_PAR02", SC7->C7_EMISSAO)                     //Data de Emissão De
    SetMVValue(cPerg, "MV_PAR03", SC7->C7_EMISSAO)                     //Data de Emissão Até
    SetMVValue(cPerg, "MV_PAR04", SC7->C7_NUM)                         //Solicitação / Pedido De
    SetMVValue(cPerg, "MV_PAR05", SC7->C7_NUM)                         //Solicitação / Pedido Até
    SetMVValue(cPerg, "MV_PAR06", Space(TamSX3("B1_COD")[1]))          //Produto De
    SetMVValue(cPerg, "MV_PAR07", Replicate("Z", TamSX3("B1_COD")[1])) //Produto Até
    SetMVValue(cPerg, "MV_PAR08", 1)                                   //Eliminar resíduo por (1=Pedido de Compra; 2=Aut de Entrega; 3=Pedido/Aut Entrega; 4=Contr. Parceria; 5=Solic. Compras)
    SetMVValue(cPerg, "MV_PAR09", SC7->C7_FORNECE)                     //Fornecedor De
    SetMVValue(cPerg, "MV_PAR10", SC7->C7_FORNECE)                     //Fornecedor Até
    SetMVValue(cPerg, "MV_PAR11", YearSub(SC7->C7_EMISSAO, 1))         //Data de Entrega De
    SetMVValue(cPerg, "MV_PAR12", YearSum(SC7->C7_EMISSAO, 5))         //Data de Entrega Até
    SetMVValue(cPerg, "MV_PAR13", 2)                                   //Elimina SC com OP (1=Sim; 2=Não)
    SetMVValue(cPerg, "MV_PAR14", "    ")                              //Item De
    SetMVValue(cPerg, "MV_PAR15", "ZZZZ")                              //Item Até
    SetMVValue(cPerg, "MV_PAR16", 2)                                   //Contabiliza Pedido (1=Sim; 2=Não)
    SetMVValue(cPerg, "MV_PAR17", 2)                                   //Mostrar Lançamento Contábil (1=Sim; 2=Não)

    //Coloca a pergunta para a memória
    Pergunte(cPerg, .F.)

    //Chama a rotina padrão
    lMsErroAuto := .F.
    MsExecAuto({|x| MATA235(x)}, .T.)

    //Se houver erro
    If lMsErroAuto
        lDeuCerto := .F.
        MostraErro()
        DisarmTransaction()
    EndIf

    FWRestArea(aArea)
Return lDeuCerto
