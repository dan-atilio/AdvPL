/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/26/buscando-o-tipo-do-cliente-ou-fornecedor-com-a-ftippessoa-maratona-advpl-e-tl-197/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe196
Função que formata uma data
@type Function
@author Atilio
@since 11/02/2023
@obs 
    Função FsDateConv
    Parâmetros
        + Data a ser formatada
        + Máscara que será utilizada na formatação
    Retorno
        + Retorna a data formatada

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe196()
    Local aArea     := FWGetArea()
    Local dDataRef  := Date()
    Local cMensagem := ""

    //Montando uma mensagem com várias possibilidades de formatar uma data
    cMensagem += FsDateConv(dDataRef, "DDMMYYYY") + CRLF
    cMensagem += FsDateConv(dDataRef, "MMDDYYYY") + CRLF
    cMensagem += FsDateConv(dDataRef, "YYYYMMDD") + CRLF
    FWAlertInfo(cMensagem, "Teste FsDateConv")

    FWRestArea(aArea)
Return
