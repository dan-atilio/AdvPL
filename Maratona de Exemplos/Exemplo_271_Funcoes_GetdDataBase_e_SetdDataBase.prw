/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/03/manipulando-a-data-logada-com-getddatabase-e-setddatabase-maratona-advpl-e-tl-271/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe271
Funções que manipulam a variável de data de login (dDatabase) do sistema
@type  Function
@author Atilio
@since 21/02/2023
@obs 

    Função GetdDataBase
    Parâmetros
        Não tem parâmetros
    Retorno
        Retorna a data que o usuário fez login no sistema

    Função SetdDataBase
    Parâmetros
        Informa a nova data de login do sistema
    Retorno
        Não tem retorno
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe271()
    Local aArea      := FWGetArea()
    Local dOntem     := DaySub(Date(), 1)

    //Altera a data de login para a data de ontem
    SetdDataBase(dOntem)

    //Busca a informação e exibe
    cMensagem := "A nova data de login é: " + dToC( GetdDataBase() )
    FWAlertInfo(cMensagem, "Teste GetdDataBase e SetdDataBase")

    FWRestArea(aArea)
Return
