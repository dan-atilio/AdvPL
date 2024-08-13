/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/20/buscando-informacoes-de-indices-com-a-fwsixutil-maratona-advpl-e-tl-246/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe247
Classe para buscar informações da SM0 (Cadastro de Empresas)
@type  Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/display/public/framework/FWSM0Util
@obs 
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe247()
    Local aArea      := FWGetArea()
    Local cMensagem  := ""
    Local aCampos    := { ;
        "M0_CODIGO",;    //Posição [1]
        "M0_CODFIL",;    //Posição [2]
        "M0_NOMECOM",;   //Posição [3]
        "M0_CGC",;       //Posição [4]
        "M0_INSCM",;     //Posição [5]
        "M0_CIDENT",;    //Posição [6]
        "M0_ESTENT",;    //Posição [7]
        "M0_ENDENT",;    //Posição [8]
        "M0_BAIRENT",;   //Posição [9]
        "M0_CEPENT",;    //Posição [10]
        "M0_COMPENT",;   //Posição [11]
        "M0_TEL";        //Posição [12]
    }
    Local aEncontrou := {}

    //Busca os campos da filial "01"
    aEncontrou := FWSM0Util():GetSM0Data(, "01", aCampos)

    //Se encontrou, monta uma mensagem e exibe
    If Len(aEncontrou) > 0
        cMensagem += "M0_NOMECOM: " + aEncontrou[3][2] + CRLF
        cMensagem += "M0_CGC: "     + aEncontrou[4][2] + CRLF
        cMensagem += "M0_CIDENT: "  + aEncontrou[6][2] + CRLF
        FWAlertInfo(cMensagem, "Teste FWSM0Util")
    EndIf

    FWRestArea(aArea)
Return
