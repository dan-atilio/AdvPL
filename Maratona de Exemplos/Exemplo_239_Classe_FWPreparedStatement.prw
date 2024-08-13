/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/16/removendo-acentos-de-uma-string-com-fwnoaccent-maratona-advpl-e-tl-238/
*/


//Bibliotecas
#Include 'TOTVS.ch'
 
/*/{Protheus.doc} User Function zExe239
Classe que prepara uma query SQL
@type Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/display/public/framework/FWPreparedStatement
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe239()
	Local aArea := FWGetArea()
    Local oStateQry
    Local cQueryOrig
    Local cQueryNova
    
    //Prepara a query original
    cQueryOrig := "SELECT * FROM " + RetSQLName("SB1") + " SB1 WHERE B1_TIPO = ? AND B1_LOCPAD = ? AND SB1.D_E_L_E_T_ = ' '"

    //Começa a montar a query
    oStateQry := FWPreparedStatement():New()
    
    //Define a query e define o conteúdo das interrogações
    oStateQry:SetQuery(cQueryOrig)
    oStateQry:SetString(1, "PA")
    oStateQry:SetString(2, "01")
    
    //Busca a query formatada
    cQueryNova := oStateQry:GetFixQuery()
    FWAlertInfo(cQueryNova, "Teste 1 FWPreparedStatement")

    RestArea(aArea)
Return
