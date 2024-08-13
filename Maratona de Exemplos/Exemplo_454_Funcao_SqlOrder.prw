/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/03/calculando-uma-raiz-quadrada-atraves-da-sqrt-maratona-advpl-e-tl-455/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe454
Monta uma ordenação para ser usada em Order By
@type Function
@author Atilio
@since 31/03/2023
@obs 

    Função SqlOrder
    Parâmetros
        Recebe a expressão da SIX (exemplo B1_FILIAL + B1_COD)
    Retorno
        Retorna a expressão para ser usada no SQL (exemplo B1_FILIAL, B1_COD)

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe454()
    Local aArea      := FWGetArea()
    Local cMensagem  := ""

    //Agora usa o índice 8
    DbSelectArea("SB1")
    SB1->(DbSetOrder(8))

    //Monta a mensagem e exibe
    cMensagem := "Cadastro de Produtos" + CRLF + CRLF
    cMensagem += "O índice da SIX é: " + SB1->(IndexKey()) + CRLF
    cMensagem += "O índice para SQL é: " + SqlOrder(SB1->(IndexKey())) + CRLF
    FWAlertInfo(cMensagem, "Teste SqlOrder")

    FWRestArea(aArea)
Return
