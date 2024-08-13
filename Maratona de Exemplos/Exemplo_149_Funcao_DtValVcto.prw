/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/02/validando-a-utilizacao-de-uma-data-com-a-funcao-dtvalvcto-maratona-advpl-e-tl-149/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe149
Função que valida a data de vencimento (não pode ser mais que 360 dias ou menor que a data logada)
@type Function
@author Atilio
@since 16/12/2022
@obs 
    Função DtValVcto
    Parâmetros
        + Data de Vencimento
    Retorno
        + Retorna .T. se é válida ou .F. se não

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe149()
    Local aArea      := FWGetArea()
    Local dDataVenc

    //Monta a data de vencimento com 3 dias atrás
    dDataVenc := DaySub(Date(), 3)
    If DtValVcto(dDataVenc)
        FWAlertSuccess("A data de vencimento '" + dToC(dDataVenc) + "' é válida", "Teste 1 DtValVcto")
    Else
        FWAlertError("A data de vencimento '" + dToC(dDataVenc) + "' não é válida", "Teste 1 DtValVcto")
    EndIf

    //Monta a data de vencimento com 1 ano no futuro
    dDataVenc := YearSum(Date(), 1)
    If DtValVcto(dDataVenc)
        FWAlertSuccess("A data de vencimento '" + dToC(dDataVenc) + "' é válida", "Teste 2 DtValVcto")
    Else
        FWAlertError("A data de vencimento '" + dToC(dDataVenc) + "' não é válida", "Teste 2 DtValVcto")
    EndIf

    //Monta a dta de vencimento daqui 5 dias
    dDataVenc := DaySum(Date(), 5)
    If DtValVcto(dDataVenc)
        FWAlertSuccess("A data de vencimento '" + dToC(dDataVenc) + "' é válida", "Teste 3 DtValVcto")
    Else
        FWAlertError("A data de vencimento '" + dToC(dDataVenc) + "' não é válida", "Teste 3 DtValVcto")
    EndIf

    FWRestArea(aArea)
Return
