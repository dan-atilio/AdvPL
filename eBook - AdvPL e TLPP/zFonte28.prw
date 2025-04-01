/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} zFonte28
Exemplo de estrutura de condicao com If, ElseIf, Else e EndIf
@type  Function
@author Atilio
@since 22/02/2023
@see https://tdn.totvs.com/display/tecen/IF+...+ENDIF
/*/

User Function zFonte28()
	Local aArea  := FWGetArea()
    Local cNome  := ""
    Local nTipo1 := 0
    Local nTipo2 := 0
    Local nTipo3 := 0
    
    //Definindo 1 nome
    cNome := "Daniel"

    If Upper(cNome) == "MARIA"
        FWAlertInfo("Nome igual a MARIA", "Teste de If, ElseIf e EndIf")

    ElseIf Upper(cNome) == "JOAO"
        FWAlertInfo("Nome igual a JOAO", "Teste de If, ElseIf e EndIf")

    Else
        FWAlertInfo("O Nome nao e MARIA nem JOAO", "Teste de If, ElseIf e EndIf")
    EndIf

    //Abre a tabela de produtos e percorre
    DbSelectArea("SB1")
    SB1->(DbGoTop())
    While ! SB1->(EoF())

        //Se o tipo do produto for Produto Acabado ou Produto Intermediário
        If SB1->B1_TIPO == 'PA' .Or. SB1->B1_TIPO == 'PI'
            nTipo1++

        //Senão, se o tipo do produto for Matéria Prima ou Embalagem
        ElseIf SB1->B1_TIPO == 'MP' .Or. SB1->B1_TIPO == 'EM'
            nTipo2++

        //Senão (todos os outros tipos)
        Else
            nTipo3++
        EndIf

        SB1->(DbSkip())
    EndDo

    //Mostra uma mensagem
    ShowLog("Caiu na primeira condição: " + cValToChar(nTipo1) + ", na segunda: " + cValToChar(nTipo2) + ", na terceira: " + cValToChar(nTipo3))

    FWRestArea(aArea)
Return
