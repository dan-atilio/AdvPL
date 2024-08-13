/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/19/buscando-uma-data-conforme-um-periodo-no-formato-mmyyyy-com-xpertodata-maratona-advpl-e-tl-546/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe546
Retorna uma data conforme o período informado no formato "MMYYYY"
@type Function
@author Atilio
@since 07/04/2023
@obs 
    Função xPerToData
    Parâmetros
        Recebe o período no formato string sendo "MMYYYY"
    Retorno
        Retorna o primeiro dia do período encontrado

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe546()
    Local aArea      := FWGetArea()
    Local cPeriodo   := ""
    Local dData      := dToS("")

    //Define o período e converte pra data
    cPeriodo := "052023"
    dData    := xPerToData(cPeriodo)

    //Mostra o resultado
    FWAlertInfo("O resultado é " + dToC(dData), "Teste xPerToData")

    FWRestArea(aArea)
Return
