/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/06/encerrando-uma-rotina-atraves-da-userexception-maratona-advpl-e-tl-520/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe521
Retorna o nome de um usuário (login) ou o nome completo
@type Function
@author Atilio
@since 06/04/2023
@see https://tdn.totvs.com/display/public/framework/UsrRetName e https://tdn.totvs.com/display/public/framework/UsrFullName
@obs 

    Função UsrFullName
    Parâmetros
        + cCodUsr    , Caractere        , Informa o código do usuário
    Retorno
        + cFullName  , Caractere        , Retorna o nome completo do usuário

    Função UsrRetName
    Parâmetros
        + cCodUsr    , Caractere        , Informa o código do usuário
    Retorno
        + cName      , Caractere        , Retorna o nome do usuário (login)

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe521()
    Local aArea      := FWGetArea()
    Local cCodUsr    := ""
    Local cNomUsr    := ""
    Local cNomComUsr := ""

    //Busca as informações do usuário
    cCodUsr    := RetCodUsr()
    cNomUsr    := Alltrim( UsrRetName(cCodUsr)  )
    cNomComUsr := Alltrim( UsrFullName(cCodUsr) )

    //Exibe uma mensagem com as informações
    FWAlertInfo("Usuário logado: " + cCodUsr + ", nome: " + cNomUsr + ", nome completo: " + cNomComusr, "Teste UsrRetName e UsrFullName")

    FWRestArea(aArea)
Return
