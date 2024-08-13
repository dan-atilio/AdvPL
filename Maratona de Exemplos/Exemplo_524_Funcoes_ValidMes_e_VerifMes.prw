/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/08/convertendo-uma-variavel-para-ser-usada-em-query-atraves-da-valtosql-maratona-advpl-e-tl-525/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe524
Função que valida o mês informado
@type Function
@author Atilio
@since 06/04/2023
@obs 

    Função ValidMes
    Parâmetros
        Recebe o número do mês
    Retorno
        Retorna se é um mês válido (.T.) ou não (.F.)


    Função VerifMes
    Parâmetros
        Recebe o número do mês e o ano no formato "MMYYYY"
    Retorno
        Retorna se é um período válido (.T.) ou não (.F.)

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe524()
    Local aArea      := FWGetArea()
    Local nMes       := 0
    Local cMesAno    := ""

    //Faz a validação do mês (tem que estar entre 1 e 12 numérico)
    nMes := 17
    If ValidMes(nMes)
        FWAlertSucess("O " + cValToChar(nMes) + " é um mês válido", "Teste ValidMes")
    Else
        FWAlertError("O " + cValToChar(nMes) + " é um mês inválido", "Teste ValidMes")
    EndIf

    //Faz a validação do mês / ano, sendo que o mês tem que ser entre 01 e 12 e o ano tem que ser 4 números, ambos no formato "MMYYYY"
    cMesAno := "042023"
    If VerifMes(cMesAno)
        FWAlertSucess("O " + cMesAno + " é um período válido", "Teste VerifMes")
    Else
        FWAlertError("O " + cMesAno + " é um período inválido", "Teste VerifMes")
    EndIf

    FWRestArea(aArea)
Return
