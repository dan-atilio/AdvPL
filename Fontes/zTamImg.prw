//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zTamImg
Função que retorna o tamanho da Imagem em pixels, tanto largura, como alteura
@author Atilio
@since 23/05/2015
@version 1.0
	@param cImagem, Caracter, Caminho absoluto da imagem a ser analisada
	@return aTamanho, Array contendo os valores de Altura e Largura em pixels
	@example
	u_zTamImg("C:\teste.jpg")
	u_zTamImg("F:\exemplo_bloq.png")
	@see http://terminaldeinformacao.com/advpl/
	@obs O retorno é um array, sendo a posição [1] a Altura, e a posição [2] a Largura.
	Se a imagem não existir, o retorno será sempre 0
/*/

User Function zTamImg(cImagem)
	Local oTImg
	Local aTamanho := {0, 0}
	Default cImagem:= ""
	
	//Criando o objeto com a imagem passada via parâmetro
    oTImg := TBitmap():New(01,01,,,,cImagem,,,,,,,,,,,,,)
    
    //Auto ajusta o tamanho, sem ele, é retornado 0
    oTImg:lAutoSize := .T.
	
	//Altura
	aTamanho[1] := oTImg:nClientHeight
	
	//Largura
	aTamanho[2] := oTImg:nClientWidth
	
	//MsgInfo("A imagem <b>"+cImagem+"</b> tem <b>"+cValToChar(aTamanho[1])+"</b> pixels de Altura e <b>"+cValToChar(aTamanho[2])+"</b> pixels de Largura!", "Atenção")
Return aTamanho