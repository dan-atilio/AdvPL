/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/31/validando-se-uma-linha-esta-apagada-numa-grid-com-a-lindelet-maratona-advpl-e-tl-327/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe327
Função que verifica se a linha esta apagada
@type  Function
@author Atilio
@since 12/03/2023
@obs 

    Função LinDelet
    Parâmetros
        Recebe um array com a linha atual
    Retorno
        Retorna .T. se a linha esta apagada ou .F. se não
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe327()
    Local aArea      := FWGetArea()
    Local nLinha     := 1
    Local cApagadas  := ""

    //Se a pergunta for confirmada
    If FWAlertYesNo("Deseja validar todas as linhas?", "Continua")
        //Percorre as linhas digitadas na grid
        For nLinha := 1 To Len(aCols)

            //Se a linha atual estiver apagada
            If LinDelet(aCols[nLinha])
                cApagadas += "+ Linha " + cValToChar(nLinha) + CRLF
            EndIf
        Next

        //Se a variavel estiver vazia, apenas mostra mensagem, senão mostra quais foram as linhas
        If Empty(cApagadas)
            FWAlertSuccess("Não há linha(s) apagada(s)", "Sucesso")
        Else
            FWAlertError(cApagadas, "Linhas Excluidas")
        EndIf
    EndIf

    FWRestArea(aArea)
Return

/*/{Protheus.doc} User Function A410CONS
Ponto de Entrada para adicionar botões no Outras Ações dentro do Pedido de Venda
@type  Function
@author Atilio
@since 12/03/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6784033
/*/

User Function A410CONS()
    Local aArea   := FWGetArea()
    Local aBotoes := {}

    aAdd(aBotoes, {'DBG07', {|| u_zExe327()}, "* Ver Linhas Apagadas", "* Apagadas"} )

    FWRestArea(aArea)
Return aBotoes
