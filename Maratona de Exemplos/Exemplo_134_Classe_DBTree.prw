/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/12/20/criando-uma-arvore-de-navegacao-com-a-classe-dbtree-maratona-advpl-e-tl-134/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe134
Cria uma navegação de níveis em árvore
@type Function
@author Atilio
@since 15/12/2022
@see https://tdn.totvs.com/display/public/framework/DBTree
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe134()
    Local cBmp1 := "PMSEDT3"
	Local cBmp2 := "PMSDOC"
	Local aArea := GetArea()
	Local aAreaSBM := SBM->(GetArea())
	Local aAreaSB1 := SB1->(GetArea())
	Local nJanAltu := 500
	Local nJanLarg := 700
	Local oBtnFec
	Local nAtu := 1
	Local nAtuGrp := 1
	Local nAtuPrd := 1
    Local nCorFundo := RGB(240, 240, 240)
    Local lDimPixels := .T.
    Local cFontNome   := 'Tahoma'
    Local oFontPadrao := TFont():New(cFontNome, , -12)
	Private aDados := {}
	Private cCadastro := "Grupo de Produtos"
	Private oDlgTree
	Private oDBTree
	Private oSayGCod, oGetGCod, cGetGCod := Space(TamSX3('BM_GRUPO')[01])
	Private oSayGDes, oGetGDes, cGetGDes := Space(TamSX3('BM_DESC')[01])
	Private oSayPCod, oGetPCod, cGetPCod := Space(TamSX3('B1_COD')[01])
	Private oSayPDes, oGetPDes, cGetPDes := Space(TamSX3('B1_DESC')[01])
	Private oSayPTip, oGetPTip, cGetPTip := Space(TamSX3('B1_TIPO')[01])
	Private oSayCarg, oGetCarg, cGetCarg := Space(10)
	
	//Abrindo o grupo de produtos
	DbSelectArea("SBM")
	SBM->(DbSetOrder(1)) //BM_FILIAL+BM_GRUPO
	SBM->(DbGoTop())
	
	//Abrindo os produtos
	DbSelectArea("SB1")
	SB1->(DbSetOrder(4)) //B1_FILIAL+B1_GRUPO+B1_COD
	SB1->(DbGoTop())
	
	//Criando a janela
    oDlgTree := TDialog():New(0, 0, nJanAltu, nJanLarg, cCadastro, , , , , , nCorFundo, , , lDimPixels)

		//Criando o DbTree
		oDBTree := DBTree():New(;
            3,;                             //nTop
            3,;                             //nLeft
            (nJanAltu/2)-100,;              //nBottom
            (nJanLarg/2)-3,;                //nRight
            oDlgTree,;                      //oWnd
            {||fProc(oDBTree:GetCargo())},; //bChange
            ,;                              //bRClick
            .T.;                            //lCargo
        )
		
		//Adiciona raíz
		oDBTree:AddTree(;
            "Grupo de Produtos" + Space(30),; //cPrompt
            .T.,;                             //lOpened
            cBmp1,;                           //cRes1
            cBmp1,;                           //cRes2
            ,;                                //cFile1
            ,;                                //cFile2
            cValToChar(nAtu)+".0.0";          //cCargo
        )
		aAdd(aDados, {	cValToChar(nAtu)+".0.0",;	//Cargo
						"",;						//Código do Grupo
						""})						//Código do Produto
		cGetCarg := cValToChar(nAtu)+".0.0"
		
		//Enquanto houver grupo de produtos
		While ! SBM->(EoF())
			//Adiciona raíz
			oDBTree:AddTree(;
				SBM->BM_GRUPO+" - "+SBM->BM_DESC,;             //cPrompt
				.T.,;                                          //lOpened
				cBmp1,;                                        //cRes1
				cBmp1,;                                        //cRes2
				,;                                             //cFile1
				,;                                             //cFile2
				cValToChar(nAtu)+"."+cValToChar(nAtuGrp)+".0"; //cCargo
			)
			nAtuPrd := 1
			aAdd(aDados, {	cValToChar(nAtu)+"."+cValToChar(nAtuGrp)+".0",;	//Cargo
							SBM->BM_GRUPO,;									//Código do Grupo
							""})											//Código do Produto
			
			//Tenta posicionar no produto
			If SB1->(DbSeek(FWxFilial('SB1') + SBM->BM_GRUPO))
				While !SB1->(EoF()) .And. ((FWxFilial('SB1') + SBM->BM_GRUPO) == (SB1->B1_FILIAL + SB1->B1_GRUPO))
					oDBTree:AddTreeItem(;
						Alltrim(SB1->B1_COD) + " - "+SB1->B1_DESC,;                       //cPrompt
						cBmp2,;                                                           //cRes
						,;                                                                //cFile
						cValToChar(nAtu)+"."+cValToChar(nAtuGrp)+"."+cValToChar(nAtuPrd); //cCargo
					)

					aAdd(aDados, {	cValToChar(nAtu)+"."+cValToChar(nAtuGrp)+"."+cValToChar(nAtuPrd),;	//Cargo
									SBM->BM_GRUPO,;														//Código do Grupo
									SB1->B1_COD})														//Código do Produto
					
					nAtuPrd++
					SB1->(DbSkip())
				EndDo
			EndIf
			
			//Finaliza raíz
			oDBTree:EndTree()
			nAtuGrp++
			SBM->(DbSkip())
		EndDo
			
			
		//Finaliza raíz
		oDBTree:EndTree()
		
		//Montando os says e gets - Grupo de Produto
        oSayGCod  := TSay():New((nJanAltu/2)-80, 010, {|| "Grupo:"}, oDlgTree, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 8, , , , , , /*lHTML*/)
        oGetGCod  := TGet():New((nJanAltu/2)-83, 060, {|u| Iif(PCount() > 0 , cGetGCod := u, cGetGCod)}, oDlgTree, 050, 12, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
        oSayGDes  := TSay():New((nJanAltu/2)-80, 170, {|| "Descrição:"}, oDlgTree, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 8, , , , , , /*lHTML*/)
        oGetGDes  := TGet():New((nJanAltu/2)-83, 220, {|u| Iif(PCount() > 0 , cGetGDes := u, cGetGDes)}, oDlgTree, 100, 12, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
		
		//Montando os says e gets - Produto
        oSayPCod  := TSay():New((nJanAltu/2)-60, 010, {|| "Produto:"}, oDlgTree, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 8, , , , , , /*lHTML*/)
        oGetPCod  := TGet():New((nJanAltu/2)-63, 060, {|u| Iif(PCount() > 0 , cGetPCod := u, cGetPCod)}, oDlgTree, 050, 12, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
        oSayPDes  := TSay():New((nJanAltu/2)-60, 170, {|| "Prod.Desc:"}, oDlgTree, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 8, , , , , , /*lHTML*/)
        oGetPDes  := TGet():New((nJanAltu/2)-63, 220, {|u| Iif(PCount() > 0 , cGetPDes := u, cGetPDes)}, oDlgTree, 100, 12, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
        oSayPTip  := TSay():New((nJanAltu/2)-40, 010, {|| "Prod.Tipo:"}, oDlgTree, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 8, , , , , , /*lHTML*/)
        oGetPTip  := TGet():New((nJanAltu/2)-43, 060, {|u| Iif(PCount() > 0 , cGetPTip := u, cGetPTip)}, oDlgTree, 030, 12, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
		
		//Cargo
        oSayCarg  := TSay():New((nJanAltu/2)-20, 010, {|| "Cargo:"}, oDlgTree, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 8, , , , , , /*lHTML*/)
        oGetCarg  := TGet():New((nJanAltu/2)-23, 060, {|u| Iif(PCount() > 0 , cGetCarg := u, cGetCarg)}, oDlgTree, 100, 12, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
		
		//Criando um botão para fechar a janela
        oBtnFec  := TButton():New((nJanAltu/2)-20, (nJanLarg/2)-(61*1), "Fechar", oDlgTree, {|| oDlgTree:End()}, 058, 017, , oFontPadrao, , lDimPixels)

        //Deixa todos os gets como ReadOnly
        oGetGCod:lReadOnly  := .T.
        oGetGDes:lReadOnly  := .T.
        oGetPCod:lReadOnly  := .T.
        oGetPDes:lReadOnly  := .T.
        oGetPTip:lReadOnly  := .T.
        oGetCarg:lReadOnly  := .T.
	oDlgTree:Activate(, , , .T.)
	
	RestArea(aAreaSB1)
	RestArea(aAreaSBM)
	RestArea(aArea)
Return

Static Function fProc(cCargo)
	Local nEncon := aScan(aDados,{|x| AllTrim(x[1]) == cCargo })
	
	//Se conseguiu encontrar algo
	If nEncon > 0
		//Se tiver grupo de produto
		If !Empty(aDados[nEncon][2])
			SBM->(DbSetOrder(1)) //BM_FILIAL+BM_GRUPO
			SBM->(DbSeek(FWxFilial('SBM') + aDados[nEncon][2]))
			cGetGCod := SBM->BM_GRUPO
			cGetGDes := SBM->BM_DESC
			
		//Senão
		Else
			cGetGCod := ""
			cGetGDes := ""
		EndIf
		
		//Se tiver produto
		If !Empty(aDados[nEncon][3])
			SB1->(DbSetOrder(1)) //B1_FILIAL+B1_COD
			SB1->(DbSeek(FWxFilial('SB1') + aDados[nEncon][3]))
			cGetPCod := SB1->B1_COD
			cGetPDes := SB1->B1_DESC
			cGetPTip := SB1->B1_TIPO
			
		//Senão
		Else
			cGetPCod := ""
			cGetPDes := ""
			cGetPTip := ""
		EndIf
	
	//Senão
	Else
		cGetGCod := ""
		cGetGDes := ""
		cGetPCod := ""
		cGetPDes := ""
		cGetPTip := "" 
	EndIf
	
	//Definindo o cargo
	cGetCarg := cCargo
	
	//Atualizando gets
	oGetGCod:Refresh()
	oGetGDes:Refresh()
	oGetPCod:Refresh()
	oGetPDes:Refresh()
	oGetPTip:Refresh()
	oGetCarg:Refresh()
Return
