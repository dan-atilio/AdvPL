/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/10/29/montando-classes-com-metodos-e-atributos-usando-class-maratona-advpl-e-tl-082/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe082
Exemplo de como criar e utilizar uma classe
@type Function
@author Atilio
@since 09/12/2022
@see https://tdn.totvs.com/pages/viewpage.action?pageId=6063065
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe082()
    Local aArea     := FWGetArea()
    Local oPessoa
    Local cNome        := "José"
    Local dNascimento  := sToD("19850712")
     
    //Instanciando o objeto através da classe Pessoa
    oPessoa := zPessoaTst():New(cNome, dNascimento)
     
    //Chamando um método da classe
    oPessoa:MostraIdade()

    FWRestArea(aArea)
Return

/*
 ====================================================
 Abaixo é a declaração da classe, seus métodos e atributos
 ====================================================
*/

/*/{Protheus.doc} zPessoaTst
Criação da classe Pessoa
@author Atilio
@since 13/12/2015
@version 1.0
    @example
    oObjeto := zPessoaTst():New()
/*/
 
Class zPessoaTst
    //Atributos
    Data cNome
    Data nIdade
    Data dNascimento
 
    //Métodos
    Method New() CONSTRUCTOR
    Method MostraIdade()
EndClass
 
/*/{Protheus.doc} New
Método que cria a instância com a classe zPessoaTst
@author Atilio
@since 13/12/2015
@version 1.0
    @param cNome, Caracter, Nome da Pessoa
    @param dNascimento, Data, Data de Nascimento da Pessoa
    @example
    oObjeto := zPessoaTst():New("João", sToD("19800712"))
/*/
 
Method New(cNome, dNascimento) Class zPessoaTst
    //Atribuindo valores nos atributos do objeto instanciado
    ::cNome        := cNome
    ::dNascimento    := dNascimento
    ::nIdade        := fCalcIdade(dNascimento)
Return Self
 
/*/{Protheus.doc} MostraIdade
Método que mostra a idade da pessoa
@author Atilio
@since 13/12/2015
@version 1.0
    @example
    oObjeto:MostraIdade()
/*/
 
Method MostraIdade() Class zPessoaTst
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
    nIdade := DateDiffYear(Date(), dNascimento)
Return nIdade
