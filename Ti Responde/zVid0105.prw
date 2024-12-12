/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2024/12/05/quais-sao-os-botoes-disponiveis-para-usar-no-formbatch-ti-responde-0105/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zVid0105
Vamos demonstrar quais botões podem ser usados num FormBatch
@type  Function
@author Atilio
@since 06/03/2024
@obs Abaixo a lista de botões (veja em https://tdn.totvs.com/display/tec/Construtor+SButton%3ANew)
    01 = OK
    02 = Cancelar
    03 = Excluir
    04 = Incluir
    05 = Parâmetros
    06 = Imprimir
    07 = Susp. Impr.
    08 = Cancelar Impressão
    09 = Ordem
    10 = Prioridade
    11 = Editar
    12 = Ouvir
    13 = Salvar
    14 = Abrir
    15 = Visualizar
    16 = Cond. Neg.
    17 = Filtrar
    18 = Financ.
    19 = Avançar
    20 = Voltar
    21 = Avançar
    22 = Voltar
    23 = Gráfico
/*/

User Function zVid0105()
    Local aArea := FWGetArea()

    //Monta uma dialog de Exemplo, conforme disponível no TDN - 
    fExempBtn()

    //Agora monta um FormBatch com alguns botões
    fExempForm()

    FWRestArea(aArea)
Return

Static Function fExempBtn()
    Local aArea := FWGetArea()
    Local oDlgBtn
    Local nJanAltu    := 300
    Local nJanLarg    := 300
    Local lDimPixels  := .T.
    Local lCentraliz  := .T.
    Local bBlocoIni   := {|| }
    Local cJanTitulo  := "Exemplo de SButton"
    //Fonte usada
    Local cFontNome   := 'Tahoma'
    Local oFontPadrao := TFont():New(cFontNome, , -12)
    //Colunas dos objetos
    Local nColunaA := 001
    Local nColunaB := 031
    Local nColunaC := 061
    Local nColunaD := 091
    Local nColunaE := 121
    //Objetos dentro da Janela
    Local oSayTip01, oBtnTip01
    Local oSayTip02, oBtnTip02
    Local oSayTip03, oBtnTip03
    Local oSayTip04, oBtnTip04
    Local oSayTip05, oBtnTip05
    Local oSayTip06, oBtnTip06
    Local oSayTip07, oBtnTip07
    Local oSayTip08, oBtnTip08
    Local oSayTip09, oBtnTip09
    Local oSayTip10, oBtnTip10
    Local oSayTip11, oBtnTip11
    Local oSayTip12, oBtnTip12
    Local oSayTip13, oBtnTip13
    Local oSayTip14, oBtnTip14
    Local oSayTip15, oBtnTip15
    Local oSayTip16, oBtnTip16
    Local oSayTip17, oBtnTip17
    Local oSayTip18, oBtnTip18
    Local oSayTip19, oBtnTip19
    Local oSayTip20, oBtnTip20
    Local oSayTip21, oBtnTip21
    Local oSayTip22, oBtnTip22
    Local oSayTip23, oBtnTip23

    //Cria a dialog
    oDlgBtn := TDialog():New(0, 0, nJanAltu, nJanLarg, cJanTitulo, , , , , , /*nCorFundo*/, , , lDimPixels)

        //Primeira linha (tipo 01 ao 05)
        oSayTip01 := TSay():New(001, nColunaA, {|| "Tipo 01:"}, oDlgBtn, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 10, , , , , , /*lHTML*/)
        oSayTip02 := TSay():New(001, nColunaB, {|| "Tipo 02:"}, oDlgBtn, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 10, , , , , , /*lHTML*/)
        oSayTip03 := TSay():New(001, nColunaC, {|| "Tipo 03:"}, oDlgBtn, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 10, , , , , , /*lHTML*/)
        oSayTip04 := TSay():New(001, nColunaD, {|| "Tipo 04:"}, oDlgBtn, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 10, , , , , , /*lHTML*/)
        oSayTip05 := TSay():New(001, nColunaE, {|| "Tipo 05:"}, oDlgBtn, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 10, , , , , , /*lHTML*/)
        oBtnTip01 := SButton():New(011, nColunaA, 01, {|| Alert('Tst')}, oDlgBtn, .T., /*cMsg*/, /*bWhen*/)
        oBtnTip02 := SButton():New(011, nColunaB, 02, {|| Alert('Tst')}, oDlgBtn, .T., /*cMsg*/, /*bWhen*/)
        oBtnTip03 := SButton():New(011, nColunaC, 03, {|| Alert('Tst')}, oDlgBtn, .T., /*cMsg*/, /*bWhen*/)
        oBtnTip04 := SButton():New(011, nColunaD, 04, {|| Alert('Tst')}, oDlgBtn, .T., /*cMsg*/, /*bWhen*/)
        oBtnTip05 := SButton():New(011, nColunaE, 05, {|| Alert('Tst')}, oDlgBtn, .T., /*cMsg*/, /*bWhen*/)

        //Segunda linha (tipo 06 ao 10)
        oSayTip06 := TSay():New(031, nColunaA, {|| "Tipo 06:"}, oDlgBtn, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 10, , , , , , /*lHTML*/)
        oSayTip07 := TSay():New(031, nColunaB, {|| "Tipo 07:"}, oDlgBtn, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 10, , , , , , /*lHTML*/)
        oSayTip08 := TSay():New(031, nColunaC, {|| "Tipo 08:"}, oDlgBtn, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 10, , , , , , /*lHTML*/)
        oSayTip09 := TSay():New(031, nColunaD, {|| "Tipo 09:"}, oDlgBtn, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 10, , , , , , /*lHTML*/)
        oSayTip10 := TSay():New(031, nColunaE, {|| "Tipo 10:"}, oDlgBtn, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 10, , , , , , /*lHTML*/)
        oBtnTip06 := SButton():New(041, nColunaA, 06, {|| Alert('Tst')}, oDlgBtn, .T., /*cMsg*/, /*bWhen*/)
        oBtnTip07 := SButton():New(041, nColunaB, 07, {|| Alert('Tst')}, oDlgBtn, .T., /*cMsg*/, /*bWhen*/)
        oBtnTip08 := SButton():New(041, nColunaC, 08, {|| Alert('Tst')}, oDlgBtn, .T., /*cMsg*/, /*bWhen*/)
        oBtnTip09 := SButton():New(041, nColunaD, 09, {|| Alert('Tst')}, oDlgBtn, .T., /*cMsg*/, /*bWhen*/)
        oBtnTip10 := SButton():New(041, nColunaE, 10, {|| Alert('Tst')}, oDlgBtn, .T., /*cMsg*/, /*bWhen*/)

        //Terceira linha (tipo 11 ao 15)
        oSayTip11 := TSay():New(061, nColunaA, {|| "Tipo 11:"}, oDlgBtn, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 10, , , , , , /*lHTML*/)
        oSayTip12 := TSay():New(061, nColunaB, {|| "Tipo 12:"}, oDlgBtn, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 10, , , , , , /*lHTML*/)
        oSayTip13 := TSay():New(061, nColunaC, {|| "Tipo 13:"}, oDlgBtn, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 10, , , , , , /*lHTML*/)
        oSayTip14 := TSay():New(061, nColunaD, {|| "Tipo 14:"}, oDlgBtn, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 10, , , , , , /*lHTML*/)
        oSayTip15 := TSay():New(061, nColunaE, {|| "Tipo 15:"}, oDlgBtn, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 10, , , , , , /*lHTML*/)
        oBtnTip11 := SButton():New(071, nColunaA, 11, {|| Alert('Tst')}, oDlgBtn, .T., /*cMsg*/, /*bWhen*/)
        oBtnTip12 := SButton():New(071, nColunaB, 12, {|| Alert('Tst')}, oDlgBtn, .T., /*cMsg*/, /*bWhen*/)
        oBtnTip13 := SButton():New(071, nColunaC, 13, {|| Alert('Tst')}, oDlgBtn, .T., /*cMsg*/, /*bWhen*/)
        oBtnTip14 := SButton():New(071, nColunaD, 14, {|| Alert('Tst')}, oDlgBtn, .T., /*cMsg*/, /*bWhen*/)
        oBtnTip15 := SButton():New(071, nColunaE, 15, {|| Alert('Tst')}, oDlgBtn, .T., /*cMsg*/, /*bWhen*/)

        //Quarta linha (tipo 16 ao 20)
        oSayTip16 := TSay():New(091, nColunaA, {|| "Tipo 16:"}, oDlgBtn, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 10, , , , , , /*lHTML*/)
        oSayTip17 := TSay():New(091, nColunaB, {|| "Tipo 17:"}, oDlgBtn, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 10, , , , , , /*lHTML*/)
        oSayTip18 := TSay():New(091, nColunaC, {|| "Tipo 18:"}, oDlgBtn, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 10, , , , , , /*lHTML*/)
        oSayTip19 := TSay():New(091, nColunaD, {|| "Tipo 19:"}, oDlgBtn, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 10, , , , , , /*lHTML*/)
        oSayTip20 := TSay():New(091, nColunaE, {|| "Tipo 20:"}, oDlgBtn, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 10, , , , , , /*lHTML*/)
        oBtnTip16 := SButton():New(101, nColunaA, 16, {|| Alert('Tst')}, oDlgBtn, .T., /*cMsg*/, /*bWhen*/)
        oBtnTip17 := SButton():New(101, nColunaB, 17, {|| Alert('Tst')}, oDlgBtn, .T., /*cMsg*/, /*bWhen*/)
        oBtnTip18 := SButton():New(101, nColunaC, 18, {|| Alert('Tst')}, oDlgBtn, .T., /*cMsg*/, /*bWhen*/)
        oBtnTip19 := SButton():New(101, nColunaD, 19, {|| Alert('Tst')}, oDlgBtn, .T., /*cMsg*/, /*bWhen*/)
        oBtnTip20 := SButton():New(101, nColunaE, 20, {|| Alert('Tst')}, oDlgBtn, .T., /*cMsg*/, /*bWhen*/)

        //Quinta linha (tipo 21 ao 23)
        oSayTip21 := TSay():New(121, nColunaA, {|| "Tipo 21:"}, oDlgBtn, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 10, , , , , , /*lHTML*/)
        oSayTip22 := TSay():New(121, nColunaB, {|| "Tipo 22:"}, oDlgBtn, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 10, , , , , , /*lHTML*/)
        oSayTip23 := TSay():New(121, nColunaC, {|| "Tipo 23:"}, oDlgBtn, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, 30, 10, , , , , , /*lHTML*/)
        oBtnTip21 := SButton():New(131, nColunaA, 21, {|| Alert('Tst')}, oDlgBtn, .T., /*cMsg*/, /*bWhen*/)
        oBtnTip22 := SButton():New(131, nColunaB, 22, {|| Alert('Tst')}, oDlgBtn, .T., /*cMsg*/, /*bWhen*/)
        oBtnTip23 := SButton():New(131, nColunaC, 23, {|| Alert('Tst')}, oDlgBtn, .T., /*cMsg*/, /*bWhen*/)

    //Ativa e exibe a janela
    oDlgBtn:Activate(, , , lCentraliz, , , bBlocoIni)

    FWRestArea(aArea)
Return

Static Function fExempForm()
    Local aArea     := FWGetArea()
    Local aTexto    := {}
    Local aBotoes   := {}
    Local nContinua := 0
    Local cTitulo   := "Processamento de Dados"

    //Monta o texto que será exibido na tela
    aAdd(aTexto, "Essa é uma rotina para processamento de informações")
    aAdd(aTexto, "--")
    aAdd(aTexto, "Abaixo uma estrófe da música tema do Duck Dodgers:")
    aAdd(aTexto, "Duck Dodgers of the twenty-four and a half century")
    aAdd(aTexto, "Protecting the powerless and the weak")
    aAdd(aTexto, "Duck Dodgers he s fighting tyranny")
    aAdd(aTexto, "In the twenty-four and a half century")

    //Monta os botões que serão exibidos
    aAdd(aBotoes, {01, .T., {|| nContinua := 1, FechaBatch()} }) //01 = Confirmar
	aAdd(aBotoes, {02, .T., {|| nContinua := 2, FechaBatch()} }) //02 = Cancelar
    aAdd(aBotoes, {14, .T., {|| Alert("Abrindo")}             }) //14 = Abrir
    aAdd(aBotoes, {17, .T., {|| Alert("Filtrando")}           }) //17 = Filtrar

    //Abre a tela
    FormBatch(cTitulo, aTexto, aBotoes) 

    //Se o usuário clicou no Confirmar
    If nContinua == 1
        //Aqui você aciona a sua função se o usuário clicou no botão confirmar
    EndIf

    FWRestArea(aArea)
Return
