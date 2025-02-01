/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/01/21/como-pegar-uma-aliquota-do-mv_esticm-via-advpl-ti-responde-0118/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} zVid0118
Demonstração de como buscar alíquotas de estados no parâmetro MV_ESTICM
@type user function
@author Atilio
@since 29/01/2024
/*/

User Function zVid0118()
    Local aArea   := FWGetArea()
    Local cEstado := Upper(Alltrim(FWInputBox("Digite a sigla do estado")))
    Local nValor  := 0
    Local cTexto  := ""

    //Se tiver estado preenchido e for dois caracteres
    If ! Empty(cEstado) .And. Len(cEstado) == 2
        //Busca a alíquota
        nValor := u_zGetICMS(cEstado)

        //Mostra o resultado em uma mensagem
        cTexto := FormatStr("Para o estado %c a alíquota é de %n", {cEstado, nValor})
        FWAlertInfo(cTexto, "Teste Alíquota")
    EndIf

    FWRestArea(aArea)
Return

/*/{Protheus.doc} zGetICMS
Função que retorna a alíquota do estado
@type user function
@author Atilio
@since 29/01/2024
@param cEstado, Caractere, Sigla do Estado a ser procurada no parâmetro MV_ESTICM
@return nValor, Numérico, Valor da alíquota
@example
nValor := u_zGetICMS("SP")
/*/
User Function zGetICMS(cEstado)
    Local aArea   := FWGetArea()
    Local cParam  := Alltrim(GetMV("MV_ESTICM"))
    Local nPosIni := 0
    Local nPosFim := 0
    Local nValor  := 0

    //Se o estado procurado esta no parâmetro
    If cEstado $ cParam
        //Pega a posição e inicial e + 2 caracteres devido ao tamanho da sigla
        nPosIni := At(cEstado, cParam) + 2 

        //Percorre o restante do parâmetro
        For nPosFim := nPosIni To Len(cParam)
            //Se for caractere, sai do laço para pegar só os numéricos
            If IsAlpha(SubStr(cParam, nPosFim, 1))
                nPosFim--
                Exit
            EndIf
        Next

        //Pega o Valor
        nQuantidade := (nPosFim-nPosIni) + 1
        nValor := Val(SubStr(cParam, nPosIni, nQuantidade))
    EndIf

    FWRestArea(aArea)
Return nValor
