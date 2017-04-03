//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zVazio
Função que verifica se o array está vazio (ou somente com linhas excluídas)
@type function
@author Atilio
@since 05/03/2016
@version 1.0
	@param aArray, Array, Array que contém as informações (como um aCols)
	@return lRet, Se o Array está vazio (não tem nenhuma posição válida)
/*/

User Function zVazio(aArray)
	Local lRet := .F.
	Local nAtual := 1
	Local nUltPos := 0
	Local nExcluidos := 0
	
	//Se o tamanho for 0, Array é vazio
	If Len(aArray) == 0
		lRet := .T.
	
	//Se tiver em branco, Array é vazio
	ElseIf Empty(aArray)
		lRet := .T.
		
	Else
		//Percorro o Array
		For nAtual := 1 To Len(aArray)
			//Pega a última posição do aCols (a que contém se a linha está excluída - .T. -, ou não - .F. -)
			nUltPos := Len(aArray[nAtual])
			
			//Se tiver excluído
			If aArray[nAtual][nUltPos]
				nExcluidos++
			EndIf
		Next
		
		//Se a quantidade de excluídos for igual ao tamanho do array, array está vazio
		If nExcluidos == Len(aArray)
			lRet := .T.
		EndIf
	EndIf
Return lRet