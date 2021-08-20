/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: 
	https://terminaldeinformacao.com/2021/11/18/como-gerar-um-excel-de-um-fwbrowse/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zBrw2Exc
Função que exporta dados de um FWBrowse para Excel
@type  Function
@author Atilio
@since 02/06/2021
@obs A variável aColunas (array com FWBrwColumn) tem que ser uma variável Private antes de acionar esse fonte
	E a variável cAliasTmp também deve ser Private, com o nome da temporária usada na tela
/*/

User Function zBrw2Exc()
	Processa({|| fExportar()}, "Processando...")
Return

Static Function fExportar()
	Local aAreaTmp := (cAliasTmp)->(GetArea())
    Local nColAtu := 0
    Local nAtual := 0
    Local oFWMsExcel
	Local oExcel
	Local cArquivo   := GetTempPath() + "browse_" + dToS(Date()) + "_" + StrTran(Time(), ":", "-") + ".xml"
	Local cWorkSheet := "Planilha"
	Local cTituloExc := "Exportação de Informações"
    Local aLinha := {}

    //Cria a planilha do excel
	oFWMsExcel := FWMSExcel():New()
	
	//Criando as abas da planilha
	oFWMsExcel:AddworkSheet(cWorkSheet)
	
	//Criando as Tabelas e as colunas
	oFWMsExcel:AddTable(cWorkSheet, cTituloExc)
    For nColAtu := 1 To Len(aColunas)
		//Se a coluna for numérica, alinha a direita
        If aColunas[nColAtu]:cType == "N"
            oFWMsExcel:AddColumn(cWorkSheet, cTituloExc, aColunas[nColAtu]:cTitle, 3, 2, .F.)
		//Senão, alinha a esquerda
        Else
            oFWMsExcel:AddColumn(cWorkSheet, cTituloExc, aColunas[nColAtu]:cTitle, 1, 1, .F.)
        EndIf
    Next

	//Posiciona no topo da temporária
    DbSelectArea(cAliasTmp)
    (cAliasTmp)->(DbGoTop())
    Count To nTotal
    ProcRegua(nTotal)
    (cAliasTmp)->(DbGoTop())

    //Enquanto houver dados
    While ! (cAliasTmp)->(EoF())
        nAtual++
        IncProc("Adicionando na planilha registro " + cValToChar(nAtual) + " de " + cValToChar(nTotal) + "...")

        aLinha := {}
        For nColAtu := 1 To Len(aColunas)
            aAdd(aLinha, eVal(aColunas[nColAtu]:bData))
        Next

        oFWMsExcel:AddRow(cWorkSheet, cTituloExc, aLinha)

        (cAliasTmp)->(DbSkip())
    EndDo

    //Esperando 5 segundos para gerar o arquivo
    Sleep(5000)

	//Ativando o arquivo e gerando o xml
	oFWMsExcel:Activate()
	oFWMsExcel:GetXMLFile(cArquivo)
	
	//Abrindo o excel e abrindo o arquivo xml
	oExcel := MsExcel():New()
	oExcel:WorkBooks:Open(cArquivo)
	oExcel:SetVisible(.T.)
	oExcel:Destroy()

    RestArea(aAreaTmp)
Return
