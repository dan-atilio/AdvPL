/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/19/criando-uma-regua-dupla-com-a-msnewprocess-maratona-advpl-e-tl-364/
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} User Function zExe364
Abre uma tela de processamento com régua dupla
@type Function
@author Atilio
@since 27/03/2023
@see https://tdn.totvs.com/display/public/framework/MsNewProcess
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe364()
    Local aArea    := FWGetArea()
    Local oProcess
    
    //Aciona a rotina para processar os registros
    oProcess := MsNewProcess():New({|| fExemplo(oProcess)}, "Processando...", "Aguarde...", .T.)
    oProcess:Activate()

    FWRestArea(aArea)
Return

Static Function fExemplo(oProcess)
    Local aArea   := FWGetArea()
    Local nAtual  := 0
    Local nTotal  := 0
    Local cQryAux := ""
    Local nAtu2   := 0
    Local nTot2   := 90
      
    //Executa a consulta
    cQryAux := " SELECT "                          + CRLF
    cQryAux += "     BM_GRUPO, "                    + CRLF
    cQryAux += "     BM_DESC "                      + CRLF
    cQryAux += " FROM "                            + CRLF
    cQryAux += "     " + RetSQLName("SBM") + " SBM "                   + CRLF
    cQryAux += " WHERE "                           + CRLF
    cQryAux += "     BM_FILIAL = '" + FWxFilial('SBM') + "' "              + CRLF
    cQryAux += "     AND SBM.D_E_L_E_T_ = ' ' "     + CRLF
    TCQuery cQryAux New Alias "QRY_AUX"
      
    //Conta quantos registros existem, e seta no tamanho da regua
    Count To nTotal
    oProcess:SetRegua1(nTotal)
      
    //Percorre todos os registros da query
    QRY_AUX->(DbGoTop())
    While ! QRY_AUX->(EoF())
          
        //Incrementa a mensagem na regua
        nAtual++
        oProcess:IncRegua1("Analisando registro " + cValToChar(nAtual) + " de " + cValToChar(nTotal) + "...")
        
        //Incrementando a regua 2
        oProcess:SetRegua2(nTot2)
        For nAtu2 := 1 To nTot2
            oProcess:IncRegua2("Posicao " + cValToChar(nAtu2) + " de " + cValToChar(nTot2) + "...")
            Sleep(100)
        Next
          
        QRY_AUX->(DbSkip())
    EndDo
    QRY_AUX->(DbCloseArea())
      
    FWRestArea(aArea)
Return
