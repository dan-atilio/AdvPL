/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/12/18/pulando-registros-com-a-funcao-dbskip-maratona-advpl-e-tl-132/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe132
Pula registros de um alias
@type Function
@author Atilio
@since 15/12/2022
@see https://tdn.totvs.com/display/tec/DBSkip
@obs 
    Função DbSkip
    Parâmetros
        + nReg        , Numérico   , Quantidade de registros a pular (se não for informado nada, será 1)
    Retorno
        Não possui retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe132()
    Local aArea      := FWGetArea()
    Local cMensagem  := ""

    //Usa o índice 3
    DbSelectArea("SB1")
    SB1->(DbSetOrder(3)) // Filial + Descrição + Código
    SB1->(DbGoTop())
    cMensagem := "Começou a rotina, no produto: " + SB1->B1_DESC + CRLF + CRLF


    //Pula 5 registros
    SB1->(DbSkip(5))
    cMensagem += "+ Pulou 5 registros (para frente), foi para: " + SB1->B1_DESC + CRLF


    //Volta 2 registros
    SB1->(DbSkip(-3))
    cMensagem += "+ Pulou 3 registros (para trás), foi para: " + SB1->B1_DESC + CRLF


    //Pula apenas 1 registro
    SB1->(DbSkip())
    cMensagem += "+ Pulou 1 registro (para frente), foi para: " + SB1->B1_DESC + CRLF

    //Exibe a mensagem
    FWAlertInfo(cMensagem, "Teste DbSkip")

    FWRestArea(aArea)
Return
