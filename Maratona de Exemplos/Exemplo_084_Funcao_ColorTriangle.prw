/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/10/31/tela-para-selecionar-uma-cor-usando-a-funcao-colortriangle-maratona-advpl-e-tl-084/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe084
Exemplo de como abrir uma dialog com seleção de cores
@type Function
@author Atilio
@since 09/12/2022
@obs 
    Função ColorTriangle
    Parâmetros
        + Cor inicial (por padrão vem preto = 0)
    Retorno
        + Cor escolhida pelo usuário

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe084()
    Local aArea     := FWGetArea()
    Local nCor      := 0

    //Abre a tela para seleção de cores e depois mostra qual o usuário escolheu
    nCor := ColorTriangle()
    FWAlertSuccess("A cor escolhida pelo usuário foi: " + cValToChar(nCor), "Teste ColorTriangle")

    FWRestArea(aArea)
Return
