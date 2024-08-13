/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/10/buscando-informacoes-das-empresas-com-a-fwloadsm0-maratona-advpl-e-tl-227/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe226
Abre uma tela para seleção de filial
@type Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/display/public/framework/FwListBranches
@obs 

    Função FWListBranches
    Parâmetros
        + lCheckUser    , Lógico      , Indica se irá exibir apenas as filiais que o usuário tem acesso
        + lAllEmp       , Lógico      , Indica se irá exibir todas as empresas do grupo ou apenas da empresa logada
        + lOnlySelect   , Lógico      , Indica se irá considerar todos os registros apresentados ou apenas o selecionado
        + aRetInfo      , Array       , Indica os campos que serão retornados como SM0_CODFIL; SM0_NOMRED e SM0_CGC (para a lista completa consulte o link acima do TDN)
    Retorno
        + aInfoRet      , Array       , Informações da filial escolhida conforme aRetInfo

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe226()
    Local aArea := FWGetArea()
    Local aSelec := {}

    //Chama a tela para selecionar filial
    aSelec := FWListBranches(, , .T., {"FLAG", "SM0_CODFIL", "SM0_NOMRED", "SM0_CGC"})

    //Se foi selecionado
    If Len(aSelec) > 0
        FWAlertInfo("Filial selecionada: " + aSelec[1][2], "Teste FWListBranches")
    EndIf
    
    FWRestArea(aArea)
Return
