/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2024/08/22/como-fazer-uma-tela-mobile-usando-apenas-advpl-ti-responde-0075/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zVid0075
Função que abre uma tela mobile via programa inicial
@type  Function
@author Atilio
@since 24/11/2023
@obs No appserver.ini, colque para já abrir direto via programa inicial, exemplo:

[WEBAPP]
Port=8099
HideParamsForm=1
LastMainProg=U_ZVID0075
EnvServer=AMBTST2

/*/

User Function zVid0075()
    
    //Prepara o ambiente
    If Select("SX2") <= 0
		RPCSetEnv("99","01","daniel.atilio","tst123","","")
    EndIf

    //Aciona a montagem de tela
    fMontaTela()
Return

Static Function fMontaTela()
    Local aArea := FWGetArea()
    //Tamanho da Janela e Comportamentos (centralizado)
    Private aTamanho    := GetScreenRes()
    Private nJanLarg    := aTamanho[1]
    Private nJanAltu    := aTamanho[2]
    Private lCentered   := .F.
    //Fontes usadas pelos objetos
    Private cFontPad    := "Tahoma"
    Private oFontTit    := TFont():New(cFontPad, , -38)
	Private oFontGrid   := TFont():New(cFontPad, , -15)
    //Objetos e variáveis da tela principal
    Private oDlgMain    := Nil
    Private oPanGrid    := Nil
    Private oGetGrid    := Nil
    Private oBtnAlt     := Nil
    Private oSayTitulo  := Nil
    Private cSayTitulo  := "Bem vindo -Usuário-"
    Private aColunas    := {}
    //Estilo CSS dos botões
    Private cCSSAzul    := "TButton { font: bold;     background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #3DAFCC, stop: 1 #0D9CBF);    color: #FFFFFF;     border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:focus {    padding:0px; outline-width:1px; outline-style:solid; outline-color: #51DAFC; outline-radius:3px; border-color:#369CB5;}TButton:hover {    color: #FFFFFF;     background-color : qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #3DAFCC, stop: 1 #1188A6);    border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:pressed {    color: #FFF;     background-color : qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #1188A6, stop: 1 #3DAFCC);    border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #369CB5; }TButton:disabled {    color: #FFFFFF;     background-color: #4CA0B5; }"
    Private cCSSAmarel  := "TButton { font: bold;     background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #000F00, stop: 1 #B4C00E);    color: #FFFFFF;     border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #B2B637; }TButton:focus {	padding:0px; outline-width:1px; outline-style:solid; outline-color: #FDFD52; outline-radius:3px; border-color:#B2B637;}TButton:hover {	color: #FFFFFF;     background-color : qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #000F00, stop: 1 #A1A611);    border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #B2B637; }TButton:pressed {	color: #000;     background-color : qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,stop: 0 #A1A611, stop: 1 #000F00);    border-width: 1px;     border-style: solid;     border-radius: 3px;     border-color: #B2B637; }TButton:disabled {	color: #FFFFFF;     background-color: #B6B34D; }"
    //Tabela temporária
    Private cAliasTab
    Private oTempTable
    Private aFields    := {}

    //Define a tabela temporária
    cAliasTab := GetNextAlias()
    oTempTable := FWTemporaryTable():New(cAliasTab)
    
    //Cria os campos
    aFields := {}
    aAdd(aFields, {"XXCODIGO", "C",   6, 0})
    aAdd(aFields, {"XXDESCRI", "C",  30, 0})
    aAdd(aFields, {"XXQUANTI", "N",   9, 2})
    aAdd(aFields, {"XXEMISSA", "D",   8, 0})
    aAdd(aFields, {"XXOBSERV", "C", 100, 0})
    
    //Efetiva a criação da temporária e define um índice
    oTempTable:SetFields(aFields)
    oTempTable:AddIndex("1", {"XXCODIGO"} )
    oTempTable:Create()
    
    //Monta a estrutura das colunas exibidas na grid
    fMontaHead()

    //Popula a tabela temporária
    fMontDados() 

    //Cria a janela sem o botão de fechar e sem ser possível sair pelo -ESC-
    oDlgMain := TDialog():New(0, 0, nJanAltu, nJanLarg, "Teste Mobile", /*uParam6*/, /*uParam7*/, /*uParam8*/, DS_MODALFRAME, CLR_BLACK, RGB(250, 250, 250), , , .T.)
        oDlgMain:lEscClose := .F.

        //Mostra o título acima da grid
        oSayTitulo := TSay():New(002, 002, {|| cSayTitulo}, oDlgMain, "", oFontTit,  , , , .T., RGB(149, 179, 215), , (nJanLarg/2), 30, , , , , , .F., , )

        //Monta um painel onde será exibido a grid da temporária
        oPanGrid := tPanel():New(036, 002, "", oDlgMain, , , , RGB(000,000,000), RGB(254,254,254), (nJanLarg/2 - 3),     (nJanAltu/2 - 75))
            oGetGrid := FWBrowse():New()
            oGetGrid:DisableFilter()
            oGetGrid:DisableConfig()
            oGetGrid:DisableReport()
            oGetGrid:DisableSeek()
            oGetGrid:DisableSaveConfig()
            oGetGrid:SetFontBrowse(oFontGrid)
            oGetGrid:SetAlias(cAliasTab)
            oGetGrid:SetDataTable()
            oGetGrid:AddLegend(cAliasTab + "->XXQUANTI == 0", "YELLOW", "Quantidade zerada")
            oGetGrid:AddLegend(cAliasTab + "->XXQUANTI <  0", "RED",    "Quantidade menor que zero")
            oGetGrid:AddLegend(cAliasTab + "->XXQUANTI >  0", "GREEN",  "Quantidade maior que zero")
            oGetGrid:SetColumns(aColunas)
            oGetGrid:SetOwner(oPanGrid)
            oGetGrid:Activate()

        //Cria o botão de Alteração
        oBtnAlt := TButton():New((nJanAltu/2 - 72), 2, "Alterar", oDlgMain, {|| fAltera()}, (nJanLarg/2 - 3), 69, , oFontTit, , .T.)
        oBtnAlt:SetCSS(cCSSAzul)

    //Ativa a dialog
    oDlgMain:Activate(, , , lCentered, {|| .T.}, , )

    //Após fechar a dialog principal, apaga a temporária
    oTempTable:Delete()

    FWRestArea(aArea)
Return


Static Function fMontaHead()
    Local nAtual
    Local aHeadAux := {}

    //Array com a estrutura de campos que será usada na grid
    aAdd(aHeadAux, {"XXCODIGO", "Código",     "C",   6,  0, "",              .F.})
    aAdd(aHeadAux, {"XXDESCRI", "Descricao",  "C",  30,  0, "",              .F.})
    aAdd(aHeadAux, {"XXQUANTI", "Quantidade", "N",   9,  2, "@E 999,999.99", .T.})
    aAdd(aHeadAux, {"XXEMISSA", "Emissão",    "D",   8,  0, "",              .T.})
    aAdd(aHeadAux, {"XXOBSERV", "Observação", "C", 100,  0, "",              .T.})
    
    //Percorre o array e vem adicionando nas colunas
    For nAtual := 1 To Len(aHeadAux)
        oColumn := FWBrwColumn():New()
        oColumn:SetData(&("{|| " + cAliasTab + "->" + aHeadAux[nAtual][1] +"}"))
        oColumn:SetTitle(aHeadAux[nAtual][2])
        oColumn:SetType(aHeadAux[nAtual][3])
        oColumn:SetSize(aHeadAux[nAtual][4])
        oColumn:SetDecimal(aHeadAux[nAtual][5])
        oColumn:SetPicture(aHeadAux[nAtual][6])
  
        aAdd(aColunas, oColumn)
    Next
Return

Static Function fMontDados()
    Local aArea   := GetArea()
    Local nAtual  := 0
    Local nTotal  := 50
    Local dDtRef  := Date()
    Local cCodAtu := "000000"
    Local cDescri := ""
    Local nQuanti := 0
    Local dEmissa := sToD("")
    
    //Percorre um valor de dados
    For nAtual := 1 To nTotal
        nAtual++
  
        cCodAtu := Soma1(cCodAtu)
        cDescri := "[" + Time() + "] Teste - " + cCodAtu
        nQuanti := Randomize(-5, 5)
        dEmissa := DaySub(dDtRef, nAtual)
  
        //Inclui um registro na temporária conforme as variáveis
        RecLock(cAliasTab, .T.)
            (cAliasTab)->XXCODIGO := cCodAtu
            (cAliasTab)->XXDESCRI := cDescri
            (cAliasTab)->XXQUANTI := nQuanti
            (cAliasTab)->XXEMISSA := dEmissa
            (cAliasTab)->XXOBSERV := ""
        (cAliasTab)->(MsUnlock())
    
    Next
    
    RestArea(aArea)
Return

Static Function fAltera()
    //Variáveis e objetos usados na tela de alteração
    Private oDlgAltera := Nil
    Private nColMeio := (nJanLarg/2 - 3) / 2
    Private oSayTitAlt, cSayTitAlt := "Alterar Registro"
    Private oSayCodigo, oGetCodigo, cGetCodigo := (cAliasTab)->XXCODIGO 
    Private oSayDescri, oGetDescri, cGetDescri := (cAliasTab)->XXDESCRI
    Private oSayObserv, oGetObserv, cGetObserv := (cAliasTab)->XXOBSERV
    Private lConfirmou := .F.

    //Cria a dialog de alteração
    oDlgAltera := TDialog():New(0, 0, nJanAltu, nJanLarg, "Alteração", , , , , CLR_BLACK, RGB(250, 250, 250), , , .T.)
        //Mostra um texto no cabeçalho
        oSayTitAlt := TSay():New(002, 002, {|| cSayTitAlt}, oDlgAltera, "", oFontTit,  , , , .T., RGB(149, 179, 215), , (nJanLarg/2), 30, , , , , , .F., , )

        //Campo de código (que não será editável)
        oSayCodigo := TSay():New(042, 002, {|| "Código:"}, oDlgAltera, "", oFontTit,  , , , .T., , , (nJanLarg/2), 30, , , , , , .F., , )
        oGetCodigo := TGet():New(072, 002, {|u| Iif(PCount() > 0 , cGetCodigo := u, cGetCodigo)}, oDlgAltera, (nJanLarg/2) - 4, 30, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontTit, , , .T.)
        oGetCodigo:lActive := .F.

        //Campo de Descrição
        oSayDescri := TSay():New(112, 002, {|| "Descrição:"}, oDlgAltera, "", oFontTit,  , , , .T., , , (nJanLarg/2), 30, , , , , , .F., , )
        oGetDescri := TGet():New(142, 002, {|u| Iif(PCount() > 0 , cGetDescri := u, cGetDescri)}, oDlgAltera, (nJanLarg/2) - 4, 30, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontTit, , , .T.)

        //Campo de Observação
        oSayObserv := TSay():New(182, 002, {|| "Observação:"}, oDlgAltera, "", oFontTit,  , , , .T., , , (nJanLarg/2), 30, , , , , , .F., , )
        oGetObserv := TGet():New(212, 002, {|u| Iif(PCount() > 0 , cGetObserv := u, cGetObserv)}, oDlgAltera, (nJanLarg/2) - 4, 30, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontTit, , , .T.)
        
        //Botão Cancelar
        oBtnCanc := TButton():New((nJanAltu/2 - 72), 2, "Cancelar", oDlgAltera, {|| oDlgAltera:End()}, nColMeio - 3, 69, , oFontTit, , .T.)
        oBtnCanc:SetCSS(cCSSAmarel)

        //Botão Confirmar
        oBtnConf := TButton():New((nJanAltu/2 - 72), nColMeio + 3, "Confirmar", oDlgAltera, {|| lConfirmou := .T., oDlgAltera:End()}, nColMeio - 3, 69, , oFontTit, , .T.)
        oBtnConf:SetCSS(cCSSAzul)

    //Ativa a Dialog
    oDlgAltera:Activate(, , , lCentered, {|| .T.}, , )

    //Se foi clicado no botão confirmar, atualiza a tabela com o que o usuário escreveu
    If lConfirmou
        RecLock(cAliasTab, .F.)
            (cAliasTab)->XXDESCRI := cGetDescri
            (cAliasTab)->XXOBSERV := cGetObserv
        (cAliasTab)->(MsUnlock())
    EndIf

    //Atualiza a grid da janela principal
    oGetGrid:Refresh()
Return
