/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/15/abrindo-uma-tela-de-carregamento-com-a-msaguarde-maratona-advpl-e-tl-357/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe356
Valida se o dicionário de dados esta no Banco de Dados
@type Function
@author Atilio
@since 26/03/2023
@see https://tdn.totvs.com/display/public/framework/MPDicInDB
@obs 
    Função MPDicInDB
    Parâmetros
        Função não tem parâmetros
    Retorno
        + lRet    , Lógico    , Se .T. o dicionário está no banco de dados se não ainda esta em arquivos dentro da Protheus Data

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe356()
    Local aArea         := FWGetArea()
    
    //Valida se o dicionário esta no banco de dados
    If MPDicInDB()
        FWAlertSuccess("O dicionário está no banco de dados (SQL)!", "Teste MPDicInDB")
    Else
        FWAlertError("O dicionário ainda não esta no banco de dados (CTREE / DBF)!", "Teste MPDicInDB")
    EndIf

    FWRestArea(aArea)
Return
