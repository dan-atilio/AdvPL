/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/03/abrindo-a-tela-de-consulta-generica-com-a-funcao-edapp-maratona-advpl-e-tl-150/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe150
Abre a tela de Consulta Genérica de Tabelas - antiga função Lerda()
@type Function
@author Atilio
@since 16/12/2022
@obs 
    Função EDaPP
    Não tem parâmetros nem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe150()
    Local aArea       := FWGetArea()

    If FWAlertYesNo("Deseja continuar e abrir a tela de Consulta Genérica de tabelas?", "Abrir Consulta Genérica?")
        EDaPP()
    EndIf

    FWRestArea(aArea)
Return
