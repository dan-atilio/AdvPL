/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/26/buscando-a-filial-usada-em-uma-tabela-com-fwxfilial-e-xfilial-maratona-advpl-e-tl-259/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe258
Classe para criar uma uma navegação de Wizard (com opção de avançar ou retroceder)
@type  Function
@author Atilio
@since 21/02/2023
@see https://tdn.totvs.com/display/public/framework/FWWizardControl
@obs 
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe258()
    Local aArea         := FWGetArea()
    Local nCorFundo     := RGB(238, 238, 238)
    Local nJanAltura    := 400
    Local nJanLargur    := 600 
    Local cJanTitulo    := 'Exemplo FWWizardControl'
    Local lCentraliz    := .T. 
    Private lDimPixels  := .T. 
    Private nObjLinha   := 0
    Private nObjColun   := 0
    Private nObjLargu   := 0
    Private nObjAltur   := 0
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
    //objeto3
    Private oQrCode
    //objeto4
    Private oSayFim 
    Private cSayFim    := 'Wizard concluído!' 
    //Objetos do Wizard
    Private oPanelGer
    Private oWizard
     
    //Cria a dialog
    oDialogPvt := TDialog():New(0, 0, nJanAltura, nJanLargur, cJanTitulo, , , , , , nCorFundo, , , lDimPixels)
        
        //Cria um painel geral
        oPanelGer := TPanel():New(001, 001, "", oDialogPvt, , , , RGB(000,000,000), RGB(254,254,254), (nJanLargur/2)-1, (nJanAltura/2)-3)

        //Instancia o Wizard
        oWizard := FWWizardControl():New(oPanelGer)
        oWizard:ActiveUISteps()

        //Página 1 do Wizard (terá um campo para o usuário digitar)
        oNewPag := oWizard:AddStep("1")
        oNewPag:SetStepDescription("Definição para usar o QRCode")
        oNewPag:SetConstruction({|oPanel| fCriaPag1(oPanel)})
        oNewPag:SetNextAction({|| fValidPag1()})
        oNewPag:SetCancelAction({|| fEncerra()})

        //Página 2 do Wizard
        oNewPag := oWizard:AddStep("2", {|oPanel| fCriaPag2(oPanel)})
        oNewPag:SetStepDescription("QRCode Gerado")
        oNewPag:SetNextAction({|| .T.})
        oNewPag:SetPrevAction({|| .T.})
        oNewPag:SetCancelAction({|| fEncerra()})

        //Página 3 do Wizard
        oNewPag := oWizard:AddStep("3", {|oPanel| fCriaPag3(oPanel)})
        oNewPag:SetStepDescription("Teste concluído")
        oNewPag:SetNextAction({|| fEncerra()})
        oNewPag:SetPrevAction({|| .T.})
        oNewPag:SetCancelAction({|| fEncerra()})
     
        //Ativa o Wizard para visualização
        oWizard:Activate()

    //Ativa e exibe a janela
    oDialogPvt:Activate(, , , lCentraliz, , , bBlocoIni)
     
    FWRestArea(aArea)
Return

Static Function fEncerra()
    oDialogPvt:End()
Return .T.

Static Function fValidPag1()
    Local lRet := .T.

    //Se não houver texto para montar o QRCode, não permite prosseguir
    If Empty(cGetTexto)
        FWAlertError("Preencha algo no campo antes de prosseguir!", "Atenção")
        lRet := .F.

    Else

        //Se o QRCode já tiver sido criado, atualiza ele
        If ValType(oQrCode) == "O"
            oQrCode:SetCodeBar(cGetTexto)
            oQrCode:Refresh()
        EndIf
    EndIf
Return lRet

Static Function fCriaPag1(oPanel)
    //objeto1 - usando a classe TSay
    nObjLinha := 4
    nObjColun := 4
    nObjLargu := 70
    nObjAltur := 6
    oSayInsira  := TSay():New(nObjLinha, nObjColun, {|| cSayInsira}, oPanel, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

    //objeto2 - usando a classe TGet
    nObjLinha := 3
    nObjColun := 64
    nObjLargu := 110
    nObjAltur := 10
    oGetTexto  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , cGetTexto := u, cGetTexto)}, oPanel, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
Return

Static Function fCriaPag2(oPanel)
    //objeto3 - usando a classe FWQRCode
    nObjLinha := 4
    nObjColun := 110
    nObjLargu := 160
    nObjAltur := 160
    oQrCode := FwQrCode():New({nObjLinha, nObjColun, nObjLargu, nObjAltur}, oPanel, cGetTexto)
Return

Static Function fCriaPag3(oPanel)
    //objeto4 - usando a classe TSay
    nObjLinha := 4
    nObjColun := 4
    nObjLargu := 200
    nObjAltur := 6
    oSayFim   := TSay():New(nObjLinha, nObjColun, {|| cSayFim}, oPanel, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)
Return
