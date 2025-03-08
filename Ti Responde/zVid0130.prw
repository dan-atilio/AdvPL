/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/03/04/como-definir-para-exibir-apenas-algumas-colunas-na-fwmbrowse-ti-responde-0130/ 
    
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zVid0130
Exemplo de como exibir apenas algumas colunas no Browse
@author Atilio
@since 06/03/2024
@version 1.0
@type function
/*/

User Function zVid0130()
	Local aArea   := FWGetArea()
	Local oBrowse
    Local aColunas   := {}
	Private aRotina := {}
	Private cCadastro := "Cadastro de Produtos"

	//Definicao do menu
	aRotina := FWLoadMenuDef("MATA010")

    //Adiciona as colunas que vão ser apresentadas no browse
    aAdd(aColunas, { 'Código',         'B1_COD',     'C',  TamSX3('B1_COD')[1],     0, ''})
    aAdd(aColunas, { 'Código Barras',  'B1_CODBAR',  'C',  TamSX3('B1_CODBAR')[1],  0, ''})
    aAdd(aColunas, { 'Unid.Med.',      'B1_UM',      'C',  TamSX3('B1_UM')[1],      0, ''})
    aAdd(aColunas, { 'Tipo',           'B1_TIPO',    'C',  TamSX3('B1_TIPO')[1],    0, ''})
    aAdd(aColunas, { 'Descrição',      'B1_DESC',    'C',  TamSX3('B1_DESC')[1],    0, ''})

	//Instanciando o browse
	oBrowse := FWMBrowse():New()
	oBrowse:SetAlias("SB1")
	oBrowse:SetDescription(cCadastro)
	oBrowse:DisableDetails()

    //Primeiro forçamos a mostrar apenas o campo de Filial, para depois definir quais campos queremos mostrar
    oBrowse:SetOnlyFields({"B1_FILIAL"})
    oBrowse:SetFields(aColunas)

	//Ativa a Browse
	oBrowse:Activate()

	FWRestArea(aArea)
Return Nil
