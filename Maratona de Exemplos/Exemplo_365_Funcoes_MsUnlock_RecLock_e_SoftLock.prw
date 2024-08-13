/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/19/travando-registros-para-atualizacao-com-msunlock-reclock-e-softlock-maratona-advpl-e-tl-365/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe365
Trava uma tabela para atualizações de informações
@type Function
@author Atilio
@since 27/03/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=24347005 e https://tdn.totvs.com/pages/releaseview.action?pageId=24347041 e https://tdn.totvs.com/pages/releaseview.action?pageId=24347081
@obs 

    Função MsUnlock
    Parâmetros
        Função não tem parâmetros
    Retorno
        Função não tem retorno

    Função SoftLock
    Parâmetros
        + cAlias    , Caractere    , Indica o alias que será verificado
    Retorno
        Retorna .T. ou .F. se conseguiu encontrar e travar

    Função RecLock
    Parâmetros
        + cAlias    , Caractere    , Indica o alias que será verificado
        + lAdd      , Lógico       , .T. se será inclusão ou .F. se será alteração
        + l1        , Lógico       , Compatibilidade
        + lSoft     , Lógico       , Pergunta para o usuário se deseja lockar novamente
        + lInJob    , Lógico       , Indica se ta rodando dentro de um Job
    Retorno
        + lRet      , Lógico       , Retorna .T. ou .F. se conseguiu encontrar e travar

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe365()
    Local aArea    := FWGetArea()
    Local cCodProd := "F0001"
 
    DbSelectArea("SB1")
    SB1->(DbSetOrder(1)) // B1_FILIAL + B1_COD
 
    //Posiciona no produto
    If SB1->(MsSeek(FWxFilial("SB1") + cCodProd))
        If SoftLock("SB1")
            Alert("Aqui pode ser feito validações antes do reclock...")
 
            RecLock("SB1", .F.)
                //SB1->B1_X_CAMPO := 'aaaa'
            SB1->(MsUnlock())
        EndIf
    EndIf
 
    FWRestArea(aArea)
Return
