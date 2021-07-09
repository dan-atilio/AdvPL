/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2021/09/23/funcao-que-retorna-o-quinto-dia-util-do-mes/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zQuinto
Função que retorna o quinto dia útil de um mês
@type  Function
@author Atilio
@since 20/05/2021
@version version
@param dDataRef, Date, Data do mês de referência
@return dQuintoDia, Date, Data do quinto dia útil
@example
    dData := u_zQuinto(sToD("20210401"))
/*/

User Function zQuinto(dDataRef)
    Local aArea := GetArea()
    Local dQuintoDia
    Local dDataAux
    Local nDiaUtil := 1
    Default dDataRef := Date()

    //Define a data auxiliar como o primeiro dia do mês
    dDataAux := FirstDate(dDataRef)

    //Enquanto o dia útil for menor que 5
    While nDiaUtil < 5
        //Se for fim de semana ou feriado, subtrai um do contador do While
        If DataValida(dDataAux) != dDataAux
            nDiaUtil--
        EndIf

        //Incrementa um dia na data auxiliar
        dDataAux := DaySum(dDataAux, 1)
        nDiaUtil++
    EndDo

    //Define o quinto dia, conforme a data que finalizou no While
    dQuintoDia := dDataAux

    RestArea(aArea)
Return dQuintoDia
