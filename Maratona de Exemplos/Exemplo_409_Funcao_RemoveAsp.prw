/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/11/separando-partes-de-um-telefone-com-a-remdddtel-maratona-advpl-e-tl-408/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe409
Remove aspas e apóstrofos de uma string
@type Function
@author Atilio
@since 28/03/2023
@obs 

    Função RemoveAsp
    Parâmetros
        Variável caractere a ser verificada
    Retorno
        Retorna a variável sem aspas ou apóstrofos

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe409()
    Local aArea     := FWGetArea()
    Local cTexto    := ""
    Local cMensagem := ""

    //Pega uma frase que tem aspas ou apóstrofos e remove
    cTexto := "E ele disse que 'Olá mundo' em inglês é 'Hello world'!"
    cMensagem := RemoveAsp(cTexto)
    FWAlertInfo(cMensagem, "Teste RemoveAsp")

    FWRestArea(aArea)
Return
