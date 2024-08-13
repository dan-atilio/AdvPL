/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/10/13/executando-queries-com-os-comandos-beginsql-e-endsql-maratona-advpl-e-tl-066/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe066
Exemplo de como fazer queries com linguagem nativa em AdvPL
@type Function
@author Atilio
@since 06/12/2022
@see https://tdn.totvs.com/display/public/framework/Embedded+SQL
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe066()
    Local aArea  := FWGetArea()
    Local cTipos := "PI;PA;"
    Local cWhere := "%B1_TIPO IN " + FormatIn(cTipos, ";") + " AND B1_LOCPAD = '01'%"
    Local nRegs  := 0
    
    //Construindo a consulta
    BeginSql Alias "SQL_SB1"

        //Definindo campos com tipo específico
        COLUMN B1_UCOM AS DATE

        //Definindo a query que será executada    
        SELECT    
            B1_COD,
            B1_DESC,
            B1_UCOM 
        FROM
            %table:SB1% SB1 
        WHERE
            B1_FILIAL  = %xFilial:SB1%
            AND B1_MSBLQL != '1'
            AND %Exp:cWhere%
            AND SB1.%notDel%
    EndSql
    
    //Enquanto houver registros
    While ! SQL_SB1->(EoF())
        nRegs++
        
        SQL_SB1->(DbSkip())
    EndDo
    SQL_SB1->(DbCloseArea())
    
    FWAlertInfo("Foram processados " + cValToChar(nRegs) + " produtos.", "Atenção")

    FWRestArea(aArea)
Return
