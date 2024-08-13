/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/09/13/funcoes-anomes-e-mesano-para-buscar-o-yyyymm-de-uma-data-maratona-advpl-e-tl-036/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe036
Exemplo de função que retorna o ano e mês conforme uma data (YYYYMM)
@type Function
@author Atilio
@since 28/11/2022
@obs 
    Função AnoMes
    Parâmetros
        + Data que será efetuado a tratativa para buscar o ano e mês
    Retorno
        + Texto no formato YYYYMM conforme a data passada

    Função MesAno
    Parâmetros
        + Data que será efetuado a tratativa para buscar o ano e mês
    Retorno
        + Texto no formato YYYYMM conforme a data passada

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe036()
    Local aArea   := FWGetArea()
    Local dData   := sToD("")
    Local cResult := ""

    //Pegando o Ano e Mês da data atual conforme o servidor
    dData   := Date()
    cResult := AnoMes(dData)
    FWAlertInfo("O período é: " + cResult, "Resultado do AnoMes")

    //Pegando o Ano e Mês de 1 mês atrás conforme o servidor
    dData   := MonthSub(Date(), 1)
    cResult := MesAno(dData)
    FWAlertInfo("O período é: " + cResult, "Resultado do MesAno")

    //Pegando o resultado e colocando em uma máscara, por exemplo YYYY-MM
    dData   := Date()
    cResult := AnoMes(dData)
    cResult := Transform(cResult, "@R 9999-99")
    FWAlertInfo("O período é: " + cResult, "Resultado do AnoMes com Máscara")

    FWRestArea(aArea)
Return
