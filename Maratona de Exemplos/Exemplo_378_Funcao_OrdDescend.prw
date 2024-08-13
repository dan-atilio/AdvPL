/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/26/adicionando-caracteres-em-um-texto-com-as-funcoes-padc-padl-e-padr-maratona-advpl-e-tl-379/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe378
Realiza a ordenação decrescente de um índice de uma tabela
@type Function
@author Atilio
@since 28/03/2023
@see https://tdn.totvs.com/display/tec/OrdDescend
@obs 

    Função OrdDescend
    Parâmetros
        + xExp           , Indefinido   , Índice que será usado
        + cIndex         , Caractere    , Nome do índice (opcional)
        + lDesc          , Lógico       , Se .T. será decrescente
    Retorno
        + lRet           , Lógico       , Retorna .T. se conseguiu flagar como decrescente

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe378()
    Local aArea      := FWGetArea()
    Local oTempTable
    Local aFields    := {}
    Local cAliasTmp  := GetNextAlias()
    Local nOrder
    Local cMensagem  := ""
    
    //Cria a temporária
    oTempTable := FWTemporaryTable():New(cAliasTmp)
    
    //Adiciona no array das colunas as que serão incluidas (Nome do Campo, Tipo do Campo, Tamanho, Decimais)
    aAdd(aFields, {"CODIGO",  "C",  6, 0})
    aAdd(aFields, {"NOME",    "C", 50, 0})
    aAdd(aFields, {"VALOR",   "N",  8, 2})
    aAdd(aFields, {"EMISSAO", "D",  8, 0})
    
    //Define as colunas usadas
    oTempTable:SetFields( aFields )
    
    //Cria índice com colunas setadas anteriormente
    oTempTable:AddIndex("1", {"CODIGO", "NOME"} )
    oTempTable:AddIndex("2", {"NOME"} )
    
    //Efetua a criação da tabela
    oTempTable:Create()
    
    //Vamos incluir 3 registros
    RecLock(cAliasTmp, .T.)
        (cAliasTmp)->CODIGO  := "TST001"
        (cAliasTmp)->NOME    := "João da Silva"
        (cAliasTmp)->VALOR   := 1.99
        (cAliasTmp)->EMISSAO := Date()
    (cAliasTmp)->(MsUnlock())

    RecLock(cAliasTmp, .T.)
        (cAliasTmp)->CODIGO  := "TST002"
        (cAliasTmp)->NOME    := "Maria da Silva"
        (cAliasTmp)->VALOR   := 1.99
        (cAliasTmp)->EMISSAO := Date()
    (cAliasTmp)->(MsUnlock())

    RecLock(cAliasTmp, .T.)
        (cAliasTmp)->CODIGO  := "TST003"
        (cAliasTmp)->NOME    := "Carlos da Silva"
        (cAliasTmp)->VALOR   := 1.99
        (cAliasTmp)->EMISSAO := Date()
    (cAliasTmp)->(MsUnlock())

    //Agora vamos ordenar a tabela de forma decrescente
    nOrder := 2
    (cAliasTmp)->(DbSetOrder(nOrder))
    OrdDescend(nOrder, cValToChar(nOrder), .T.)
    (cAliasTmp)->(DbGoTop())

    //Vamos percorrer os registros e montar a mensagem
    While ! (cAliasTmp)->(EoF())
        cMensagem += "+ " + Alltrim((cAliasTmp)->NOME) + CRLF

        (cAliasTmp)->(DbSkip())
    EndDo
    FWAlertInfo(cMensagem, "Teste OrdDescend")

    //Exclui a temporária
    oTempTable:Delete()

    FWRestArea(aArea)
Return
