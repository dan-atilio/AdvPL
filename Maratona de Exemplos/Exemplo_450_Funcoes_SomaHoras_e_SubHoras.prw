/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/01/somando-e-subtraindo-horas-com-as-funcoes-somahoras-e-subhoras-maratona-advpl-e-tl-450/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe450
Realiza a soma ou subtração em variáveis numéricas para controle de horas
@type Function
@author Atilio
@since 26/11/2022
@obs 

    Função SomaHoras
    Parâmetros
        Valor inicial da Hora
        Valor que será somado a Hora
    Retorno
        Retorna o valor com a adição


    Função SubHoras
    Parâmetros
        Valor inicial da Hora
        Valor que será subtraído da Hora
    Retorno
        Retorna o valor com a subtração

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe450()
    Local aArea        := FWGetArea()
    Local nResult      := 0
    
    //Soma a segunda hora na primeira
    nResult := SomaHoras(17.45, 10.30)
    FWAlertInfo("O resultado é " + cValToChar(nResult), "Teste SomaHoras")

    //Subtrair a segunda hora pela primeira
    nResult := SubHoras(12.30, 3.45)
    FWAlertInfo("O resultado é " + cValToChar(nResult), "Teste SubHoras")

    FWRestArea(aArea)
Return
