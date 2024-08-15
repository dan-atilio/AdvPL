/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2023/02/27/incluir-registros-em-uma-tela-sem-execauto-sem-reclock-e-sem-ser-mvc-ti-responde-045/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zVid0045
Teste de inclusão usando AxIncluiAuto
@type  Function
@author Atilio
@since 20/08/2022
/*/

User Function zVid0045()
    Local aArea     := FWGetArea()
    Local cTabela   := "RC1"
    Local aDados    := {}
    Local cTudoOk   := "Gpm660Vld(1)"
    Local cTransact := "Gpm660_PCO()"
    Local nRetorno  := 0
    Private lMsErroAuto := .F.

    //Adiciona os campos para o ExecAuto
    aAdd(aDados, {"RC1_FILTIT", "01",                                Nil})
    aAdd(aDados, {"RC1_PREFIX", "GPE",                               Nil})
    aAdd(aDados, {"RC1_NUMTIT", "000000005",                         Nil})
    aAdd(aDados, {"RC1_CODTIT", "GPE",                               Nil})
    aAdd(aDados, {"RC1_DESCRI", "GPE - Teste 5",                     Nil})
    aAdd(aDados, {"RC1_VALOR",  250,                                 Nil})
    aAdd(aDados, {"RC1_EMISSA", dDataBase,                           Nil})
    aAdd(aDados, {"RC1_VENCTO", DaySum(dDataBase, 5),                Nil})
    aAdd(aDados, {"RC1_VENREA", DaySum(dDataBase, 5),                Nil})
    aAdd(aDados, {"RC1_TIPO",   "NF",                                Nil})
    aAdd(aDados, {"RC1_NATURE", "NATDES0001",                        Nil})
    aAdd(aDados, {"RC1_FORNEC", "F00003",                            Nil})
    aAdd(aDados, {"RC1_LOJA",   "01",                                Nil})
    aAdd(aDados, {"RC1_DTBUSI", FirstDate(MonthSub(dDataBase, 1)),   Nil})
    aAdd(aDados, {"RC1_DTBUSF", LastDate(MonthSub(dDataBase, 1)),    Nil})

    //Inicializa a transação
    Begin Transaction
        //Joga a tabela para a memória (M->)
        RegToMemory(;
            cTabela,; // cAlias - Alias da Tabela
            .T.,;     // lInc   - Define se é uma operação de inclusão ou atualização
            .F.;      // lDic   - Define se irá inicilizar os campos conforme o dicionário
        )

        //Se conseguir fazer a execução automática
        If EnchAuto(;
            cTabela,; // cAlias  - Alias da Tabela
            aDados,;  // aField  - Array com os campos e valores
            cTudoOk,; // uTUDOOK - Validação do botão confirmar
            3;        // nOPC    - Operação do Menu (3=inclusão, 4=alteração, 5=exclusão)
        )

            //Aciona a efetivação da gravação
            nRetorno := AxIncluiAuto(;
                cTabela,;   // cAlias     - Alias da Tabela
                ,;          // cTudoOk    - Operação do TudoOk (se usado no EnchAuto não precisa usar aqui)
                cTransact,; // cTransact  - Operação acionada após a gravação mas dentro da transação
                3;          // nOpcaoAuto - Operação do Menu (3=inclusão, 4=alteração, 5=exclusão)
            )

        Else
            AutoGrLog("Falha na geração da RC1!")
            MostraErro()
            DisarmTransaction()
        EndIf
    End Transaction

    FWRestArea(aArea)
Return
