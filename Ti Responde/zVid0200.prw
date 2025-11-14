/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/11/04/bloquear-operacoes-em-todas-telas-de-cadastro-em-uma-filial-ti-responde-0200/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zVid0200
Função que valida a filial logada, se for a "01" ou a "02" irá barrar as operações
@type  Function
@author Atilio
@since 08/08/2024
@return lBloqueada, Lógico, .T. Se for uma das filiais que não podem manipular os dados ou .F. se podem manipular
/*/

User Function zVid0200()
    Local aArea      := FWGetArea()
    Local lBloqueada := .F.
    Local cFilAtual  := FWFilial()
    Local cFilBloq   := "01;02;" //Se for mais caracteres, ficaria por exemplo 0101;0102; e assim por diante

    //Se for uma das filiais bloqueadas
    If cFilAtual $ cFilBloq
        lBloqueada := .T.
    EndIf

    FWRestArea(aArea)
Return lBloqueada

/*/{Protheus.doc} User Function MBrwBtn
Valida o clique em alguma opção disponível nos Browses das rotinas
@type  Function
@author Atilio
@since 08/08/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6815197
/*/

User Function MBrwBtn()
    Local aArea     := FWGetArea()
    Local lContinua := .T.
    Local nOpcaMenu := ParamIXB[3]

    //Se a filial estiver bloqueada
	If u_zVid0200()

		//Se for a opção de visualizar vai permitir
		If nOpcaMenu == 2
			lContinua := .T.
			
		//Senão, se for qualquer outra, vai bloquear
		Else
			lContinua := .F.
		EndIf
	EndIf

    FWRestArea(aArea)
Return lContinua

/*/{Protheus.doc} User Function ChkExec
Ponto de Entrada acionado ao clicar em alguma opção no menu
@type  Function
@author Atilio
@since 08/08/2024
@see https://tdn.totvs.com/display/public/framework/CHKEXEC+-+Dispara+ponto+de+entrada
/*/

User Function ChkExec()
    Local lContinua := .T.
    Local cFuncao   := Alltrim(Upper(PARAMIXB))
    Local cFuncBloq := ""

    //Se a filial estiver bloqueada
	If u_zVid0200()
        //Monta quais funções são bloqueadas (aqui você pode colocar outras também, como customizadas ou de outros processos)
        cFuncBloq += "MATA215(); " //Refaz Acumulados
        cFuncBloq += "MATA216(); " //Refaz Poder Terceiros
        cFuncBloq += "MATA300(); " //Refaz Saldos
        cFuncBloq += "MATA215(); " //Refaz Empenhos / Acumulados
        cFuncBloq += "MATA190(); " //Refaz Custo Entrada
        cFuncBloq += "FINA410(); " //Refaz Dados Cliente e Fornecedor

        //Se a função tiver na lista das bloqueadas, não permite prosseguir
        If cFuncao $ cFuncBloq
			lContinua := .F.
		EndIf
    EndIf

Return lContinua


