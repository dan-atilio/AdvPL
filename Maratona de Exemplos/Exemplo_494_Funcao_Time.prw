/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/23/buscando-a-hora-atual-com-time-maratona-advpl-e-tl-494/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe494
Retorna a hora atual do sistema operacional
@type Function
@author Atilio
@since 04/04/2023
@see https://tdn.totvs.com/display/tec/Time
@obs 

    Time
    Parâmetros
        Função não tem parâmetros
    Retorno
        + cTime       , Caractere     , Retorna a hora no formato "hh:mm:ss"

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe494()
    Local aArea      := FWGetArea()
    Local cHora      := ""

    //Busca a hora atual
    cHora := Time()

    //Mostra uma mensagem
    FWAlertInfo("Oloko bicho, agora são exatamente " + cHora, "Teste Time")

    FWRestArea(aArea)
Return
