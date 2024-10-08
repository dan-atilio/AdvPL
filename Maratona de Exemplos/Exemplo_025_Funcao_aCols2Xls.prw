/*
    Esse exemplo faz parte da s�rie do YouTube, Maratona de Exemplos, do canal Terminal de Informa��o, 
    caso queira ver esse exemplo rodando em v�deo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/09/02/funcao-acols2xls-que-gera-um-excel-atraves-de-aheader-e-acols-maratona-advpl-e-tl-025/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe025
Exemplo de fun��o para gerar um Excel conforme um array de aCols e aHeader
@type Function
@author Atilio
@since 26/11/2022
@obs Fun��o aCols2Xls
    Par�metros
        + Array com os dados (como o aCols de uma tela)
        + Array com as informa��es de cabe�alho (como o aHeader de uma tela)

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe025()
    Local aArea   := FWGetArea()
    Local aCols   := {}
    Local aHeader := {}

    //Adiciona os cabe�alhos
    aAdd(aHeader, {"Nome"})
    aAdd(aHeader, {"Idade"})
    aAdd(aHeader, {"Cidade"})

    //Adiciona os dados
    aAdd(aCols, {"Daniel", 29, "Bauru",       .F.})
    aAdd(aCols, {"Jo�o",   35, "Agudos",      .F.})
    aAdd(aCols, {"Maria",  40, "Piratininga", .F.})
    aAdd(aCols, {"Jos�",   48, "Pederneiras", .F.})

    //Aciona a gera��o do Excel
    aCols2Xls(aCols, aHeader)

    FWRestArea(aArea)
Return
