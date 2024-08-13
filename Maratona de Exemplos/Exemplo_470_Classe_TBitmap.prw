/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/11/criando-um-pincel-para-pintar-um-fundo-de-relatorio-com-tbrush-maratona-advpl-e-tl-471/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe470
Classe para exibir imagens em Dialogs no Protheus
@type Function
@author Atilio
@since 02/04/2023
@see https://tdn.totvs.com/display/tec/TBitmap
@obs 

    Esse artigo foi baseado na função zSlider disponível em - https://terminaldeinformacao.com/2020/08/28/como-fazer-um-slideshow-em-advpl/

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe470()
    Local aArea := GetArea()
    Local lDimPixels := .T.
    Local lCentraliz := .T.
    Local bBlocoIni  := {|| }
    //Fontes
    Local cFontUti    := "Tahoma"
    Local oFontAno    := TFont():New(cFontUti,,-38)
    Local oFontSub    := TFont():New(cFontUti,,-20)
    Local oFontSubN   := TFont():New(cFontUti,,-20,,.T.)
    Local oFontBtn    := TFont():New(cFontUti,,-14)
    Default cDirFiles := "C:\Users\danat\OneDrive\Trabalho\Atilio Sistemas\Workspace_VS\Local\Cursos\Curso_OO\imgs\"
    Private cDirect   := Alltrim(cDirFiles)
    Private aImgs     := {}
    Private nImgAtu   := 0
    //Janela e componentes
    Private oDlgCom
    Private oGetImg
    Private cGetImg := ""
    Private oBmpFoto
    //Tamanho da janela
    Private nJanLarg := 800
    Private nJanAltu := 600

    //Somente se tiver imagens a exibir
    If ! Empty(cDirect) .And. ExistDir(cDirect)
        //Tratativa para adicionar uma barra no final
        If SubStr(cDirect, Len(cDirect), 1) != '\'
            cDirect += "\"
        EndIf
 
        //Carregando as imagens
        FWMsgRun(, {|oSay| fBuscaImg(oSay) }, "Processando", "Buscando imagens da pasta")
 
        //Se tiver imagens
        If Len(aImgs) > 0
            nImgAtu := 1
            cGetImg := cDirect + aImgs[nImgAtu]
 
            //Criando a janela
            oDlgCom := TDialog():New(0, 0, nJanAltu, nJanLarg, "Slideshow", , , , , , /*nCorFundo*/, , , lDimPixels)
                //Labels gerais
                oSayModulo := TSay():New(004, 003, {|| "TI"},                                            oDlgCom, "", oFontAno,  , , , .T., RGB(149, 179, 215), , 200, 30, , , , , , .F., , )
                oSayTitulo := TSay():New(004, 045, {|| "Exemplo de Slideshow"},                          oDlgCom, "", oFontSub,  , , , .T., RGB(031, 073, 125), , 200, 30, , , , , , .F., , )
                oSaySubTit := TSay():New(014, 045, {|| cValToChar(Len(aImgs)) + " imagens encontradas"}, oDlgCom, "", oFontSubN, , , , .T., RGB(031, 073, 125), , 300, 30, , , , , , .F., , )
 
                //Botão de Sair
                oBtnSair := TButton():New(006, (nJanLarg/2-001)-(0052*1), "Sair", oDlgCom, {|| oDlgCom:End()}, 050, 018, , oFontBtn, , lDimPixels)
 
                //Botões de navegação
                oBtnEsq := TButton():New((nJanAltu/4), 003,                     "<-", oDlgCom, {|| fChangeImg(-1)}, 030, 018, , oFontBtn, , lDimPixels)
                oBtnDir := TButton():New((nJanAltu/4), (nJanLarg/2-003)-(0030), "->", oDlgCom, {|| fChangeImg(1)},  030, 018, , oFontBtn, , lDimPixels)
 
                //Get com a informação da imagem atual
                oGetImg  := TGet():New((nJanAltu/2) - 16, 003, {|u| Iif(PCount() > 0 , cGetImg := u, cGetImg)}, oDlgCom, (nJanLarg/2)-3, 013, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontBtn, , , lDimPixels)
                oGetImg:lReadOnly := .T.
 
                //Imagem atual
                oBmpFoto := TBitmap():New(027, 024, (nJanLarg/2)-42, (nJanAltu/2)-48, /*cResName*/, /*cBmpFile*/, /*lNoBorder*/, oDlgCom, /*bLClicked*/, /*bRClicked*/, /*lScroll*/, /*lStretch*/, /*oCursor*/, /*uParam14*/, /*uParam15*/, /*bWhen*/, lDimPixels, /*bValid*/)
                oBmpFoto:lStretch := .T.
                oBmpFoto:Load(, cGetImg)
                oBmpFoto:Refresh()

            //Ativa e exibe a janela
            oDlgCom:Activate(, , , lCentraliz, , , bBlocoIni)
        Else
            FWAlertError("Não foi encontrado imagens nesse diretório!", "Atenção")
        EndIf
    Else
        FWAlertError("Diretório não existe ou inválido!", "Atenção")
    EndIf
 
    RestArea(aArea)
Return
 
Static Function fBuscaImg(oSay)
    Local aExtensoes := {"jpg", "png", "bmp"}
    Local nExtAtu
    Local aFiles
    Local cCamFull
    Local nFileAtu
 
    //Percorrendo as extensoes
    For nExtAtu := 1 To Len(aExtensoes)
        oSay:SetText("Analisando extensão - " + aExtensoes[nExtAtu])
 
        //Definindo o diretorio full e colocando tudo no array de arquivos
        cCamFull := cDirect + "*." + aExtensoes[nExtAtu]
        aFiles := {}
        aDir(cCamFull, aFiles)
         
        //Percorrendo todos os arquivos e adicionando no nosso array de imagens
        For nFileAtu := 1 To Len(aFiles)
            oSay:SetText("Analisando extensão - " + aExtensoes[nExtAtu] + ", arquivo " + cValToChar(nFileAtu) + " de " + cValToChar(Len(aFiles)))
            aAdd(aImgs, aFiles[nFileAtu])
        Next
    Next
Return
 
Static Function fChangeImg(nNewPos)
    //Decrementa uma imagem
    If nNewPos == -1
        nImgAtu--
 
    //Incrementa uma imagem
    ElseIf nNewPos == 1
        nImgAtu++
    EndIf
 
    //Se a imagem atual passou da ultima, vai para a primeira
    If nImgAtu > Len(aImgs)
        nImgAtu := 1
 
    //Se for menor ou igual a zero, vai para a última
    ElseIf nImgAtu <= 0
        nImgAtu := Len(aImgs)
    EndIf
 
    //Atualiza o get
    cGetImg := cDirect + aImgs[nImgAtu]
    oGetImg:Refresh()
 
    //Atualiza a imagem
    oBmpFoto:Load(, cGetImg)
    oBmpFoto:Refresh()
Return
