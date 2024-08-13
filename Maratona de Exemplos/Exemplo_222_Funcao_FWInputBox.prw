/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/08/abrindo-uma-tela-para-digitacao-com-fwinputbox-maratona-advpl-e-tl-222/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe222
Abre uma tela com um campo digitável
@type Function
@author Atilio
@since 20/02/2023
@obs 

    Função FWInputBox
    Parâmetros
        + Mensagem que será exibida em cima do campo de digitação
        + Conteúdo que já virá preenchido no campo
    Retorno
        Retorna o conteúdo digitado pelo usuário

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe222()
    Local aArea     := FWGetArea()
    Local cConteudo := "Daniel"
    Local cDigitado := ""

    //Abre a janela para o usuário inserir as informações
    cDigitado := FWInputBox("Insira o seu o nome no campo abaixo:", cConteudo)

    //Exibe uma mensagem
    FWAlertInfo("O conteúdo default é '" + cConteudo + "' e o usuário digitou '" + cDigitado + "'", "Teste com FWInputBox")

    FWRestArea(aArea)
Return
