/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/09/montando-o-relacionamento-entre-duas-tabelas-com-a-fwjoinfilial-maratona-advpl-e-tl-224/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe225
Retorna o usuário e data dos logs de inclusão e alteração de campos
@type Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6814934
@obs 

    Função FWLeUserLg
    Parâmetros
        + cCampo        , Caractere   , Nome do Campo
        + nTipo         , Numérico    , 1 para retornar o nome do usuário e 2 para retornar a data
    Retorno
        + cRet          , Caractere   , Nome do Usuário ou Data

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe225()
    Local aArea := FWGetArea()
    Local cMensagem := ""
     
    DbSelectArea('SB1')
    SB1->(DbSetOrder(1)) //Filial + Código
     
    //Se conseguir posicionar, monta a mensagem para exibir
    If SB1->(DbSeek(FWxFilial('SB1') + "F0003"))
        cMensagem += "Produto: " + Alltrim(SB1->B1_COD) + " - " + Alltrim(SB1->B1_DESC) + CRLF

        //Logs de Inclusão
        cMensagem += CRLF
        cMensagem += "** Inclusão **" + CRLF
        cMensagem += "Usuário: " + FWLeUserLg("B1_USERLGI", 1) + CRLF
        cMensagem += "Data:    " + FWLeUserLg("B1_USERLGI", 2) + CRLF

        //Logs de Alteração
        cMensagem += CRLF
        cMensagem += "** Alteração **" + CRLF
        cMensagem += "Usuário: " + FWLeUserLg("B1_USERLGA", 1) + CRLF
        cMensagem += "Data:    " + FWLeUserLg("B1_USERLGA", 2) + CRLF
        
        //Exibe a mensagem
        FWAlertInfo(cMensagem, "Teste FWLeUserLg")
    EndIf

    FWRestArea(aArea)
Return
