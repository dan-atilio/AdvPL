/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2016/05/03/mudando-sequencia-de-impressao-de-um-relatorio-protheus/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zImpAux
Função que imprime o TMSPrinter em sequencia diferente
@type function
@author Atilio
@since 24/11/2015
@version 1.0
	@param oPrint, Objeto, Objeto de impressão criado via TMSPrinter
	@example
	u_zImpAux(oPrint)
/*/

User Function zImpAux(oPrint)
	Local aArea := GetArea()
	Local nCopies := 2
	Local nCopAux := nCopies
	Local oDlgQtd
	Local nAtuPag := 0
	
	//Filtra vendedor
	Define MsDialog oDlgQtd Title "Quantidade de cópias" From 000,000 To 080,300 PIXEL
		//Mostrnado um label (texto na janela)
		@ 010,010 Say "Qtde.:" Size 55,07 Of oDlgQtd Pixel
		
		//Mostrando um campo que irá armazenar valor
		@ 010,050 MsGet nCopAux Size 55,11 Of oDlgQtd Pixel PICTURE "@E 99"
		
		//Criando um botão de confirmar com ações
		Define SButton From 005,120 Type 1 Action (nOpca:=1,oDlgQtd:End()) Enable Of oDlgQtd
		
		//Criando um botão de cancelar com ações		
		Define SButton From 025,120 Type 2 Action (nOpca:=2,oDlgQtd:End()) Enable Of oDlgQtd
	//Ativando a janela
	Activate MsDialog oDlgQtd Centered
	
	//Se a rotina for confirmada
	If nOpca == 1
		nCopies := nCopAux
	
		//Percorre as imagens / páginas
		For nAtuPag := 1 To oPrint:nPage
			oPrint:Print( {nAtuPag}, nCopies )
		Next
	EndIf
	
	RestArea(aArea)
Return