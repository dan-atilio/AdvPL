/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/11/buscando-o-nome-da-moeda-atraves-da-moeda2nome-maratona-advpl-e-tl-349/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe348
Retorna o nome do mês conforme data passada
@type Function
@author Atilio
@since 25/03/2023
@obs 

    Função MesDia
    Parâmetros
        Recebe a Data a ser verificada ou o número do Mês
    Retorno
        Retorna o nome do mês

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe348()
	Local aArea     := FWGetArea()
    Local dDtHoje   := Date()
    Local nMesTst   := 5
    Local cMesExten := ""

    //Pega o nome do mês conforme uma variável data
    cMesExten := MesExtenso(dDtHoje)
    FWAlertInfo("O resultado é " + cMesExten, "Teste 1 MesExtenso")

    //Pega o nome do mês conforme uma variável numérica
    cMesExten := MesExtenso(nMesTst)
    FWAlertInfo("O resultado é " + cMesExten, "Teste 2 MesExtenso")

    FWRestArea(aArea)
Return
