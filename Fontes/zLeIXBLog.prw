/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2016/11/15/funcao-le-log-ixblog-retorna-somente-lista-dos-execblock-executados/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

//Constantes
#Define STR_PULA   Chr(13)+Chr(10)

/*/{Protheus.doc} zLeIXBLog
Função que lÃª arquivo gerado pelo IXBLog, e gera um outro apenas com o nome dos pontos de entrada executado
@type function
@author Atilio
@since 05/08/2016
@version 1.0
	@param cArquivo, character, (Descrição do parÃ¢metro)
	@example
	u_zLeIXBLog("E:\administrador_026270.log")
/*/

User Function zLeIXBLog(cArquivo)
	Local aArea   := GetArea()
	Local cPEs    := "ExecBlocks executados: "+STR_PULA
	Local oFile
	Local cTmpDir := GetTempPath()
	Local cTmpArq := "log_pe_"+dToS(dDataBase)+"_"+StrTran(Time(), ':', '')+".txt"
	
	//Definindo o arquivo a ser lido
	oFile := FWFileReader():New(cArquivo)
	
	//Se o arquivo pode ser aberto
	If (oFile:Open())
	
		//Se não for fim do arquivo
		If ! (oFile:EoF())
		
			//Enquanto houver linhas a serem lidas
			While (oFile:HasLine())
				cLinAtu := oFile:GetLine()
				
				//Se tiver contido o texto ExecBlock
				If "ExecBlock" $ cLinAtu
					cNomePonto := Alltrim(StrTran(cLinAtu, 'ExecBlock   :', ''))
					
					//Se ele não estiver contido, adiciona no texto
					If ! cNomePonto $ cPEs
						cPEs += "> "+cNomePonto+STR_PULA
					EndIf
				EndIf
			EndDo
		EndIf

		//Fecha o arquivo e finaliza o processamento
		oFile:Close()
	EndIf
	
	//Gera o arquivo e abre
	MemoWrite(cTmpDir+cTmpArq, cPEs)
	ShellExecute("OPEN", cTmpArq, "", cTmpDir, 0 )
	
	RestArea(aArea)
Return