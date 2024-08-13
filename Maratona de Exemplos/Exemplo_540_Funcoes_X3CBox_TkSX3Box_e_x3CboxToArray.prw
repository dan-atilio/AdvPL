/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/16/buscando-a-descricao-de-uma-opcao-de-um-combo-com-x3combo-maratona-advpl-e-tl-541/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe540
Retorna o conteúdo de um ComboBox conforme a SX3
@type Function
@author Atilio
@since 07/04/2023
@see https://tdn.totvs.com/display/public/framework/X3CBox+-++Campo+combo
@obs 
    Função X3CboxToArray
    Parâmetros
        Recebe o nome do campo
    Retorno
        Retorna um Array com as opções do combo

    Função TkSX3Box
    Parâmetros
        Recebe o nome do campo
    Retorno
        Retorna um Array com as opções do combo

    Função X3Cbox
    Parâmetros
        Recebe o nome do campo
    Retorno
        Retorna uma string com as opções do combo

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe540()
    Local aArea      := FWGetArea()
    Local cCampo     := ""
    Local aExeX3Arr  := {}
    Local cExeX3     := ""
    Local aExeX3Tk   := {}

    //Exemplo 1, combo box com opções comuns
    cCampo     := PadR("A1_TIPO", 10)
    aExeX3Arr  := X3CboxToArray(cCampo)
    cExeX3     := X3CBox(cCampo)
    aExeX3Tk   := TkSX3Box(cCampo)
    FWAlertInfo("O conteúdo do combo é: " + cExeX3, "Teste 1 X3CBox, TkSX3Box e X3CboxToArray")

    //Exemplo 2, combo box que tenha # no conteúdo
    cCampo     := PadR("F4_CREDACU", 10)
    aExeX3Arr  := X3CboxToArray(cCampo)
    cExeX3     := X3CBox(cCampo)
    aExeX3Tk   := TkSX3Box(cCampo)
    FWAlertInfo("O conteúdo do combo é: " + cExeX3, "Teste 2 X3CBox, TkSX3Box e X3CboxToArray")

    FWRestArea(aArea)
Return
