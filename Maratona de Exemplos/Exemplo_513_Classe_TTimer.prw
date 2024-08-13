/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/02/criando-um-temporizador-atraves-da-ttimer-maratona-advpl-e-tl-513/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe513
Cria um temporizador que é executado a cada x milissegundos
@type  Function
@author Atilio
@since 05/04/2023
@see https://tdn.totvs.com/display/tec/TTimer
@obs 
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe513()
    Local aArea := FWGetArea()
    Private nTempo := 30000 //30.000 milissegundos e igual a 30 segundos
    Private lUpdate := .F.
    Private dDataAtu := Date()
    //Objetos da Janela
    Private oDlgPvt
    Private oBtnAtu
    Private oBtnFech
    Private oTimer
    Private nTamBtn  := 048
    Private cGetTot  := ""
    Private oGetTot
    Private cGetObs  := ""
    Private oGetObs
    //Tamanho da Janela
    Private    aTamanho    := MsAdvSize()
    Private    nJanLarg    := 600 //aTamanho[5]
    Private    nJanAltu    := 150 //aTamanho[6]
    //Fontes
    Private cFontUti    := "Tahoma"
    Private oFontAno    := TFont():New(cFontUti,,-38)
    Private oFontSub    := TFont():New(cFontUti,,-20)
    Private oFontSubN   := TFont():New(cFontUti,,-20,,.T.)
    Private oFontBtn    := TFont():New(cFontUti,,-14)
      
    //Criacao da tela com os dados que serao informados dos titulos
    DEFINE MSDIALOG oDlgPvt TITLE "Teste de TTimer" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
        //Labels gerais
        @ 004, 003 SAY "TI"                   SIZE 200, 030 FONT oFontAno  OF oDlgPvt COLORS RGB(149,179,215) PIXEL
        @ 004, 030 SAY "Função de Exemplo"    SIZE 200, 030 FONT oFontSub  OF oDlgPvt COLORS RGB(031,073,125) PIXEL
        @ 014, 030 SAY "para testar TTimer"   SIZE 200, 030 FONT oFontSubN OF oDlgPvt COLORS RGB(031,073,125) PIXEL
              
        //Botoes
        @ 006, (nJanLarg/2-3)-((nTamBtn)*01)-0 BUTTON oBtnFech  PROMPT "Fechar"        SIZE nTamBtn, 018 OF oDlgPvt ACTION (oDlgPvt:End())                               FONT oFontBtn PIXEL
        @ 006, (nJanLarg/2-3)-((nTamBtn)*02)-1 BUTTON oBtnAtu   PROMPT "Atualizar"     SIZE nTamBtn, 018 OF oDlgPvt ACTION (fAtualiza())                                 FONT oFontBtn PIXEL
          
        //Get com Total de Produtos
        @ 030, 003   MSGET oGetTot VAR    cGetTot        SIZE (nJanLarg/2) - 3, 015 OF oDlgPvt COLORS 0, 16777215    FONT oFontBtn  PIXEL
        oGetTot:lReadOnly := .T.
  
        //Get com observacoes
        @ (nJanAltu/2)-21, 003   MSGET oGetObs VAR    cGetObs        SIZE (nJanLarg/2) - 3, 015 OF oDlgPvt COLORS 0, 16777215    FONT oFontBtn  PIXEL
        oGetObs:lReadOnly := .T.
        oGetObs:setCSS("QLineEdit{color:#ff0000; background-color:#ffffff;}")
          
        //Chamando a primeira vez para atualizar o get
        fAtualiza()
          
        //Temporizador para atualizar a tela sozinho
        oTimer := TTimer():New(    nTempo,;
                                {|| fAtualiza() },;
                                oDlgPvt )
        oTimer:Activate()
    ACTIVATE MSDIALOG oDlgPvt CENTERED
  
    FWRestArea(aArea)
Return
  
Static Function fAtualiza()
    Processa({|| fAtuTela()}, "Processando...")
Return
  
Static Function fAtuTela()
    Local cQuery := ""
    Local nTotal := 0
  
    //Se nao estiver sendo atualizada, comeca a atualizar a tela
    If ! lUpdate
        lUpdate := .T.
  
        //Monta a query, executa e pega o resultado
        cQuery := " SELECT  " + CRLF
        cQuery += "     COUNT(B1_COD) AS TOTAL  " + CRLF
        cQuery += " FROM  " + CRLF
        cQuery += "     " + RetSQLName("SB1") + " SB1 " + CRLF
        cQuery += " WHERE  " + CRLF
        cQuery += "     B1_FILIAL = '" + FWxFilial('SB1') + "'  " + CRLF
        cQuery += "     AND SB1.D_E_L_E_T_ = '' " + CRLF
        PLSQuery(cQuery, "QRY_SB1")
        nTotal := QRY_SB1->TOTAL
        QRY_SB1->(DbCloseArea())
  
        //Atualiza o totalizador dos produtos
        cGetTot := cValToChar(nTotal) + " produtos encontrados!"
        oGetTot:Refresh()
  
        //Atualiza o Get de Observacao
        cGetObs := "Rotina atualiza a cada " + cValToChar(nTempo / 60000) + " minutos. ult. atualizacao - " + dToC(Date()) + " as " + Time()
        oGetObs:Refresh()
          
        lUpdate := .F.
    EndIf
Return
