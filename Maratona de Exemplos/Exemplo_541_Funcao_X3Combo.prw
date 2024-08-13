/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/16/buscando-informacoes-de-um-combo-com-x3cbox-tksx3box-e-x3cboxtoarray-maratona-advpl-e-tl-540/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe541
Retorna a descrição de uma opção selecionada do combo
@type Function
@author Atilio
@since 07/04/2023
@obs 

    Função X3Combo
    Parâmetros
        Nome do Campo
        Opção selecionado do Combo
    Retorno
        Retorna a descrição do combo conforme a opção selecionada

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe541()
    Local aArea      := FWGetArea()
    Local cCampo     := ""
    Local cOpcao     := ""
    Local cDescricao := ""

    //Define o campo, a opção e busca a descrição do combo
    cCampo := "A1_PESSOA"
    cOpcao := "F"
    cDescricao := X3Combo(cCampo, cOpcao)

    //Exibe o resultado
    FWAlertInfo("O resultado é '" + cDescricao + "'", "Teste X3Combo")

    FWRestArea(aArea)
Return
