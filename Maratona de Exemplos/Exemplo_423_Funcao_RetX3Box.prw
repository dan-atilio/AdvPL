/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/18/buscando-um-array-com-as-opcoes-de-um-combobox-atraves-da-retx3box-maratona-advpl-e-tl-423/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe423
Retorna um array com as opções de um ComboBox conforme a SX3
@type Function
@author Atilio
@since 29/03/2023
@obs 
    Função RetX3Box
    Parâmetros
        Recebe o nome do campo
    Retorno
        Retorna um Array com as opções do combo

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe423()
    Local aArea      := FWGetArea()
    Local cCampo     := ""
    Local aOpcoes    := {}

    //Exemplo 1, combo box com opções comuns
    cCampo     := "A1_TIPO"
    aOpcoes    := RetX3Box(cCampo)
    FWAlertInfo("O conteúdo do combo tem " + cValToChar(Len(aOpcoes)) + " opções", "Teste 1 RetX3Box")

    //Exemplo 2, combo box que tenha # no conteúdo
    cCampo     := "F4_CREDACU"
    aOpcoes    := RetX3Box(cCampo)
    FWAlertInfo("O conteúdo do combo tem " + cValToChar(Len(aOpcoes)) + " opções", "Teste 2 RetX3Box")

    FWRestArea(aArea)
Return
