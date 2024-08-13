/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/13/salvando-uma-imagem-do-rpo-em-uma-pasta-com-a-resource2file-maratona-advpl-e-tl-412/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe413
Retorna o código do usuário logado no sistema
@type Function
@author Atilio
@since 28/03/2023
@see https://tdn.totvs.com/display/public/framework/RetCodUsr
@obs 

    Função RetCodUsr
    Parâmetros
        Função não tem Parâmetros
    Retorno
        + cCodUsr    , Caractere        , Retorna o código do usuário logado no sistema

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe413()
    Local aArea     := FWGetArea()
    Local cCodUsr   := ""
    Local cNomUsr   := ""

    //Busca as informações do usuário
    cCodUsr := RetCodUsr()
    cNomUsr := UsrRetName(cCodUsr)

    //Exibe uma mensagem com as informações
    FWAlertInfo("Usuário logado: " + cCodUsr + " (" + cNomUsr + ")", "Teste RetCodUsr")

    FWRestArea(aArea)
Return
