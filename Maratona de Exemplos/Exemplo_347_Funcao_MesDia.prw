/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/10/buscando-o-periodo-no-formato-yyyymm-com-a-mesanoatf-maratona-advpl-e-tl-346/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe347
Retorna o mês e o dia no formato "MMDD"
@type Function
@author Atilio
@since 25/03/2023
@obs 

    Função MesDia
    Parâmetros
        Recebe a Data a ser verificada
    Retorno
        Retorna o Mês e o dia em uma string no formato "MMDD"

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe347()
	Local aArea    := FWGetArea()
    Local dDtHoje  := Date()
    Local cConteud

    //Pega o Mês e o Dia conforme a data passada e exibe uma mensagem
    cConteud := MesDia(dDtHoje)
    FWAlertInfo("O resultado é " + cConteud, "Teste - MesDia")

    FWRestArea(aArea)
Return
