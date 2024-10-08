/*
    Esse exemplo faz parte da s�rie do YouTube, Maratona de Exemplos, do canal Terminal de Informa��o, 
    caso queira ver esse exemplo rodando em v�deo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/05/tratando-caracteres-especiais-com-a-funcao-escape-maratona-advpl-e-tl-154/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe155
Monta a estrutura de um produto em uma tabela tempor�ria
@type Function
@author Atilio
@since 18/12/2022
@see https://tdn.totvs.com/pages/releaseview.action?pageId=287060852 e https://tdn.totvs.com/pages/releaseview.action?pageId=287060899
@obs 
    Fun��o Estrut2
    Par�metros
        + cProduto     , Caractere   , C�digo do produto (passar com os espa�os a direita)
        + nQuantidade  , Num�rico    , Quantidade base para ser calculada na estrutura
        + cAliasEstru  , Caractere   , Nome do alias da estrutura
        + oTempTable   , Objeto      , Objeto que ser� criado como tempor�ria
        + lAsShow      , L�gico      , Monta a estrutura exatamente igual � na visualiza��o em tela
        + lPreEstru    , L�gico      , Se for .T. olha a pr� estrutura na SGG sen�o se for .F. olha na estrutura na SG1
        + lVldData     , L�gico      , Faz a consist�ncia se os componentes est�o dentro ou fora das datas de vig�ncia (data ini e fim)
    Retorno
        N�o tem Retorno

    Fun��o FimEstrut2
    Par�metros
        + cAliasEstru    , Caractere       , Nome do alias usado
        + oTempTable     , Objeto          , Objeto da Tabela tempor�ria criada na Estrut2
    Retorno
        N�o tem Retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe155()
    Local aArea     := FWGetArea()
    Local cMensagem := ""
    Local cCodProd  := "E0001" //Produto ra�z da estrutura
    Local nQuant    := 5       //Quantidade a produzir

    //Vari�veis Private para utiliza��o da fun��o Estrut2
    Private oTempTable  := Nil
    Private cAliasTmp   := "ESTRUT"
    Private nEstru      := 0
    
    //Cria a estrutura tempor�ria
    cCodProd := AvKey(cCodProd, "B1_COD")
    Estrut2(cCodProd, nQuant, cAliasTmp, @oTempTable)
    
    //Se houver dados
    (cAliasTmp)->(DbGoTop())
    If ! (cAliasTmp)->(EoF())
        
        //Enquanto houver dados, monta mensagem do produto, componente e quantidade
        While ! (cAliasTmp)->(EoF())
            cMensagem += "Produto: " + (cAliasTmp)->CODIGO + ", Componente: " + (cAliasTmp)->COMP + ", Quantidade: " + cValToChar((cAliasTmp)->QUANT) + CRLF
            
            (cAliasTmp)->(DbSkip())
        EndDo
        
        FWAlertInfo(cMensagem, "Estrutura atrav�s de Estrut2")

    Else
        FWAlertError("Estrutura n�o encontrada!", "Falha Estrut2")
    EndIf
    
    //Finaliza a fun��o de estrutura
    FimEstrut2(cAliasTmp, @oTempTable)

    FWRestArea(aArea)
Return
