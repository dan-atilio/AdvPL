/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFonte41
Classe para criar uma tabela temporária (enquanto a thread estiver aberta a tabela ficará disponível no SQL)
@type  Function
@author Atilio
@since 21/02/2023
@see https://tdn.totvs.com/display/public/framework/FWTemporaryTable
/*/

User Function zFonte41()
    Local aArea      := FWGetArea()
    Local oTempTable
    Local aFields    := {}
    Local cAliasTmp  := GetNextAlias()
    
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
    
    //Efetua a criação da tabela
    oTempTable:Create()
    
    //Aqui vamos incluir 1 registro de teste
    RecLock(cAliasTmp, .T.)
        (cAliasTmp)->CODIGO  := "TST001"
        (cAliasTmp)->NOME    := "Teste de inclusão em FWTemporaryTable"
        (cAliasTmp)->VALOR   := 1.99
        (cAliasTmp)->EMISSAO := Date()
    (cAliasTmp)->(MsUnlock())

    //Iremos mostrar uma mensagem para demonstrarmos um select direto no banco
    ShowLog("SELECT * FROM " + oTempTable:GetRealName())

    //Exclui a temporária
    oTempTable:Delete()

    FWRestArea(aArea)
Return
