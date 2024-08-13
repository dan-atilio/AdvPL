/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/23/verificando-se-um-alias-esta-aberto-com-a-select-maratona-advpl-e-tl-433/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe433
Retorna o numero na memória de um alias aberto
@type Function
@author Atilio
@since 30/03/2023
@see https://tdn.totvs.com/display/tec/Select
@obs 
    Função Select
    Parâmetros
        + cAlias      , Caractere     , Alias que será analisado
    Retorno
        + nRet        , Numérico      , Retorna o número encontrado da área de trabalho (workarea)

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe433()
    Local aArea    := FWGetArea()
    Local cQuery   := ""

    //Abrindo uma tabela e mostrando com qual número ela foi aberta    
    DbSelectArea("SB1")
    FWAlertInfo("O alias SB1 foi aberto com o seguinte número: " + cValToChar(Select("SB1")), "Teste 1 - Select")

    //Exemplo 2, fechando um alias, antes de abrir novamente
    cQuery := " SELECT TOP 1 B1_COD, B1_DESC FROM " + RetSQLName("SB1") + " SB1 WHERE " + RetSQLCond("SB1")
    If Select('QRY_SB1') > 0
        FWAlertSuccess("Estava aberto o Alias QRY_SB1, então foi fechado!", "Teste 2 - Select")
        QRY_SB1->(DbCloseArea())
    EndIf
    PLSQuery(cQuery, 'QRY_SB1')

    FWRestArea(aArea)
Return
