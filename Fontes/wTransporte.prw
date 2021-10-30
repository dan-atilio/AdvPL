/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2021/10/05/como-usar-a-autenticacao-com-oauth2-em-rest/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "TOTVS.ch"
#Include "RESTFul.ch"
#Include "TopConn.ch"
 
/*
    WS Rest de Exemplo para busca de Transportadoras
    Usando como base oAuth2
     
    Daniel Atilio
    https://terminaldeinformacao.com
*/
 
WSRESTFUL wTransporte DESCRIPTION "WS de Métodos de Transporte"
    //Atributos usados
    WSDATA limit AS INTEGER
    WSDATA page AS INTEGER
  
    //Métodos usados
    WSMETHOD GET ALL DESCRIPTION "Retorna todas as transportadoras" WSSYNTAX '/wTransporte?{limit, page}' PATH "wTransporte"       PRODUCES APPLICATION_JSON
END WSRESTFUL
 
//Poderia ser usado o FWAdapterBaseV2(), porém a paginação foi feita manualmente
WSMETHOD GET ALL WSRECEIVE limit, page WSSERVICE wTransporte
    Local lRet       := .T.
    Local oResponse  := JsonObject():New()
    Local cQuerySA4  := ""
    Local nTamanho   := 10
    Local nTotal     := 0
    Local nPags      := 0
    Local nPagina    := 0
    Local nAtual     := 0
 
    //Efetua a busca dos transportadoras
    cQuerySA4 := " SELECT " + CRLF
    cQuerySA4 += "     SA4.R_E_C_N_O_ AS SA4REC " + CRLF
    cQuerySA4 += " FROM " + CRLF
    cQuerySA4 += "     " + RetSQLName("SA4") + " SA4 " + CRLF
    cQuerySA4 += " WHERE " + CRLF
    cQuerySA4 += "     A4_FILIAL = '" + FWxFilial("SA4") + "' " + CRLF
    cQuerySA4 += "     AND SA4.D_E_L_E_T_ = '' " + CRLF
    cQuerySA4 += " ORDER BY " + CRLF
    cQuerySA4 += "     SA4REC " + CRLF
    TCQuery cQuerySA4 New Alias "QRY_SA4"
 
    //Se não encontrar a transportadora
    If QRY_SA4->(EoF())
        SetRestFault(500, "Falha ao consultar transportadoras")
        oResponse["errorId"]  := "TRA001"
        oResponse["error"]    := "Transportadora(s) não encontrada(s)"
        oResponse["solution"] := "A consulta de transportadoras não retornou nenhuma informação"
    Else
 
        oResponse["objects"] := {}
 
        //Conta o total de registros
        Count To nTotal
        QRY_SA4->(DbGoTop())
 
        //O tamanho do retorno, será o limit, se ele estiver definido
        If ! Empty(::limit)
            nTamanho := ::limit
        EndIf
 
        //Pegando total de páginas
        nPags := NoRound(nTotal / nTamanho, 0)
        nPags += Iif(nTotal % nTamanho != 0, 1, 0)
         
        //Se vier página
        If ! Empty(::page)
            nPagina := ::page
        EndIf
 
        //Se a página vier zerada ou negativa ou for maior que o máximo, será 1 
        If nPagina <= 0 .Or. nPagina > nPags
            nPagina := 1
        EndIf
 
        //Se a página for diferente de 1, pula os registros
        If nPagina != 1
            QRY_SA4->(DbSkip((nPagina-1) * nTamanho))
        EndIf
 
        //Adiciona os dados para a meta
        oJsonMeta := JsonObject():New()
        oJsonMeta["total"]         := nTotal
        oJsonMeta["current_page"]  := nPagina
        oJsonMeta["total_page"]    := nPags
        oJsonMeta["total_items"]   := nTamanho
        oResponse["meta"] := oJsonMeta
 
        //Percorre os transportadoras
        While ! QRY_SA4->(EoF())
            nAtual++
             
            //Se ultrapassar o limite, encerra o laço
            If nAtual > nTamanho
                Exit
            EndIf
 
            //Posiciona a transportadora e adiciona no retorno
            DbSelectArea("SA4")
            SA4->(DbGoTo(QRY_SA4->SA4REC))
            oJsonObj := JsonObject():New()
            oJsonObj["id"]   := SA4->A4_COD
            oJsonObj["name"] := SA4->A4_NOME
            aAdd(oResponse["objects"], oJsonObj)
 
            QRY_SA4->(DbSkip())
        EndDo
    EndIf
    QRY_SA4->(DbCloseArea())
 
    //Define o retorno
    Self:SetContentType("application/json")
    Self:SetResponse(oResponse:toJSON())
Return lRet