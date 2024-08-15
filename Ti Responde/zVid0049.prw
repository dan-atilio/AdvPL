/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2023/03/27/quais-produtos-estao-sem-saldo-no-help-ma240negat-ti-responde-049/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} User Function MT261UM
Ponto de entrada paliativo, após fazer validações da quantidade na Transferência Múltipla
@type  Function
@author Atilio
@since 25/04/2022
@obs Função esta dentro da validação em A261Quant
    Esse p.e. na verdade tem o intuito de fazer a validação entre a quantidade e a
    quantidade na segunda unidade de medida (o MV_ESTNEG tem que estar como N)

    Porém ele foi usado, caso o retorno seja .F. quer dizer que esta com alguma
    falta de estoque, e dessa forma, fazemos a validação percorrendo as linhas,
    encontrando o produto, o armazém, e assim fazendo a validação do estoque
    para poder mostrar para o usuário, quais são os produtos com a divergência
/*/

User Function MT261UM()
    Local aArea      := FWGetArea()
    Local lRet       := ParamIXB[3]
    Local nPosProdu  := GDFieldPos("D3_COD")
    Local nPosQuant  := GDFieldPos("D3_QUANT")
    Local nPosLocOri := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == "D3_LOCAL"})
    //Local nPosLocDes := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == "D3_LOCAL"}, nPosLocOri+1)
    Local cMensagem  := ""
    Local nLinha     := 0
    Local cQrySaldo  := ""
    Local nSaldo     := 0
    Local nQtdDigit  := 0
    Local cVariavel  := ReadVar()

    //Se não for de processo automático (ExecAuto)
    If ! lAutoma261

        //Percorre todas as linhas digitadas
        For nLinha := 1 To Len(aCols)

            //Zera as variáveis
            nSaldo := 0

            //Se a linha estiver em memória
            If n == nLinha .And. cVariavel == "M->D3_QUANT"
                nQtdDigit := &(ReadVar())
            Else
                nQtdDigit := aCols[nLinha][nPosQuant]
            EndIf

            //Efetua a busca do Saldo
            cQrySaldo := " SELECT " + CRLF
            cQrySaldo += " 	B2_QATU-B2_QACLASS-B2_RESERVA AS TOTAL " + CRLF
            cQrySaldo += " FROM " + CRLF
            cQrySaldo += " 	" + RetSQLName("SB2") + " SB2 " + CRLF
            cQrySaldo += " WHERE " + CRLF
            cQrySaldo += " 	B2_FILIAL = '" + FWxFilial("SB2") + "' " + CRLF
            cQrySaldo += " 	AND B2_COD = '" + aCols[nLinha][nPosProdu] + "' " + CRLF
            cQrySaldo += " 	AND B2_LOCAL = '" + aCols[nLinha][nPosLocOri] + "' " + CRLF
            cQrySaldo += " 	AND SB2.D_E_L_E_T_ = ' ' " + CRLF
            TCQuery cQrySaldo New Alias "QRY_SALDO"

            //Se houver dados, atualiza a variável de saldo
            If ! QRY_SALDO->(EoF())
                nSaldo := QRY_SALDO->TOTAL
            EndIf
            QRY_SALDO->(DbCloseArea())

            //Se o saldo for menor que a quantidade digitada, não vai poder atender a transferência
            If nSaldo < nQtdDigit
                cMensagem += "<li>Linha '" + cValToChar(nLinha) + "', Produto '" + aCols[nLinha][nPosProdu] + "', Armazém '" + aCols[nLinha][nPosLocOri] + "', foi digitado '" + cValToChar(nQtdDigit) + "' mas tem saldo de apenas '" + cValToChar(nSaldo) + "'!</li>"
            EndIf
        Next

        //Se tem mensagem a ser exibida
        If ! Empty(cMensagem)
            FWAlertError("Os seguintes produtos, possuem divergência entre a quantidade digitada e o saldo em estoque:<br><ul>" + cMensagem + "</ul>", "Falha nos saldos do Estoque")
        EndIf
    EndIf

    FWRestArea(aArea)
Return lRet
