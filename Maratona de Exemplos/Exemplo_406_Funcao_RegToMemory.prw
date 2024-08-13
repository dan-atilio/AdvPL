/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/10/colocando-uma-tabela-em-memoria-com-a-regtomemory-maratona-advpl-e-tl-406/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe406
Deixa uma tabela em memória para edição (M->)
@type Function
@author Atilio
@since 28/03/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6814879
@obs 
    Função RegToMemory
    Parâmetros
        + cAlias     , Caractere     , Alias da Tabela
        + lInc       , Lógico        , .T. se for inclusão ou .F. se for alteração
        + lDic       , Lógico        , .T. se irá se basear no dicionário de dados da SX3
        + lInitPad   , Lógico        , .T. se irá iniciliazar os campos em uma operação de inclusão baseado no lDic
        + cStack     , Caractere     , Compatibilidade / Reservado
    Retorno
        Função não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe406()
    Local aArea     := FWGetArea()
    Local cCampo    := ""

    //Inicia o controle de transações
    Begin Transaction
        //Joga a tabela para a memória (M->)
        RegToMemory(;
            "SA1",;   // cAlias - Alias da Tabela
            .T.,;     // lInc   - Define se é uma operação de inclusão ou atualização
            .F.;      // lDic   - Define se irá inicilizar os campos conforme o dicionário
        )

        //Preenche o estado e o código da cidade
        M->A1_EST     := "SP"
        M->A1_COD_MUN := "06003"

        //Chama gatilho caso exista
        cCampo := "A1_COD_MUN"
        If ExistTrigger(cCampo)
            RunTrigger( ;
                1,;           //nTipo (1=Enchoice; 2=GetDados; 3=F3)
                Nil,;         //Linha atual da Grid quando for tipo 2
                Nil,;         //Não utilizado
                ,;            //Objeto quando for tipo 1
                cCampo;       //Campo que dispara o gatilho
            )
        EndIf

        //Mostra a cidade preenchida conforme gatilho disparado
        FWAlertInfo("Cidade: " + M->A1_MUN, "Teste de ExistTrigger e RunTrigger")

        //Cancela a transação para não incluir nenhum registro
        DisarmTransaction()
    End Transaction

    FWRestArea(aArea)
Return
