/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/11/04/controle-de-numeracoes-usando-confirmsx8-getsxenum-e-rollbacksx8-maratona-advpl-e-tl-088/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe088
Exemplo de como buscar um código sequencial de uma tabela, confirmar no banco ou estornar
@type Function
@author Atilio
@since 09/12/2022
@see https://tdn.totvs.com/pages/releaseview.action?pageId=23889183 , https://tdn.totvs.com/pages/releaseview.action?pageId=24346933 e https://tdn.totvs.com/pages/releaseview.action?pageId=24347062
@obs 
    Função GetSXENum
    Parâmetros
        + cAlias        , Caractere    , Informa o alias da tabela
        + cCpoSx8       , Caractere    , Informa o nome do campo que irá buscar o sequencial
        + cAliasSX8     , Caractere    , Informa o alias caso não seja utilizado o nome padrão da tabela no sequenciamento (opcional)
        + nOrdem        , Numérico     , Informa o número do índice que será utilizado para verificar o sequenciamento da tabela (opcional)
    Retorno
        + cRet          , Caractere    , Retorna o conteúdo sequencial encontrado

    Função ConfirmSX8
    Parâmetros
        + lPosConf      , Lógico       , Se passado .T. será validado se já existe o código gravado na tabela do Protheus
    Retorno
        Não possui

    Função RollBackSX8
    Parâmetros
        Não possui
    Retorno
        Não possui



    Atualmente as numerações ficam no License Server, antigamente eram as tabelas SXE e SXF (e mais antigamente a SX8)

    Outro ponto importante, em documentações citam a ConfirmSXE e RollBackSXE, porém até o momento da montagem desse exemplo
    essas das funções não veem nativas no RPO (se você der um inspetor de funções, ambas não serão encontradas), por esse motivo
    utilizamos a ConfirmSX8 e RollBackSX8

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe088()
    Local aArea     := FWGetArea()
    Local cCodigo   := ''

    //Iniciando o controle de transações    
    Begin Transaction

        //Pegando o último pedido de venda disponível conforme a numeração automática
        cCodigo := GetSXENum('SC5', 'C5_NUM')
        
        //Perguntando se deseja confirmar esse código, para confirmar e atualizar as tabelas de numeração automática
        If FWAlertYesNo("Deseja confirmar o código " + cCodigo + "?", "Confirma?")
            ConfirmSX8()
        
        //Senão, volta a numeração onde estava    
        Else
            RollBackSX8()
        EndIf
    End Transaction

    FWRestArea(aArea)
Return
