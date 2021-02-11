/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2017/01/31/funcao-para-converter-imagens-em-pdf-advpl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zTransPDF
Função que converte imagens para pdf (como as geradas pelo TMSPrinter)
@type function
@author Atilio
@since 11/09/2016
@version 1.0
@param cDirect, character, Diretório das imagens (dentro da Protheus_Data)
@param cArqs, character, Arquivos com a extensão desejada (por exemplo, jpg)
@param lExcImg, lógico, Define se irá excluir as imagens após transformar em pdf
@example
	u_zTransPDF("\_diretorio\", "arquivos*.jpg")
	
	//ou
	
	//Salvando todas as páginas em JPEG
	oPrintPvt:SaveAllAsJpeg("\x_tst\relatorio_tst", 1250, 2000, 200)
	
	//Agora chama a função de transformação de JPEG em PDF
	u_zTransPDF("\x_tst\", "relatorio_tst*.jpg")
/*/

User Function zTransPDF(cDirect, cArqs, lExcImg)
	Local aArea     := GetArea()
	Local cDirMagic := "C:\Program Files\ImageMagick-7.0.2-Q16\"
	Local cComando  := ""
	Local cDirSrv   := Alltrim(GetSrvProfString("RootPath",""))
	Local aDados    := {}
	Local nAtual    := 0
	Default cDirect := ""
	Default cArqs   := ""
	Default lExcImg := .T.
	
	//Se tiver diretório e arquivos
	If !Empty(cDirect) .And. !Empty(cArqs)
		cDirect := Lower(cDirect)
		cArqs   := Lower(cArqs)
		
		//Definindo o comando para converter a imagem
		cComando := "mogrify -format pdf "+cDirSrv+cDirect+cArqs
		
		//Executando o comando no servidor
		WaitRunSrv(cDirMagic+cComando, .T., cDirMagic)
		
		//Se tiver que excluir as imagens
		If lExcImg
			aDados := Directory(cDirect+cArqs)
			
			//Percorre todos os arquivos de imagem
			For nAtual := 1 To Len(aDados)
				FErase(cDirect+aDados[nAtual][1])
			Next
		EndIf
	EndIf
	
	RestArea(aArea)
Return