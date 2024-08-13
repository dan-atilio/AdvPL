/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/26/buscando-a-ultima-pergunta-executada-com-a-setlastperg-maratona-advpl-e-tl-438/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe439
Altera o módulo em execução pela rotina
@type Function
@author Atilio
@since 30/03/2023
@obs 
    Função SetModulo
    Parâmetros
        Recebe o nome do módulo
        Recebe a sigla abreviada do módulo
    Retorno
        Retorna um Array com o backup de qual módulo estava sendo posição [1] sigla do módulo e [2] o número do módulo

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe439()
    Local aArea    := FWGetArea()
    Local aDados   := {}

    //Aciona a rotina para alterar o módulo
    aDados := SetModulo("SIGAEST", "EST")

    FWAlertInfo("Agora estou no módulo '" + cModulo + "', antes eu estava no '" + aDados[1] + "'!", "Teste SetModulo")

	FWRestArea(aArea)
Return
