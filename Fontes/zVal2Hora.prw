/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2015/05/14/converter-valor-numerico-para-hora-em-advpl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zVal2Hora
Converte valor numérico (ex.: 15.30) para hora (ex.: 15:30)
@author Atilio
@since 20/09/2014
@version 1.0
	@param [nValor], Numérico, Valor numérico correspondente as horas
	@param [cSepar], Caracter, Caracter de separação (ex.: 'h', ':', etc)
	@return cHora, Variável que irá armazenar as horas
	@example
	u_zVal2Hora(1.50, 'h') //01h30
	u_zVal2Hora(1.50, ':') //01:30
/*/
 
User Function zVal2Hora(nValor, cSepar)
	Local cHora := ""
	Local cMinutos := ""
	Default cSepar := ":"
	Default nValor := -1
	
	//Se for valores negativos, retorna a hora atual
	If nValor < 0
		cHora := SubStr(Time(), 1, 5)
		cHora := StrTran(cHora, ':', cSepar)
		
	//Senão, transforma o valor numérico
	Else
		cHora := Alltrim(Transform(nValor, "@E 99.99"))
		
		//Se o tamanho da hora for menor que 5, adiciona zeros a esquerda
		If Len(cHora) < 5
			cHora := Replicate('0', 5-Len(cHora)) + cHora
		EndIf
		
		//Fazendo tratamento para minutos
		cMinutos := SubStr(cHora, At(',', cHora)+1, 2)
		cMinutos := StrZero((Val(cMinutos)*60)/100, 2)
		
		//Atualiza a hora com os novos minutos
		cHora := SubStr(cHora, 1, At(',', cHora))+cMinutos
		
		//Atualizando o separador
		cHora := StrTran(cHora, ',', cSepar)
	EndIf
	
	ConOut("> zVal2Hora: "+cHora)
Return cHora