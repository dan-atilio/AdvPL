/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/05/montando-a-estrutura-de-um-produto-com-as-funcoes-estrut2-e-fimestrut2-maratona-advpl-e-tl-155/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe154
Função que retira caracteres especiais de um conteúdo web (como URL)
@type Function
@author Atilio
@since 18/12/2022
@obs 
    Função Escape
    Parâmetros
        Recebe a string que terá os caracteres transformados
    Retorno
        Retorna a string com os caracteres já transformados

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe154()
    Local aArea     := FWGetArea()
    Local cOriginal := ""
    Local cConverti := ""

    //Convertendo uma URL que possua espaços
    cOriginal := "terminal de informação"
    cConverti := Escape(cOriginal)
    FWAlertInfo("A conversão de '" + cOriginal + "' deu '" + cConverti + "' ", "Exemplo Escape")

    FWRestArea(aArea)
Return
