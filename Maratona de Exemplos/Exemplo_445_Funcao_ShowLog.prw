/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/29/executando-funcionalidades-no-s-o-com-shellexecute-waitrun-e-winexec-maratona-advpl-e-tl-444/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe445
Abre uma tela para visualização de textos
@type Function
@author Atilio
@since 31/03/2023
@obs 
    Função ShowLog
    Parâmetros
        Recebe o conteúdo em texto que será exibido
    Retorno
        Retorna .T. se clicou no Confirmar ou .F. se não

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe445()
    Local aArea     := FWGetArea()
    Local cQryAux   := ""
    Local cCondicao := RetSQLCond("SB1")

    //Busca todos os produtos que não estejam bloqueados
    cQryAux := " SELECT " + CRLF
    cQryAux += "     B1_COD, " + CRLF
    cQryAux += "     B1_DESC, " + CRLF
    cQryAux += "     B1_UCOM, " + CRLF
    cQryAux += "     SB1.R_E_C_N_O_ AS SB1REC " + CRLF
    cQryAux += " FROM " + CRLF
    cQryAux += "     " + RetSQLName("SB1") + " SB1 " + CRLF
    cQryAux += " WHERE " + CRLF
    cQryAux += cCondicao + CRLF
    cQryAux += "     AND B1_MSBLQL != '1' " + CRLF
    cQryAux += "     AND B1_TIPO = 'PA' " + CRLF

    //Exibe a query em tela
    ShowLog(cQryAux)

	FWRestArea(aArea)
Return
