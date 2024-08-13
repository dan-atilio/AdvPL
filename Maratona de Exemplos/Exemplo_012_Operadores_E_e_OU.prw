/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/08/20/operadores-and-e-or-para-utilizacao-em-condicoes-maratona-advpl-e-tl-012/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe012
Exemplo de como utilizar os operadores .And. e .Or. nos testes
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.engpro.totvs.com.br/display/tec/Operadores+Comuns
@obs
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe012()
    Local aArea   := FWGetArea()
    Local nVar1   := 2
    Local nVar2   := 2

    //Somente se a primeira condição E a segunda forem verdadeiras
    If (nVar1 == nVar2) .And. fTstFunc()
        FWAlertInfo("Resultado é verdadeiro", "Teste com .And.")
    EndIf

    //Se a primeira condição OU a segunda for verdadeira
    If fTstFunc() .Or. FWAlertYesNo("Pergunta de Teste", "Continua?")
        FWAlertInfo("Resultado é verdadeiro", "Teste com .Or.")
    EndIf

    FWRestArea(aArea)
Return

Static Function fTstFunc()
    Local lRet := .T.
Return lRet
