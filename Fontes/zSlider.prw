/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2020/08/28/como-fazer-um-slideshow-em-advpl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zSlider
Exemplo de Slideshow em AdvPL
@type  Function
@author Atilio
@since  21/06/2020
@version version
@param cDirFile, Character, Diretorio com arquivos que serao carregados
@example u_zSlider("C:\Users\daniel.atilio\Desktop\imagens")
/*/

User Function zSlider(cDirFiles)
    Local aArea := GetArea()
    //Fontes
    Local cFontUti    := "Tahoma"
    Local oFontAno    := TFont():New(cFontUti,,-38)
    Local oFontSub    := TFont():New(cFontUti,,-20)
    Local oFontSubN   := TFont():New(cFontUti,,-20,,.T.)
    Local oFontBtn    := TFont():New(cFontUti,,-14)
    Default cDirFiles := ""
    Private cDirect   := Alltrim(cDirFiles)
    Private aImgs     := {}
    Private nImgAtu   := 0
    //Janela e componentes
    Private oDlgCom
    Private oGetImg
    Private cGetImg := ""
    Private oBmpFoto
    //Tamanho da janela
	Private	nJanLarg := 800
	Private	nJanAltu := 600

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
            DEFINE MSDIALOG oDlgCom TITLE "Slideshow" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
                //Labels gerais
                @ 004, 003 SAY "TI"                                             SIZE 200, 030 FONT oFontAno  OF oDlgCom COLORS RGB(149,179,215) PIXEL
                @ 004, 040 SAY "Exemplo de Slideshow"                           SIZE 200, 030 FONT oFontSub  OF oDlgCom COLORS RGB(031,073,125) PIXEL
                @ 014, 040 SAY cValToChar(Len(aImgs)) + " imagens encontradas"  SIZE 200, 030 FONT oFontSubN OF oDlgCom COLORS RGB(031,073,125) PIXEL

                //Botão de Sair
                @ 006, (nJanLarg/2-001)-(0052*01) BUTTON oBtnSai    PROMPT "Sair"             SIZE 050, 018 OF oDlgCom ACTION (oDlgCom:End())                                 FONT oFontBtn PIXEL

                //BotÃµes de navegação
                @ (nJanAltu/4), 003                     BUTTON oBtnEsq    PROMPT "<-"       SIZE 030, 018 OF oDlgCom ACTION (fChangeImg(-1))                                FONT oFontBtn PIXEL
                @ (nJanAltu/4), (nJanLarg/2-003)-(0030) BUTTON oBtnDir    PROMPT "->"       SIZE 030, 018 OF oDlgCom ACTION (fChangeImg(1))                                 FONT oFontBtn PIXEL

                //Get com a informação da imagem atual
                @ (nJanAltu/2) - 16, 003  MSGET oGetImg VAR cGetImg SIZE (nJanLarg/2)-3, 013 OF oDlgForm COLORS 0, 16777215 READONLY PIXEL

                //Imagem atual
                @ 027, 024 BITMAP oBmpFoto                    SIZE (nJanLarg/2)-42, (nJanAltu/2)-48 OF oDlgForm ADJUST              PIXEL
                oBmpFoto:Load(, cGetImg)
				oBmpFoto:Refresh()
            ACTIVATE MsDialog oDlgCom CENTERED
        Else
            MsgStop("Não foi encontrado imagens nesse diretório!", "Atenção")
        EndIf
    Else
        MsgStop("Diretório não existe ou inválido!", "Atenção")
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