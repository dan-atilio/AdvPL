/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/27/criando-variaveis-private-atraves-da-setprvt-maratona-advpl-e-tl-441/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe440
Define o conteúdo de um parâmetro de uma pergunta
@type Function
@author Atilio
@since 30/03/2023
@see https://tdn.totvs.com/display/public/framework/SetMVValue
@obs 
    Função SetMVValue
    Parâmetros
        + cPergunta     , Caractere     , Código do grupo de perguntas
        + cMVVar        , Caractere     , MV_PAR que será atualizado
        + xValue        , Indefinido    , Conteúdo que será atribuído ao parâmetro
    Retorno
        + lRet          , Lógico        , .T. se conseguiu atribuir ou .F. se não

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe440()
    Local aArea    := FWGetArea()
    Local cPerg    := "MATR802"
    Local dDataHj  := Date()
    Local dDataDe  := DaySub(dDataHj, 7)
    Local dDataAte := DaySum(dDataHj, 7)

    //Define os parâmetros antes de abrir a tela
    SetMVValue(cPerg, "MV_PAR03", dDataDe)
    SetMVValue(cPerg, "MV_PAR04", dDataAte)

    //Aciona a tela para exibir a pergunta
    If Pergunte(cPerg, .T.)
        // ...
    EndIf

	FWRestArea(aArea)
Return
