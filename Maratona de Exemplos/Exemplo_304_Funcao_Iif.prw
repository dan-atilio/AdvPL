/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/20/fazendo-um-teste-condicional-com-iif-maratona-advpl-e-tl-304/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} zExe304
Exemplo de estrutura de condicao com Iif
@type  Function
@author Atilio
@since 22/02/2023
@see https://tdn.totvs.com/display/tec/iif
@obs 

    Função Iif
    Parâmetros
        Expressão que será testada (tem que dar .T. ou .F.)
        Valor que será retornado se a expressão der .T.
        Valor que será retornado se a expressão der .F.
    Retorno
        Valor que será retornado depende da expressão passada

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe304()
	Local aArea    := FWGetArea()
    Local nMesAtu  := Month(Date())
    Local nMesAniv := 7
    Local cMsg     := ""

    cMsg := Iif(nMesAtu == nMesAniv, "ANIVERSARIANTE", "AINDA NAO")
    FWAlertInfo(cMsg, "Teste de Iif")

    /*
    If nMesAtu == nMesAniv
        cMsg := "ANIVERSARIANTE"
    Else
        cMsg := "AINDA NAO"
    EndIf
    */

    /*
    nValor := Iif(A == B, Iif(B == C, 7, Iif(C == D, 4, 9)), 3)
    If A == B
        If B == C
            nValor := 7
        Else
            If C == D
                nValor := 4
            Else
                nValor := 9
            EndIf
        EndIf
    Else
        nValor := 3
    EndIf
    */  

    FWRestArea(aArea)
Return
