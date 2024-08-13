/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/08/verificando-se-um-usuario-e-administrador-atraves-da-fwisadmin-maratona-advpl-e-tl-223/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe223
Verifica se um usuário tem privilégio de Administrador (grupo de Administradores)
@type Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6814856
@obs 

    Função FWIsAdmin
    Parâmetros
        + cID           , Caractere   , Código do usuário que será validado (caso não seja informado usará o código do usuário logado)
    Retorno
        + lRet          , Lógico      , .T. se o usuário for administrador ou .F. se não

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe223()
    Local aArea     := FWGetArea()
    
    //Verifica se o usuário é administrador, se sim exibe mensagem
    If FWIsAdmin()
        FWAlertSuccess("O usuário é adminstrador, logo poderá fazer operações de manipulação do BD", "Teste FWIsAdmin")
    EndIf

    FWRestArea(aArea)
Return
