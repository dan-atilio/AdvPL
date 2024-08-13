/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/29/buscando-informacoes-de-um-objeto-do-repositorio-com-a-getapoinfo-maratona-advpl-e-tl-264/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe264
Função que retorna informações de um objeto dentro do RPO
@type  Function
@author Atilio
@since 21/02/2023
@see https://tdn.totvs.com/display/tec/GetAPOInfo
@obs 

    Função GetApoInfo
    Parâmetros
        + cFonte        , Caractere        , Nome do Código Fonte
    Retorno
        + aData         , Array            , Array com os detalhes do código fonte
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe264()
    Local aArea      := FWGetArea()
    Local aDados     := {}
    Local cMensagem  := ""

    //Busca as informações do fonte
    aDados := GetApoInfo("zMiniForm.prw")

    //Se houver informações, monta a mensagem e exibe
    If Len(aDados) > 0
        cMensagem := "Nome do Fonte: "              + aDados[01] + CRLF
        cMensagem += "Linguagem: "                  + aDados[02] + CRLF
        cMensagem += "Modo de Compilação: "         + aDados[03] + CRLF
        cMensagem += "Data da última modificação: " + dToC(aDados[04]) + CRLF
        cMensagem += "Hora da última modificação: " + aDados[05]

        FWAlertInfo(cMensagem, "Teste GetApoInfo")
    EndIf

    FWRestArea(aArea)
Return
