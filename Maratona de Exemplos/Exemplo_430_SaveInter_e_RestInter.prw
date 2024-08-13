/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/22/buscando-o-saldo-de-um-lote-de-produto-com-a-sb8saldo-maratona-advpl-e-tl-431/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe430
Faz um backup de variáveis em memória (aCols, aHeader, INCLUI, ALTERA, MV_PAR**, cCadastro, etc)
@type Function
@author Atilio
@since 29/03/2023
@obs 

    Função SaveInter
    Parâmetros
        Função não tem parâmetros
    Retorno
        Função não tem retorno

    Função RestInter
    Parâmetros
        Função não tem parâmetros
    Retorno
        Função não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe430()
    Local aArea     := FWGetArea()
    Local cMensagem := ""

    //Altera variáveis do Protheus antes de fazer o backup
    cCadastro := "Teste - Antes de fazer o backup"
    INCLUI    := .T.
    MV_PAR01  := "aaa , bbb"
    MV_PAR60  := "daniel"

    //Faz um backup das variáveis do Protheus em memória
    SaveInter()



    //Altera as variáveis só pra fazer um teste
    cCadastro := "Teste - Depois de ter feito o Backup"
    INCLUI    := .F.
    MV_PAR01  := "xxx , yyy"
    MV_PAR60  := "atilio"

    //Restaura o backup das variáveis do Protheus em memória
    RestInter()



    //Agora mostra as 3 variáveis como elas estão após voltar o backup
    cMensagem := "cCadastro: " + cCadastro + CRLF
    cMensagem += "INCLUI: " + cValToChar(INCLUI) + CRLF
    cMensagem += "MV_PAR01: " + MV_PAR01 + CRLF
    cMensagem += "MV_PAR60: " + MV_PAR60
    FWAlertInfo(cMensagem, "Teste SaveInter e RestInter")

    FWRestArea(aArea)
Return
