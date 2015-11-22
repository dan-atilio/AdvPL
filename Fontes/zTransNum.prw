//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zTransNum
Função para conversão de valor numérico para texto conforme quantidade de decimais informada 
@author Daniel Atilio
@since  05/06/2014
@version 1.0
	@param nValor,		Numérico, Valor que será convertido
	@param nTotal,		Numérico, Quantidade total de casas
	@param nDec,		Numérico, Quantidade de casas decimais
	@param lConsDec,	Lógico,   Considera a quantidade de decimais no tamanho final
	@return cTexto, Conteúdo texto da conversão
	@example
	u_zTransNum(15.23, 5, 2)
/*/
 
User Function zTransNum(nValor, nTotal, nDec, lConsDec)
	Local cMascara := "@E 9,999,999,999,999,999,999"
	Local cTexto := ""
	Default lConsDec := .F.
	
	//Decimais
	cMascara += "."+Replicate('9',nDec)
	
	//Transformando conforme máscara
	cTexto := Alltrim(Transform(nValor,cMascara))
	
	//Retirando ponto e vírgula
	cTexto := StrTran(cTexto,',','')
	cTexto := StrTran(cTexto,'.','')
	
	//Colocando zeros a esquerda
	cTexto := StrZero(Val(cTexto),nTotal+Iif(lConsDec, nDec, 0))
	
/*	MsgInfo(	'nValor: '+cValToChar(nValor)+Chr(13)+Chr(10)+;
				'cMascara: '+cMascara+Chr(13)+Chr(10)+;
				'cTexto: '+cTexto+Chr(13)+Chr(10)+;
				'nTotal: '+cValToChar(nTotal)+Chr(13)+Chr(10)+;
				'nDec: '+cValToChar(nDec))*/
Return cTexto