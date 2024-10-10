/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2024/10/08/gravando-campos-customizados-na-sc9-atraves-do-m440sc9i-ti-responde-0088/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function M440SC9I
Ponto de Entrada logo após a inclusão da SC9
@type  Function
@author Atilio
@since 26/01/2024
@obs Essa rotina esta durante o RecLock da SC9, NÃO DESPOSICIONAR a tabela

    Para esse exemplo, foi usado o campo customizado C9_X_ORIG
    Que irá gravar o nome da função de origem
    Crie esse campo na sua base como Caractere tamanho 10 no contexto Real
/*/

User Function M440SC9I()
    Local aArea := FWGetArea()

    //Aciona a gravação de campos customizados
    u_zVid0088()

    FWRestArea(aArea)
Return

/*/{Protheus.doc} zVid0088
Função para gravar campos customizados na SC9
@type user function
@author Atilio
@since 26/01/2024
/*/

User Function zVid0088()
    Local aArea      := FWGetArea()
    Local cTextoOrig := ""

    //Se vier da função de Pedido de Vendas
    If Alltrim(FunName()) == "MATA410"
        //Se for da rotina de Cópia
        If FWIsInCallStack("a410PCopia")
            cTextoOrig := "CPY"

        //Se estiver em Alteração
        ElseIf ALTERA
            cTextoOrig := "ALT"

        //Senão será Inclusão
        Else
            cTextoOrig := "INC"
        EndIf

        //Atualiza a origem com o texto do Pedido de Venda e qual foi a origem
        SC9->C9_X_ORIG := "PEDVEN_" + cTextoOrig

    //Senão, se veio de outra função que gerou a SC9, grava o FunName
    Else
        SC9->C9_X_ORIG := FunName()
    EndIf

    //Grava o código do usuário
    SC9->C9_X_USER := RetCodUsr()

    //Se você quiser gravar outros campos, basta fazer conforme a sintaxe abaixo (lembre-se de sempre conferir a integridade dos dados antes): 
    /*
    SC9->C9_BLCRED := "01"
    */

    FWRestArea(aArea)
Return
