/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/23/formatando-um-texto-para-usar-como-in-no-sql-atraves-da-formatin-maratona-advpl-e-tl-190/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe191
Formata uma string com variáveis e máscaras (parecido com a Transform, mas podendo utilizar direto a formatação numa string como um printf em C)
@type Function
@author Atilio
@since 11/02/2023
@obs 
    Função FormatStr
    Parâmetros
        + Frase original com os lugares a serem formatados como %c ; %n ; %d e %l
        + Define qual será o caractere separador
    Retorno
        + Frase já formatada

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe191()
    Local aArea      := FWGetArea()
    Local cFraseSimp := ""
    Local cFraseComp := ""
    Local dDataHoje  := Date()
    Local aDados     := {}

    //Monta uma frase simples e exibe
    cFraseSimp := FormatStr("Hoje é %d", dDataHoje)
    FWAlertInfo(cFraseSimp, "Teste 1 - FormatStr")

    //Monta uma frase complexa
    aDados := {}
    aAdd(aDados, dDataHoje)
    aAdd(aDados, "Daniel Atilio")
    aAdd(aDados, 2012)
    aAdd(aDados, .T.)
    cFraseComp := FormatStr("Hoje é %d , o nome é %c , o Terminal de Informação nasceu em %n , o autor gosta de ler %l", aDados)
    FWAlertInfo(cFraseComp, "Teste 1 - FormatStr")

    FWRestArea(aArea)
Return
