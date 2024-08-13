/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/09/14/funcao-apoleclient-para-validar-a-instalacao-de-um-aplicativo-do-office-maratona-advpl-e-tl-037/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe037
Exemplo de função que verifica se um software do pacote Office está instalado
@type Function
@author Atilio
@since 28/11/2022
@obs 
    Função ApOleClient
    Parâmetros
        + Nome do aplicativo (como MSEXCEL; MSPROJECT; MSVISIO)
    Retorno
        + Retorna .T. se é encontrou o aplicativo instaldo ou .F. se não encontrar

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe037()
    Local aArea     := FWGetArea()

    //Verifica se o Excel está instalado
    If ApOleClient("MsExcel")
        FWAlertInfo("O Excel esta instalado na máquina!", "Excel")
    EndIf

    //Verifica se o Visio NÃO está instalado
    If ! ApOleClient("MsVisio")
        FWAlertInfo("O Visio não esta instalado na máquina!", "Visio")
    EndIf

    FWRestArea(aArea)
Return
