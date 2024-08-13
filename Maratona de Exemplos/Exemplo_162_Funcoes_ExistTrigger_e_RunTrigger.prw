/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/09/convertendo-data-e-hora-no-formato-utc-com-exlocaltoutc-e-exutctolocal-maratona-advpl-e-tl-163/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe162
Valida se gatilhos existem e executa eles
@type Function
@author Atilio
@since 19/12/2022
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6815032
@obs 
    Função ExistTrigger
    Parâmetros
        + Nome do campo a ser verificado
    Retorno
        + .T. Se o campo possui gatilhos (X3_TRIGGER) ou .F. se não possui

    Função RunTrigger
    Parâmetros
        + nTipo        , Numérico    , Qual é o tiipo do gatilho (1=Enchoice; 2=Grid GetDados; 3=Consulta Padrão F3)
        + nLin         , Numérico    , Qual é a linha (quando o tipo for 2)
        + cMacro       , Caractere   , Compatibilidade
        + oObj         , Objeto      , Objeto da tela quando o tipo for 1
        + cField       , Caractere   , Nome do campo que os gatilhos serão disparados
    Retorno
        Função não tem Retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe162()
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
