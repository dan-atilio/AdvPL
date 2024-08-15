/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2024/08/06/como-atualizar-um-browse-ao-alternar-de-linha-de-outro-browse-ti-responde-0070/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} User Function zVid0070
Exemplo de um browse que atualiza o outro manualmente (sem usar MVC com SetRelation e sem usar FWBrwRelation)
@type  Function
@author Atilio
@since 13/11/2023
@obs Baixe o zExecQry nesse link - https://terminaldeinformacao.com/2021/04/21/como-fazer-um-update-via-advpl/
/*/

User Function zVid0070()
    Local aArea        := GetArea()
    Local cFontPad     := 'Tahoma'
    Local oFontGrid    := TFont():New(cFontPad,,-14)
    Local bBlocoOk     := {|| lOk := .T., fMostraMark(), oDlgMark:End()}
    Local bBlocoCan    := {|| lOk := .F., oDlgMark:End()}
    Local aOutrasAc    := {}
    Local bBlocoIni    := {|| EnchoiceBar(oDlgMark, bBlocoOk, bBlocoCan, , aOutrasAc)}
    Local lDimPixels   := .T.
    Local cJanTitulo   := "Estados x Cidades"
    Local lCentraliz   := .T.
    //Janela e componentes
    Private oDlgMark
    Private aRotina    := MenuDef()
    //Estado
    Private oPanelEst
    Private oMarkEst
    Private cAliasEst  := GetNextAlias()
    Private aCamposEst := {}
    Private oTmpTabEst := Nil
    Private aColunEst  := {}
    //Municipios
    Private oPanelMun
    Private oMarkMun
    Private cAliasMun  := GetNextAlias()
    Private aCamposMun := {}
    Private oTmpTabMun := Nil
    Private aColunMun  := {}
    //Tamanho da janela
    Private aTamanho   := MsAdvSize()
    Private nJanLarg   := aTamanho[5]
    Private nJanAltu   := aTamanho[6]
    Private nColMeio   := (nJanLarg/2) /2
     
    //Adiciona as colunas que serão criadas na temporária (estados)
    aAdd(aCamposEst, {'XX_SIGLA',  'C',  2, 0}) //Sigla do Estado (ex.: AC)
    aAdd(aCamposEst, {'XX_ESTADO', 'C', 30, 0}) //Nome do Estado (ex.: ACRE)

    //Cria a tabela temporária
    oTmpTabEst:= FWTemporaryTable():New(cAliasEst)
    oTmpTabEst:SetFields(aCamposEst)
    oTmpTabEst:Create()  

    //Adiciona as colunas que serão criadas na temporária (municipios)
    aAdd(aCamposMun, {'OK',        'C',   2, 0}) //Flag para marcação
    aAdd(aCamposMun, {'XX_SIGLA',  'C',   2, 0}) //Sigla do Estado (ex.: SP)
    aAdd(aCamposMun, {'XX_CODMUN', 'C',   5, 0}) //Código da Cidade (ex.: 06003)
    aAdd(aCamposMun, {'XX_NOME',   'C',  50, 0}) //Nome da Cidade (ex.: BAURU)

    //Cria a tabela temporária
    oTmpTabMun:= FWTemporaryTable():New(cAliasMun)
    oTmpTabMun:SetFields(aCamposMun)
    oTmpTabMun:Create()  

    //Popula as tabelas temporárias
    Processa({|| fPopula()}, 'Processando...')

    //Adiciona as colunas que serão exibidas no FWMarkBrowse
    fCriaCols()
     
    //Criando a janela
    oDlgMark := TDialog():New(0, 0, nJanAltu, nJanLarg, cJanTitulo, , , , , , /*nCorFundo*/, , , lDimPixels)
        //Dados dos Estados
        oPanelEst := tPanel():New(030, 001, '', oDlgMark, , , , RGB(000,000,000), RGB(254,254,254), nColMeio - 1,     (nJanAltu/2 - 1))
        oMarkEst := FWMarkBrowse():New()
        oMarkEst:SetAlias(cAliasEst)                
        oMarkEst:SetDescription('Estados')
        oMarkEst:DisableFilter()
        oMarkEst:DisableConfig()
        oMarkEst:DisableSeek()
        oMarkEst:DisableSaveConfig()
        oMarkEst:DisableReport()
        oMarkEst:SetFontBrowse(oFontGrid)
        //oMarkEst:SetFieldMark('OK')
        oMarkEst:SetTemporary(.T.)
        oMarkEst:SetColumns(aColunEst)
        //oMarkEst:AllMark() 
        oMarkEst:SetOwner(oPanelEst)
        oMarkEst:oBrowse:bChange := {|| fMudaLin()}
        oMarkEst:Activate()

        //Dados dos Municipios
        oPanelMun := tPanel():New(030, nColMeio + 1, '', oDlgMark, , , , RGB(000,000,000), RGB(254,254,254), (nJanLarg/2 -10),     (nJanAltu/2 - 1))
        oMarkMun := FWMarkBrowse():New()
        oMarkMun:SetAlias(cAliasMun)                
        oMarkMun:SetDescription('Municípios')
        oMarkMun:DisableFilter()
        oMarkMun:DisableConfig()
        oMarkMun:DisableSeek()
        oMarkMun:DisableSaveConfig()
        oMarkMun:DisableReport()
        oMarkMun:SetFontBrowse(oFontGrid)
        oMarkMun:SetFieldMark('OK')
        oMarkMun:SetTemporary(.T.)
        oMarkMun:SetColumns(aColunMun)
        //oMarkMun:AllMark() 
        oMarkMun:SetOwner(oPanelMun)
        oMarkMun:Activate()

    //Ativa e exibe a janela
    oDlgMark:Activate(, , , lCentraliz, , , bBlocoIni)
    
    //Deleta a temporária e desativa a tela de marcação
    oTmpTabEst:Delete()
    oTmpTabMun:Delete()
    oMarkEst:DeActivate()
    oMarkMun:DeActivate()
    
    RestArea(aArea)
Return

Static Function MenuDef()
    Local aRotina := {}
Return aRotina

Static Function fPopula()
    Local cQryUpd := ""

    //Vamos inserir todos os estados na temporária
    cQryUpd := ""
    cQryUpd += " INSERT INTO " + oTmpTabEst:GetRealName() + CRLF
    cQryUpd += " (XX_SIGLA, XX_ESTADO) " + CRLF
    cQryUpd += " SELECT X5_CHAVE, X5_DESCRI FROM " + RetSQLName("SX5") + " WHERE X5_TABELA = '12' ORDER BY X5_CHAVE "
    u_zExecQry(cQryUpd, .T.)

    //Vamos inserir todos os municipios na segunda temporária
    cQryUpd := ""
    cQryUpd += " INSERT INTO " + oTmpTabMun:GetRealName() + CRLF
    cQryUpd += " (XX_SIGLA, XX_CODMUN, XX_NOME) " + CRLF
    cQryUpd += " SELECT CC2_EST, CC2_CODMUN, CC2_MUN FROM CC2990 WHERE D_E_L_E_T_ = ' ' ORDER BY CC2_EST, CC2_CODMUN "
    u_zExecQry(cQryUpd, .T.)
Return

Static Function fCriaCols()
    Local nAtual   := 0 
    Local aEstrut  := {}
    Local oColumn
    
    //Adicionando campos que serão mostrados na tela
    //[1] - Campo da Temporaria
    //[2] - Titulo
    //[3] - Tipo
    //[4] - Tamanho
    //[5] - Decimais
    //[6] - Máscara
    aEstrut := {}
    aAdd(aEstrut, {'XX_SIGLA',  'Sigla',  'C',  2, 0, ''})
    aAdd(aEstrut, {'XX_ESTADO', 'Estado', 'C', 30, 0, ''})

    //Percorrendo todos os campos da estrutura
    For nAtual := 1 To Len(aEstrut)
        //Cria a coluna
        oColumn := FWBrwColumn():New()
        oColumn:SetData(&('{|| ' + cAliasEst + '->' + aEstrut[nAtual][1] +'}'))
        oColumn:SetTitle(aEstrut[nAtual][2])
        oColumn:SetType(aEstrut[nAtual][3])
        oColumn:SetSize(aEstrut[nAtual][4])
        oColumn:SetDecimal(aEstrut[nAtual][5])
        oColumn:SetPicture(aEstrut[nAtual][6])

        //Adiciona a coluna
        aAdd(aColunEst, oColumn)
    Next

    //Adicionando campos que serão mostrados na tela
    //[1] - Campo da Temporaria
    //[2] - Titulo
    //[3] - Tipo
    //[4] - Tamanho
    //[5] - Decimais
    //[6] - Máscara
    aEstrut := {}
    aAdd(aEstrut, {'XX_CODMUN', 'Codigo',    'C',  5, 0, ''})
    aAdd(aEstrut, {'XX_NOME',   'Município', 'C', 50, 0, ''})

    //Percorrendo todos os campos da estrutura
    For nAtual := 1 To Len(aEstrut)
        //Cria a coluna
        oColumn := FWBrwColumn():New()
        oColumn:SetData(&('{|| ' + cAliasMun + '->' + aEstrut[nAtual][1] +'}'))
        oColumn:SetTitle(aEstrut[nAtual][2])
        oColumn:SetType(aEstrut[nAtual][3])
        oColumn:SetSize(aEstrut[nAtual][4])
        oColumn:SetDecimal(aEstrut[nAtual][5])
        oColumn:SetPicture(aEstrut[nAtual][6])

        //Adiciona a coluna
        aAdd(aColunMun, oColumn)
    Next
Return

Static Function fMudaLin()
    Local cEstado := (cAliasEst)->XX_SIGLA
    Local cFiltro := cAliasMun + "->XX_SIGLA == '" + cEstado + "'"

    //Aplica o filtro no alias de municipios
    (cAliasMun)->(DbClearFilter())
    (cAliasMun)->(DbSetFilter({|| &(cFiltro)}, cFiltro))

    //Atualiza a grid de cidades
    If Type("oMarkMun") != "U"
        oMarkMun:Refresh(.T.)
    EndIf
Return

Static Function fMostraMark()
    Local cMensagem := ""
    Local cMarca    := oMarkMun:Mark()

    //Limpa o filtro dos municipios e posiciona no topo
    (cAliasMun)->(DbClearFilter())
    (cAliasMun)->(DbGoTop())

    //Percorre todos os registros
    While ! (cAliasMun)->(EoF())

        //Se o registro tiver marcado
        If oMarkMun:IsMark(cMarca)
            cMensagem += PadR((cAliasMun)->XX_SIGLA, 3) + "|" + (cAliasMun)->XX_CODMUN + "|" + (cAliasMun)->XX_NOME + "|" + CRLF
        EndIf

        (cAliasMun)->(DbSkip())
    EndDo

    //Se tiver mensagem
    If ! Empty(cMensagem)
        cMensagem := "Est" + "|" + PadR("Cod.", 5) + "|" + PadR("Cidade", 50) + "|" + CRLF + CRLF + cMensagem
        ShowLog(cMensagem)
    EndIf
Return
