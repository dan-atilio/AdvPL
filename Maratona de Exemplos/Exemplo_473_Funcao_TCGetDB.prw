/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/12/criando-botoes-atraves-da-tbutton-maratona-advpl-e-tl-472/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe473
Retorna o banco de dados utilizado pelo ERP
@type Function
@author Atilio
@since 03/04/2023
@see https://tdn.totvs.com/display/tec/TCGetDB
@obs 

    TCGetDB
    Parâmetros
        Função não tem parâmetros
    Retorno
        + cRet       , Caractere      , Retorna uma string com o nome do banco utilizado

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe473()
    Local aArea  := FWGetArea()
    Local cBanco := ""

    //Busca informações do banco utilizado
    cBanco := TCGetDB()

    //Exibe o resultado
    FWAlertInfo("O banco utilizado é: " + cBanco, "Teste TCGetDB")

    FWRestArea(aArea)
Return
