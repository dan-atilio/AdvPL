/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/04/criando-uma-barra-com-botoes-usando-a-enchoicebar-maratona-advpl-e-tl-153/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe152
Verifica se um conteúdo esta vazio
@type Function
@author Atilio
@since 18/12/2022
@see https://tdn.totvs.com/display/tec/Empty
@obs 
    Função Empty
    Parâmetros
        + xExp           , Indefinido   , Indica o valor que será validado
    Retorno
        + lRet           , Lógico       , Retorna .T. se o conteúdo for vazio ou .F. se tiver dados

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe152()
    Local aArea       := FWGetArea()
    Local aDados      := {}
    Local cNome       := Space(10)
    Local cNome2      := "Daniel"
    Local nValor      := 0
    Local dData       := sToD("")
    Local cVarTst     := Nil
    Local cMensagem   := ""

    //Monta a mensagem
    cMensagem += "aDados   : " + cValToChar(Empty(aDados   )) + CRLF
    cMensagem += "cNome    : " + cValToChar(Empty(cNome    )) + CRLF
    cMensagem += "cNome2   : " + cValToChar(Empty(cNome2   )) + CRLF
    cMensagem += "nValor   : " + cValToChar(Empty(nValor   )) + CRLF
    cMensagem += "dData    : " + cValToChar(Empty(dData    )) + CRLF
    cMensagem += "cVarTst  : " + cValToChar(Empty(cVarTst  )) + CRLF
    FWAlertInfo(cMensagem, "Teste 1 - Empty")

    //Agora faz direto o teste com if
    cNome := "aaa"
    If Empty(cNome)
        FWAlertError("Conteúdo esta vazio na variável", "Teste 2 - Empty")
    Else
        FWAlertInfo("A variável possui conteúdo", "Teste 2 - Empty")
    EndIf


    FWRestArea(aArea)
Return
