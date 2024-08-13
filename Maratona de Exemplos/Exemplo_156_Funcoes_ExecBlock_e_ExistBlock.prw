/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/06/executando-uma-funcao-se-estiver-compilada-com-execblock-e-existblock-maratona-advpl-e-tl-156/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe156
Valida se uma função existe e com a possibilidade de executar
@type Function
@author Atilio
@since 18/12/2022
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6814883 e https://tdn.totvs.com/display/public/framework/ExistBlock+-+Verifica+ponto+de+entrada+existente
@obs 
    Função ExecBlock
    Parâmetros
        + cNomePE      , Caractere   , Nome da User Function / ponto de entrada
        + lVarEnv      , Lógico      , Indica se as variáveis private e public serão restauradas
        + lSet         , Lógico      , Indica se os Sets do sistema serão restaurados
        + uParam       , Indefinido  , Define as variáveis que vão ficar disponíveis na função executada através do PARAMIXB
    Retorno
        + uRetorno     , Indefinido  , Assume o retorno da User Function executada

    Função ExistBlock
    Parâmetros
        + cNomePE      , Caractere   , Nome da User Function / ponto de entrada
        + lLocaliz     , Lógico      , Indica se é específico para o mercado internacional (.T.) ou para qualquer ambiente inclusive o Brasil (.F.)
        + lForced      , Lógico      , Indica se será executado (.T.) mesmo em Série 3, Pyme ou Start ou se não será (.F.) nesses ambientes
    Retorno
        + lExiste      , Lógico      , .T. se encontrou ou .F. se não encontrou

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe156()
    Local aArea     := FWGetArea()
    Local xRetorno  := ""
    
    //Se a função estiver compilada no ambiente
    If ExistBlock("zExe084")
        xRetorno := ExecBlock("zExe084", /*lVarEnv*/, /*lSet*/, {"Daniel", 29, Date()})

        FWAlertInfo("O retorno é: " + cValToChar(xRetorno), "Teste com ExistBlock e ExecBlock")
    EndIf

    FWRestArea(aArea)
Return
