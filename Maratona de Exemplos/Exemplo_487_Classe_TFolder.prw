/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/19/criando-telas-com-a-tdialog-maratona-advpl-e-tl-486/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe487
Classe para criar abas dentro de uma Dialog
@type Function
@author Atilio
@since 04/04/2023
@see https://tdn.totvs.com/display/tec/TFolder
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe487()
    Local aArea         := FWGetArea()
    Local nCorFundo     := RGB(238, 238, 238)
    Local nJanAltura    := 248
    Local nJanLargur    := 655 
    Local cJanTitulo    := 'Exemplo TFolder'
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
    //objeto0 
    Private oBtnObj0 
    Private cBtnObj0    := 'Confirmar'  
    Private bBtnObj0    := {|| MsgInfo('Primeira Aba (Campo A): ' + xGetObj2A + ', Segunda Aba (Campo B): ' + xGetObj2B + ', Terceira Aba (Campo C): ' + xGetObj2C, 'Atencao objeto0')}  
    //objeto1 
    Private oSayObj1A 
    Private cSayObj1A    := 'Campo A:'  
    //objeto2 
    Private oGetObj2A 
    Private xGetObj2A    := Space(10) //Se o get for data para inicilizar use dToS(''), se for numerico inicie com 0  
    //objeto1 
    Private oSayObj1B 
    Private cSayObj1B    := 'Campo B:'  
    //objeto2 
    Private oGetObj2B 
    Private xGetObj2B    := Space(10) //Se o get for data para inicilizar use dToS(''), se for numerico inicie com 0  
    //objeto1 
    Private oSayObj1C 
    Private cSayObj1C    := 'Campo C:'  
    //objeto2 
    Private oGetObj2C 
    Private xGetObj2C    := Space(10) //Se o get for data para inicilizar use dToS(''), se for numerico inicie com 0  
    //Abas
    Private oFolder
    Private aAbas := {"Cadastro", "Complemento", "Outros"}
    
    //Cria a dialog
    oDialogPvt := TDialog():New(0, 0, nJanAltura, nJanLargur, cJanTitulo, , , , , , nCorFundo, , , lDimPixels)
    
        //objeto0 - usando a classe TButton
        nObjLinha := 106
        nObjColun := 5
        nObjLargu := 75
        nObjAltur := 15
        oBtnObj0  := TButton():New(nObjLinha, nObjColun, cBtnObj0, oDialogPvt, bBtnObj0, nObjLargu, nObjAltur, , oFontPadrao, , lDimPixels)

        //Cria as abas
        oFolder := TFolder():New(001, 001, aAbas, /*aDialogs*/, oDialogPvt, /*nOption*/, /*nClrFore*/, /*uParam8*/, lDimPixels, /*uParam10*/, (nJanLargur/2)-1, (nJanAltura/2)-30)

        /* Aba 1 */

            //objeto1 - usando a classe TSay
            nObjLinha := 7
            nObjColun := 2
            nObjLargu := 28
            nObjAltur := 6
            oSayObj1A  := TSay():New(nObjLinha, nObjColun, {|| cSayObj1A}, oFolder:aDialogs[1], /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

            //objeto2 - usando a classe TGet
            nObjLinha := 5
            nObjColun := 37
            nObjLargu := 50
            nObjAltur := 10
            oGetObj2A  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , xGetObj2A := u, xGetObj2A)}, oFolder:aDialogs[1], nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
            oGetObj2A:Picture      := '@!'                        //Mascara / Picture do campo

        /* Aba 2 */

            //objeto1 - usando a classe TSay
            nObjLinha := 7
            nObjColun := 2
            nObjLargu := 28
            nObjAltur := 6
            oSayObj1B  := TSay():New(nObjLinha, nObjColun, {|| cSayObj1B}, oFolder:aDialogs[2], /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

            //objeto2 - usando a classe TGet
            nObjLinha := 5
            nObjColun := 37
            nObjLargu := 100
            nObjAltur := 10
            oGetObj2B  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , xGetObj2B := u, xGetObj2B)}, oFolder:aDialogs[2], nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
            oGetObj2B:Picture      := '@!'                        //Mascara / Picture do campo

        /* Aba 3 */

            //objeto1 - usando a classe TSay
            nObjLinha := 7
            nObjColun := 2
            nObjLargu := 28
            nObjAltur := 6
            oSayObj1C  := TSay():New(nObjLinha, nObjColun, {|| cSayObj1C}, oFolder:aDialogs[3], /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

            //objeto2 - usando a classe TGet
            nObjLinha := 5
            nObjColun := 37
            nObjLargu := 150
            nObjAltur := 10
            oGetObj2C  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , xGetObj2C := u, xGetObj2C)}, oFolder:aDialogs[3], nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
            oGetObj2C:Picture      := '@!'                        //Mascara / Picture do campo

    
    //Ativa e exibe a janela
    oDialogPvt:Activate(, , , lCentraliz, , , bBlocoIni)
    
    FWRestArea(aArea)
Return
