/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/01/gerando-um-arquivo-do-excel-atraves-da-dlgtoexcel-maratona-advpl-e-tl-146/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe147
Retorna o número do dia e o nome em inglês
@type Function
@author Atilio
@since 16/12/2022
@see https://tdn.totvs.com/display/tec/Dow
@obs 
    Função Dow
    Parâmetros
        + dData        , Data         , Indica a data que será validada
    Retorno
        + nDia         , Numérico     , Retorna o número de 0 a 7 (sendo 0 = Data vazia; 1 = Domingo ; 2 = Segunda ; 3 = Terça ; 4 = Quarta ; 5 = Quinta ; 6 = Sexta ; 7 = Sabado)

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe147()
    Local aArea       := FWGetArea()
    Local dDataRef    := Date()
    Local nDia        := 0
    Local cNomeDia    := ""
    Local cMensagem   := ""

    //Busca o dia e o nome do dia em inglês
    nDia     := Dow(dDataRef)
    cNomeDia := cDow(dDataRef)

    //Monta a mensagem e exibe
    cMensagem := "Data Atual: " + dToC(dDataRef) + CRLF + CRLF
    cMensagem += "Dia: " + cValToChar(nDia) + CRLF
    cMensagem += "Nome: " + cNomeDia
    FWAlertInfo(cMensagem, "Teste com Dow e cDow")

    FWRestArea(aArea)
Return
