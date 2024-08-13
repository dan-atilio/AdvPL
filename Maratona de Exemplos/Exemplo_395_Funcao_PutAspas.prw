/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/04/buscando-o-nome-de-funcoes-na-pilha-de-chamadas-com-a-procname-maratona-advpl-e-tl-394/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe395
Adiciona apóstrofo ou aspas no começo e no fim de uma string
@type Function
@author Atilio
@since 28/03/2023
@obs 

    Função PutAspas
    Parâmetros
        Variável caractere a ser verificada
    Retorno
        Retorna a variável com aspas ou apóstrofos a mais no começo e no fim

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe395()
    Local aArea     := FWGetArea()
    Local cTexto    := ""
    Local cMensagem := ""
    
    //Adiciona apóstrofos em uma frase no inicio e fim
    cTexto := "Olá mundo"
    cMensagem := PutAspas(cTexto)
    FWAlertInfo(cMensagem, "Teste 1 PutAspas")

    //Adiciona aspas em uma frase no inicio e fim (pois ela já tem apóstrofos)
    cTexto := "E ele disse que 'Olá mundo' em inglês é 'Hello world'!"
    cMensagem := PutAspas(cTexto)
    FWAlertInfo(cMensagem, "Teste 2 PutAspas")

    FWRestArea(aArea)
Return
