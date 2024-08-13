/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/09/02/funcao-acols2xls-que-gera-um-excel-atraves-de-aheader-e-acols-maratona-advpl-e-tl-025/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe025
Exemplo de função para gerar um Excel conforme um array de aCols e aHeader
@type Function
@author Atilio
@since 26/11/2022
@obs Função aCols2Xls
    Parâmetros
        + Array com os dados (como o aCols de uma tela)
        + Array com as informações de cabeçalho (como o aHeader de uma tela)

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe025()
    Local aArea   := FWGetArea()
    Local aCols   := {}
    Local aHeader := {}

    //Adiciona os cabeçalhos
    aAdd(aHeader, {"Nome"})
    aAdd(aHeader, {"Idade"})
    aAdd(aHeader, {"Cidade"})

    //Adiciona os dados
    aAdd(aCols, {"Daniel", 29, "Bauru",       .F.})
    aAdd(aCols, {"João",   35, "Agudos",      .F.})
    aAdd(aCols, {"Maria",  40, "Piratininga", .F.})
    aAdd(aCols, {"José",   48, "Pederneiras", .F.})

    //Aciona a geração do Excel
    aCols2Xls(aCols, aHeader)

    FWRestArea(aArea)
Return
