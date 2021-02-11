/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2020/03/27/funcao-para-rastrear-informacoes-em-transportadoras-via-advpl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Totvs.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} zTransp
Função para consultar pedidos em transportadoras
@type  Function
@author Atilio
@since 25/11/2019
@version 1.0
/*/

User Function zTransp()
    Local aArea   := GetArea()
    Local cPedido := SC5->C5_NUM
    Local aPergs  := {}
    
	//Adiciona os parametros para a pergunta
	aAdd(aPergs, {1, "Pedido",   cPedido, "", ".T.", "SC5", ".T.", 80, .T.})
	
	//Mostra uma pergunta com parambox para filtrar o subgrupo
	If ParamBox(aPergs, "Informe os parametros", , , , , , , , , .F., .F.)
		fMontaBusca()
	EndIf

    RestArea(aArea)
Return

Static Function fMontaBusca()
    Local cUrl          := ""
    Local cQry          := ""
    Local cEmissao      := ""
    //Tamanho da janela
    Private aTamanho	:= MsAdvSize()
	Private nJanLarg	:= aTamanho[5]
    Private nJanAltu	:= aTamanho[6]
    //Navegador Internet
    Private oWebChannel
    Private nPort
    Private oWebEngine
    Private aComandos   := {}

    //Faz a consulta do pedido e da transportadora
    cQry := " SELECT " + CRLF
    cQry += "    C5_NUM, " + CRLF
    cQry += "    C5_TRANSP, " + CRLF
    cQry += "    C5_NOTA, " + CRLF
    cQry += "    C5_EMISSAO, " + CRLF
    cQry += "    A1_CGC, " + CRLF
    cQry += "    F2_CHVNFE " + CRLF
    cQry += " FROM " + CRLF
    cQry += "    " + RetSQLName('SC5') + " SC5 " + CRLF
    cQry += "     INNER JOIN " + RetSQLName('SA1') + " SA1 ON ( " + CRLF
    cQry += "         A1_FILIAL = '" + FWxFilial('SA1') + "' " + CRLF
    cQry += "         AND A1_COD = C5_CLIENTE " + CRLF
    cQry += "         AND A1_LOJA = C5_LOJACLI " + CRLF
    cQry += "         AND SA1.D_E_L_E_T_ = ' ' " + CRLF
    cQry += "      ) " + CRLF
    cQry += "     INNER JOIN " + RetSQLName('SF2') + " SF2 ON ( " + CRLF
    cQry += "         F2_FILIAL = '" + FWxFilial('SF2') + "' " + CRLF
    cQry += "         AND F2_DOC = C5_NOTA " + CRLF
    cQry += "         AND F2_SERIE = C5_SERIE " + CRLF
    cQry += "         AND SF2.D_E_L_E_T_ = ' ' " + CRLF
    cQry += "     ) " + CRLF
    cQry += " WHERE " + CRLF
    cQry += "    C5_FILIAL = '" + FWxFilial('SC5') + "' " + CRLF
    cQry += "    AND C5_NUM = '" + MV_PAR01 + "' " + CRLF
    cQry += "    AND SC5.D_E_L_E_T_ = ' ' " + CRLF
    TCQuery cQry New Alias "QRY_PED"

    //Se houver dados
    If ! QRY_PED->(EoF())
        // - Rodonaves
        If QRY_PED->C5_TRANSP == "000512"
            cUrl := "https://cliente.rte.com.br/Tracking/"
            aAdd(aComandos, 'document.getElementById("cpfcnpj").value = "' + QRY_PED->A1_CGC + '"; ')
            aAdd(aComandos, 'document.getElementById("documentNumber").value = "' + QRY_PED->C5_NOTA + '"; ')
        
        // - Transportadora Americana
        ElseIf QRY_PED->C5_TRANSP == "000520"
            cEmissao := SubStr(QRY_PED->C5_EMISSAO, 7, 2) + "/" + SubStr(QRY_PED->C5_EMISSAO, 5, 2) + "/" + SubStr(QRY_PED->C5_EMISSAO, 1, 4)
            cUrl := "https://www.tanet.com.br/rastrear-encomenda/5/"
            aAdd(aComandos, 'document.getElementById("cpf_cnpj").value = "' + QRY_PED->A1_CGC + '"; ')
            aAdd(aComandos, 'document.getElementById("nota_fiscal").value = "' + QRY_PED->C5_NOTA + '"; ')
            aAdd(aComandos, 'document.getElementById("data_emissao").value = "' + cEmissao + '"; ')

        // - Braspress
        ElseIf QRY_PED->C5_TRANSP == "000670"
            cUrl := "https://www.braspress.com/acesso-rapido/rastreie-sua-encomenda/"
            u_MsgLog("Atenção", "Preencha CNPJ [" + QRY_PED->A1_CGC + "] e NF [" + cValToChar(Val(QRY_PED->C5_NOTA)) + "]")

        // - Setex do Brasil
        ElseIf QRY_PED->C5_TRANSP == "001569"
            cUrl := "http://www.setexdobrasil.com.br/#track"
            aAdd(aComandos, 'document.getElementById("accessKey").value = "' + QRY_PED->F2_CHVNFE + '";')
            aAdd(aComandos, 'document.getElementById("sendAcessKeyButton").click();')
        EndIf
        
        //Se tiver a URL preenchida
        If ! Empty(cUrl)
            DEFINE DIALOG oDlg TITLE "Pesquisa de Transportadora" FROM 000,000 TO nJanAltu,nJanLarg PIXEL

                // Prepara o conector WebSocket
                oWebChannel := TWebChannel():New()
                nPort := oWebChannel::connect()

                // Cria componente
                oWebEngine := TWebEngine():New(oDlg, 0, 0, 100, 100,, nPort)
                oWebEngine:bLoadFinished := {|self,url| fRodaScript(url) }
                oWebEngine:navigate(cUrl)
                oWebEngine:Align := CONTROL_ALIGN_ALLCLIENT

            ACTIVATE DIALOG oDlg CENTERED
        Else
            MsgStop("URL da Transportadora nao encontrada!" + CRLF + "Disponivel apenas para Rodonaves, Americana, Braspress e Setex!", "Atencao")
        EndIf
    Else
        MsgStop("Dados do pedido nao encontrados!", "Atencao")
    EndIf
    QRY_PED->(DbCloseArea())
Return

Static Function fRodaScript(cUrl)
    Local nAtual := 0

    //Percorre os comandos
    For nAtual := 1 To Len(aComandos)
        oWebEngine:runJavaScript(aComandos[nAtual])
    Next
Return