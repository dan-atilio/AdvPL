/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/21/criando-gatilhos-com-a-fwstrutrigger-maratona-advpl-e-tl-248/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe249
Classe para buscar informações da SX1 (Grupo de Perguntas)
@type  Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/display/public/framework/FWSX1Util
@obs 
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe249()
    Local aArea      := FWGetArea()
    Local aPergs     := {}
    Local oSX1       := FWSX1Util():New()

    //Busca os grupos de pergunta
    oSX1:AddGroup("A311TES")
    oSX1:SearchGroup()
    aPergs := oSX1:GetGroup("A311TES") 

    //Exibe uma mensagem
    FWAlertInfo("Foi encontrado " + cValToChar(Len(aPergs[2])) + " pergunta(s)", "Teste FWSX1Util")

    FWRestArea(aArea)
Return
