/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/23/criando-um-teclado-virtual-com-tkeyboard-maratona-advpl-e-tl-495/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe495
Cria um teclado virtual em uma Dialog
@type Function
@author Atilio
@since 04/04/2023
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe495()
    Local aArea         := FWGetArea()
    Local nCorFundo     := RGB(238, 238, 238)
    Local nJanAltura    := 251
    Local nJanLargur    := 470 
    Local cJanTitulo    := 'Exemplo TKeyboard'
    Local lDimPixels    := .T. 
    Local lCentraliz    := .T. 
    Local nObjLinha     := 0
    Local nObjColun     := 0
    Local nObjLargu     := 0
    Local nObjAltur     := 0
    Local nTamanText    := 50
    Private cFontNome   := 'Tahoma'
    Private oFontPadrao := TFont():New(cFontNome, , -12)
    Private oDialogPvt 
    Private bBlocoIni   := {|| /*fSuaFuncao()*/ } //Aqui voce pode acionar funcoes customizadas que irao ser acionadas ao abrir a dialog  
    Private oGetTeste 
    Private xGetTeste    := Space(nTamanText)
    Private oKey
    
    
    //Cria a dialog
    oDialogPvt := TDialog():New(0, 0, nJanAltura, nJanLargur, cJanTitulo, , , , , , nCorFundo, , , lDimPixels)

        //objeto1 - usando a classe TGet
        nObjLinha := 3
        nObjColun := 3
        nObjLargu := (nJanLargur/2) - 6
        nObjAltur := 10
        oGetTeste  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , xGetTeste := u, xGetTeste)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)

        //Definindo que quando o get for clicado, será vinculado ao teclado virtual
        oGetTeste:bGotFocus  := {|| oKey:SetVars(oGetTeste, nTamanText)}

        //Criando o teclado virtual
        nObjLinha := 19
        nObjColun := 3
        oKey := TKeyboard():New( nObjLinha, nObjColun, 2, oDialogPvt)

        //Definindo que ficará vinculado ao get criado anteriomente
        oKey:SetVars(oGetTeste, nTamanText)

        //Definindo uma ação ao clicar no -Enter-
        oKey:SetEnter({|| FWAlertInfo( oKey:GetContext(), "Teste TKeyboard")})
    
    //Ativa e exibe a janela
    oDialogPvt:Activate(, , , lCentraliz, , , bBlocoIni)
    
    FWRestArea(aArea)
Return
