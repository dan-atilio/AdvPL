/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/17/buscando-o-nome-da-tabela-no-banco-com-a-retsqlname-maratona-advpl-e-tl-421/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe420
Retorna o filtro dos campos de filial e "delete" de uma tabela
@type Function
@author Atilio
@since 28/03/2023
@obs 
    Função RetSQLCond
    Parâmetros
        Recebe o Alias para a montagem da condição
    Retorno
        Retorna a condição de filtro montada

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe420()
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
    PLSQuery(cQryAux, "QRY_AUX")

    //Se houver dados
    If ! QRY_AUX->(EoF())

        //Percorre os dados da query
        While ! QRY_AUX->(EoF())
            /*
                Suas customizações
            */

            QRY_AUX->(DbSkip())
        EndDo

    EndIf
    QRY_AUX->(DbCloseArea())

    FWRestArea(aArea)
Return
