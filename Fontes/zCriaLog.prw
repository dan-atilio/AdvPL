/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2015/10/23/criacao-de-log-customizado-no-protheus/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zCriaLog
Função parar criação de logs
@author Atilio
@since 04/05/2015
@version 1.0
	@param cDescri, Caracter, Descrição do Log
	@param cTab, Caracter, Tabela do Log
	@param cCampo, Caracter, Campo do Log
	@param cAntigo, Caracter, Conteúdo antigo do campo do Log
	@param cNovo, Caracter, Conteúdo novo do campo do Log
	@param cChave, Caracter, Chave da tabela do Log
	@param cCont, Caracter, Conteúdo da Chave do Log
	@param nRec, Numérico, RecNO da tabela do Log
	@example
	u_zCriaLog("Alteração campo bloqueio", "SB1", "B1_MSBLQL", "2", "1", "B1_COD", "000001", 5000)
/*/

User Function zCriaLog(cDescri, cTab, cCampo, cAntigo, cNovo, cChave, cCont, nRec)
	Local aArea		:= GetArea()
	Local cSeq			:= ""
	Default cDescri	:= ""
	Default cTab		:= ""
	Default cCampo	:= ""
	Default cAntigo	:= ""
	Default cNovo		:= ""
	Default cChave	:= ""
	Default cCont		:= ""
	Default nRec		:= 0
	
	//Se tiver descrição
	If !Empty(cDescri) 
		//Pegando a próxima sequência
		cSeq := GetSXENum('ZD0', 'ZD0_SEQ')
		
		//Salvando o log
		RecLock("ZD0", .T.)
			ZD0_SEQ		:= cSeq
			ZD0_USRCOD		:= RetCodUsr()
			ZD0_USRNOM		:= UsrRetName(RetCodUsr())
			ZD0_DATA		:= dDataBase
			ZD0_HORA		:= Time()
			ZD0_DESCRI		:= cDescri
			ZD0_FUNC		:= FunName()
			ZD0_FILORI		:= cFilAnt
			ZD0_AMB		:= GetEnvServer()
			ZD0_TAB		:= cTab
			ZD0_CAMPO		:= cCampo
			ZD0_CONANT		:= cAntigo
			ZD0_CONNOV		:= cNovo
			ZD0_CHAVE		:= cChave
			ZD0_CONCHA		:= cCont
			ZD0_REC		:= nRec
		ZD0->(MsUnlock())
		ConfirmSX8()
	EndIf
	
	RestArea(aArea)
Return