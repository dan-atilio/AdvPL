/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/03/25/como-fazer-um-combo-num-parambox-conforme-definicoes-de-um-campo-na-sx3-ti-responde-0136/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} User Function zVid0136
Exemplo de como criar um ComboBox no ParamBox com as definições diretas de um campo do dicionário (X3_CBOX)
@type  Function
@author Atilio
@since 12/01/2024
/*/

User Function zVid0136()
    Local aArea        := FWGetArea()
    Local aPergs       := {}
    Local dDataDe      := FirstDate(Date())
    Local dDataAt      := LastDate(Date())
    Local cClienteDe   := Space(TamSX3('A1_COD')[01])
    Local cClienteAte  := StrTran(cClienteDe, ' ', 'Z')
    Local nTipo        := 1
    Local cTipClient   := "0"
    Local aTiposCli    := TkSX3Box("A1_TIPO")

    //Adiciona o tipo todos
    aSize(aTiposCli, Len(aTiposCli) + 1)
    aIns(aTiposCli, 1)
    aTiposCli[1] = "0=Todos"

    //Adicionando os parâmetros
    aAdd(aPergs, {1, "Data da Última Compra De",  dDataDe,     "", ".T.", "",    ".T.", 80,  .F.}) // MV_PAR01
    aAdd(aPergs, {1, "Data da Última Compra Até", dDataAt,     "", ".T.", "",    ".T.", 80,  .T.}) // MV_PAR02
    aAdd(aPergs, {1, "Cliente De",                cClienteDe,  "", ".T.", "SA1", ".T.", 60,  .F.}) // MV_PAR03
    aAdd(aPergs, {1, "Cliente Até",               cClienteAte, "", ".T.", "SA1", ".T.", 60,  .T.}) // MV_PAR04
    aAdd(aPergs, {2, "Tipo do Filtro",      nTipo,      {"1=Trazer Tudo", "2=Trazer somente os que compraram", "3=Trazer os que nunca compraram"},  100, ".T.", .F.}) // MV_PAR05
    aAdd(aPergs, {2, "Tipo Cliente",        cTipClient, aTiposCli,  100, ".T.", .F.}) // MV_PAR06
 
    //Mostra a tela para o usuário confirmar
    If ParamBox(aPergs, "Informe os parâmetros", , , , , , , , , .F., .F.)
        MV_PAR05 := Val(cValToChar(MV_PAR05))
        MV_PAR06 := Left(MV_PAR06, 1)
        
        fContaRegs()
    EndIf

    FWRestArea(aArea)
Return

Static Function fContaRegs()
    Local aArea    := FWGetArea()
	Local cQryDad  := ""
	Local nTotal   := 0
	
	//Montando consulta de dados
	cQryDad := "SELECT "		+ CRLF
	cQryDad += "    A1_COD, "		+ CRLF
	cQryDad += "    A1_NOME, "		+ CRLF
	cQryDad += "    A1_ULTCOM "		+ CRLF
	cQryDad += "FROM "		+ CRLF
	cQryDad += "    " + RetSQLName("SA1") + " SA1 "		+ CRLF
	cQryDad += "WHERE "		+ CRLF
	cQryDad += "    A1_FILIAL = '" + FWxFilial("SA1") + "' "		+ CRLF
    cQryDad += "    AND A1_COD >= '" + MV_PAR03 + "' "		+ CRLF
	cQryDad += "    AND A1_COD <= '" + MV_PAR04 + "' "		+ CRLF
    If MV_PAR05 == 2
        cQryDad += "    AND A1_ULTCOM != '' "		+ CRLF
        cQryDad += "    AND A1_ULTCOM >= '" + dToS(MV_PAR01) + "' "		+ CRLF
        cQryDad += "    AND A1_ULTCOM <= '" + dToS(MV_PAR02) + "' "		+ CRLF
	ElseIf MV_PAR05 == 3
        cQryDad += "    AND A1_ULTCOM = '' "		+ CRLF
    EndIf
    If MV_PAR06 != "0"
        cQryDad += "    AND A1_TIPO = '" + MV_PAR06 + "' "		+ CRLF
    EndIf
	cQryDad += "    AND SA1.D_E_L_E_T_ = ' ' "		+ CRLF
	cQryDad += "ORDER BY "		+ CRLF
    cQryDad += "    A1_COD "		+ CRLF

    //Baixe a zViewQry nesse link - https://terminaldeinformacao.com/2021/12/22/como-usar-a-funcao-showlog/
    u_zViewQry(cQryDad)
	
	//Executando consulta
	TCQuery cQryDad New Alias "QRY_DAD"
	TCSetField("QRY_DAD", "A1_ULTCOM", "D")
	
	//Conta a quantidade de registros
	Count To nTotal
	QRY_DAD->(DbCloseArea())
	
	//Exibe uma mensagem
	Alert("Foi encontrado " + cValToChar(nTotal) + " registro(s)")

    FWRestArea(aArea)
Return
