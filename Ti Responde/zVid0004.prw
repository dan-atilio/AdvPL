/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2022/03/21/realcar-a-informacao-de-empresa-e-filial-no-cabecalho-do-protheus-ti-responde-004/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include 'TOTVS.CH'

Static cCorEmp02 := "0B9BBF"
Static cCorEmp01 := "F39C12"

//Foi criado como static, para ficar só nesse prw, mas ser possível alterar a variável padrão
Static oLabelChk := Nil

/*/{Protheus.doc} User Function ChkExec
Ponto de entrada acionado ao abrir alguma rotina do Protheus
@type  Function
@author Atilio
@since 18/08/2021
/*/

User Function ChkExec()
    Local aArea := GetArea()
    Local lRet := .T.

	fTrataFil()

    RestArea(aArea)
Return lRet

/*/{Protheus.doc} User Function MBRWBTN
Ponto de entrada acionado ao clicar em algum botão de um browse MVC ou comum
@type  Function
@author Atilio
@since 18/08/2021
/*/

User Function MBRWBTN()
    Local aArea  := GetArea()
    Local aDados := {}

    aDados := fAltText(oLabelChk)
    oLabelChk:SetText(aDados[1])
    oLabelChk:SetCSS(aDados[2])

    RestArea(aArea)
Return

Static Function fTrataFil()
	Local aArea := GetArea()
    Local nAtual
    Local cCSS
    Local aDados := {}
    //Busca a tela e os objetos dentro dela
    Private nAtuPvt
    Private oPai       := GetWndDefault()
    Private aControles := oPai:aControls

    //Percorre todos os objetos da tela
    For nAtual := 1 To Len(aControles)
        nAtuPvt := nAtual
        cCSS := aControles[nAtual]:GetCSS()

        //Se for um botão e for o de data (função GETSDIINFO)
		//Foi feito no botão de data, pois nos controles depois ele é sobreposto para o de filial conforme oMsgItemX
        If ValAtrib("aControles[nAtuPvt]:bLClicked") != "U" .And.;
            ValAtrib("aControles[nAtuPvt]:cCaption") != "U" .And.;
            ValAtrib("aControles[nAtuPvt]:cTitle") != "U" .And.;
            aControles[nAtuPvt]:cCaption == aControles[nAtuPvt]:cTitle .And.;
            cToD(aControles[nAtuPvt]:cCaption) == dDataBase

			aControles[nAtuPvt]:SetCSS(u_zCSSFil())

        ElseIf "TSAY" $ Upper(cCSS)
            aDados := fAltText(aControles[nAtuPvt])
            aControles[nAtuPvt]:SetText(aDados[1])
            aControles[nAtuPvt]:SetCSS(aDados[2])
            oLabelChk := aControles[nAtuPvt]
        EndIf

    Next

    RestArea(aArea)
Return

Static Function ValAtrib(cVar)
Return Type(cVar)

Static Function fAltText(oObjeto)
    Local aDados := {"", ""}
    Local cTexto := ""
    Local cCss   := ""
    Local cFil01 := " | PIRATININGA"
    Local cFil02 := " | BAURU"

    //Retira a cidade do texto
    cTexto := oObjeto:cCaption
    If cFil02 $ cTexto
        cTexto := StrTran(cTexto, cFil02, "")
    ElseIf cFil01 $ cTexto
        cTexto := StrTran(cTexto, cFil01, "")
    EndIf

    //Referencia: https://stackoverflow.com/questions/66277783/gradient-color-for-text-of-qlabel-qt-c
    //Se for de Piratininga será amarelo
    If SubStr(cFilAnt, 1, 2) == "02"
        cCSS := "TSay { margin: 2px; color: #" + cCorEmp01 + "; font: 20px Arial; background: qlineargradient( x1:0 y1:0.75, x2:0 y2:1, stop:0 yellow, stop:1 grey);  }"
        cTexto += cFil01

    //Senão, será azul
    Else
        cCSS := "TSay { margin: 2px; color: #" + cCorEmp02 + "; font: 20px Arial; background: qlineargradient( x1:0 y1:0.75, x2:0 y2:1, stop:0 cyan, stop:1 grey); }"
        cTexto += cFil02
    EndIf

    aDados[1] := cTexto
    aDados[2] := cCSS
Return aDados

/*/{Protheus.doc} User Function zCSSFil
Função para alterar a cor de texto do botão de filial no topo da tela do Protheus
@type  Function
@author Atilio
@since 16/06/2021
@version version
/*/

User Function zCSSFil()
    Local aArea := GetArea()
    Local cCSS  := ''
    
    //Monta o estilo do CSS
    cCSS := 'TButton { '
    cCSS += '    font-weight: bold;'
    //cCSS += '    font-size: 12pt;'
    cCSS += '    color: #DC3545;' //Vermelho
    //cCSS += '    color: #17A2B8;' //Azul
    //cCSS += '    color: #4C4C4C;' //Cinza padrão
    cCSS += '    border-left: 1px solid #DEE0DD;'
    cCSS += '    border-right: none;'
    cCSS += '    border-top: none;'
    cCSS += '    border-bottom: none;'
    cCSS += '    background: transparent;'
    cCSS += '    margin-top: 5px;'
    cCSS += '    margin-bottom: 5px;'
    cCSS += '}'

    RestArea(aArea)
Return cCSS
