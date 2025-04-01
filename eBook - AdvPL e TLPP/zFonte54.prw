/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "Totvs.ch"
#Include "RESTFul.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} WSRESTFUL zFonte54
Busca de Produtos
@author Atilio
@since 13/03/2025
@version 1.0
@type wsrestful
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

WSRESTFUL zFonte54 DESCRIPTION 'Busca de Produtos'
    //Atributos
    WSDATA id         AS STRING
    WSDATA updated_at AS STRING
    WSDATA limit      AS INTEGER
    WSDATA page       AS INTEGER
 
    //Métodos
    WSMETHOD GET    ID     DESCRIPTION 'Retorna o registro pesquisado' WSSYNTAX '/zFonte54/get_id?{id}'                       PATH 'get_id'        PRODUCES APPLICATION_JSON
    WSMETHOD GET    ALL    DESCRIPTION 'Retorna todos os registros'    WSSYNTAX '/zFonte54/get_all?{updated_at, limit, page}' PATH 'get_all'       PRODUCES APPLICATION_JSON
END WSRESTFUL

/*/{Protheus.doc} WSMETHOD GET ID
Busca registro via ID
@author Atilio
@since 13/03/2025
@version 1.0
@type method
@param id, Caractere, String que será pesquisada através do MsSeek
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

WSMETHOD GET ID WSRECEIVE id WSSERVICE zFonte54
    Local lRet       := .T.
    Local jResponse  := JsonObject():New()
    Local cAliasWS   := 'SB1'

    //Se o id estiver vazio
    If Empty(::id)
        //SetRestFault(500, 'Falha ao consultar o registro') //caso queira usar esse comando, você não poderá usar outros retornos, como os abaixo
        Self:setStatus(500) 
        jResponse['errorId']  := 'ID001'
        jResponse['error']    := 'ID vazio'
        jResponse['solution'] := 'Informe o ID'
    Else
        DbSelectArea(cAliasWS)
        (cAliasWS)->(DbSetOrder(1))

        //Se não encontrar o registro
        If ! (cAliasWS)->(MsSeek(FWxFilial(cAliasWS) + ::id))
            //SetRestFault(500, 'Falha ao consultar ID') //caso queira usar esse comando, você não poderá usar outros retornos, como os abaixo
            Self:setStatus(500) 
            jResponse['errorId']  := 'ID002'
            jResponse['error']    := 'ID não encontrado'
            jResponse['solution'] := 'Código ID não encontrado na tabela ' + cAliasWS
        Else
            //Define o retorno
            jResponse['cod'] := (cAliasWS)->B1_COD 
            jResponse['desc'] := (cAliasWS)->B1_DESC 
            jResponse['tipo'] := (cAliasWS)->B1_TIPO 
            jResponse['um'] := (cAliasWS)->B1_UM 
        EndIf
    EndIf

    //Define o retorno
    Self:SetContentType('application/json')
    Self:SetResponse(EncodeUTF8(jResponse:toJSON()))
Return lRet

/*/{Protheus.doc} WSMETHOD GET ALL
Busca todos os registros através de paginação
@author Atilio
@since 13/03/2025
@version 1.0
@type method
@param updated_at, Caractere, Data de alteração no formato string 'YYYY-MM-DD' (somente se tiver o campo USERLGA / USERGA na tabela)
@param limit, Numérico, Limite de registros que irá vir (por exemplo trazer apenas 100 registros)
@param page, Numérico, Número da página que irá buscar (se existir 1000 registros dividido por 100 terá 10 páginas de pesquisa)
@obs Codigo gerado automaticamente pelo Autumn Code Maker

    Poderia ser usado o FWAdapterBaseV2(), mas em algumas versões antigas não existe essa funcionalidade
    então a paginação foi feita manualmente

@see http://autumncodemaker.com
/*/

WSMETHOD GET ALL WSRECEIVE updated_at, limit, page WSSERVICE zFonte54
    Local lRet       := .T.
    Local jResponse  := JsonObject():New()
    Local cQueryTab  := ''
    Local nTamanho   := 10
    Local nTotal     := 0
    Local nPags      := 0
    Local nPagina    := 0
    Local nAtual     := 0
    Local oRegistro
    Local cAliasWS   := 'SB1'

    //Efetua a busca dos registros
    cQueryTab := " SELECT " + CRLF
    cQueryTab += "     TAB.R_E_C_N_O_ AS TABREC " + CRLF
    cQueryTab += " FROM " + CRLF
    cQueryTab += "     " + RetSQLName(cAliasWS) + " TAB " + CRLF
    cQueryTab += " WHERE " + CRLF
    cQueryTab += "     TAB.D_E_L_E_T_ = '' " + CRLF
    
    //Abaixo esta sendo feito o filtro com o campo de log de alteração (LGA), porém desde Maio de 2023, pode apresentar divergências
    // então você pode substituir o campo 'B1_USERLGA' por S_T_A_M_P_, I_N_S_D_T_ ou outro campo de data da tabela
    If ! Empty(::updated_at)
        cQueryTab += "     AND ((CASE WHEN SUBSTRING(B1_USERLGA, 03, 1) != ' ' THEN " + CRLF
        cQueryTab += "        CONVERT(VARCHAR,DATEADD(DAY,((ASCII(SUBSTRING(B1_USERLGA,12,1)) - 50) * 100 + (ASCII(SUBSTRING(B1_USERLGA,16,1)) - 50)),'19960101'),112) " + CRLF
        cQueryTab += "        ELSE '' " + CRLF
        cQueryTab += "     END) >= '" + StrTran(::updated_at, '-', '') + "') " + CRLF
    EndIf
    cQueryTab += " ORDER BY " + CRLF
    cQueryTab += "     TABREC " + CRLF
    TCQuery cQueryTab New Alias 'QRY_TAB'

    //Se não encontrar registros
    If QRY_TAB->(EoF())
        //SetRestFault(500, 'Falha ao consultar registros') //caso queira usar esse comando, você não poderá usar outros retornos, como os abaixo
        Self:setStatus(500) 
        jResponse['errorId']  := 'ALL003'
        jResponse['error']    := 'Registro(s) não encontrado(s)'
        jResponse['solution'] := 'A consulta de registros não retornou nenhuma informação'
    Else
        jResponse['objects'] := {}

        //Conta o total de registros
        Count To nTotal
        QRY_TAB->(DbGoTop())

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
            QRY_TAB->(DbSkip((nPagina-1) * nTamanho))
        EndIf

        //Adiciona os dados para a meta
        jJsonMeta := JsonObject():New()
        jJsonMeta['total']         := nTotal
        jJsonMeta['current_page']  := nPagina
        jJsonMeta['total_page']    := nPags
        jJsonMeta['total_items']   := nTamanho
        jResponse['meta'] := jJsonMeta

        //Percorre os registros
        While ! QRY_TAB->(EoF())
            nAtual++
            
            //Se ultrapassar o limite, encerra o laço
            If nAtual > nTamanho
                Exit
            EndIf

            //Posiciona o registro e adiciona no retorno
            DbSelectArea(cAliasWS)
            (cAliasWS)->(DbGoTo(QRY_TAB->TABREC))
            
            oRegistro := JsonObject():New()
            oRegistro['cod'] := (cAliasWS)->B1_COD 
            oRegistro['desc'] := (cAliasWS)->B1_DESC 
            oRegistro['tipo'] := (cAliasWS)->B1_TIPO 
            oRegistro['um'] := (cAliasWS)->B1_UM 
            aAdd(jResponse['objects'], oRegistro)

            QRY_TAB->(DbSkip())
        EndDo
    EndIf
    QRY_TAB->(DbCloseArea())

    //Define o retorno
    Self:SetContentType('application/json')
    Self:SetResponse(EncodeUTF8(jResponse:toJSON()))
Return lRet
