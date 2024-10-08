/*
    Esse exemplo faz parte da s�rie do YouTube, Maratona de Exemplos, do canal Terminal de Informa��o, 
    caso queira ver esse exemplo rodando em v�deo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/09/convertendo-data-e-hora-no-formato-utc-com-exlocaltoutc-e-exutctolocal-maratona-advpl-e-tl-163/
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
    Fun��o ExistTrigger
    Par�metros
        + Nome do campo a ser verificado
    Retorno
        + .T. Se o campo possui gatilhos (X3_TRIGGER) ou .F. se n�o possui

    Fun��o RunTrigger
    Par�metros
        + nTipo        , Num�rico    , Qual � o tiipo do gatilho (1=Enchoice; 2=Grid GetDados; 3=Consulta Padr�o F3)
        + nLin         , Num�rico    , Qual � a linha (quando o tipo for 2)
        + cMacro       , Caractere   , Compatibilidade
        + oObj         , Objeto      , Objeto da tela quando o tipo for 1
        + cField       , Caractere   , Nome do campo que os gatilhos ser�o disparados
    Retorno
        Fun��o n�o tem Retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe162()
    Local aArea     := FWGetArea()
    Local cCampo    := ""

    //Inicia o controle de transa��es
    Begin Transaction
        //Joga a tabela para a mem�ria (M->)
        RegToMemory(;
            "SA1",;   // cAlias - Alias da Tabela
            .T.,;     // lInc   - Define se � uma opera��o de inclus�o ou atualiza��o
            .F.;      // lDic   - Define se ir� inicilizar os campos conforme o dicion�rio
        )

        //Preenche o estado e o c�digo da cidade
        M->A1_EST     := "SP"
        M->A1_COD_MUN := "06003"

        //Chama gatilho caso exista
        cCampo := "A1_COD_MUN"
        If ExistTrigger(cCampo)
            RunTrigger( ;
                1,;           //nTipo (1=Enchoice; 2=GetDados; 3=F3)
                Nil,;         //Linha atual da Grid quando for tipo 2
                Nil,;         //N�o utilizado
                ,;            //Objeto quando for tipo 1
                cCampo;       //Campo que dispara o gatilho
            )
        EndIf

        //Mostra a cidade preenchida conforme gatilho disparado
        FWAlertInfo("Cidade: " + M->A1_MUN, "Teste de ExistTrigger e RunTrigger")

        //Cancela a transa��o para n�o incluir nenhum registro
        DisarmTransaction()
    End Transaction

    FWRestArea(aArea)
Return
