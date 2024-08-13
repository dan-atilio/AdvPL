/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/19/buscando-um-tom-de-cor-atraves-da-rgb-maratona-advpl-e-tl-424/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe424
Retorna uma cor para ser usada em AdvPL conforme o padrão RGB (Red, Green e Blue)
@type Function
@author Atilio
@since 29/03/2023
@see https://centraldeatendimento.totvs.com/hc/pt-br/articles/360022454272-Cross-Segmento-TOTVS-Backoffice-Linha-Protheus-ADVPL-Tabela-de-cores-MSDIALOG
@obs 
    Função RGB
    Parâmetros
        Recebe o tom em Vermelho (0 a 255)
        Recebe o tom em Verde (0 a 255)
        Recebe o tom em Azul (0 a 255)
    Retorno
        Retorna a cor em AdvPL para ser utilizada

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe424()
    Local aArea         := FWGetArea()
    Local nCorUsada     := 0
    Local nJanAltura    := 281
    Local nJanLargur    := 358 
    Local cJanTitulo    := 'Exemplo RGB'
    Local lDimPixels    := .T. 
    Local lCentraliz    := .T. 
    Local nObjLinha     := 0
    Local nObjColun     := 0
    Local nObjLargu     := 0
    Local nObjAltur     := 0
    Private cFontNome   := 'Tahoma'
    Private oFontPadrao := TFont():New(cFontNome, , -12)
    Private oDialogPvt 
    Private bBlocoIni   := {|| /*fSuaFuncao()*/ } //Aqui voce pode acionar funcoes customizadas que irao ser acionadas ao abrir a dialog 
    //objeto1 
    Private oSayInsira 
    Private cSayInsira    := 'Insira o Texto:' 
    //objeto2 
    Private oGetTexto 
    Private cGetTexto    := "https://terminaldeinformacao.com" + Space(200)
    //objeto4 
    Private oBtnConf 
    Private cBtnObj8    := 'Confirmar' 
    Private bBtnObj8    := {|| FWAlertInfo("Em construção...", "Teste RGB")}  

    //Definindo a cor de fundo como um Magenta ou Rosa meio claro
    nCorUsada := RGB(230, 010, 230)
     
    //Cria a dialog
    oDialogPvt := TDialog():New(0, 0, nJanAltura, nJanLargur, cJanTitulo, , , , , , nCorUsada, , , lDimPixels)
     
        //objeto1 - usando a classe TSay
        nObjLinha := 4
        nObjColun := 4
        nObjLargu := 70
        nObjAltur := 12
        oSayInsira  := TSay():New(nObjLinha, nObjColun, {|| cSayInsira}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)
 
        //objeto2 - usando a classe TGet
        nObjLinha := 3
        nObjColun := 64
        nObjLargu := 110
        nObjAltur := 15
        oGetTexto  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , cGetTexto := u, cGetTexto)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)

        //objeto4 - usando a classe TButton
        nObjLinha := 116
        nObjColun := 2
        nObjLargu := (nJanLargur/2) - 2
        nObjAltur := 15
        oBtnConf  := TButton():New(nObjLinha, nObjColun, cBtnObj8, oDialogPvt, bBtnObj8, nObjLargu, nObjAltur, , oFontPadrao, , lDimPixels)
     
    //Ativa e exibe a janela
    oDialogPvt:Activate(, , , lCentraliz, , , bBlocoIni)

    FWRestArea(aArea)
Return
