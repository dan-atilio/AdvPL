/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/18/executando-uma-query-e-pegando-o-resultado-em-um-array-com-tcsqltoarr-maratona-advpl-e-tl-485/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe485
Executa uma query e joga o resultado em um array (similar a QryArray)
@type Function
@author Atilio
@since 03/04/2023
@see https://tdn.totvs.com/display/tec/TCSqlToArr
@obs 
    Função TCSqlToArr
    Parâmetros
        + cQuery       , Caractere      , Query SQL que será executada
        + aResult      , Array          , Array com o resultado da query
        + aBinds       , Array          , Array com os conteúdos que serão inseridos no lugar das interrogações dentro da query
        + aSetFields   , Array          , Array com os campos a definirem o conteúdo (similar a TCSetField após executar uma query)
        + aQryStru     , Array          , Array para ser alimentado com a estrutura dos campos da query
    Retorno
        + nRet         , Numérico       , Retorna um número com o resultado de execução da query (se menor que 0 aconteceu algum erro)

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe485()
    Local aArea     := FWGetArea()
    Local cQryAux   := ""
    Local aDados    := {}

    //Busca todos os grupos de produto
    cQryAux := " SELECT " + CRLF
    cQryAux += "     BM_GRUPO, " + CRLF
    cQryAux += "     BM_DESC, " + CRLF
    cQryAux += "     SBM.R_E_C_N_O_ AS SBMREC " + CRLF
    cQryAux += " FROM " + CRLF
    cQryAux += "     " + RetSQLName("SBM") + " SBM " + CRLF
    cQryAux += " WHERE " + CRLF
    cQryAux += "     BM_FILIAL = '" + FWxFilial("SBM") + "' " + CRLF
    cQryAux += "     AND SBM.D_E_L_E_T_ = ' ' " + CRLF
    
    //Tenta executar a query e atribuir em um Array
    If TCSqlToArr(cQryAux, @aDados) < 0
        FWAlertInfo("Falha: " + TCSQLError(), "Teste TCSqlToArr")
    Else
        FWAlertInfo("Foi encontrado " + cValToChar(Len(aDados)) + " registro(s), a posição 1 é: " + aDados[1][1], "Teste TCSqlToArr")
    EndIf

    FWRestArea(aArea)
Return
