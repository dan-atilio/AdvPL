/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/11/13/validando-se-um-campo-e-obrigatorio-com-a-funcao-cpoobrigat-maratona-advpl-e-tl-097/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe097
Verifica se um campo é obrigatório no Protheus
@type Function
@author Atilio
@since 11/12/2022
@obs 
    Função CpoObrigat
    Parâmetros
        + Nome do campo
    Retorno
        + .T. se o campo for obrigatório ou .F. se não

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe097()
    Local aArea     := FWGetArea()
    Local cCampo    := "B1_DESC"

    //Testa se o campo é obrigatório
    If CpoObrigat(cCampo)
        FWAlertSuccess("O campo é obrigatório", "Teste CpoObrigat")
    Else
        FWAlertError("O campo não é obrigatório", "Teste CpoObrigat")
    EndIf

    FWRestArea(aArea)
Return
