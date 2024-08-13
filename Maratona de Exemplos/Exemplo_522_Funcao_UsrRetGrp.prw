/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/07/buscando-o-email-de-um-usuario-atraves-da-usrretmail-maratona-advpl-e-tl-523/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe522
Retorna os grupos de um usuário
@type Function
@author Atilio
@since 06/04/2023
@see https://tdn.totvs.com/display/public/framework/UsrRetGrp
@obs 

    Função UsrRetGrp
    Parâmetros
        + cUser      , Caractere        , Informa o nome do usuário
        + cCodUser   , Caractere        , Informa o código do usuário
    Retorno
        + aGrupos    , Array            , Retorna um array com os grupos que o usuário tem acesso

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe522()
    Local aArea      := FWGetArea()
    Local cCodUsr    := ""
    Local cNomUsr    := ""
    Local aGrupos    := {}
    Local cMensagem  := ""
    Local nGrpAtu    := 0

    //Busca as informações do usuário
    cCodUsr    := RetCodUsr()
    cNomUsr    := UsrRetName(cCodUsr)
    aGrupos    := UsrRetGrp(cNomUsr, cCodUsr)

    //Percorre os grupos e vai montando a mensagem
    cMensagem := "Usuário logado: " + cCodUsr + " (" + cNomUsr + "), tem acesso ao(s) seguinte(s) grupo(s): " + CRLF
    For nGrpAtu := 1 To Len(aGrupos)
        cMensagem += "+ " + aGrupos[nGrpAtu] + CRLF
    Next

    //Exibe uma mensagem com as informações
    FWAlertInfo(cMensagem, "Teste UsrRetGrp")

    FWRestArea(aArea)
Return
