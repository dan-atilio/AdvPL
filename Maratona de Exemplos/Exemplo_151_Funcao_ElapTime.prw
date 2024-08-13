/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/03/pegando-a-diferenca-entre-dois-horarios-com-a-funcao-elaptime-maratona-advpl-e-tl-151/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe151
Função que faz a comparação entre duas variáveis de horas
@type Function
@author Atilio
@since 18/12/2022
@see https://tdn.totvs.com/display/tec/ElapTime
@obs 
    Função ElapTime
    Parâmetros
        + cHoraInicial   , Caractere    , Indica a hora inicial da comparação
        + cHoraFinal     , Caractere    , Indica a hora final para comparação
    Retorno
        + cRet           , Caractere    , Retorna a diferença no formato hh:mm:ss

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe151()
    Local aArea       := FWGetArea()
    Local cHoraIni    := "14:10:35"
    Local cHoraFim    := "16:09:40"
    Local cDiferenca  := ""

    //Pega a diferença, e se passar de 1 hora, mostra uma mensagem
    cDiferenca := ElapTime(cHoraIni, cHoraFim)
    If cDiferenca > "01:00:00"
        FWAlertInfo("A diferença passa de 1 hora: " + cDiferenca, "Teste ElapTime")
    EndIf

    FWRestArea(aArea)
Return
