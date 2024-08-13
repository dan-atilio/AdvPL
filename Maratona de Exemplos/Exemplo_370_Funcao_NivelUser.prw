/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/22/buscando-o-nome-da-tabela-com-nometab-e-sx2name-maratona-advpl-e-tl-371/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe370
Valida se o usuário tem acesso a nível específico
@type Function
@author Atilio
@since 27/03/2023
@obs 

    Função NivelUser
    Parâmetros
        Recebe o nível a ser validado
    Retorno
        Retorna .T. (se o usuário NÃO tem acesso) ou .F. (se ele tem SIM o acesso)

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe370()
    Local aArea     := FWGetArea()
    Local cPaisBkp  := cPaisLoc

    //Para o correto funcionamento, deve ser alterado a variavel publica com o pais (pois internamente da NivelUser ele valida)
    cPaisLoc := "XXX"

    //Valida se o usuário tem acesso ao nível 6
    If NivelUser("6")
        FWAlertError("O usuário NÃO tem acesso ao nível 6 no módulo " + cModulo + " (nivel " + cValToChar(cNivel) + ")", "Teste NivelUser")
    Else
        FWAlertSuccess("O usuário tem acesso ao nível 6 no módulo " + cModulo, "Teste NivelUser")
    EndIf
 
    cPaisLoc := cPaisBkp
    FWRestArea(aArea)
Return
