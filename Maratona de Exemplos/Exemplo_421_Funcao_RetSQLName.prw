/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/17/montando-um-filtro-basico-de-uma-tabela-atraves-da-retsqlcond-maratona-advpl-e-tl-420/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe421
Retorna o nome real da tabela conforme configuração da SX2
@type Function
@author Atilio
@since 29/03/2023
@obs 
    Função RetSQLName
    Parâmetros
        Recebe o Alias da tabela (por exemplo SB1)
    Retorno
        Retorna o nome real no banco de dados (por exemplo SB1010 ou SB1020 ou SB1990 etc conforme empresa logada)

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe421()
    Local aArea     := FWGetArea()
    Local cQryAux   := ""
    Local cNomeTab  := RetSQLName("SB1")

    //Busca todos os produtos que não estejam bloqueados
    cQryAux := " SELECT " + CRLF
    cQryAux += "     B1_COD, " + CRLF
    cQryAux += "     B1_DESC, " + CRLF
    cQryAux += "     B1_UCOM, " + CRLF
    cQryAux += "     SB1.R_E_C_N_O_ AS SB1REC " + CRLF
    cQryAux += " FROM " + CRLF
    cQryAux += "     " + cNomeTab + " SB1 " + CRLF
    cQryAux += " WHERE " + CRLF
    cQryAux += "     B1_FILIAL = '" + FWxFilial("SB1") + "' " + CRLF
    cQryAux += "     AND B1_MSBLQL != '1' " + CRLF
    cQryAux += "     AND B1_TIPO = 'PA' " + CRLF
    cQryAux += "     AND SB1.D_E_L_E_T_ = ' ' " + CRLF
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
