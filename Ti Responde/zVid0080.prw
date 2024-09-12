/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2024/09/10/como-colocar-titulo-em-uma-coluna-de-legenda-em-um-fwmbrowse-ti-responde-0080/ 
    
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zVid0080
Exemplo de como alterar o título de uma coluna de legendas
@author Atilio
@since 05/01/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function zVid0080()
	Local aArea   := FWGetArea()
	Local oBrowse
	Private aRotina := {}
	Private cCadastro := "Cadastro de Produtos"

	//Definicao do menu
	aRotina := FWLoadMenuDef("MATA010")

	//Instanciando o browse
	oBrowse := FWMBrowse():New()
	oBrowse:SetAlias("SB1")
	oBrowse:SetDescription(cCadastro)
	oBrowse:DisableDetails()

	//Adicionando as Legendas (coluna 1)
    oBrowse:AddLegend("SB1->B1_MSBLQL == '1'",     'BR_CANCEL',   'Produto Bloqueado',     '1')
    oBrowse:AddLegend("SB1->B1_MSBLQL != '1'",     'CHECKED',     'Produto Ativo',         '1')

    //Adicionando as Legendas (coluna 2)
    oBrowse:AddLegend("SB1->B1_TIPO == 'PA'",      'GREEN',       'Produto Acabado',       '2')
    oBrowse:AddLegend("SB1->B1_TIPO == 'PI'",      'RED',         'Produto Intermediário', '2')
    oBrowse:AddLegend("! SB1->B1_TIPO $ 'PA;PI;'", 'WHITE',       'Outros Tipos',          '2')

    //Adicionando as Legendas (coluna 3)
    oBrowse:AddLegend("SB1->B1_UM == 'UN'",        'YELLOW',      'Unitário (UN)',         '3')
    oBrowse:AddLegend("SB1->B1_UM == 'KG'",        'BLACK',       'Quilograma (KG)',       '3')
    oBrowse:AddLegend("! SB1->B1_UM $ 'UN;KG;'",   'PINK',        'Outras Unidades',       '3')

    //Agora altera o nome das 3 colunas de legenda
	oBrowse:aColumns[1]:cTitle := "Bloqueado"
    oBrowse:aColumns[2]:cTitle := "Tipo"
    oBrowse:aColumns[3]:cTitle := "U.M."

	//Ativa a Browse
	oBrowse:Activate()

	FWRestArea(aArea)
Return Nil
