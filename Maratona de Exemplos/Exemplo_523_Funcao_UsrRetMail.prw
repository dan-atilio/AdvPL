/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/07/buscando-os-grupos-de-um-usuario-com-a-usrretgrp-maratona-advpl-e-tl-522/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe523
Retorna o email cadastrado no usuário
@type Function
@author Atilio
@since 06/04/2023
@see https://tdn.totvs.com/display/public/framework/UsrRetMail
@obs 

    Função UsrRetMail
    Parâmetros
        + cCodUsr    , Caractere        , Informa o código do usuário
    Retorno
        + cMail      , Caractere        , Retorna o endereço de email do usuário

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe523()
    Local aArea      := FWGetArea()
    Local cCodUsr    := ""
    Local cNomUsr    := ""
    Local cEmailUsr  := ""
    Local cMensagem  := ""

    //Busca as informações do usuário
    cCodUsr    := RetCodUsr()
    cNomUsr    := UsrRetName(cCodUsr)
    cEmailUsr  := UsrRetMail(cCodUsr)

    //Monta a mensagem e exibe
    cMensagem := "Usuário logado: " + cCodUsr + " (" + cNomUsr + "), tem o seguinte endereço de email: " + cEmailUsr
    FWAlertInfo(cMensagem, "Teste UsrRetMail")

    FWRestArea(aArea)
Return
