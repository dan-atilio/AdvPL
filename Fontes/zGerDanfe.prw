/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2019/03/02/funcao-para-gerar-danfe-e-xml-de-uma-nota-em-uma-pasta-via-advpl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch" 
#Include "TBIConn.ch" 
#Include "Colors.ch"
#Include "RPTDef.ch"
#Include "FWPrintSetup.ch"

/*/{Protheus.doc} zGerDanfe
Função que gera a danfe e o xml de uma nota em uma pasta passada por parÃ¢metro
@author Atilio
@since 10/02/2019
@version 1.0
@param cNota, characters, Nota que será buscada
@param cSerie, characters, Série da Nota
@param cPasta, characters, Pasta que terá o XML e o PDF salvos
@type function
@example u_zGerDanfe("000123ABC", "1", "C:\TOTVS\NF")
@obs Para o correto funcionamento dessa rotina, é necessário:
	1. Ter baixado e compilado o rdmake danfeii.prw
	2. Ter baixado e compilado o zSpedXML.prw - https://terminaldeinformacao.com/2017/12/05/funcao-retorna-xml-de-uma-nota-em-advpl/
/*/
User Function zGerDanfe(cNota, cSerie, cPasta)
	Local aArea     := GetArea()
	Local cIdent    := ""
	Local cArquivo  := ""
	Local oDanfe    := Nil
	Local lEnd      := .F.
	Local nTamNota  := TamSX3('F2_DOC')[1]
	Local nTamSerie := TamSX3('F2_SERIE')[1]
	Private PixelX
	Private PixelY
	Private nConsNeg
	Private nConsTex
	Private oRetNF
	Private lPtImpBol
	Private aNotasBol
	Private nColAux
	Default cNota   := ""
	Default cSerie  := ""
	Default cPasta  := GetTempPath()
	
	//Se existir nota
	If ! Empty(cNota)
		//Pega o IDENT da empresa
		cIdent := RetIdEnti()
		
		//Se o último caracter da pasta não for barra, será barra para integridade
		If SubStr(cPasta, Len(cPasta), 1) != "\"
			cPasta += "\"
		EndIf
		
		//Gera o XML da Nota
		cArquivo := cNota + "_" + dToS(Date()) + "_" + StrTran(Time(), ":", "-")
		u_zSpedXML(cNota, cSerie, cPasta + cArquivo  + ".xml", .F.)
		
		//Define as perguntas da DANFE
		Pergunte("NFSIGW",.F.)
		MV_PAR01 := PadR(cNota,  nTamNota)     //Nota Inicial
		MV_PAR02 := PadR(cNota,  nTamNota)     //Nota Final
		MV_PAR03 := PadR(cSerie, nTamSerie)    //Série da Nota
		MV_PAR04 := 2                          //NF de Saida
		MV_PAR05 := 1                          //Frente e Verso = Sim
		MV_PAR06 := 2                          //DANFE simplificado = Nao
		
		//Cria a Danfe
		oDanfe := FWMSPrinter():New(cArquivo, IMP_PDF, .F., , .T.)
		
		//Propriedades da DANFE
		oDanfe:SetResolution(78)
		oDanfe:SetPortrait()
		oDanfe:SetPaperSize(DMPAPER_A4)
		oDanfe:SetMargin(60, 60, 60, 60)
		
		//Força a impressão em PDF
		oDanfe:nDevice  := 6
		oDanfe:cPathPDF := cPasta				
		oDanfe:lServer  := .F.
		oDanfe:lViewPDF := .F.
		
		//Variáveis obrigatórias da DANFE
		PixelX    := oDanfe:nLogPixelX()
		PixelY    := oDanfe:nLogPixelY()
		nConsNeg  := 0.4
		nConsTex  := 0.5
		oRetNF    := Nil
		lPtImpBol := .F.
		aNotasBol := {}
		nColAux   := 0
		
		//Chamando a impressão da danfe no RDMAKE
		RptStatus({|lEnd| StaticCall(DANFEII, DanfeProc, @oDanfe, @lEnd, cIdent, , , .F.)}, "Imprimindo Danfe...")
		oDanfe:Print()
	EndIf
	
	RestArea(aArea)
Return