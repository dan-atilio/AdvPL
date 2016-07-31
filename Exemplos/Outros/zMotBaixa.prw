//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zMotBaixa
Função que exemplifica como acessar os motivos de baixa financeiro
@type function
@author Atilio
@since 07/05/2016
@version 1.0
/*/

User Function zMotBaixa()
	Local aArea     := GetArea()
	Local aMotBx    := {}
	Local aBaixaAtu := {}
	
	//Pegando os motivos de baixa
	aMotBx := ReadMotBx()
	
	//Quebrando a primeira posição do Motivo de Baixas
	//  Abaixo as posições do motivo de baixas
	//  [1] -> Sigla
	//  [2] -> Descrição
	//  [3] -> Movimentação Bancária
	//  [4] -> Comissão
	//  [5] -> Carteira
	//  [6] -> Cheque
	aBaixaAtu := StrTokArr(aMotBx[1], '³')
	
	RestArea(aArea)
Return