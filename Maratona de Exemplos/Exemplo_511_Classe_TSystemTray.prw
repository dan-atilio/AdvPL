/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/01/criando-uma-caixa-de-texto-intervalada-com-tspinbox-maratona-advpl-e-tl-510/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe511
Classe para criar um ícone na bandeja do sistema operacional (só funciona com TWindow)
@type  Function
@author Atilio
@since 05/04/2023
@see https://tdn.totvs.com/display/tec/TSystemTray
@obs 
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe511()
    Local lContinua   := .T.
    Local cEmprAux    := "99"
	Local cFilAux     := ""
	Private cUsrAux   := ""
	Private cPswAux   := ""
    Private lProgInic := .F.

	//Se a SX2 não tiver aberta, quer dizer que não veio pelo Protheus, logo é quiosque
	If Select("SX2")==0

		//Montando uma seção, apenas para poder pegar os parâmetros da SX61
		RPCSetEnv(cEmprAux, "", "", "", "")

		//Verificando se o login deu certo
		If u_zLogin(@cUsrAux, @cPswAux)
			RPCSetEnv(cEmprAux, cFilAux, cUsrAux, cPswAux, "SIGAEST")

			lContinua := .T.
            lProgInic := .T.
        Else
            lContinua := .F.
		EndIf
	EndIf

    If lContinua
        fMontaTela()
    EndIf
Return

Static Function fMontaTela()
    Local nLinObj := 0
    Local nLargBtn := 85
    Local nAltuBtn := 15
    //Blocos de código chamados pelos botões
    Local bConfirm  := {|| RptStatus({|| FWAlertInfo("Em Construção", "Atenção")}, "Processando Registros...", "Aguarde...")}
    Local bCancela  := {|| fCancelar()}
    //Fontes
    Private cFontPad    := "Tahoma"
    Private oFontBtn    := TFont():New(cFontPad, , -14)
	Private oFontBtnN   := TFont():New(cFontPad, , -14, , .T.)
    Private oFontMod    := TFont():New(cFontPad, , -38)
    Private oFontMaior  := TFont():New(cFontPad, , -68)
	Private oFontSub    := TFont():New(cFontPad, , -20)
    //Objetos da Janela
    Private lCentered
	Private oBtConfirm
	Private oBtCancela
    Private oSayTitulo, cSayTitulo := 'Tela de Testes'
    Private oSayEtiqus, cSayEtiqus := '000'
    Private oDlgCentral
    //Tamanho da janela
    Private aTamanho
    Private nJanLarg
    Private nJanAltu
    Private nPosTop
    Private nPosLeft
    //Etiqueta
    Private cEspacProd := Space(TamSX3("B1_COD")[1])
    Private oGetProdut
    Private cGetProdut := cEspacProd
    Private oGetBlank
    Private cGetBlank := ""
    //Grid
    Private oGridPro
    Private aHeaderPro := {}
    Private aColsPro := {}

    //Se vier do programa inicial, a dimensão será diferente
    If lProgInic
        aTamanho  := GetScreenRes()
        nJanLarg  := aTamanho[1]
        nJanAltu  := aTamanho[2] - 80
        lCentered := .F.
        nPosTop   := 0
        nPosLeft  := -10
    Else
        aTamanho  := MsAdvSize()
        nJanLarg  := aTamanho[5]
        nJanAltu  := aTamanho[6]
        lCentered := .T.
        nPosTop   := 0
        nPosLeft  := 0
    EndIf

    //Cria o cabeçalho da grid
    //                Titulo                    Campo         Picture                        Tamanho                       Dec                     Valid           Usado  Tipo F3    
    aAdd(aHeaderPro, {"Produto",                "XX_PROD",    "",                            15,                           0,                      ".F.",          ".F.", "C", "",     ""} )
    aAdd(aHeaderPro, {"Descrição",              "XX_DESC",    "",                            30,                           0,                      ".F.",          ".F.", "C", "",     ""} )
    aAdd(aHeaderPro, {"SB1 RecNo",              "XX_RECNUM",  "@E 999,999,999,999,999,999",  18,                           0,                      ".F.",          ".F.", "N", "",     ""} )
    aAdd(aHeaderPro, {" ",                      "XX_BLANK",   "",                            01,                           0,                      ".F.",          ".F.", "C", "",     ""} )

    //Cria a janela
    If lProgInic
        oDlgCentral := TWindow():New(nPosTop, nPosLeft, nJanAltu, nJanLarg, cSayTitulo, , , , , , , , CLR_BLACK, RGB(250, 250, 250), , , , , , , .T.)

        //Cria o menu de popup que vai ser acionado ao clicar com o botão direito no ícone da bandeja
        oMenu  := TMenu():New(0, 0, 0, 0, .T., , oDlgCentral)
        oItem1 := TMenuItem():New(oDlgCentral,'Mudar a Cor de Fundo', , , , {|| nCor := ColorTriangle(), oDlgCentral:nClrPane := nCor, oDlgCentral:Refresh() }, , 'BR_VERDE', , , , , , , .T.)
        oItem2 := TMenuItem():New(oDlgCentral,'Exibir Data e Hora',   , , , {|| FWAlertInfo(dToC(Date()) + " - " + Time(), "Atenção") }                       , , 'HISTORIC', , , , , , , .T.)
        oItem3 := TMenuItem():New(oDlgCentral,'Encerrar Aplicação',   , , , {|| oDlgCentral:End() }                                                           , , 'EXCLUIR' , , , , , , , .T.)
        oMenu:Add(oItem1)
        oMenu:Add(oItem2)
        oMenu:Add(oItem3)
    
        //Cria o ícone da bandeja do sistema operacional
        cIcon := "pesquisa.png"
        oSysTray := TSystemTray():New(oDlgCentral, cIcon)
        oSysTray:cToolTip := "Exemplo de TSystemTray"
        oSysTray:SetMenu(oMenu)
    Else
        oDlgCentral := TDialog():New(nPosTop, nPosLeft, nJanAltu, nJanLarg, cSayTitulo, , , , , CLR_BLACK, RGB(250, 250, 250), , , .T.)
    EndIf
        //Títulos e SubTítulos
        oSayTitulo := TSay():New(004, 003, {|| cSayTitulo}, oDlgCentral, "", oFontMod,  , , , .T., RGB(149, 179, 215), , 200, 30, , , , , , .F., , )
        oSayEtiqus := TSay():New(-003, (nJanLarg/2) - 120, {|| cSayEtiqus}, oDlgCentral, "", oFontMaior,  , , , .T., RGB(255, 000, 000), , 100, 50, , , , , , .F., , )

        //Get da Etiqueta
        nLinObj := 36
        oGetProdut := TGet():New(nLinObj, 3, {|u| Iif( Pcount()>0, cGetProdut := u, cGetProdut)}, oDlgCentral, (nJanLarg/2)-3, 20, "@!", {|| fVldCodig()}, , , oFontMod, , , .T., , , , , , , .F., , , , , , , , , , , , , , , , )
        oGetProdut:cPlaceHold := "< Código do Produto >"

        oGetBlank  := TGet():New(-100, -100, {|u| Iif(PCount() > 0 , cGetBlank := u, cGetBlank)}, oDlgCentral, 10, 10, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontBtn, , , .T.)
        oGetBlank:bGotFocus := {|| oGetProdut:SetFocus()}

		//Botões
        nLinObj := 059
        oBtConfirm := TButton():New(nLinObj + (nAltuBtn * 00), (nJanLarg/2) - (nLargBtn * 1), "Confirmar",                  oDlgCentral, bConfirm, nLargBtn, nAltuBtn, , oFontBtnN, , .T., , , , , , )
        oBtCancela := TButton():New(nLinObj + (nAltuBtn * 01), (nJanLarg/2) - (nLargBtn * 1), "Cancelar",                   oDlgCentral, bCancela, nLargBtn, nAltuBtn, , oFontBtn,  , .T., , , , , , )

        //Abaixo cria a grid
        oGridPro := MsNewGetDados():New(;
            nLinObj,;									//nTop
            3,;						                    //nLeft
            (nJanAltu/2) - 3,;					        //nBottom
            (nJanLarg/2) - 3 - nLargBtn,;				//nRight
            ,;				                            //nStyle
            "AllwaysTrue()",;							//cLinhaOk
            ,;											//cTudoOk
            "",;										//cIniCpos
            {},;	    	                            //aAlter
            ,;											//nFreeze
            99999999,;									//nMax
            ,;											//cFieldOK
            ,;											//cSuperDel
            ,;											//cDelOk
            oDlgCentral,;								//oWnd
            aHeaderPro,;								//aHeader
            aColsPro)									//aCols
        oGridPro:oBrowse:SetCSS(u_zCSSGrid())
        oGridPro:lActive := .F.

    //Ativa e exibe a janela
    If lProgInic
        oDlgCentral:Activate("MAXIMIZED")
    Else
        oDlgCentral:Activate(, , , lCentered, {|| .T.}, , )
    EndIf
Return

Static Function fVldCodig()
    Local lRet      := .T.
    Local aColsAux  := oGridPro:aCols
    Local lAdiciona := .T.
    Local nPosProd  := aScan(aHeaderPro, {|x| Alltrim(x[2]) == "XX_PROD"})
    Local nLinha    := 0

    //Somente se tiver código de etiqueta
    If ! Empty(cGetProdut)

        //Validar se a etiqueta não foi inserida na grid ainda
        For nLinha := 1 To Len(aColsAux)
            If Alltrim(cGetProdut) == Alltrim(aColsAux[nLinha][nPosProd])
                FWAlertError("O produto '" + cGetProdut + "' já foi adicionado na linha '" + cValToChar(nLinha) + "'!", "Falha")
                lAdiciona := .F.
                Exit
            EndIf
        Next

        //Se deu tudo certo
        If lAdiciona
            DbSelectArea("SB1")
            SB1->(DbSetOrder(1))

            //Se conseguir posicionar no produto
            If SB1->(MsSeek(FWxFilial('SB1') + cGetProdut))
                //Se tiver apenas 1 linha e a coluna do produto estivar vazia
                If Len(aColsAux) == 1 .And. Empty(aColsAux[1][nPosProd])
                    aColsAux := {}
                EndIf

                //Adiciona uma linha na grid
                aAdd(aColsAux, {;
                    SB1->B1_COD,;
                    SubStr(SB1->B1_DESC, 1, 30),;
                    SB1->(RecNo()),;
                    "",;
                    .F.;
                })
                oGridPro:SetArray(aColsAux)
                oGridPro:Refresh()

                //Atualiza produtos lidos
                cSayEtiqus := Soma1(cSayEtiqus)
                oSayEtiqus:Refresh()

            Else
                FWAlertError("O produto '" + cGetProdut + "' não encontrado!", "Falha")
            EndIf

        EndIf

        //Zera o Get, para ser inserida uma nova etiqueta
        cGetProdut := cEspacProd
    EndIf
Return lRet

Static Function fCancelar()
    Local aColsAux  := oGridPro:aCols
    
    //Somente se a pergunta for confirmada
    If FWAlertYesNo("Deseja cancelar?", "Continua?")
        aColsAux := {}
        oGridPro:SetArray(aColsAux)
        oGridPro:Refresh()

        cSayEtiqus := '000'
        oSayEtiqus:Refresh()
    EndIf
Return
