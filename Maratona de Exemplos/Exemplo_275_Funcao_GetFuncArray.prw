/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/05/buscando-o-nome-do-ambiente-com-a-getenvserver-maratona-advpl-e-tl-274/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe275
Busca informações de uma função (ou de várias dependendo da máscara)
@type  Function
@author Atilio
@since 21/02/2023
@see https://tdn.totvs.com/display/tec/GetFuncArray
@obs 

    Função GetFuncArray
    Parâmetros
        + cMascara  , Caractere    , Nome da máscara de pesquisa
        + aTipo     , Array        , Tipos de arquivos
        + aArquivo  , Array        , Nome dos arquivos
        + aLinha    , Array        , Linha da compilação das funções
        + aData     , Array        , Data da modificação dos arquivos
        + aHora     , Array        , Hora da modificação dos arquivos
    Retorno
        + aScr      , Array        , Retorna um array que contém o nome das funções
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe275()
    Local aArea   := FWGetArea()
    Local cFuncao := "MATA???"
    Local cTexto  := ""
    Local nAtual  := 0
    Local aRet    := {}
    Local aType   := {}
    Local aFile   := {}
    Local aLine   := {}
    Local aDate   := {}
    Local aTime   := {}

    //Busca as informações da função
    aRet := GetFuncArray(cFuncao, @aType, @aFile, @aLine, @aDate, @aTime)
    For nAtual := 1 To Len(aRet)
        cTexto += "Função "    + cValtoChar(nAtual) + "= " + aRet[nAtual] + CRLF
        cTexto += "> Arquivo " + cValtoChar(nAtual) + "= " + aFile[nAtual] + CRLF
        cTexto += "> Linha "   + cValtoChar(nAtual) + "= " + aLine[nAtual] + CRLF
        cTexto += "> Tipo "    + cValtoChar(nAtual) + "= " + aType[nAtual] + CRLF
        cTexto += "> Data "    + cValtoChar(nAtual) + "= " + dToC(aDate[nAtual]) + CRLF
        cTexto += "> Hora "    + cValtoChar(nAtual) + "= " + aTime[nAtual] + CRLF
        cTexto += CRLF + CRLF
    Next

    //Exibe o que encontrou
    ShowLog(cTexto)

    FWRestArea(aArea)
Return
