/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2015/12/15/vd-advpl-015/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zPessoa
Criação da classe Pessoa
@author Atilio
@since 13/12/2015
@version 1.0
	@example
	oObjeto := zPessoa():New()
/*/

Class zPessoa
	//Atributos
	Data cNome
	Data nIdade
	Data dNascimento

	//Métodos
	Method New() CONSTRUCTOR
	Method MostraIdade()
EndClass

/*/{Protheus.doc} New
Método que cria a instância com a classe zPessoa
@author Atilio
@since 13/12/2015
@version 1.0
	@param cNome, Caracter, Nome da Pessoa
	@param dNascimento, Data, Data de Nascimento da Pessoa
	@example
	oObjeto := zPessoa():New("João", sToD("19800712"))
/*/

Method New(cNome, dNascimento) Class zPessoa
	//Atribuindo valores nos atributos do objeto instanciado
	::cNome		:= cNome
	::dNascimento	:= dNascimento
	::nIdade		:= fCalcIdade(dNascimento)
Return Self

/*/{Protheus.doc} MostraIdade
Método que mostra a idade da pessoa
@author Atilio
@since 13/12/2015
@version 1.0
	@example
	oObjeto:MostraIdade()
/*/

Method MostraIdade() Class zPessoa
	Local cMsg := ""
	
	//Criando e mostrando a mensagem
	cMsg := "A <b>pessoa</b> "+::cNome+" tem "+cValToChar(::nIdade)+" anos!"
	MsgInfo(cMsg, "Atenção")
Return

/*-------------------------------------------------*
 | Função: fCalcIdade                              |
 | Autor:  Daniel Atilio                           |
 | Data:   13/12/2015                              |
 | Descr.: Função que calcula a idade da Pessoa    |
 *-------------------------------------------------*/

Static Function fCalcIdade(dNascimento)
	Local nIdade
	
	//Chamando a função YearSub para subtrair os anos de uma data
	nIdade := DateDiffYear(dDataBase, dNascimento)
Return nIdade