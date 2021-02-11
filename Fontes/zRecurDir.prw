/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2018/09/25/funcao-retorna-varios-arquivos-de-pastas-subpastas-em-advpl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zRecurDir
Função recursiva de diretórios, que traz arquivos dentro de uma pasta e suas subpastas
@author Atilio
@since 30/05/2018
@version 1.0
@param cPasta, characters, Qual é a pasta a ser verificada
@param cMascara, characters, Qual é a máscara de pesquisa
@param dAPartir, date, Data de corte dos arquivos (Opcional)
@type function
@obs Ao finalizar a rotina, é gerado uma mensagem no console.log com alguns dizeres:
	zRecurDir:
	Buscando arquivos '*.xml', Dentro da pasta 'Z:\Conhecimento Transportadoras XML\', Considerando a partir de '01/05/2018'!
	
	Inicio: 15:51:26
	Término: 15:51:34
	Diferença: 00:00:08
	Arquivos encontrados: 40247
	Arquivos filtrados: 1443
	
@example Basta declarar um array, e mandar os parÃ¢metros para processamento.
	No exemplo abaixo, é buscado os arquivos xml, dentro do diretório especificado, pegando apenas o que consta com a data do dia 01/05/2018 em diante
	aArquivos := u_zRecurDir("Z:\Conhecimento Transportadoras XML\", "*.xml", sToD("20180501"))
/*/

User Function zRecurDir(cPasta, cMascara, dAPartir)
	Local aArea      := GetArea()
	Local cTempoIni  := Time()
	Local cTempoFim  := ""
	Local aArquivos  := {}
	Local aPastas    := {}
	Local aTemp      := {}
	Local aArqOrig   := {}
	Local nAtual     := 0
	Local nAux       := 0
	Local nTamanho   := 0
	Local nTamAux    := 0
	Default cPasta   := ""
	Default cMascara := ""
	Default dAPartir := sToD("")
	
	//Se tiver pasta e máscara
	If ! Empty(cPasta) .And. ! Empty(cMascara)
		
		//Caso não tenha "\" no fim adiciona, por exemplo, "C:\TOTVS" -> "C:\TOTVS\"
		cPasta += Iif(SubStr(cPasta, Len(cPasta), 1) != "\", "\", "")
		
		//Pega as pastas da raÃ­z
		aPastas := Directory(cPasta + "*.*", "D")
		
		//Percorre todas as pastas do Array (Conforme ele for sendo atualizado, volta pro laço)
		For nAtual := 1 To Len(aPastas)
			
			//Se não tiver ponto no nome, e for do tipo D (Diretório)
			If ! "." $ Alltrim(aPastas[nAtual][1]) .And. aPastas[nAtual][5] == "D"
				
				//Se não tiver a pasta raÃ­z no nome, adiciona, por exemplo, "SubPasta" -> "C:\TOTVS\SubPasta"
				If ! cPasta $ aPastas[nAtual][1]
					aPastas[nAtual][1] := cPasta + aPastas[nAtual][1]
				EndIf
				
				//Caso não tenha "\" no fim adiciona, por exemplo, "C:\TOTVS" -> "C:\TOTVS\"
				aPastas[nAtual][1] += Iif(SubStr(aPastas[nAtual][1], Len(aPastas[nAtual][1]), 1) != "\", "\", "")
				
				//Pega todas as pastas dentro dessa
				aTemp := Directory(aPastas[nAtual][1] + "*.*", "D")
				
				//Percorre as subpastas dentro, e adiciona o texto a esquerda, por exemplo, "PastaX" -> "C:\TOTVS\SubPasta\PastaX"
				For nAux := 1 To Len(aTemp)
					aTemp[nAux][1] := aPastas[nAtual][1] + aTemp[nAux][1]
				Next
				
				//Pega o tamanho das subpastas, e o tamanho atual das pastas
				nTamanho := Len(aTemp)
				nTamAux  := Len(aPastas)
				
				//Redimensiona o array das pastas, aumentando conforme o tamanho das subpastas
				aSize(aPastas, Len(aPastas) + nTamanho)
				
				//Copia as subpastas para dentro da pasta a partir da última posição
				aCopy(aTemp, aPastas, , , nTamAux + 1)
			EndIf
		Next
		
		//Pega o tamanho das pastas
		nTamanho := Len(aPastas)
		
		//Percorre todas as pastas
		For nAtual := 1 To nTamanho
			
			//Se tiver pasta a ser validada
			If nAtual <= Len(aPastas)
			
				//Se tiver ponto no nome, ou for diferente de D (Diretório)
				If "." $ Alltrim(aPastas[nAtual][1]) .Or. aPastas[nAtual][5] != "D"
					
					//Exclui aposição atual do Array
					aDel(aPastas, nAtual)
					
					//Redimensiona o Array, diminuindo 1 posição
					aSize(aPastas, Len(aPastas) - 1)
					
					//Altera variáveis de controle, diminuindo elas
					nTamanho--
					nAtual--
				EndIf
			EndIf
		Next
		
		//Ordena o Array por ordem alfabética
		aSort(aPastas)
		
		//Pega os arquivos da pasta raÃ­z
		aArquivos := Directory(cPasta + cMascara)
		
		//Percorre todos os arquivos
		For nAtual := 1 To Len(aArquivos)
			
			//Se a pasta não tiver no nome do arquivo, adiciona, por exemplo, "arquivo.xml" -> "C:\TOTVS\arquivo.xml"
			If ! cPasta $ aArquivos[nAtual][1]
				aArquivos[nAtual][1] := cPasta + aArquivos[nAtual][1]
			EndIf
		Next
		
		//Percorre todas as pastas / subpastas encontradas
		For nAtual := 1 To Len(aPastas)
			//Se a pasta realmente existe
			If ExistDir(aPastas[nAtual][1])
			
				//Caso não tenha "\" no fim adiciona, por exemplo, "C:\TOTVS" -> "C:\TOTVS\"
				aPastas[nAtual][1] += Iif(SubStr(aPastas[nAtual][1], Len(aPastas[nAtual][1]), 1) != "\", "\", "")
				
				//Pega todos os arquivos dessa subpasta filtrando a máscara
				aTemp := Directory(aPastas[nAtual][1] + cMascara)
				
				//Percorre todos os arquivos encontrados
				For nAux := 1 To Len(aTemp)
					
					//Adiciona o caminho completo da subpasta, por exemplo, "arquivo2.xml" -> "C:\TOTVS\SubPasta\arquivo2.xml"
					aTemp[nAux][1] := aPastas[nAtual][1] + aTemp[nAux][1]
				Next
				
				//Pega o tamanho do array dos arquivos encontrados, e o tamanho do array de arquivos que serão retornados
				nTamanho := Len(aTemp)
				nTamAux  := Len(aArquivos)
				
				//Aumento o tamanho do array de Arquivos, com o tamanho dos encontrados
				aSize(aArquivos, Len(aArquivos) + nTamanho)
				
				//Copia o conteúdo dos enontrados para dentro do array de Arquivos
				aCopy(aTemp, aArquivos, , , nTamAux + 1)
			EndIf
		Next
		
		//Copia para um novo array de backup
		aArqOrig := aClone(aArquivos)
		
		//Se tiver data de filtragem
		If ! Empty(dAPartir)
			
			//Enquanto houver arquivos
			nAtual := 0
			While nAtual <= Len(aArquivos)
				nAtual++
				
				//Se existir arquivos válidos a serem processados
				If Len(aArquivos) >= nAtual
					
					//Se na pasta atual, a data do arquivo NÃƒO for maior que a data de corte
					If ! aArquivos[nAtual][3] >= dAPartir
						
						//Deleta a posição atual o array de Arquivos
						aDel(aArquivos, nAtual)
						
						//Redimensiona o Array, diminuindo uma posição
						aSize(aArquivos, Len(aArquivos) - 1)
						
						nAtual--
					EndIf
				EndIf
			EndDo
		EndIf
	EndIf
	
	//Finaliza o tempo, e mostra uma saÃ­da no console.log
	cTempoFim := Time()
	ConOut("zRecurDir:" + CRLF +;
		"Buscando arquivos '" + cMascara + "', " +;
		"Dentro da pasta '" + cPasta + "', " +;
		"Considerando a partir de '" + dToC(dAPartir) + "'!" + CRLF + CRLF +;
		"Inicio: " + cTempoIni + CRLF +;
		"Término: " + cTempoFim + CRLF +;
		"Diferença: " + ElapTime(cTempoIni, cTempoFim) + CRLF +;
		"Arquivos encontrados: " + cValToChar(Len(aArqOrig)) + CRLF +;
		"Arquivos filtrados: " + cValToChar(Len(aArquivos)))
	
	RestArea(aArea)
Return aArquivos