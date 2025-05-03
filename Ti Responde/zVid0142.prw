/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/04/15/como-calcular-impostos-de-um-pedido-de-compras-ti-responde-0142/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zVid0142
Função para demonstrar o cálculo de impostos no Pedido de Compras
@type  Function
@author Atilio
@since 03/04/2024
/*/

User Function zVid0142()
    Local aArea    := FWGetArea()
    Local aPergs   := {}
    Local cPedido  := Space(TamSX3("C7_NUM")[01])
    
    //Adiciona os parâmetros que serão exibidos na tela do ParamBox
    aAdd(aPergs, {1, "Número Pedido",  cPedido,  "", "ExistCPO('SC7')", "SC7", ".T.", 60,  .T.})
    
    //Se a pergunta for confirmada
    If ParamBox(aPergs, "Informe os parâmetros", /*aRet*/, /*bOk*/, /*aButtons*/, /*lCentered*/, /*nPosx*/, /*nPosy*/, /*oDlgWizard*/, /*cLoad*/, .F., .F.)
        Processa({|| fCalcula()})
    EndIf

    FWRestArea(aArea)
Return

Static Function fCalcula()
    Local aArea     := FWGetArea()
    Local cNumPed   := MV_PAR01
    Local cMsgLog   := ""
    Local nItem     := 0
    Local aCampos   := {}
    Local aValids   := {}
    Local nCampoAtu := 0
    Local cCampoAtu := ""
    Local cValidAtu := ""
    Local nPosInici := 0
    Local nPosFinal := 0
    Local cReferenc := ""
    Local cMascara  := "@E 999,999,999.99"

    //Primeiro passo, vamos posicionar no Pedido de Compras
    DbSelectArea("SC7")
    SC7->(DbSetOrder(1)) // C7_FILIAL + C7_NUM + C7_ITEM + C7_SEQUEN
    If SC7->(MsSeek(FWxFilial("SC7") + cNumPed))

        //Define o tamanho da régua como 0 para ficar de um lado para outro
        ProcRegua(0)

        //Busca todos os campos da SC7 e em seguida, todos os valids, que tenham "MAFISREF"
        aCampos := SC7->(DbStruct())
        For nCampoAtu := 1 To Len(aCampos)
            cCampoAtu := aCampos[nCampoAtu][1]
            cValidAtu := Alltrim(Upper( GetSX3Cache(cCampoAtu, "X3_VALID") ))

            //Se tiver o MAFISREF na validação, vamos adicionar num segundo array
            If "MAFISREF" $ cValidAtu
                aAdd(aValids, {cCampoAtu, cValidAtu})
            EndIf
        Next

        //Encerra o cálculo fiscal caso tenha algum em memória
        MaFisEnd()

        //Inicializa o cálculo fiscal
        MaFisIni(SC7->C7_FORNECE, SC7->C7_LOJA, "F", "N", "R", {})

        //Agora percorre todos os itens do pedido de compras
        While ! SC7->(EoF()) .And. SC7->C7_FILIAL + SC7->C7_NUM == FWxFilial("SC7") + cNumPed

            //Inicia o carregamento do item do pedido
            nItem++
		    MaFisIniLoad(nItem)

            //Incrementa a régua do Processa
            IncProc("Analisando item " + cValToChar(nItem))

            //Percorre os valids de campo
            For nCampoAtu := 1 To Len(aValids)
                cCampoAtu := aValids[nCampoAtu][1]
                cValidAtu := aValids[nCampoAtu][2]

                //Busca as posições inicias e finais dentro do MAFISREF
                nPosInici  := At('MAFISREF("', cValidAtu) + 10
                nPosFinal  := At('","MT120",', cValidAtu)

                //Pega apenas o conteúdo entre a posição inicial e final
				cReferenc := SubStr(cValidAtu, nPosInici, nPosFinal - nPosInici)

				//Carrega a informação da SC7 para o cálculo fiscal
				MaFisLoad(cReferenc, &("SC7->"+ cCampoAtu), nItem)
            Next

            //Encerra o carregamento do item do pedido
            MaFisEndLoad(nItem, 2)

            SC7->(DbSkip())
        EndDo

        //Agora vamos montar a mensagem que será exibida com os valores dos impostos
        cMsgLog := "Pedido '" + cNumPed + "': " + CRLF + CRLF
        cMsgLog += "-> IPI:      " + Transform(MaFisRet(, 'NF_VALIPI')  , cMascara) + CRLF
	    cMsgLog += "-> ICMS:     " + Transform(MaFisRet(, 'NF_VALICM')  , cMascara) + CRLF
	    cMsgLog += "-> Despesas: " + Transform(MaFisRet(, 'NF_DESPESA') , cMascara) + CRLF
	    cMsgLog += "-> Frete:    " + Transform(MaFisRet(, 'NF_FRETE')   , cMascara) + CRLF
	    cMsgLog += "-> Seguro:   " + Transform(MaFisRet(, 'NF_SEGURO')  , cMascara) + CRLF
	    cMsgLog += "-> Vlr.Tot.: " + Transform(MaFisRet(, 'NF_TOTAL')   , cMascara) + CRLF

    //Senão encontrar, apenas define uma mensagem
    Else
        cMsgLog := "Pedido '" + cNumPed + "' não encontrado!"
    EndIf

    //Exibe a mensagem com o resultado
    ShowLog(cMsgLog)

    FWRestArea(aArea)
Return
