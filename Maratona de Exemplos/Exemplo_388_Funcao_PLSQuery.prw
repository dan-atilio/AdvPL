/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/01/buscando-o-estilo-css-de-um-objeto-com-a-poscss-maratona-advpl-e-tl-389/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe388
Executa uma query, e onde houver campos do tipo data, já aplica a conversão
@type Function
@author Atilio
@since 28/03/2023
@obs 
    Função PLSQuery
    Parâmetros
        Query SQL
        Alias que será aberto
        Define se irá gerar um log da query (com tempo de execução) na pasta logpls dentro da Protheus Data
        Nome do arquivo de log caso seja para gerar
    Retorno
        Função não tem Retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe388()
    Local aArea     := FWGetArea()
    Local cQryAux   := ""

    //Busca todos os produtos que não estejam bloqueados
    cQryAux := " SELECT " + CRLF
    cQryAux += "     B1_COD, " + CRLF
    cQryAux += "     B1_DESC, " + CRLF
    cQryAux += "     B1_UCOM, " + CRLF
    cQryAux += "     SB1.R_E_C_N_O_ AS SB1REC " + CRLF
    cQryAux += " FROM " + CRLF
    cQryAux += "     " + RetSQLName("SB1") + " SB1 " + CRLF
    cQryAux += " WHERE " + CRLF
    cQryAux += "     B1_FILIAL = '" + FWxFilial("SB1") + "' " + CRLF
    cQryAux += "     AND B1_MSBLQL != '1' " + CRLF
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
