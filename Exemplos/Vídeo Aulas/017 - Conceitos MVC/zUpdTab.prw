/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2016/04/24/vd-advpl-017/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zUpdTab
Função que cria tabelas, campos e índices para utilização nos exemplos de MVC
@type function
@author Atilio
@since 23/04/2016
@version 1.0
/*/

User Function zUpdTab()
	Local aArea := GetArea()
	
	Processa( {|| fAtualiza()}, "Processando...")
	
	RestArea(aArea)
Return

/*---------------------------------------------------------------------*
 | Func:  fAtualiza                                                    |
 | Autor: Daniel Atilio                                                |
 | Data:  23/04/2016                                                   |
 | Desc:  Função que chama as rotinas para criação                     |
 *---------------------------------------------------------------------*/

Static Function fAtualiza()
	ProcRegua(6)
	
	//ZZ1 - Artistas
	IncProc('Atualizando ZZ1 - Artistas...')
	fAtuZZ1()
	
	//ZZ2 - CDs
	IncProc('Atualizando ZZ2 - CDs...')
	fAtuZZ2()
	
	//ZZ3 - Músicas do CD
	IncProc('Atualizando ZZ3 - Músicas do CD...')
	fAtuZZ3()
	
	//ZZ4 - Venda de CDs
	IncProc('Atualizando ZZ4 - Venda de CDs...')
	fAtuZZ4()
Return

/*---------------------------------------------------------------------*
 | Func:  fAtuZZ1                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  23/04/2016                                                   |
 | Desc:  Função que cria a tabela ZZ1                                 |
 *---------------------------------------------------------------------*/

Static Function fAtuZZ1()
	Local aSX2 := {}
	Local aSX3 := {}
	Local aSIX := {}
	
	//Tabela
	//			01			02						03		04			05
	//			Chave		Descrição				Modo	Modo Un.	Modo Emp.
	aSX2 := {	'ZZ1',		'Artista',				'C',	'C',		'C'}
	
	//Campos
	//				01				02			03								04			05		06					07								08						09		10			11		12				13			14			15			16		17			18				19			20			21
	//				Campo			Filial?	Tamanho						Decimais	Tipo	Titulo				Descrição						Máscara				Nível	Vld.Usr	Usado	Ini.Padr.		Cons.F3	Visual		Contexto	Browse	Obrigat	Lista.Op		Mod.Edi	Ini.Brow	Pasta
	aAdd(aSX3,{	'ZZ1_FILIAL',	.T.,		FWSizeFilial(),				0,			'C',	"Filial",			"Filial do Sistema",			"",						1,		"",			.F.,	"",				"",			"",			"",			"N",	.T.,		"",				"",			"",			""})
	aAdd(aSX3,{	'ZZ1_COD',		.F.,		06,								0,			'C',	"Codigo",			"Codigo Artista",				"@!",					1,		"",			.T.,	"",				"",			"A",		"R",		"S",	.T.,		"",				"",			"",			""})
	aAdd(aSX3,{	'ZZ1_DESC',	.F.,		50,								0,			'C',	"Descricao",		"Descricao / Nome",			"@!",					1,		"",			.T.,	"",				"",			"A",		"R",		"S",	.T.,		"",				"",			"",			""})
	
	//Índices
	//				01			02			03							04				05				06			07
	//				Índice		Ordem		Chave						Descrição		Propriedade	NickName	Mostr.Pesq
	aAdd(aSIX,{	"ZZ1",		"1",		"ZZ1_FILIAL+ZZ1_COD",	"Codigo",		"U",			"",			"S"})
		
	//Criando os dados
	u_zCriaTab(aSX2, aSX3, aSIX)
Return

/*---------------------------------------------------------------------*
 | Func:  fAtuZZ2                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  23/04/2016                                                   |
 | Desc:  Função que cria a tabela ZZ2                                 |
 *---------------------------------------------------------------------*/

Static Function fAtuZZ2()
	Local aSX2 := {}
	Local aSX3 := {}
	Local aSIX := {}
	
	//Tabela
	//			01			02						03		04			05
	//			Chave		Descrição				Modo	Modo Un.	Modo Emp.
	aSX2 := {	'ZZ2',		'CDs',					'C',	'C',		'C'}
	
	//Campos
	//				01				02			03								04			05		06					07								08						09		10			11		12				13			14			15			16		17			18				19			20			21
	//				Campo			Filial?	Tamanho						Decimais	Tipo	Titulo				Descrição						Máscara				Nível	Vld.Usr	Usado	Ini.Padr.		Cons.F3	Visual		Contexto	Browse	Obrigat	Lista.Op		Mod.Edi	Ini.Brow	Pasta
	aAdd(aSX3,{	'ZZ2_FILIAL',	.T.,		FWSizeFilial(),				0,			'C',	"Filial",			"Filial do Sistema",			"",						1,		"",			.F.,	"",				"",			"",			"",			"N",	.T.,		"",				"",			"",			""})
	aAdd(aSX3,{	'ZZ2_CODART',	.F.,		06,								0,			'C',	"Cod. Artista",	"Codigo Artista",				"@!",					1,		"",			.T.,	"",				"",			"A",		"R",		"S",	.T.,		"",				"",			"",			""})
	aAdd(aSX3,{	'ZZ2_CODCD',	.F.,		06,								0,			'C',	"Cod. CD",			"Codigo CD",					"@!",					1,		"",			.T.,	"",				"",			"A",		"R",		"S",	.T.,		"",				"",			"",			""})
	aAdd(aSX3,{	'ZZ2_DESC',	.F.,		50,								0,			'C',	"Descricao",		"Descricao / Nome",			"@!",					1,		"",			.T.,	"",				"",			"A",		"R",		"S",	.T.,		"",				"",			"",			""})
	aAdd(aSX3,{	'ZZ2_PRECO',	.F.,		06,								2,			'N',	"Preco",			"Preco",						"@E 999.99",			1,		"",			.T.,	"",				"",			"A",		"R",		"S",	.T.,		"",				"",			"",			""})
	
	//Índices
	//				01			02			03										04									05				06			07
	//				Índice		Ordem		Chave									Descrição							Propriedade	NickName	Mostr.Pesq
	aAdd(aSIX,{	"ZZ2",		"1",		"ZZ2_FILIAL+ZZ2_CODCD",				"Codigo CD",						"U",			"",			"S"})
	aAdd(aSIX,{	"ZZ2",		"2",		"ZZ2_FILIAL+ZZ2_CODART+ZZ2_CODCD",	"Codigo Artista + Codigo CD",	"U",			"",			"S"})
		
	//Criando os dados
	u_zCriaTab(aSX2, aSX3, aSIX)
Return

/*---------------------------------------------------------------------*
 | Func:  fAtuZZ3                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  23/04/2016                                                   |
 | Desc:  Função que cria a tabela ZZ3                                 |
 *---------------------------------------------------------------------*/

Static Function fAtuZZ3()
	Local aSX2 := {}
	Local aSX3 := {}
	Local aSIX := {}
	
	//Tabela
	//			01			02						03		04			05
	//			Chave		Descrição				Modo	Modo Un.	Modo Emp.
	aSX2 := {	'ZZ3',		'Musicas do CD',		'C',	'C',		'C'}
	
	//Campos
	//				01				02			03								04			05		06					07								08						09		10			11		12				13			14			15			16		17			18				19			20			21
	//				Campo			Filial?	Tamanho						Decimais	Tipo	Titulo				Descrição						Máscara				Nível	Vld.Usr	Usado	Ini.Padr.		Cons.F3	Visual		Contexto	Browse	Obrigat	Lista.Op		Mod.Edi	Ini.Brow	Pasta
	aAdd(aSX3,{	'ZZ3_FILIAL',	.T.,		FWSizeFilial(),				0,			'C',	"Filial",			"Filial do Sistema",			"",						1,		"",			.F.,	"",				"",			"",			"",			"N",	.T.,		"",				"",			"",			""})
	aAdd(aSX3,{	'ZZ3_CODART',	.F.,		06,								0,			'C',	"Cod. Artista",	"Codigo Artista",				"@!",					1,		"",			.T.,	"",				"",			"A",		"R",		"S",	.T.,		"",				"",			"",			""})
	aAdd(aSX3,{	'ZZ3_CODCD',	.F.,		06,								0,			'C',	"Cod. CD",			"Codigo CD",					"@!",					1,		"",			.T.,	"",				"",			"A",		"R",		"S",	.T.,		"",				"",			"",			""})
	aAdd(aSX3,{	'ZZ3_CODMUS',	.F.,		06,								0,			'C',	"Cod. Musica",	"Codigo Musica",				"@!",					1,		"",			.T.,	"",				"",			"A",		"R",		"S",	.T.,		"",				"",			"",			""})
	aAdd(aSX3,{	'ZZ3_DESC',	.F.,		50,								0,			'C',	"Descricao",		"Descricao / Nome",			"@!",					1,		"",			.T.,	"",				"",			"A",		"R",		"S",	.T.,		"",				"",			"",			""})
	
	//Índices
	//				01			02			03													04													05				06			07
	//				Índice		Ordem		Chave												Descrição											Propriedade	NickName	Mostr.Pesq
	aAdd(aSIX,{	"ZZ3",		"1",		"ZZ3_FILIAL+ZZ3_CODCD+ZZ3_CODMUS",				"Codigo CD + Codigo Musica",					"U",			"",			"S"})
	aAdd(aSIX,{	"ZZ3",		"2",		"ZZ3_FILIAL+ZZ3_CODART+ZZ3_CODCD+ZZ3_CODMUS",	"Codigo Artista + Codigo CD + Codigo Musica",	"U",			"",			"S"})
		
	//Criando os dados
	u_zCriaTab(aSX2, aSX3, aSIX)
Return

/*---------------------------------------------------------------------*
 | Func:  fAtuZZ4                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  23/04/2016                                                   |
 | Desc:  Função que cria a tabela ZZ4                                 |
 *---------------------------------------------------------------------*/

Static Function fAtuZZ4()
	Local aSX2 := {}
	Local aSX3 := {}
	Local aSIX := {}
	
	//Tabela
	//			01			02						03		04			05
	//			Chave		Descrição				Modo	Modo Un.	Modo Emp.
	aSX2 := {	'ZZ4',		'Vendas dos CDs',		'C',	'C',		'C'}
	
	//Campos
	//				01				02			03								04			05		06					07								08						09		10			11		12				13			14			15			16		17			18				19			20			21
	//				Campo			Filial?	Tamanho						Decimais	Tipo	Titulo				Descrição						Máscara				Nível	Vld.Usr	Usado	Ini.Padr.		Cons.F3	Visual		Contexto	Browse	Obrigat	Lista.Op		Mod.Edi	Ini.Brow	Pasta
	aAdd(aSX3,{	'ZZ4_FILIAL',	.T.,		FWSizeFilial(),				0,			'C',	"Filial",			"Filial do Sistema",			"",						1,		"",			.F.,	"",				"",			"",			"",			"N",	.T.,		"",				"",			"",			""})
	aAdd(aSX3,{	'ZZ4_CODVEN',	.F.,		06,								0,			'C',	"Codigo",			"Codigo Venda",				"@!",					1,		"",			.T.,	"",				"",			"A",		"R",		"S",	.T.,		"",				"",			"",			""})
	aAdd(aSX3,{	'ZZ4_DESC',	.F.,		50,								0,			'C',	"Descricao",		"Descricao / Nome",			"@!",					1,		"",			.T.,	"",				"",			"A",		"R",		"S",	.T.,		"",				"",			"",			""})
	aAdd(aSX3,{	'ZZ4_CODCD',	.F.,		06,								0,			'C',	"Codigo CD",		"Codigo do CD",				"@!",					1,		"",			.T.,	"",				"",			"A",		"R",		"S",	.T.,		"",				"",			"",			""})
	aAdd(aSX3,{	'ZZ2_QUANT',	.F.,		03,								0,			'N',	"Quantidade",		"Quantidade",					"@E 999",				1,		"",			.T.,	"",				"",			"A",		"R",		"S",	.T.,		"",				"",			"",			""})
	aAdd(aSX3,{	'ZZ2_PRECO',	.F.,		06,								2,			'N',	"Preco",			"Preco",						"@E 999.99",			1,		"",			.T.,	"",				"",			"A",		"R",		"S",	.T.,		"",				"",			"",			""})
	aAdd(aSX3,{	'ZZ2_TOTAL',	.F.,		08,								2,			'N',	"Total",			"Total",						"@E 99,999.99",		1,		"",			.T.,	"",				"",			"A",		"R",		"S",	.T.,		"",				"",			"",			""})
	
	//Índices
	//				01			02			03							04				05				06			07
	//				Índice		Ordem		Chave						Descrição		Propriedade	NickName	Mostr.Pesq
	aAdd(aSIX,{	"ZZ4",		"1",		"ZZ4_FILIAL+ZZ4_CODVEN",	"Codigo",		"U",			"",			"S"})
		
	//Criando os dados
	u_zCriaTab(aSX2, aSX3, aSIX)
Return