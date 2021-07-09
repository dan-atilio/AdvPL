/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2021/07/29/como-forcar-um-erro-no-protheus-para-ver-a-pilha-de-chamadas/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zErro
Função que força a exibição de um Error Log para análise
@type  Function
@author Atilio
@since 10/05/2021
@version version
@obs O ideal é adicionar a rotina no AfterLogin como um atalho do sistema, por exemplo:
User Function AfterLogin()
    //...

    SetKey(K_SH_F9, { || u_zErro() }) //Shift + F9

    //...
Return
/*/

User Function zErro()
    Local nVar := 0
    Local cVar := ""

    //Ao tentar somar / concatenar numérico com caractere irá causar o type mismatch
    Alert(nVar + cVar)
Return
