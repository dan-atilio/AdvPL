/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/22/buscando-informacoes-das-tabelas-com-a-fwsx2util-maratona-advpl-e-tl-250/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe250
Classe para buscar informações da SX2 (Tabelas)
@type  Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/display/public/framework/FWSX2Util
@obs 
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe250()
    Local aArea      := FWGetArea()
    Local aDados     := {}
    Local aBuscar    := {"X2_ARQUIVO", "X2_NOME", "X2_UNICO"}

    //Busca as informações da SX2 da tabela de produtos
    aDados := FwSX2Util():GetSX2Data("SB1", aBuscar, .F.)

    //Exibe uma mensagem
    FWAlertInfo("Foi encontrado " + cValToChar(Len(aDados)) + " dado(s)", "Teste FWSX2Util")

    FWRestArea(aArea)
Return
