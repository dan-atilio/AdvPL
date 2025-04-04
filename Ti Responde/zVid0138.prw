/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/04/01/como-salvar-uma-imagem-do-fwqrcode-ti-responde-0138/ 
    
*/


//Bibliotecas
#Include 'TOTVS.ch'
 
/*/{Protheus.doc} User Function zVid0138
Função que gera um QRCode em tela
@type Function
@author Atilio
@since 25/03/2024
@see https://tdn.totvs.com/display/public/framework/FwQrCode
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zVid0138()
	Local aArea         := FWGetArea()
    Local nCorFundo     := RGB(238, 238, 238)
    Local nJanAltura    := 311
    Local nJanLargur    := 358 
    Local cJanTitulo    := 'Exemplo FWQrCode'
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
    //objeto 3
    Private oQrCode
    //objeto4 
    Private oBtnAtu 
    Private cBtnAtu    := 'Atualizar' 
    Private bBtnAtu    := {|| fAtualiza()}  
    //objeto5 
    Private oBtnSal 
    Private cBtnSal    := 'Salvar' 
    Private bBtnSal    := {|| fSalva()}  
     
    //Cria a dialog
    oDialogPvt := TDialog():New(0, 0, nJanAltura, nJanLargur, cJanTitulo, , , , , , nCorFundo, , , lDimPixels)
     
        //objeto1 - usando a classe TSay
        nObjLinha := 4
        nObjColun := 4
        nObjLargu := 70
        nObjAltur := 6
        oSayInsira  := TSay():New(nObjLinha, nObjColun, {|| cSayInsira}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)
 
        //objeto2 - usando a classe TGet
        nObjLinha := 3
        nObjColun := 64
        nObjLargu := 110
        nObjAltur := 10
        oGetTexto  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , cGetTexto := u, cGetTexto)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
 
        //objeto3 - usando a classe FWQRCode
        nObjLinha := 19
        nObjColun := 44
        nObjLargu := 180
        nObjAltur := 180
        oQrCode := FwQrCode():New({nObjLinha, nObjColun, nObjLargu, nObjAltur}, oDialogPvt, cGetTexto)

        //objeto4 - usando a classe TButton
        nObjLinha := 116
        nObjColun := 2
        nObjLargu := (nJanLargur/2) - 2
        nObjAltur := 15
        oBtnAtu  := TButton():New(nObjLinha, nObjColun, cBtnAtu, oDialogPvt, bBtnAtu, nObjLargu, nObjAltur, , oFontPadrao, , lDimPixels)
     
        //objeto5 - usando a classe TButton
        nObjLinha := 135
        nObjColun := 2
        nObjLargu := (nJanLargur/2) - 2
        nObjAltur := 15
        oBtnSal  := TButton():New(nObjLinha, nObjColun, cBtnSal, oDialogPvt, bBtnSal, nObjLargu, nObjAltur, , oFontPadrao, , lDimPixels)

    //Ativa e exibe a janela
    oDialogPvt:Activate(, , , lCentraliz, , , bBlocoIni)
     
    FWRestArea(aArea)
Return

Static Function fAtualiza()
    //Somente se houver texto, irá atualizar na tela
    If ! Empty(cGetTexto)
        oQrCode:SetCodeBar(cGetTexto)
        oQrCode:Refresh()
    EndIf
Return

Static Function fSalva()
    Local cArquivoQR := oQrCode:cDirName + oQrCode:cPngFile + ".png"
    Local cTipArq := 'Arquivos imagem (*.png)'
    Local cTitulo := 'Gravação de arquivo'
    Local cDirIni := GetTempPath()
    Local lSalvar := .T.
    Local cArqSel := ''
    
    //Aciona a tela para gravar o arquivo
    cArqSel := tFileDialog(;
        cTipArq,;  // Filtragem de tipos de arquivos que serão selecionados
        cTitulo,;  // Título da Janela para seleção dos arquivos
        ,;         // Compatibilidade
        cDirIni,;  // Diretório inicial da busca de arquivos
        lSalvar,;  // Se for .T., será uma Save Dialog, senão será Open Dialog
        ;          // Se não passar parâmetro, irá pegar apenas 1 arquivo; Se for informado GETF_MULTISELECT será possível pegar mais de 1 arquivo; Se for informado GETF_RETDIRECTORY será possível selecionar o diretório
    )
    
    //Efetua a gravação do arquivo
    If ! Empty(cArqSel)
        __CopyFile(cArquivoQR, cArqSel)
    EndIf
Return


