/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFonte42
Abre uma tela de parâmetros para o usuário informar nos campos
@type Function
@author Atilio
@since 28/03/2023
/*/

User Function zFonte42()
    Local aArea      := FWGetArea()
    
    fExempSimp()

    fExempComp()

    FWRestArea(aArea)
Return

Static Function fExempSimp()
    Local aPergs   := {}
    Local cProdDe  := Space(TamSX3('B1_COD')[01])
    Local cProdAt  := Space(TamSX3('B1_COD')[01])
    Local dDataDe  := FirstDate(Date())
    Local dDataAt  := LastDate(dDataDe)
    Local nTipo    := 3
    
    //Adiciona as perguntas utilizadas na tela de parâmetros
    aAdd(aPergs, {1, "Produto De",  cProdDe,  "", "ExistCPO('SB1')", "SB1", ".T.", 60,  .F.})
    aAdd(aPergs, {1, "Produto Até", cProdAt,  "", "ExistCPO('SB1')", "SB1", ".T.", 60,  .T.})
    aAdd(aPergs, {1, "Data De",  dDataDe,  "", ".T.", "", ".T.", 80,  .F.})
    aAdd(aPergs, {1, "Data Até", dDataAt,  "", ".T.", "", ".T.", 80,  .T.})
    aAdd(aPergs, {2, "Tipo do Filtro",      nTipo, {"1=Não Bloqueados", "2=Somente Bloqueados", "3=Ambos"},  090, ".T.", .F.})

    //Se a pergunta foi confirmada    
    If ParamBox(aPergs, "Informe os parâmetros")
        MV_PAR05 := Val(cValToChar(MV_PAR05))

        FWAlertSuccess("Pergunta confirmada", "Teste Simples de ParamBox")
    EndIf

Return

Static Function fExempComp()
    Local aPergs   := {}
    Local cProduto := Space(TamSX3('B1_COD')[01])
    Local nTipoCmb := 3
    Local nTipoRad := 3
    Local lFiltArm := .T.
    Local lFiltGrp := .T.
    Local cArquivo := "C:\spool\teste.txt"
    
    //Adiciona as perguntas utilizadas na tela de parâmetros
    aAdd(aPergs, { 1, "01 (Get) - Informe o Produto",        cProduto,  "", "ExistCPO('SB1')", "SB1", ".T.", 60,  .T.})
    aAdd(aPergs, { 2, "02 (Combo) - Tipo",                   nTipoCmb, {"1=Não Bloqueados", "2=Somente Bloqueados", "3=Ambos"},  090, ".T.", .F.})
    aAdd(aPergs, { 3, "03 (Radio) - Tipo",                   nTipoRad, {"1=Não Bloqueados", "2=Somente Bloqueados", "3=Ambos"},  090, ".T.", .F., ".T."})
    aAdd(aPergs, { 4, "04 (CheckBox) - Filtra Armazém 01",   lFiltArm, "Sim, será filtrado",  090, ".T.", .F.})
    aAdd(aPergs, { 5, "05 (CheckBox) - Filtra Grupo G001",   lFiltGrp, 100, ".T."})
    aAdd(aPergs, { 6, "06 (File) - Caminho do arquivo",      cArquivo, "", ".T.", ".T.", 100, .F., "Arquivos txt|*.txt| Arquivos csv|*.csv", "C:\spool\", GETF_LOCALHARD  + GETF_NETWORKDRIVE, .T.})
    aAdd(aPergs, { 7, "07 (Filtro) - Filtro específico",     "SB1", "", .T.})
    aAdd(aPergs, { 8, "08 (Password) - Informe a Senha",     "beluga",  "", ".T.", "", ".T.", 60,  .T.})
    aAdd(aPergs, { 9, "09 (Say) - Apenas uma frase",         100, 20, .T.})
    aAdd(aPergs, {10, "10 (Range) - Range de dados",         "", "SB1", 110, "C", 50, ".T."})
    aAdd(aPergs, {11, "11 (Memo) - Digite uma frase",        "aaaa", ".T.", ".T.", .F.})
    aAdd(aPergs, {12, "12 (Filtro) - Informe o filtro",      "SB1", "", ".T."})

    //Se a pergunta foi confirmada    
    If ParamBox(aPergs, "Informe os parâmetros", , , , , , , , , .F., .F.)
        MV_PAR02 := Val(cValToChar(MV_PAR02))
        MV_PAR03 := Val(cValToChar(MV_PAR03))

        FWAlertSuccess("Pergunta confirmada", "Teste Completo de ParamBox")
    EndIf

Return
