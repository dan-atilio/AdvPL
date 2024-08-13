/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/02/buscando-o-nome-dos-campos-de-uma-tabela-atraves-da-ttgetstru-maratona-advpl-e-tl-512/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe512
Retorna os campos de uma tabela em uma string
@type Function
@author Atilio
@since 05/04/2023
@obs 

    TTGetStru
    Parâmetros
        Array contendo a DbStruct (no lugar do Alias)
        Alias que será analisado (no lugar do Array)
        String usada para separação dos campos
    Retorno
        Retorna uma string com os campos encontrados conforme o Array ou Alias e usando o separador definido

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe512()
    Local aArea      := FWGetArea()
    Local cCampos    := ""
    Local aStruct    := {}

    //Buscando os campos de um alias usando ; como separador
    cCampos := TTGetStru(, "SBM", ";")
    ShowLog(cCampos)

    //Buscando os campos de uma struct usando . como separador
    DbSelectArea("SB1")
    aStruct := SB1->(DbStruct())
    cCampos := TTGetStru(aStruct, , ".")
    ShowLog(cCampos)

    FWRestArea(aArea)
Return
