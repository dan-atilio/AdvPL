/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/23/convertendo-textos-entre-oem-e-ansi-com-oemtoansi-e-ansitooem-maratona-advpl-e-tl-373/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe373
Realiza a conversão entre ANSI e OEM (MS-DOS)
@type Function
@author Atilio
@since 28/03/2023
@see https://tdn.totvs.com/display/tec/ANSIToOEM e https://tdn.totvs.com/display/tec/OEMToANSI
@obs 

    Função AnsiToOem
    Parâmetros
        + cStringAnsi    , Caractere    , String no formato ANSI
    Retorno
        + cRet           , Caractere    , String no formato OEM/MS-DOS

    Função OemToAnsi
    Parâmetros
        + cStringOem     , Caractere    , String no formato OEM/MS-DOS
    Retorno
        + cRet           , Caractere    , String no formato ANSI

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe373()
    Local aArea      := FWGetArea()
    Local cTextoOrig := ""
    Local cTextoNovo := ""

    //Realiza a conversão de ANSI para OEM
    cTextoOrig := "João Travessão"
    cTextoNovo := AnsiToOem(cTextoOrig)
    FWAlertInfo("Texto original '" + cTextoOrig + "' ficou como '" + cTextoNovo + "'", "Teste AnsiToOem")

    //Realiza a conversão de OEM para ANSI
    cTextoOrig := "Atenção Atenção - As belugas estão chegando"
    cTextoNovo := OemToAnsi(cTextoOrig)
    FWAlertInfo("Texto original '" + cTextoOrig + "' ficou como '" + cTextoNovo + "'", "Teste OemToAnsi")
 
    FWRestArea(aArea)
Return
