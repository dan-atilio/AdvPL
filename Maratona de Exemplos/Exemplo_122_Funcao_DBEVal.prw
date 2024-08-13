/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/12/08/executando-um-bloco-de-codigo-em-um-alias-com-dbeval-maratona-advpl-e-tl-122/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe122
Executa um bloco de código no alias
@type Function
@author Atilio
@since 14/12/2022
@see https://tdn.totvs.com/display/tec/DBEVal
@obs 
    Função DBEVal
    Parâmetros
        + bBlock           , Bloco de Código  , Bloco de código a ser executado
        + bFirstCondition  , Bloco de Código  , Bloco de código com condição em caso de inserção de registro
        + bSecondCondition , Bloco de Código  , Segundo bloco de código com condição em caso de inserção de registro
        + nCount           , Numérico         , Número máximo de registros a serem processados
        + nRecno           , Numérico         , RecNo do único registro a ser processado
        + lRest            , Lógico           , Indica que os demais registros serão processados
    Retorno
        Função não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe122()
    Local aArea      := FWGetArea()
    Local nTotal     := 0
    Local bBloco     := {|| }
    Local aProds     := {}

    DbSelectArea('SB1')
    SB1->(DbSetOrder(1)) //B1_FILIAL + B1_COD

    //Define o bloco de código
    bBloco := {|| Iif("A" $ Upper(SB1->B1_DESC), nTotal++, Nil)}

    //Executa o bloco de código
    SB1->(DbGoTop())
    SB1->(DbEVal(bBloco))

    //Mostra o resultado
    FWAlertInfo("Existe(m) " + cValToChar(nTotal) + " produto(s) que  tem a letra 'A' na descrição!", "Teste 1 DbEVal")


    

    //Define o bloco de código
    bBloco := {|| ;
        aAdd(aProds, {SB1->B1_COD, SB1->B1_DESC, SB1->(RecNo())});
    }

    //Executa o bloco de código
    SB1->(DbGoTop())
    SB1->(DbEVal(bBloco))

    //Mostra o resultado
    FWAlertInfo("Existe(m) " + cValToChar(Len(aProds)) + " produto(s) no Array!", "Teste 2 DbEVal")

    FWRestArea(aArea)
Return
