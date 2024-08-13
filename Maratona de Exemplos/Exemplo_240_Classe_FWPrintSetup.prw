/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/17/configurando-a-impressao-atraves-da-fwprintsetup-maratona-advpl-e-tl-240/
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "FWPrintSetup.ch"

//Constantes
#Define PAD_LEFT			0					//Alinhamento Esquerda
#Define PAD_RIGHT			1					//Alinhamento Direita
#Define PAD_CENTER			2					//Alinhamento Centralizado
#Define IMP_SPOOL           2

Static oSetupRel

/*/{Protheus.doc} User Function zExe240
Imprime a etiqueta via fwmsprinter
@type  Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/display/public/framework/FWPrintSetup
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe240()
    Local aArea := FWGetArea()
    Local aPergs   := {}
    Private cCodProd  := Space(TamSX3('B1_COD')[01])
    
    //Adiciona os parâmetros que serão exibidos
    aAdd(aPergs, {1, "Produto", cCodProd,  "", ".T.", "SB1", ".T.", 60,  .T.})
    
    //Se a pergunta for confirmada
    If ParamBox(aPergs, "Informe os parâmetros", , , , , , , , , .F., .F.)
        cCodProd := Alltrim(MV_PAR01)
        fImprEtq()
    EndIf

    FWRestArea(aArea)
Return

Static Function fImprEtq()
	Local oPrint
	Local oBrush		:= TBrush():New(,RGB(000, 000, 000))
	Local nAltura		:= 1200
	Local nLargura		:= 1200
	Local nLinAux		:= 0
    Local lNegrito      := .T.
    Local lSublinhado   := .T.
    Local lItalico      := .T.
    Local cNomeFont     := "Arial"
    Local oFontDadN     := TFont():New(cNomeFont, /*uPar2*/, -15, /*uPar4*/,   lNegrito, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, ! lSublinhado, ! lItalico)
    Local oFontRoda     := TFont():New(cNomeFont, /*uPar2*/, -13, /*uPar4*/,   lNegrito, /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, ! lSublinhado, ! lItalico)

    DbSelectArea("SB1")
    SB1->(DbSetOrder(1)) // Filial + Produto
    If SB1->(MsSeek(FWxFilial("SB1") + cCodProd))

        //Criando a impressão
        oPrint := FwMsPrinter():New("ETQPRODU",,.T.,GetTempPath(),.T.)

        //Se ainda não tiver configuração de Setup
        While ValType(oSetupRel) == "U"
            fConfImpr()
        EndDo

        //Se for direto para impressora
        If oSetupRel:GetProperty(PD_PRINTTYPE) == IMP_SPOOL
            oPrint:nDevice := IMP_SPOOL
            oPrint:cPrinter := oSetupRel:aOptions[PD_VALUETYPE]
        Endif

        oPrint:StartPage()

        //Imprimindo o cabeçalho (imagem e mensagem)
        oPrint:SayBitmap(075, 010, "\x_imagens\logo.png", 105, 105)
        oPrint:Say(130, nLargura-490, "Terminal de Informação", oFontDadN,,,, PAD_CENTER)
        oPrint:Line(250, 000, 250, nAltura)
        nLinAux := 290

        oPrint:Say(nLinAux, 030, "Etiqueta de Produto", oFontDadN,,,, PAD_LEFT)
        nLinAux += 080

        //Descrição
        oPrint:Say(nLinAux, 030, "Descrição:", oFontDadN,,,, PAD_LEFT)
        oPrint:Say(nLinAux, 340, Alltrim(SB1->B1_DESC), oFontDadN,,,, PAD_LEFT)
        nLinAux += 080

        //Data e Validade
        oPrint:Say(nLinAux, 030, "Tipo:", oFontDadN,,,, PAD_LEFT)
        oPrint:Say(nLinAux, 340, SB1->B1_TIPO, oFontDadN,,,, PAD_LEFT)
        oPrint:Say(nLinAux, 580, "U.M.:", oFontDadN,,,, PAD_LEFT)
        oPrint:Say(nLinAux, 850, SB1->B1_UM, oFontDadN,,,, PAD_LEFT)
        nLinAux += 080
        
        //Código de Barras
        oPrint:FwMsBar("CODE128", 12, 1, Alltrim(cCodProd), oPrint,.F.,,,,,,,,.F.,)
        nLinAux += 240

        //Dados finais
        oPrint:FillRect({nLinAux-20, 000, nAltura-250, nLargura-20}, oBrush)
        oPrint:Say(nLinAux+030, 30, "PRODUTO", oFontDadN,,RGB(255, 255, 255),, PAD_LEFT)
        oPrint:Say(nLinAux+140, 30, cCodProd, oFontRoda,,RGB(255, 255, 255),, PAD_LEFT)
        oPrint:Say(nLinAux+020, (nLargura - 720), 'Se tiver dúvidas', oFontRoda,,RGB(255, 255, 255),, PAD_CENTER)
        oPrint:Say(nLinAux+060, (nLargura - 720), 'entre em contato conosco',   oFontRoda,,RGB(255, 255, 255),, PAD_CENTER)
        oPrint:Say(nLinAux+100, (nLargura - 720), 'através do e-Mail', oFontRoda,,RGB(255, 255, 255),, PAD_CENTER)
        oPrint:Say(nLinAux+140, (nLargura - 720), 'contato@atiliosistemas.com',   oFontRoda,,RGB(255, 255, 255),, PAD_CENTER)

        //Mandando para o spool de impressão
        oPrint:Print()
    Else
        FWAlertError("Produto não encontrado", "Falha")
    EndIf

Return

Static Function fConfImpr()
	Local aDevice       := {"DISCO", "SPOOL", "EMAIL", "EXCEL", "HTML", "PDF"}
	Local oSetup
	Local cSession  	:= GetPrinterSession()
	Local cDevice     	:= If(Empty(fwGetProfString(cSession,"PRINTTYPE","SPOOL",.T.)),"PDF",fwGetProfString(cSession,"PRINTTYPE","SPOOL",.T.))
	Local nPrintType    := aScan(aDevice, {|x| x == cDevice })
	Local nOrientation  := 1 //If(fwGetProfString(cSession, "ORIENTATION", "PORTRAIT", .T.) == "PORTRAIT", 1, 2)
	Local nLocal        := 2 //If(fwGetProfString(cSession, "LOCAL", "SERVER", .T.) == "SERVER", 1, 2)
	Local nFlags        := PD_ISTOTVSPRINTER + PD_DISABLEPAPERSIZE + PD_DISABLEPREVIEW + PD_DISABLEMARGIN

	//Cria o setup do relatório
	oSetup := FWPrintSetup():New(nFlags, "ETIQUETA")
	oSetup:SetPropert(PD_DESTINATION , nLocal)
	oSetup:SetPropert(PD_ORIENTATION , nOrientation)
	oSetup:SetPropert(PD_PRINTTYPE   , nPrintType)

	oSetupRel := Nil

	//Se a tela for confirmada, atualiza o setup default do relatório
	If oSetup:Activate() == PD_OK
		If oSetup:GetProperty(PD_PRINTTYPE) == IMP_SPOOL .And. oSetup:GetProperty(PD_DESTINATION) == 2
			oSetupRel := oSetup
		Else
			FWAlertInfo("Escolha o tipo SPOOL e LOCAL para impressão!")
		EndIf
	EndIf
Return            
