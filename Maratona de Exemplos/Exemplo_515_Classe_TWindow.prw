/*
    Esse exemplo faz parte da s�rie do YouTube, Maratona de Exemplos, do canal Terminal de Informa��o, 
    caso queira ver esse exemplo rodando em v�deo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/03/criando-uma-janela-atraves-da-twindow-maratona-advpl-e-tl-515/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe515
Cria uma janela nativa com comportamento do sistema operacional (como minimizar)
@type  Function
@author Atilio
@since 05/04/2023
@see https://tdn.totvs.com/display/tec/TWindow
@obs 
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe515()
    Local lContinua   := .T.
    Local cEmprAux    := "99"
	Local cFilAux     := ""
	Private cUsrAux   := ""
	Private cPswAux   := ""
    Private lProgInic := .F.

	//Se a SX2 n�o tiver aberta, quer dizer que n�o veio pelo Protheus, logo � quiosque
	If Select("SX2")==0

		//Montando uma se��o, apenas para poder pegar os par�metros da SX61
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
    //Blocos de c�digo chamados pelos bot�es
    Local bConfirm  := {|| RptStatus({|| FWAlertInfo("Em Constru��o", "Aten��o")}, "Processando Registros...", "Aguarde...")}
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

    //Se vier do programa inicial, a dimens�o ser� diferente
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

    //Cria o cabe�alho da grid
    //                Titulo                    Campo         Picture                        Tamanho                       Dec                     Valid           Usado  Tipo F3    
    aAdd(aHeaderPro, {"Produto",                "XX_PROD",    "",                            15,                           0,                      ".F.",          ".F.", "C", "",     ""} )
    aAdd(aHeaderPro, {"Descri��o",              "XX_DESC",    "",                            30,                           0,                      ".F.",          ".F.", "C", "",     ""} )
    aAdd(aHeaderPro, {"SB1 RecNo",              "XX_RECNUM",  "@E 999,999,999,999,999,999",  18,                           0,                      ".F.",          ".F.", "N", "",     ""} )
    aAdd(aHeaderPro, {" ",                      "XX_BLANK",   "",                            01,                           0,                      ".F.",          ".F.", "C", "",     ""} )

    //Cria a janela
    If lProgInic
        oDlgCentral := TWindow():New(nPosTop, nPosLeft, nJanAltu, nJanLarg, cSayTitulo, , , , , , , , CLR_BLACK, RGB(250, 250, 250), , , , , , , .T.)
    Else
        oDlgCentral := TDialog():New(nPosTop, nPosLeft, nJanAltu, nJanLarg, cSayTitulo, , , , , CLR_BLACK, RGB(250, 250, 250), , , .T.)
    EndIf
        //T�tulos e SubT�tulos
        oSayTitulo := TSay():New(004, 003, {|| cSayTitulo}, oDlgCentral, "", oFontMod,  , , , .T., RGB(149, 179, 215), , 200, 30, , , , , , .F., , )
        oSayEtiqus := TSay():New(-003, (nJanLarg/2) - 120, {|| cSayEtiqus}, oDlgCentral, "", oFontMaior,  , , , .T., RGB(255, 000, 000), , 100, 50, , , , , , .F., , )

        //Get da Etiqueta
        nLinObj := 36
        oGetProdut := TGet():New(nLinObj, 3, {|u| Iif( Pcount()>0, cGetProdut := u, cGetProdut)}, oDlgCentral, (nJanLarg/2)-3, 20, "@!", {|| fVldCodig()}, , , oFontMod, , , .T., , , , , , , .F., , , , , , , , , , , , , , , , )
        oGetProdut:cPlaceHold := "< C�digo do Produto >"

        oGetBlank  := TGet():New(-100, -100, {|u| Iif(PCount() > 0 , cGetBlank := u, cGetBlank)}, oDlgCentral, 10, 10, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontBtn, , , .T.)
        oGetBlank:bGotFocus := {|| oGetProdut:SetFocus()}

		//Bot�es
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

    //Somente se tiver c�digo de etiqueta
    If ! Empty(cGetProdut)

        //Validar se a etiqueta n�o foi inserida na grid ainda
        For nLinha := 1 To Len(aColsAux)
            If Alltrim(cGetProdut) == Alltrim(aColsAux[nLinha][nPosProd])
                FWAlertError("O produto '" + cGetProdut + "' j� foi adicionado na linha '" + cValToChar(nLinha) + "'!", "Falha")
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
                FWAlertError("O produto '" + cGetProdut + "' n�o encontrado!", "Falha")
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
