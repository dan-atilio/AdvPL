/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/07/gerando-valores-randomicos-com-as-funcoes-randbytime-e-randbydate-maratona-advpl-e-tl-401/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe401
Gera valores randomicos conforme data e hora
@type Function
@author Atilio
@since 28/03/2023
@obs 
    Função RandByTime
    Parâmetros
        Não tem parâmetros
    Retorno
        Retorna o valor randomico conforme a hora atual
    
    Função RandByDate
    Parâmetros
        Não tem parâmetros
    Retorno
        Retorna o valor randomico conforme a data atual

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe401()
    Local aArea     := FWGetArea()
    Local cPorData  := ""
    Local cPorHora  := ""

    //Gera um valor randomico pela hora atual
    cPorHora := RandByTime()
    FWAlertInfo("Valor gerado é: " + cPorHora, "Teste RandByTime")

    //Gera um valor randomico pela data atual
    cPorData := RandByDate()
    FWAlertInfo("Valor gerado é: " + cPorData, "Teste RandByDate")

    FWRestArea(aArea)
Return
