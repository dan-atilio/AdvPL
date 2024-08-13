/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/11/22/verificando-se-e-um-dia-util-com-a-funcao-datavalida-maratona-advpl-e-tl-106/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe106
Retorna a próxima data válida (sem ser fim de semana ou feriado)
@type Function
@author Atilio
@since 12/12/2022
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6815098
@obs 
    Função DataValida
    Parâmetros
        + dData         , Data         , Data a ser validada
        + lTipo         , Lógico       , .T. se posterga para a próxima data válida ou .F. se retrocede para data válida anterior
    Retorno
        + dData         , Data         , Data válida do sistema

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe106()
    Local aArea     := FWGetArea()
    Local dData     := sToD("20221210")
    Local dDataVld

    //Busca a data válida
    dDataVld := DataValida(dData)

    //Se for diferente, exibe a mensagem dizendo que era feriado ou fim de semana
    If dData != dDataVld
        FWAlertInfo("Fim de semana ou feriado!" + CRLF + "dData: " + DToC(dData) + CRLF + "dDataVld: " + DToC(dDataVld), "Teste DataValida")
    Else
        FWAlertInfo("Datas iguais", "Teste DataValida")
    EndIf

    FWRestArea(aArea)
Return
