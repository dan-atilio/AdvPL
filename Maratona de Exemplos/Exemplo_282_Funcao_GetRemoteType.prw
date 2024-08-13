/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/09/buscando-conteudos-dentro-do-rpo-com-a-getresarray-maratona-advpl-e-tl-283/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe282
Retorna o tipo de estação que esta executando o Protheus
@type  Function
@author Atilio
@since 21/02/2023
@see https://tdn.totvs.com/display/tec/GetRemoteType
@obs 
    
    Função GetRemoteType
    Parâmetros
        + cLibVersion , Caractere   , Busca a versão da LIB usada por referência
    Retorno
        + nRet        , Numérico    , Retorna em qual sistema esta executando a rotina

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe282()
    Local aArea      := FWGetArea()
    Local cMensagem  := ""
    Local cLibUsada  := ""
    Local nTipo      := 0
    
    //Busca as informações sobre o remote
    nTipo := GetRemoteType(@cLibUsada)

    //Monta a mensagem a ser exibida
    If nTipo == -1
        cMensagem += "Job, Web ou Sem Remote"
    ElseIf nTipo == 1
        cMensagem += "Windows"
    ElseIf nTipo == 2
        cMensagem += "Linux / Unix-Like"
    EndIf
    cMensagem += " - " + cLibUsada

    //Exibe uma mensagem com os programas
    FWAlertInfo(cMensagem, "Teste GetRemoteType")

    FWRestArea(aArea)
Return
