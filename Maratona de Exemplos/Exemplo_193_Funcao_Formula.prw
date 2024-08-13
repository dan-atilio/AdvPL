/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/24/executando-uma-formula-cadastrada-no-sistema-com-a-formula-maratona-advpl-e-tl-193/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe193
Executa uma fórmula cadastrada na SM4
@type Function
@author Atilio
@since 11/02/2023
@obs 
    Função Formula
    Parâmetros
        + Código da fórmula a ser executada
    Retorno
        + Retorna o valor conforme a fórmnula executada

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe193()
    Local aArea     := FWGetArea()
    Local cFormCod  := "F01"
    Local dResult   := Nil

    //Executa a fórmula e mostra o resultado
    dResult := Formula(cFormCod)
    FWAlertInfo("O resultado é " + dToC(dResult), "Formula - Teste 1")

    FWRestArea(aArea)
Return
