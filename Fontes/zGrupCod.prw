/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2018/06/19/funcao-para-deixar-codigo-produto-sequencial-conforme-grupo/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} zGrupCod
Função que preenche o código do produto conforme o grupo
@author Atilio
@since 04/04/2018
@version 1.0
@type function
@obs Passo a Passo de como fazer para funcionar:
	1. Acesse o Configurador (SIGACFG), vá na tabela SB1 e clique em Editar
	2. Vá no campo Grupo (B1_GRUPO), verifique se ele está como obrigatório, caso não esteja, deixe ele como obrigatório (está na aba Uso)
	3. No modo de edição do campo, deixe a expressão INCLUI para ele ficar habilitado apenas na inclusão (está na aba OpçÃµes)
	4. Altere a sequÃªncia do campo, para ele vir antes do campo Código (B1_COD)
	5. Vá no campo Código (B1_COD), no modo de edição deixe a expressão .F. para não deixar alterar o campo
	6. Confirme as alteraçÃµes da tabela
	7. Vá na seção de Gatilhos, e clique para incluir um novo Gatilho. Nesse Gatilho, coloque a origem sendo o B1_GRUPO, e o destino o B1_COD, e a Regra sendo <b>u_zGrupCod()</b>
	8. Salve as alteraçÃµes do Configurador
	9. Compile a função abaixo
/*/

User Function zGrupCod()
	Local aArea   := GetArea()
	Local cCodigo := ""
	Local cGrupo  := FWFldGet("B1_GRUPO")
	Local cQryAux := ""
	Local nTamGrp := TamSX3('B1_GRUPO')[01]
	Local nTamCod := TamSX3('B1_COD')[01]
	
	//Se houver grupo
	If ! Empty(cGrupo)
		cCodigo := cGrupo + Replicate('0', nTamCod-nTamGrp)
		
		//Pegando o último código (não foi fitraldo o DELET para manter a sequencia unica)
		cQryAux := " SELECT "                                                                        + CRLF
		cQryAux += " 	ISNULL(MAX(B1_COD), '" + cCodigo + "') AS ULTIMO "                           + CRLF
		cQryAux += " FROM "                                                                          + CRLF
		cQryAux += " 	" + RetSQLName('SB1') + " SB1 "                                              + CRLF
		cQryAux += " WHERE "                                                                         + CRLF
		cQryAux += " 	B1_FILIAL = '" + FWxFilial('SB1') + "' "                                     + CRLF
		cQryAux += " 	AND B1_GRUPO = '" + cGrupo + "' "                                            + CRLF
		cQryAux += " 	AND SUBSTRING(B1_COD, 1, " + cValToChar(nTamGrp) + ") = '" + cGrupo + "' "   + CRLF
		TCQuery cQryAux New Alias "QRY_AUX"
		
		//Define o novo código, incrementando 1 no final
		cCodigo := Soma1(cCodigo)
		
		QRY_AUX->(DbCloseArea())
	EndIf
	
	RestArea(aArea)
Return cCodigo