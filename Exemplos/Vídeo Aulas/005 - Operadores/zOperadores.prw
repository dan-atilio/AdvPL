/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2015/11/05/vd-advpl-005/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zOperadores
Exemplo de Operadores mais comuns em AdvPL
@author Atilio
@since 25/10/2015
@version 1.0
	@example
	u_zOperadores()
	@obs Utilize esse teste no cadastro de fórmulas
/*/

User Function zOperadores()
	Local aArea := GetArea()
	
	//Declaração de variáveis
	Local nValor1	:= 5
	Local nValor2	:= 3
	Local cTexto1	:= "Daniel Atilio"
	Local cTexto2	:= "Atilio"
	
	//Atribuição
	nValor1 := 6	//Existe também o replace, porém ele é utilizado para campos (RecLock)
	
	//Manipulação
	nValor1++		//Soma 1 na variável. Outro exemplo:		nValor1 := nValor1 + 1
	nValor1--		//Subtrai 1 na variável. Outro exemplo:	nValor1 := nValor1 - 1
	nValor1 *= 2	//Multiplica o valor. Outro exemplo:		nValor1 := nValor1 * 2
	nValor1 /= 2	//Divide o valor. Outro exemplo:			nValor1 := nValor1 / 2
	nValor1 += 7  //Soma o valor. Outro exemplo:				nValor1 := nValor1 + 7
	nValor1 -= 7	//Subtrai o valor. Outro exemplo:			nValor1 := nValor1 - 7
	
	//Testes
	ConOut("Testes: ")
	ConOut( nValor1 == nValor2 )		//Exatamente igual
	ConOut( !(nValor1 == nValor2) )		//Negação de teste
	ConOut( nValor1 != nValor2 )		//Diferente de (também pode ser usado <>)
	ConOut( cTexto2 $ cTexto1 )			//Está contido
	ConOut( nValor1 > nValor2 )			//É maior que (também pode ser >=, seria maior ou igual)
	ConOut( nValor1 < nValor2 )			//É menor que (também pode ser <=, seria menor ou igual)
	
	//Testes compostos
	ConOut("Testes Compostos: ")
	ConOut( (1==1) .And. (1!=1) )		//Teste com .And. só retorna verdadeiro, se todos os testes forem verdadeiro
	ConOut( (1==1) .Or.  (1!=1) )		//Teste com .Or.  retorna verdadeiro, se qualquer teste for verdadeiro
	
	//Macro Substituição
	&("nValor3 := 8")
	Alert(nValor3)
	
	RestArea(aArea)
Return