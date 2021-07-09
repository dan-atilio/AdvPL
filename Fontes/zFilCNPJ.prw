/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2022/03/16/funcao-que-retorna-a-filial-atraves-de-um-cnpj/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFilCNPJ
Função que retorna o código da filial (no padrão EEFF) através de um CNPJ vindo do parâmetro
@type  Function
@author Atilio
@since 22/04/2021
@version version
/*/

User Function zFilCNPJ(cCNPJ)
    Local aArea := GetArea()
    Local aEmpresas := FWAllCompany()
    Local aFiliais := {}
    Local aFilCNPJ := {}
    Local nEmpAtu := 0
    Local nFilAtu := 0
    Local aFilRet := {}
    Local cEmpFil
    Default cCNPJ := ""

    //Se tiver CNPJ a procurar
    If ! Empty(cCNPJ)
        //Percorre todas as empresas
        For nEmpAtu := 1 To Len(aEmpresas)
            aFiliais := FWAllFilial(aEmpresas[nEmpAtu])

            //Percorre todas as filiais da empresa atual
            For nFilAtu := 1 To Len(aFiliais)
                cEmpFil := aEmpresas[nEmpAtu] + aFiliais[nFilAtu] //padrão EEFF

                //Se o CNPJ vindo por parâmetro for igual da filial atual, encerra os laços
                If Alltrim(cCNPJ) == FWArrFilAtu(aEmpresas[nEmpAtu], cEmpFil)[18]
                    aAdd(aFilRet, aEmpresas[nEmpAtu])
                    aAdd(aFilRet, cEmpFil)

                    nEmpAtu := Len(aEmpresas)
                    Exit
                EndIf
            Next
        Next
    EndIf

    RestArea(aArea)
Return aFilRet
