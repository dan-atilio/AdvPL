/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2024/10/10/como-fazer-um-markbrowse-com-coluna-editavel-via-advpl-ti-responde-0089/ 
    
*/


//Bibliotecas
#Include "Totvs.ch"
#Include "FWMVCDef.ch"

/*/{Protheus.doc} User Function zVid0089
Exemplo de tela com marcação de dados
@author Atilio
@since 20/02/2023
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function zVid0089()
	Local aArea := FWGetArea()
	Local aPergs   := {}
	Local xPar0 := Space(TamSX3('B1_COD')[1])
	Local xPar1 := StrTran(xPar0, ' ', 'Z')
	
	//Adicionando os parametros do ParamBox
	aAdd(aPergs, {1, "Produto De",  xPar0,  "", ".T.", "SB1", ".T.", 80,  .F.})
	aAdd(aPergs, {1, "Produto Até", xPar1,  "", ".T.", "SB1", ".T.", 80,  .T.})
	
	//Se a pergunta for confirma, chama a tela
	If ParamBox(aPergs, 'Informe os parâmetros', /*aRet*/, /*bOk*/, /*aButtons*/, /*lCentered*/, /*nPosx*/, /*nPosy*/, /*oDlgWizard*/, /*cLoad*/, .F., .F.)
		fMontaTela()
	EndIf
	
	FWRestArea(aArea)
Return

/*/{Protheus.doc} fMontaTela
Monta a tela com a marcação de dados
@author Atilio
@since 20/02/2023
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fMontaTela()
    Local aArea         := GetArea()
    Local aCampos := {}
    Local oTempTable := Nil
    Local aColunas := {}
    Local cFontPad    := 'Tahoma'
    Local oFontGrid   := TFont():New(cFontPad, /*uPar2*/, -14)
    //Barra de Botões
    Local bBlocoOk     := {|| lOk := .T., oDlgBrow:End()}
    Local bBlocoCan    := {|| lOk := .F., oDlgBrow:End()}
    Local aOutrasAc    := {}
    Local bBlocoIni    := {|| EnchoiceBar(oDlgBrow, bBlocoOk, bBlocoCan, , aOutrasAc)}
    Private lOk        := .F.
    //Janela e componentes
    Private oDlgBrow
    Private oPanGrid
    Private oFWBrowse
    Private cAliasTmp := GetNextAlias()
    Private aRotina   := MenuDef()
    //Tamanho da janela
    Private aTamanho := MsAdvSize()
    Private nJanLarg := aTamanho[5]
    Private nJanAltu := aTamanho[6]

    //Opções no Outras Ações
    aAdd(aOutrasAc, {'BMP', {|| fMarkTod()}, '* (Des) Marcar todos registros'})
     
    //Adiciona as colunas que serão criadas na temporária
    aAdd(aCampos, { 'FLAG_OK', 'L', 1,                    0}) //Flag para marcação
    aAdd(aCampos, { 'B1_COD',  'C', TamSX3('B1_COD')[1],  0}) //Produto
    aAdd(aCampos, { 'B1_TIPO', 'C', TamSX3('B1_TIPO')[1], 0}) //Tipo
    aAdd(aCampos, { 'B1_UM',   'C', TamSX3('B1_UM')[1],   0}) //Unid. Med.
    aAdd(aCampos, { 'B1_DESC', 'C', TamSX3('B1_DESC')[1], 0}) //Descrição
    aAdd(aCampos, { 'RECNUM',  'N', 16,                   0}) //RecNo da SB1

    //Cria a tabela temporária
    oTempTable:= FWTemporaryTable():New(cAliasTmp)
    oTempTable:SetFields( aCampos )
    oTempTable:Create()  

    //Popula a tabela temporária
    Processa({|| fPopula()}, 'Processando...')

    //Adiciona as colunas que serão exibidas no browse
    aColunas := fCriaCols()
     
    //Criando a janela
    oDlgBrow := TDialog():New(0, 0, nJanAltu, nJanLarg, 'Tela para Consulta de Dados - Autumn Code Maker', , , , , , /*nCorFundo*/, , , .T.)
        //Dados
        oPanGrid := tPanel():New(035, 001, '', oDlgBrow, /*oFont*/, /*lCentered*/, /*uParam7*/, RGB(000,000,000), RGB(254,254,254), (nJanLarg/2) - 1, (nJanAltu/2) - 1)
        oFWBrowse := FWBrowse():New()
        oFWBrowse:DisableFilter()
        oFWBrowse:DisableConfig()
        oFWBrowse:DisableReport()
        oFWBrowse:DisableSeek()
        oFWBrowse:DisableSaveConfig()
        oFWBrowse:SetFontBrowse(oFontGrid)
        oFWBrowse:SetAlias(cAliasTmp)
        oFWBrowse:SetDataTable()
        oFWBrowse:SetEditCell(.T., {|| .T.}) 
        oFWBrowse:lHeaderClick := .F.
        oFWBrowse:AddMarkColumns(;
            {|| Iif((cAliasTmp)->FLAG_OK, 'LBOK', 'LBNO') },;      //ícones
            {|| (cAliasTmp)->FLAG_OK := ! (cAliasTmp)->FLAG_OK};   //ao dar duplo clique
        )
        
        //Define as colunas, vincula ao painel e exibe
        oFWBrowse:SetColumns(aColunas)
        oFWBrowse:SetOwner(oPanGrid)
        oFWBrowse:Activate()
        
    oDlgBrow:Activate(, , , .T., , , bBlocoIni)

    //Se usuário clicou no botão confirmar
    If lOk
        fConfirmou()
    EndIf
    
    //Deleta a temporária e desativa a tela de marcação
    oTempTable:Delete()
    oFWBrowse:DeActivate()
    
    RestArea(aArea)
Return

/*/{Protheus.doc} MenuDef
Botões usados no Browse
@author Atilio
@since 20/02/2023
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function MenuDef()
    Local aRotina := {}
     
    //Criação das opções
    ADD OPTION aRotina TITLE 'Continuar'  ACTION 'u_zVid72Ok'     OPERATION 2 ACCESS 0
Return aRotina

/*/{Protheus.doc} fPopula
Executa a query SQL e popula essa informação na tabela temporária usada no browse
@author Atilio
@since 20/02/2023
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fPopula()
    Local cQryDados := ''
    Local nTotal := 0
    Local nAtual := 0

    //Monta a consulta
    cQryDados += "SELECT B1_COD, B1_TIPO, B1_UM, B1_DESC, SB1.R_E_C_N_O_ AS SB1REC "		+ CRLF
    cQryDados += "FROM SB1990 SB1 "		+ CRLF
    cQryDados += "WHERE B1_FILIAL = '' AND B1_COD >= '" + MV_PAR01 + "' AND B1_COD <= '" + MV_PAR02 + "' AND SB1.D_E_L_E_T_ = ' ' "		+ CRLF
    cQryDados += "ORDER BY B1_COD"		+ CRLF
    PLSQuery(cQryDados, 'QRYDADTMP')

    //Definindo o tamanho da régua
    DbSelectArea('QRYDADTMP')
    Count to nTotal
    ProcRegua(nTotal)
    QRYDADTMP->(DbGoTop())

    //Enquanto houver registros, adiciona na temporária
    While ! QRYDADTMP->(EoF())
        nAtual++
        IncProc('Analisando registro ' + cValToChar(nAtual) + ' de ' + cValToChar(nTotal) + '...')

        RecLock(cAliasTmp, .T.)
            (cAliasTmp)->FLAG_OK := .F.
            (cAliasTmp)->B1_COD := QRYDADTMP->B1_COD
            (cAliasTmp)->B1_TIPO := QRYDADTMP->B1_TIPO
            (cAliasTmp)->B1_UM := QRYDADTMP->B1_UM
            (cAliasTmp)->B1_DESC := QRYDADTMP->B1_DESC
            (cAliasTmp)->RECNUM := QRYDADTMP->SB1REC
        (cAliasTmp)->(MsUnlock())

        QRYDADTMP->(DbSkip())
    EndDo
    QRYDADTMP->(DbCloseArea())
    (cAliasTmp)->(DbGoTop())
Return

/*/{Protheus.doc} fCriaCols
Função que gera as colunas usadas no browse (similar ao antigo aHeader)
@author Atilio
@since 20/02/2023
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fCriaCols()
    Local nAtual       := 0 
    Local aColunas := {}
    Local aEstrut  := {}
    Local oColumn
    
    //Adicionando campos que serão mostrados na tela
    //[1] - Campo da Temporaria
    //[2] - Titulo
    //[3] - Tipo
    //[4] - Tamanho
    //[5] - Decimais
    //[6] - Máscara
    //[7] - Editável? .T. = sim, .F. = não
    aAdd(aEstrut, { 'B1_COD',  'Produto',    'C', TamSX3('B1_COD')[1],  0, '',     .F.})
    aAdd(aEstrut, { 'B1_TIPO', 'Tipo',       'C', TamSX3('B1_TIPO')[1], 0, '',     .F.})
    aAdd(aEstrut, { 'B1_UM',   'Unid. Med.', 'C', TamSX3('B1_UM')[1],   0, '',     .F.})
    aAdd(aEstrut, { 'B1_DESC', 'Descrição',  'C', TamSX3('B1_DESC')[1], 0, '',     .T.})

    //Percorrendo todos os campos da estrutura
    For nAtual := 1 To Len(aEstrut)
        //Cria a coluna
        oColumn := FWBrwColumn():New()
        oColumn:SetData(&('{|| ' + cAliasTmp + '->' + aEstrut[nAtual][1] +'}'))
        oColumn:SetTitle(aEstrut[nAtual][2])
        oColumn:SetType(aEstrut[nAtual][3])
        oColumn:SetSize(aEstrut[nAtual][4])
        oColumn:SetDecimal(aEstrut[nAtual][5])
        oColumn:SetPicture(aEstrut[nAtual][6])

        //Se for ser possível ter o duplo clique
        If aEstrut[nAtual][7]
            oColumn:SetEdit(.T.)
            oColumn:SetReadVar(aEstrut[nAtual][1])
            //oColumn:SetValid({|| fSuaValid()})
        EndIf

        //Adiciona a coluna
        aAdd(aColunas, oColumn)
    Next
Return aColunas

/*/{Protheus.doc} fConfirmou
Função acionada após fechar a tela se o usuário confirmou
@author Atilio
@since 20/02/2023
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fConfirmou()
    Processa({|| fProcessa()}, 'Processando...')
Return

/*/{Protheus.doc} fProcessa
Função que percorre os registros da tela
@author Atilio
@since 20/02/2023
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fProcessa()
    Local aArea     := FWGetArea()
    Local nAtual    := 0
    Local nTotal    := 0
    Local nTotMarc := 0
    
    //Define o tamanho da régua
    DbSelectArea(cAliasTmp)
    (cAliasTmp)->(DbGoTop())
    Count To nTotal
    ProcRegua(nTotal)
    
    //Percorrendo os registros
    (cAliasTmp)->(DbGoTop())
    While ! (cAliasTmp)->(EoF())
        nAtual++
        IncProc('Analisando registro ' + cValToChar(nAtual) + ' de ' + cValToChar(nTotal) + '...')
    
        //Caso esteja marcado
        If (cAliasTmp)->FLAG_OK
            nTotMarc++
            
            //Posiciona no registro original
            RecLock("SB1")
            SB1->(DbGoTo((cAliasTmp)->RECNUM))

            //Grava a alteração
            RecLock("SB1", .F.)
                SB1->B1_DESC := (cAliasTmp)->B1_DESC
            SB1->(MsUnlock())
        EndIf
         
        (cAliasTmp)->(DbSkip())
    EndDo
    
    //Mostra a mensagem de término e caso queria fechar a dialog, basta usar o método End()
    FWAlertInfo('Dos [' + cValToChar(nTotal) + '] registros, foram processados [' + cValToChar(nTotMarc) + '] registros', 'Atenção')

    FWRestArea(aArea)
Return

Static Function fMarkTod()
    //Percorre todos os registros
    DbSelectArea(cAliasTmp)
    (cAliasTmp)->(DbGoTop())
    While ! (cAliasTmp)->(EoF())
        //Atualiza o registro atual
        RecLock(cAliasTmp, .F.)
            (cAliasTmp)->FLAG_OK := ! (cAliasTmp)->FLAG_OK
        (cAliasTmp)->(MsUnlock())

        (cAliasTmp)->(DbSkip())
    EndDo

    //Volta pro topo, e atualiza a tela
    (cAliasTmp)->(DbGoTop())
    oFWBrowse:Refresh()
Return
