/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2022/07/25/disparo-de-e-mail-na-admissao-e-demissao-de-funcionarios-ti-responde-015/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include 'TOTVS.ch'
#Include 'TopConn.ch'

/*/{Protheus.doc} User Function GPEM040
Ponto de entrada ao demitir o funcionário
@type  Function
@author Atilio
@since 03/03/2022
/*/

User Function GPEM040()
	Local aArea			:= FWGetArea()
	Local aParam     	:= PARAMIXB
	Local cIdPonto		:= ""
	Local cAssunto		:= "Rescisão de Funcionário (" + Alltrim(Capital(SRA->RA_NOME)) + ")"
	Local cPara			:= SuperGetMV("MV_X_DESTI", .F., "email@empresa.com;")
	Local xRet			:= .T.
	Local nOperation
	Local oObjForm
	Local nSRGDemit     := 0

	//Se veio parâmetors na rotina
	If ! Empty(aParam)
		oObjForm    := aParam[1]
		cIdPonto    := aParam[2]
		nOperation	:= oObjForm:GetOperation()

		//Tratativa após o commit da operação somente na inclusão
		If nOperation == MODEL_OPERATION_INSERT .and. cIdPonto == "MODELCOMMITNTTS"

			//Busca quantos registros tem na SRG (Rescisões)
			nSRGDemit := fSRGDemit(SRA->RA_FILIAL, SRA->RA_MAT)

			//Somente se tiver uma única linha na SRG (não tem complemento)
			If nSRGDemit == 1
                //Monta a mensagem do email e realiza o disparo
                cCorpoMsg := '<p>Olá.</p>' + CRLF
                cCorpoMsg += '<p>Um funcionário foi demitido, verifique se será necessário bloquear acessos aos sistemas.</p>' + CRLF
                cCorpoMsg += '<p>Abaixo os dados:</p>' + CRLF
                cCorpoMsg += '<ul>' + CRLF
                cCorpoMsg += '<li><strong>Filial:</strong> ' + SRA->RA_FILIAL + '</li>' + CRLF
                cCorpoMsg += '<li><strong>Matrícula:</strong> ' + SRA->RA_MAT + '</li>' + CRLF
                cCorpoMsg += '<li><strong>Nome:</strong> ' + Alltrim(Capital(SRA->RA_NOMECMP)) + '</li>' + CRLF
                cCorpoMsg += '</ul>' + CRLF
                cCorpoMsg += '<p>e-Mail gerado automaticamente em ' + dToC(Date()) + ' às ' + Time() + '.</p>' + CRLF
                
                GPEMail(cAssunto, cCorpoMsg, cPara)
			EndIf
		EndIf
	EndIf

	FWRestArea(aArea)
Return xRet

Static Function fSRGDemit(cFilFun, cMatFun)
	Local aArea   := FWGetArea()
	Local cQrySRG := ""
	Local nQtdSRG := 0

    //Efetua a busca dos dados na SRG
	cQrySRG := " SELECT  " + CRLF
	cQrySRG += " 	COUNT(*) AS TOTAL " + CRLF
	cQrySRG += " FROM  " + CRLF
	cQrySRG += " 	" + RetSQLName("SRG") + " SRG " + CRLF
	cQrySRG += " WHERE " + CRLF
	cQrySRG += " 	RG_FILIAL = '" + cFilFun + "' " + CRLF
	cQrySRG += " 	AND RG_MAT = '" + cMatFun + "' " + CRLF
	cQrySRG += " 	AND SRG.D_E_L_E_T_ = ' ' " + CRLF
	TCQuery cQrySRG New Alias "QRY_SRG"

	//Se tem dados, atualiza o retorno
	If ! QRY_SRG->(EoF())
		nQtdSRG := QRY_SRG->TOTAL
	EndIf
	QRY_SRG->(DbCloseArea())

	FWRestArea(aArea)
Return nQtdSRG
