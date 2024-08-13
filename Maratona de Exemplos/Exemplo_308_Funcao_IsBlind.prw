/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/22/validando-se-o-sistema-esta-rodando-sem-interface-com-isblind-maratona-advpl-e-tl-308/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} zExe308
Valida se a função esta rodando sem interface gráfica para o usuário (ideal para jobs ou webservices)
@type  Function
@author Atilio
@since 23/02/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6814878
@obs 

    Função IsBlind
    Parâmetros
        Não tem parâmetros
    Retorno
        + lIsBlind   , Lógico      , .T. se tiver rodando sem interface gráfica (não passou pelo SIGAADV / SIGAMDI / etc) ou .F. se não

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe308()
	Local aArea      := FWGetArea()
    Local cMensagem  := ""
    
    //Verifica o tipo de conexão com o Protheus
    If IsBlind()
        cMensagem := "Estamos executando sem interface do Protheus"
    Else
        cMensagem := "Estamos executando normalmente"
    EndIf

    //Exibe o resultado, esse é apenas um Teste, se rodar mesmo o IsBlind evite ficar mostrando alerts e mensagens
    FWAlertInfo(cMensagem, "Teste IsBlind")

    FWRestArea(aArea)
Return
