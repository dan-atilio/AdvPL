/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2015/12/04/vd-advpl-012/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zEmbedd
Exemplo de utilização do Embedded SQL
@author Atilio
@since 29/11/2015
@version 1.0
	@example
	u_zEmbedd()
/*/

User Function zEmbedd()
	Local aArea := GetArea()
	
	//Construindo a consulta
	BeginSql Alias "SQL_SB1"
		//COLUMN F3_ENTRADA AS DATE //Deve se usar isso para transformar o campo em data  
		Select	
			B1_COD,
			B1_DESC
		FROM
			%table:SB1% SB1 
		WHERE
			SB1.%notDel%
			AND B1_MSBLQL != '1'			
	EndSql   
	
	//Percorrendo os registros
	While ! SQL_SB1->(EoF())
		ConOut("# SQL_SB1: " + SQL_SB1->B1_COD + "|" + SQL_SB1->B1_DESC)
	
		SQL_SB1->(DbSkip())
	EndDo
	
	SQL_SB1->(DbCloseArea())
	RestArea(aArea)
Return