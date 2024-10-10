/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2024/09/19/como-usar-tsystemtray-com-sigamdi-ti-responde-0083/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"

//Variáveis estáticas
Static oSysTray
Static oTimer

/*/{Protheus.doc} User Function MdiOk
P.E. acionado logo ao abrir o sistema via SIGAMDI
@type  Function
@author Atilio
@since 22/12/2023
@see https://tdn.totvs.com/display/public/framework/MDIOK
/*/

User Function MdiOk()
    Local aArea := FWGetArea()
    Local lContinua := .T.
    Local oJanela := GetWndDefault()
    Local oMenu
    Local oItem1
    Local cIcon  := "totvsprinter_logo.png"
    Local nTempo := 10000 //60.000 milissegundos é igual a 1 minuto

    //Somente se for usuário administrador
    If FWIsAdmin() .And. ValType(oSysTray) == "U"
        //Monta o menu e os itens
        oMenu  := TMenu():New(0, 0, 0, 0, .T., , oJanela)
        oItem1 := TMenuItem():New(oJanela,'...', , , , {|| /* comandos */ },          , 'BR_VERDE', , , , , , , .T.)
        oItem2 := TMenuItem():New(oJanela,'Teste', , , , {|| Alert("testando, 123!") }, , 'CHECKED', , , , , , , .T.)
        oMenu:Add(oItem1)
        oMenu:Add(oItem2)

        //Cria o ícone na barra do S.O.
        oSysTray := TSystemTray():New(oJanela, cIcon)
        oSysTray:cToolTip := "Protheus"
        oSysTray:SetMenu(oMenu)

        //Temporizador para disparar mensagem
        oTimer := TTimer():New(    nTempo,;
                                {|| fAtualiza() },;
                                oJanela )
        oTimer:Activate()
    EndIf

    FWRestArea(aArea)
Return lContinua

Static Function fAtualiza()
    Local aArea     := FWGetArea()
    Local cMensagem := "Agora é " + Time()
    Local nTimeOut  := 8000 // 8.000 milissegundos é igual a 8 segundos
    Local cQuery    := ""
    Local nTotal    := 0

    //Busca os registros em analise que necessitam de aprovação
    cQuery += " SELECT  " + CRLF
    cQuery += " 	E2_NUM  " + CRLF
    cQuery += " FROM  " + CRLF
    cQuery += " 	" + RetSQLName("SE2") + " SE2 " + CRLF
    cQuery += " WHERE " + CRLF
    cQuery += " 	E2_FILIAL = '01' " + CRLF
    cQuery += " 	AND E2_VENCREA = '" + dToS(Date()) + "' " + CRLF
    cQuery += " 	AND E2_BAIXA = '' " + CRLF
    cQuery += " 	AND SE2.D_E_L_E_T_ = ' ' " + CRLF
    TCQuery cQuery New Alias "QRY_SE2"

    //Se existem dados
    If ! QRY_SE2->(EoF())

        //Conta a quantidade de registros
        Count To nTotal
        QRY_SE2->(DbGoTop())

        //Monta a mensagem que será exibida
        cMensagem := "Existem '" + cValToChar(nTotal) + "' títulos a pagar em aberto vencendo hoje. Pressione a tecla -F9- que será aberto a tela para análise."

        //Exibe uma mensagem no S.O.
        oSysTray:ShowMessage(;
            "Pressione -F9-",; //[ cTitulo ],;
            cMensagem,; //[ cMessage ],;
            1,;         //[ nTypeMessage ],;
            nTimeOut,;  //[ ntimeout ],;
            {||};       //[ bAction ];
        )
    EndIf
    QRY_SE2->(DbCloseArea())

    FWRestArea(aArea)
Return

/*/{Protheus.doc} User Function ChkExec
Ponto de Entrada acionado ao clicar em alguma opção no menu
@type  Function
@author Atilio
@since 22/12/2023
@see https://tdn.totvs.com/display/public/framework/CHKEXEC+-+Dispara+ponto+de+entrada
/*/

User Function ChkExec()
    Local lContinua := .T.

    //Somente se for usuário administrador
    If FWIsAdmin()
    
        //Adiciona o atalho
        SetKey(VK_F9, {|| FinA750() })
    EndIf

Return lContinua
