/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/30/validando-se-uma-tabela-existe-no-dicionario-com-fwaliasindic-maratona-advpl-e-tl-205/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe205
Função que valida se uma tabela existe no dicionário do Protheus
@type Function
@author Atilio
@since 12/02/2023
@see https://tdn.totvs.com/display/public/framework/FWAliasInDic
@obs 
    Função FWAliasInDic
    Parâmetros
        + cAlias      , Caractere        , Alias da tabela a ser procurada
        + lHelp       , Lógico           , Define se irá mostrar uma mensagem de aviso caso não encontre a tabela
    Retorno
        + lRet        , Lógico           , .T. se a tabela foi encontrada no dicionário ou .F. se não foi

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe205()
    Local aArea     := FWGetArea()

    //Verifica se uma tabela existe no dicionário    
    If FWAliasInDic("SB1")
        FWAlertInfo("A tabela SB1 foi encontrada, você pode fazer queries, locks, etc", "Teste de FWAliasInDic")
    EndIf

    FWRestArea(aArea)
Return
