/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/19/testando-o-modo-de-compartilhamento-entre-duas-tabelas-com-xretmodo-maratona-advpl-e-tl-547/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe547
Testa o modo de compartilhamento entre duas tabelas
@type Function
@author Atilio
@since 07/04/2023
@obs 
    Função xRetModo
    Parâmetros
        Recebe o nome do primeiro alias
        Recebe o nome do segundo alias
        .T. se irá mostrar a mensagem de Help caso haja diferenças ou .F. se não
        Recebe a variável que será atualizada com o modo de compartilhamento do primeiro alias (passar com @)
        Recebe a variável que será atualizada com o modo de compartilhamento do segundo alias (passar com @)
    Retorno
        Retorna .T. se for igual o compartilhamento ou .F. se não

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe547()
    Local aArea      := FWGetArea()
    Local cTabProd   := ""
    Local cTabGrup   := ""
    Local cModProd   := ""
    Local cModGrup   := ""
    Local lIguais    := .F.
    
    //Define as tabelas que serão comparadas
    cTabProd := "SB1"
    cTabGrup := "SBM"
    
    //Valida o compartilhamento de ambas
    lIguais  := xRetModo(cTabProd, cTabGrup , .F. , @cModProd, @cModGrup)

    //Se for igual, mostra mensagem de sucesso, senão mostra mensagem de erro
    If lIguais
        FWAlertSuccess("As tabelas tem o mesmo tipo de compartilhamento", "Teste xRetModo")
    Else
        FWAlertError("O compartilhamento da " + cTabProd + " é [" + cModProd + "], enquanto da " + cTabGrup + " é [" + cModGrup + "]", "Teste xRetModo")
    EndIf

    FWRestArea(aArea)
Return
