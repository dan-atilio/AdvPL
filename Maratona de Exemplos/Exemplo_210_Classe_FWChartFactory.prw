/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/02/buscando-o-codigo-da-empresa-logada-com-fwcodemp-maratona-advpl-e-tl-211/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe210
Cria gráficos em Dialogs do Protheus
@type  Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/display/public/framework/FwChartFactory
@obs 
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/
 
User Function zExe210()
    Local aArea := FWGetArea()
    Local oFWChart
    Local oDlg
    Local aRand := {}
     
    //Cria a Janela
    DEFINE MSDIALOG oDlg PIXEL FROM 0,0 TO 400,600
        //Instância a classe
        oFWChart := FWChartFactory():New()
        oFWChart := oFWChart:getInstance(BARCHART) //BARCOMPCHART ; LINECHART ; PIECHART
         
        //Inicializa pertencendo a janela
        oFWChart:Init(oDlg, .T., .T. )
         
        //Seta o título do gráfico
        oFWChart:SetTitle("Título", CONTROL_ALIGN_CENTER)
         
        //Adiciona as séries, com as descrições e valores
        oFWChart:addSerie("Ano 2011", 20044453.50)
        oFWChart:addSerie("Ano 2012", 21044453.35)
        oFWChart:addSerie("Ano 2013", 22044453.15)
        oFWChart:addSerie("Ano 2014", 23044453.10)
        oFWChart:addSerie("Ano 2015", 25544453.01)
         
        //Define que a legenda será mostrada na esquerda
        oFWChart:setLegend( CONTROL_ALIGN_LEFT )
         
        //Seta a máscara mostrada na régua
        oFWChart:cPicture := "@E 999,999,999,999,999.99"
         
        //Define as cores que serão utilizadas no gráfico
        aAdd(aRand, {"084,120,164", "007,013,017"})
        aAdd(aRand, {"171,225,108", "017,019,010"})
        aAdd(aRand, {"207,136,077", "020,020,006"})
        aAdd(aRand, {"166,085,082", "017,007,007"})
        aAdd(aRand, {"130,130,130", "008,008,008"})
         
        //Seta as cores utilizadas
        oFWChart:oFWChartColor:aRandom := aRand
        oFWChart:oFWChartColor:SetColor("Random")
         
        //Constrói o gráfico
        oFWChart:Build()
    ACTIVATE MSDIALOG oDlg CENTERED

    FWRestArea(aArea)
Return
