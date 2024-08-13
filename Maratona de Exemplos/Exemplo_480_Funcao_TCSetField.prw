/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/16/definindo-o-tipo-de-um-campo-atraves-da-tcsetfield-maratona-advpl-e-tl-480/
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} User Function zExe480
Atualiza as definições de uma tabela no Cache do DBAccess
@type Function
@author Atilio
@since 03/04/2023
@see https://tdn.totvs.com/display/tec/TCSetField
@obs 

    TCSetField
    Parâmetros
        + cAlias      , Caractere      , Alias da Query
        + cField      , Caractere      , Nome do campo da Query
        + cType       , Caractere      , Indica o tipo que será definido (D de Data; N de Numérico; L de Lógico)
        + nSize       , Numérico       , Tamanho do campo
        + nPrecision  , Numérico       , Quantidade de decimais do campo
    Retorno
        Função não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe480()
    Local aArea      := FWGetArea()
    Local cQrySB1    := ""

    //Monta uma query para buscar um grupo de produto com o código G001
    cQrySB1 += " SELECT  " + CRLF
    cQrySB1 += "     B1_COD, B1_DESC, B1_UREV, B1_DATREF " + CRLF
    cQrySB1 += " FROM  " + CRLF
    cQrySB1 += "     " + RetSQLName("SB1") + " SB1  " + CRLF
    cQrySB1 += " WHERE  " + CRLF
    cQrySB1 += "     B1_FILIAL = '" + FWxFilial("SB1") + "' " + CRLF
    cQrySB1 += "     AND B1_GRUPO = 'G001' " + CRLF
    cQrySB1 += "     AND SB1.D_E_L_E_T_ = ' ' " + CRLF

    //Abre o alias em memória
    TCQuery cQrySB1 New Alias "QRY_SB1"

    //Define o campo B1_UREV como do tipo Data
    TCSetField("QRY_SB1", "B1_UREV", "D")

    //Exibe alguma mensagem, caso haja dados
    If ! QRY_SB1->(EoF())
        FWAlertInfo("Descrição do primeiro registro: " + QRY_SB1->B1_DESC, "Teste TCSetField")
    EndIf

    //Fecha o alias
    QRY_SB1->(DbCloseArea())

    FWRestArea(aArea)
Return
